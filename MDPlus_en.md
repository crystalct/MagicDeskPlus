# Magic Desk Plus Cartridge for Commodore 64

## 1. Introduction: The Standard Magic Desk Format

The **Magic Desk** cartridge format originally emerged in 1983 from a Commodore Business Machines project, designed to host a simplified productivity software suite (including modules like *Type and File*, *Spreadsheet*, and *Financial Planning*). The fundamental goal of the designers was to keep the software resident in memory, completely eliminating the exhausting loading times of the disk drive or Datassette. Although only the *Type and File* module was commercially released, the technical legacy of the hardware architecture has survived for decades.

### Hardware Interface and Expansion Port Signals
The operation of a standard Magic Desk cartridge is tied to the management of electrical signals on the Commodore 64's 44-pin expansion port. The standard configuration requires the `/EXROM` signal to be pulled low (ground) and the `/GAME` signal to be kept high. 

This setting instructs the C64's PLA (Programmable Logic Array) to map 8 KB of external ROM into the memory window between `$8000` and `$9FFF`, while keeping the BASIC ROM and KERNAL ROM unchanged.

### Memory Banking Architecture: The `$DE00` Register
Like other types of cartridges, the Magic Desk adopts *data-type banking*, where the bank switch is triggered by the value of the written data. The heart of the system is a hardware *latching* register (usually a 74LS273 chip) that activates when the CPU writes a byte in the I/O area between `$DE00` and `$DEFF`.

The structure of the control byte written to `$DE00` is as follows:
* **Bits 0-5 (or 0-6):** Define which 8 KB ROM bank should slide under the `$8000-$9FFF` window. With 7 bits, it is possible to address up to 128 banks, equal to 1 MB of memory.
* **Bit 7 (Disable Control):** Acts as a global switch. If set to 1 (values `>= $80`), the circuitry forces the `/EXROM` line to a high logic state, instantly disabling the cartridge and restoring the C64's internal RAM in the `$8000-$9FFF` area.

### Software Exploitation: The Trampoline Technique
Since the 6502 processor cannot switch the ROM bank "underneath itself" without interpreting random data and causing a crash, programmers resort to the trampoline technique (*trampoline code*). The software copies a small banking routine into the C64's RAM (for example, on the Stack or in page 3), disables interrupts (`SEI`), executes the write to `$DE00`, jumps to the new ROM bank, and re-enables interrupts (`CLI`).

For the KERNAL to automatically start the cartridge upon power-up, Bank 0 must contain the startup vectors (Cold and Warm Start) and the PETSCII signature `"CBM80"` starting from address `$8000`.

---

## 2. Hardware Architecture of the Magic Desk Plus

The **Magic Desk Plus** radically expands the specifications of the classic format. In addition to supporting 256/512/1024 KBytes of ROM memory, it introduces a **128 KByte static SRAM** backed by a battery, alongside an **8/32 KByte EEPROM** memory. A configuration with only the SRAM or only the EEPROM is allowed.

To manage this additional space while keeping the `$DE00` register unchanged, the cartridge introduces a dedicated data transit window and two new registers in the I/O 1 area:

* **Data I/O Window (`$DF00 - $DFFF`):** A fixed 256-byte access window mapped directly onto the currently active SRAM or EEPROM memory page.
* **Page Register (`$DE01`):** *Write-only* register responsible for selecting the 256-byte page (values from 0 to 255) to project into the transit window.
* **Control Register (`$DE03`):** *Write-only* register dedicated to enabling and configuring the SRAM/EEPROM.

**The `$DF00 - $DFFF` window will be the direct access point, both for reading and writing, to the memory (SRAM or EEPROM) even with the main cartridge ROM disabled.**

### Configuration of the Control Register `$DE03`
Since `$DE03` is a write-only register, the 6502 processor cannot read its state. It is therefore useful to keep a shadow copy (*shadow register*) in system RAM (e.g., `mdp_ctrl_shadow`) to apply bitwise modifications safely (potential *shadow registers* for both `$DE01` and `$DE03` are not strictly necessary). 

* **Bit 0:** Selects the two portions of SRAM. Writing `0` uses the first 64 KByte portion; writing `1` uses the second 64 KByte portion. At power-up, the first portion is selected by default. If the SRAM is disabled, Bit 0 is irrelevant.
* **Bit 5:** Enables or disables the SRAM by switching with the potential EEPROM. If set to `1`, the SRAM is enabled; if set to `0`, the SRAM is disabled and the EEPROM takes over. At power-up, the EEPROM is active by default.

---

## 3. EEPROM Management and Programming

The Magic Desk Plus architecture also envisions the coexistence of SRAM with a non-volatile EEPROM type memory (8 KB or 32 KB). The EEPROM and SRAM share the same hardware I/O window (`$DF00-$DFFF`) and the same page register `$DE01`. The exclusive selection of one or the other is done by setting bit 5 in `$DE03`.

Depending on the installed EEPROM, the page selection responds to fixed hardware masks. An 8 KB EEPROM (32 pages) responds to the `0x1F` mask by ignoring the upper bits of `$DE01`, while a 32 KB one (128 pages) uses the `0x7F` mask and ignores bit 7.

Unlike SRAM which allows immediate writes, programming an EEPROM cell imposes a physical storage time that can reach up to 10 milliseconds per operation. The software must strictly insert a *delay loop* (software delay cycle) immediately after every storage instruction in the `$DF00-$DFFF` window, to prevent page changes or new writes from corrupting the ongoing process.

---

## 4. Case Study for SRAM Usage: The MDP-FS File System (MagicDesk Plus File System)

The **MagicDesk Plus File System (MDP-FS)** is a software architecture designed to manage the 128 KBytes of persistent SRAM (via battery backup) and transform them into an ultra-high-performance "RAM Disk".

### Linked Allocation Philosophy (1541-Style)
To eliminate fragmentation and lighten the load on the MOS 6502 processor, MDP-FS adopts a linked block allocation inspired by the formatting logic of the Commodore 1541. Every 256-byte hardware page corresponds exactly to a single logical block.

Each block systematically sacrifices the last two bytes (offsets `$FE` and `$FF`) to host the linking pointers (*Pointer Linking*), offering **254 bytes of net data per block**:
* **Bytes 0 - 253 (Offsets `$00` - `$FD`):** Net data sector (Payload).
* **Byte 254 (Offset `$FE`):** Indicates the SRAM Portion (0 or 1) where the next block resides. If set to `$FF`, it indicates the absolute end of the file (EOF).
* **Byte 255 (Offset `$FF`):** If the block is not the last one, it indicates the index of the next page to map into `$DE01`. If the block is terminal (EOF), it contains the exact number of valid bytes in the data area (from 1 to 254).

### Fixed SRAM Memory Layout
The SRAM map is rigidly partitioned to guarantee boot and the persistence of structural metadata:

| Portion | Page | Intended Use |
| :--- | :--- | :--- |
| **0** | 0 | **Main Directory:** Descriptive file entries. |
| **0** | 1 | **BAM:** Bit allocation map for the 512 total blocks. |
| **0 and 1** | Various | **User Data:** Blocks available for storage. |
| **1** | 255 | **Hardware Block:** The last two bytes (`$FE` and `$FF`) must strictly host the native signature `$CA, $F1`. |

### Directory Structure
A single directory page hosts exactly 8 entries of 32 bytes each. Every entry defines the file's structure:
* **Bytes 0-15:** PETSCII file name.
* **Bytes 16-17:** Portion and Page of the starting block.
* **Bytes 18-19:** 16-bit word (Little-Endian) with the total allocated blocks.
* **Byte 20:** Status flag (e.g., `$01` = Active, `$02` = Writing, `$80` = Deleted).
* **Bytes 21-31:** Space reserved for extensions.

### API Logical Flow (`mdp_fread` and `mdp_fwrite`)
The MDP-FS APIs completely abstract hardware manipulation for applications. 
While reading a stream via `mdp_fread`, the API sequentially reads the `$DF00` window and moves the bytes into the RAM buffer. Reaching offset 254 of a non-terminal block, the API autonomously fetches the linking bytes, physically switches the `$DE03` and `$DE01` registers to the new block, resets the offset, and continues reading without interrupting the flow. This allows for virtually instantaneous streaming, perfect for loading complex Multicolor graphics in real-time.
During writing with `mdp_fwrite`, at the end of a block, the API queries the BAM to find space, updates the pointers of the depleting block, switches the registers, and advances to the new block transparently for the caller.

---

## 5. Hardware Detection Algorithms

To identify the installed memories, software libraries execute safe detection routines. 
To perform SRAM detection, the system enables Portion 1 and Page 255 and then reads the offsets `$FE` and `$FF`. If the read values correspond to the hexadecimal signature `$CA, $F1`, the SRAM is marked as present and already initialized hardware. In case of a missing signature or random data, the library attempts a sequence of storing and re-reading the signature values to ascertain the chip's presence. If the chip responds but the drive is unformatted, the `mdp_format` function can be invoked, which clears the RAM, sets up the BAM, and permanently inscribes the physical signature in the last block.
Similar algorithms are executed by scanning pages 31 and 127 with the EEPROM activated to identify the possible presence and size of the EEPROM memories based on address aliasing.

---

## 6. Advanced Hardware Considerations and Timings

The design of expanded cartridges involves specific technical challenges for the original 8-bit architecture of the Commodore 64:

### Clock Management and `PHI2` Signal Integration
The exclusive use of the `/IO1` line to activate the bank *latching* can trigger severe hardware instabilities on revised C64s. The `/IO1` signal activates as soon as the decoded addresses match, which is before the data bus is electrically stable. The `PHI2` signal defines the correct time window in which the data is guaranteed and ready to be latched. To ensure maximum reliability on all motherboards, the trigger circuit must be based on the boolean equation:

$$\text{Output} = \text{NOT}(\text{/IO1} \text{ OR } \text{NOT}(\text{PHI2}))$$

### Read Corruption and Conflicts
In less refined hardware implementations that do not decode the `R/W` (Read/Write) line, a read instruction like `LDA $DE00` can generate an unexpected clock pulse on the flip-flop. This will store unstable data taken from the bus, switching the bank randomly and corrupting execution. 
Furthermore, since the ROM covers the `$8000-$9FFF` window, it does not overwrite the interrupt vectors at the top of memory (`$FFFA-$FFFF`). An IRQ or NMI signal will generate a jump to the KERNAL ROM vectors; if this has been excluded from the memory layout, the programmer is forced to redesign the map by allocating custom vectors in the active banks.

### Speed Limits on Commodore 128
Although the project is fully compatible with a Commodore 128 in emulation mode, its use in native 2 MHz mode could cause problems due to the halved bus cycles. In this case, it might be a good idea to replace the `74LS` series logic chips with those of the `74HCT` or `74AHCT` series to tolerate the accelerated frequency of the system.

---

## 7. Comparative Format Analysis

To contextualize the Magic Desk Plus in the retrocomputing ecosystem, it is essential to evaluate it against historical and modern rival standards:

| Feature | Magic Desk Standard | Magic Desk Plus | Ocean Format | EasyFlash |
| :--- | :--- | :--- | :--- | :--- |
| **Memory Window** | `$8000-$9FFF` (8 KB) | `$8000-$9FFF` (8 KB) | `$8000` / `$A000` (8 or 16 KB) | `$8000` + `$A000` (16 KB) |
| **Persistent Memory** | Absent | **128 KB SRAM** + EEPROM | Absent | Flash ROM (1 MB) + 256 Bytes of SRAM |
| **I/O Service RAM** | Absent | **256-Byte Window** | Absent | 256-Byte Window |
| **Banking Logic** | Write to `$DE00` | Write to `$DE00`, `$DE01`, `$DE03` | Write to `$DE00` | `$DE00` and `$DE02` Registers |
| **Hardware Complexity** | Very Low | **Low** (No custom components) | Low | Medium/High (Requires CPLD) |
