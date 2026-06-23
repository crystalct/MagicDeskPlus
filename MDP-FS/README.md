# MagicDesk Plus File System (MDP-FS)
**User Manual & Commands**

The MagicDesk Plus File System (MDP-FS) transforms the MagicDesk Plus cartridge memory expansion into an ultra-fast RAM disk. The installer transparently hooks into the Commodore 64 KERNAL routines, allowing you to use classic DOS commands just as if you were operating a real floppy drive.

## Device (Drive) Number
The RAM disk is hardcoded to respond exclusively on **Device 7** (the standard floppy drive is 8). 
This allows you to seamlessly use your physical disk (drive 8) alongside the RAM disk (drive 7) to copy files back and forth at maximum speed.

---

## Supported Commands

### 1. Formatting (Format)
The RAM disk must be initialized before first use. This command completely wipes the directory and flushes the BAM (Block Availability Map) allocation.
You can use either the short `N:` (New) command or the extended `NEW:` syntax.

*BASIC Syntax:*
```basic
OPEN 15,7,15,"N:" : CLOSE 1
```
or
```basic
OPEN 15,7,15,"NEW:" : CLOSE 1
```

### 2. Validation & Optimization (Validate)
Validation checks the integrity of the file system. In the future, this will safely reconstruct the BAM by scanning the directory and recover any "orphaned" memory blocks.

*BASIC Syntax:*
```basic
OPEN 1,7,15,"V0:" : CLOSE 1
```

### 3. Listing Disk Contents (Directory)
Displays the list of files currently stored in the cartridge memory and the total free blocks (bytes) remaining.

*BASIC Syntax:*
```basic
LOAD "$",7
LIST
```
*(Note: As with a real floppy, this command overwrites any BASIC program currently in memory).*

### 4. Saving a File (Save)
Saves the BASIC program currently in memory (or a specific memory block) directly to the RAM disk.

*BASIC Syntax:*
```basic
SAVE "FILENAME",7
```
The filename can be up to 16 characters long. 
If you attempt to save a file and there is not enough free space on the cartridge, you will get the standard `?FILE TOO LARGE ERROR` or the saving procedure will cleanly abort, rolling back any partially allocated blocks.

### 5. Loading a File (Load)
Loads a previously saved program back into memory.

*BASIC Syntax for Relative Load (BASIC start area):*
```basic
LOAD "FILENAME",7
```

*BASIC Syntax for Absolute Load (Original memory location):*
```basic
LOAD "FILENAME",7,1
```

---

## Technical Notes
- Memory-safe architecture: The handlers do not overwrite any critical *Zero Page* registers, ensuring maximum compatibility with third-party software.
- Bullet-proof saving: If you run out of disk space during a `SAVE`, MDP-FS executes an instant rollback, reverting partially written BAM blocks to keep your filesystem pristine.

