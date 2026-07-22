# Why a remaster?

Transitioning from the classic 1541 floppy disk version to a **Magic Desk Plus (MDP)** cartridge for a title like *Murder on the Mississippi* represents a radical transformation in both technical architecture and gameplay experience.

In an investigative adventure game centered around constantly moving between cabins, interrogating suspects, and examining clues, the original disk version suffered from frequent disk access delays and seek times, even when paired with a custom fast loader. Remastering the game onto the MDP cartridge format offers several critical advantages:

---

### 1. Instant Load Times (Zero Wait Time)
By mapping up to 1 MB of ROM directly into the `$8000–$9FFF` memory window via bank-switching (controlled via register `$DE00`), every location, dialogue, or graphical asset is accessed instantaneously. Dependencies on mechanical 1541 drive timings or fast loader routines are entirely eliminated, making riverboat exploration seamless and immediate.

---

### 2. Dynamic Expansion, Extra RAM, and Overcoming System Limits
The original Commodore 64 release was pushed to the absolute limit, occupying virtually the entire 64 KB RAM space. During the cartridge port, even after removing obsolete routines (such as the 1541 custom fast loader code), the freed internal RAM was still insufficient for introducing expanded game code and new features.

The inclusion of **128 KB of SRAM** on the cartridge (accessed via 256-byte pages in the `$DF00–$DFFF` I/O window managed by `$DE01` and `$DE03` registers) was crucial: even without implementing a complex file system like MDP-FS, this SRAM space is directly leveraged to host extended game code, acting as true auxiliary RAM for buffers, on-the-fly decompression, and complex state tracking.

---

### 3. Instant, Secure, and Time-Proof Save States
Investigative games demand frequent saving. Compared to the slow, error-prone process of floppy disk writes:
* **Battery-Backed SRAM:** Allows saving the exact game state instantly without operational delays, retaining data even when the C64 is powered off.
* **EEPROM Backup (Non-Volatile):** Overcomes the physical lifespan limit of the backup battery. By backing up progress to the integrated EEPROM (8KB or 32KB), save data remains permanently archived over time regardless of battery charge state.

---

### 4. Dedicated MDP Manager and ROM Save Manager
Integrating dedicated utility software directly within the cartridge ROM elevates the remaster's polish:
* **Magic Desk Plus Manager:** Handles clean hardware initialization on boot and memory detection, taking system control in a transparent, reliable manner.
* **Save Manager:** Provides the user with an intuitive interface for managing multiple save slots. Using dedicated hardware signatures, it verifies save data integrity prior to loading and transparently handles non-volatile EEPROM transfers (respecting necessary cell write delays).

---

### 5. Graphical Polish and Sprite Restyling
To top off this comprehensive enhancement, an important graphical upgrade was performed: some character sprites were meticulously redrawn to closely resemble the original artwork and character "portraits."

![newsprites](./murder.png)

---

### Why Not an EasyFlash Release?
Addressing this hypothetical question highlights why the Magic Desk Plus hardware was the superior choice:
* **Continuous Disk Writes for Gameplay Notes:** In the original game, the disk drive is continuously accessed for write operations to update notebook entries and record game progress.
* **Flash Memory Limitations (EasyFlash):** EasyFlash relies on Flash ROM. While reprogrammable on the C64, Flash memory is **not designed for random, frequent, high-speed write cycles**. Writing a single byte or updating a note in Flash requires erasing entire memory blocks (with slow and complex write cycles), making real-time note-taking and saves technically impractical.
* **Lack of Extended Code RAM:** EasyFlash lacks the 128 KB of true random-access SRAM necessary to expand the game code beyond the C64's native 64 KB RAM limit.

The **Magic Desk Plus** cartridge, featuring **128 KB of battery-backed static SRAM** (complemented by permanent EEPROM storage), solves both challenges simultaneously: it provides extra execution space to bypass the C64's RAM limitations and enables instantaneous, real-time updates to the notebook and game saves!

https://crystalct.itch.io/c64-murder-on-the-mississippi-remastered
