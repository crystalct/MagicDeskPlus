/*
 * magicdesk.c - Cartridge handling, Magic Desk cart.
 *
 * Written by
 *  Marco van den Heuvel <blackystardust68@yahoo.com>
 *
 * This file is part of VICE, the Versatile Commodore Emulator.
 * See README for copyright notice.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 *  02111-1307  USA.
 *
 */

/* #define MAGICDESK_DEBUG */

#include "vice.h"

#include <stdio.h>
#include <string.h>

#define CARTRIDGE_INCLUDE_SLOTMAIN_API
#include "c64cartsystem.h"
#undef CARTRIDGE_INCLUDE_SLOTMAIN_API
#include "c64mem.h"
#include "cartio.h"
#include "cartridge.h"
#include "cmdline.h"
#include "crt.h"
#include "export.h"
#include "lib.h"
#include "log.h"
#include "machine.h"
#include "magicdesk.h"
#include "monitor.h"
#include "ram.h"
#include "resources.h"
#include "snapshot.h"
#include "types.h"
#include "util.h"

#ifdef MAGICDESK_DEBUG
#define DBG(x) printf x
#else
#define DBG(x)
#endif

/*
    "Magic Desk" Cartridge

    - this cart comes in 3 sizes, 32Kb (4 banks), 64Kb (8 banks) and 128Kb (16
   banks).
      - supports "DDI Magic Cart" (32 banks, 256kb)
      - supports "Magic Desk Clone" homebrew cart (64 banks, 512kb and 128banks,
   1MB)

    - ROM is always mapped in at $8000-$9FFF (8k game).

    - 1 register at io1 / de00:

    bit 0-6   bank number
    bit 7     exrom (1 = cart disabled)
*/

#define MAXBANKS 128
#define MAGICDESK_SRAM_SIZE 131072

static uint8_t regval = 0;
static uint8_t bankmask = 0x7f;

/* Magic Desk Plus SRAM and EEPROM variables */
static int magicdesk_enabled = 0;
static int magicdesk_plus_enabled = 0;

static uint8_t *magicdesk_sram_ram = NULL;
static char *magicdesk_sram_filename = NULL;
static int magicdesk_sram_rw = 1;
static int magicdesk_sram_write_image = 0;
static int magicdesk_sram_enabled = 0;

static char *magicdesk_eeprom_filename = NULL;
static int magicdesk_eeprom_rw = 1;
static int magicdesk_eeprom_write_image = 0;
static int magicdesk_eeprom_enabled = 0;

static uint8_t magicdesk_page_reg = 0;
static uint8_t magicdesk_ctrl_reg = 0;

/* RAMINITPARAM for SRAM pattern initialization */
static RAMINITPARAM ramparam = {
    .start_value = 255,
    .value_invert = 2,
    .value_offset = 1,

    .pattern_invert = 0x100,
    .pattern_invert_value = 255,

    .random_start = 0,
    .random_repeat = 0,
    .random_chance = 0,
};

/* Parallel EEPROM placeholder structure */
typedef struct magicdesk_eeprom_s {
  uint8_t *data;
  size_t size;
  int rw;
  char *filename;
  int dirty;
} magicdesk_eeprom_t;

static magicdesk_eeprom_t magicdesk_eeprom = {NULL, 0, 0, NULL, 0};

static void magicdesk_eeprom_reset(void) {}

static int magicdesk_eeprom_open_image(const char *filename, int rw) {
  FILE *fd;
  size_t size;

  if (filename == NULL || *filename == '\0') {
    return -1;
  }

  if (magicdesk_eeprom.filename != NULL) {
    lib_free(magicdesk_eeprom.filename);
  }
  magicdesk_eeprom.filename = lib_strdup(filename);
  magicdesk_eeprom.rw = rw;
  magicdesk_eeprom.dirty = 0;

  fd = fopen(filename, "rb");
  if (fd == NULL) {
    if (rw) {
      fd = fopen(filename, "wb+");
      if (fd == NULL) {
        return -1;
      }
      magicdesk_eeprom.size = 8192;
      magicdesk_eeprom.data = lib_malloc(8192);
      memset(magicdesk_eeprom.data, 0xff, 8192);
      if (fwrite(magicdesk_eeprom.data, 1, 8192, fd) != 8192) {
        fclose(fd);
        lib_free(magicdesk_eeprom.data);
        magicdesk_eeprom.data = NULL;
        return -1;
      }
      fclose(fd);
      return 0;
    }
    return -1;
  }

  fseek(fd, 0, SEEK_END);
  size = ftell(fd);
  fseek(fd, 0, SEEK_SET);

  if (size != 8192 && size != 32768) {
    fclose(fd);
    log_message(LOG_DEFAULT,
                "MAGICDESK: Invalid EEPROM image size (must be 8K or 32K).");
    return -1;
  }

  magicdesk_eeprom.size = size;
  magicdesk_eeprom.data = lib_malloc(size);
  if (fread(magicdesk_eeprom.data, 1, size, fd) < size) {
    fclose(fd);
    lib_free(magicdesk_eeprom.data);
    magicdesk_eeprom.data = NULL;
    return -1;
  }
  fclose(fd);
  return 0;
}

static int magicdesk_eeprom_flush_image(void);

static void magicdesk_eeprom_close_image(int rw) {
  if (magicdesk_eeprom.data != NULL) {
    if (rw && magicdesk_eeprom.dirty) {
      magicdesk_eeprom_flush_image();
    }
    lib_free(magicdesk_eeprom.data);
    magicdesk_eeprom.data = NULL;
  }
  if (magicdesk_eeprom.filename != NULL) {
    lib_free(magicdesk_eeprom.filename);
    magicdesk_eeprom.filename = NULL;
  }
  magicdesk_eeprom.size = 0;
  magicdesk_eeprom.dirty = 0;
}

static int magicdesk_eeprom_save_image(const char *filename) {
  FILE *fd;

  if (magicdesk_eeprom.data == NULL || filename == NULL || *filename == '\0') {
    return -1;
  }

  fd = fopen(filename, "wb");
  if (fd == NULL) {
    return -1;
  }

  if (fwrite(magicdesk_eeprom.data, 1, magicdesk_eeprom.size, fd) !=
      magicdesk_eeprom.size) {
    fclose(fd);
    return -1;
  }
  fclose(fd);
  magicdesk_eeprom.dirty = 0;
  return 0;
}

static int magicdesk_eeprom_flush_image(void) {
  log_message(LOG_DEFAULT, "MAGICDESK: Flushing EEPROM image. Dirty: %d\n",
              magicdesk_eeprom.dirty);
  if (magicdesk_eeprom.filename != NULL && magicdesk_eeprom.dirty) {
    return magicdesk_eeprom_save_image(magicdesk_eeprom.filename);
  }
  return 0;
}

static uint8_t magicdesk_eeprom_read(uint16_t addr) {
  if (magicdesk_eeprom.data != NULL) {
    uint8_t page_mask = (magicdesk_eeprom.size == 8192) ? 0x1f : 0x7f;
    uint32_t offset =
        (((uint32_t)(magicdesk_page_reg & page_mask)) << 8) | (addr & 0xff);
    if (offset < magicdesk_eeprom.size) {
      return magicdesk_eeprom.data[offset];
    }
  }
  return 0xff;
}

static void magicdesk_eeprom_store(uint16_t addr, uint8_t value) {
  if (magicdesk_eeprom.data != NULL && magicdesk_eeprom.rw) {
    uint8_t page_mask = (magicdesk_eeprom.size == 8192) ? 0x1f : 0x7f;
    uint32_t offset =
        (((uint32_t)(magicdesk_page_reg & page_mask)) << 8) | (addr & 0xff);
    if (offset < magicdesk_eeprom.size) {
      magicdesk_eeprom.data[offset] = value;
      magicdesk_eeprom.dirty = 1;
    }
  }
}

static int magicdesk_eeprom_snapshot_write(struct snapshot_s *s) {
  snapshot_module_t *m;
  uint32_t size = (uint32_t)magicdesk_eeprom.size;

  m = snapshot_module_create(s, "MD_EEPROM", 0, 1);
  if (m == NULL) {
    return -1;
  }
  if (SMW_DW(m, size) < 0) {
    snapshot_module_close(m);
    return -1;
  }
  if (magicdesk_eeprom.data != NULL) {
    if (SMW_BA(m, magicdesk_eeprom.data, size) < 0) {
      snapshot_module_close(m);
      return -1;
    }
  }
  snapshot_module_close(m);
  return 0;
}

static int magicdesk_eeprom_snapshot_read(struct snapshot_s *s) {
  uint8_t vmajor, vminor;
  snapshot_module_t *m;
  uint32_t size;

  m = snapshot_module_open(s, "MD_EEPROM", &vmajor, &vminor);
  if (m == NULL) {
    return -1;
  }

  if (SMR_DW(m, &size) < 0) {
    snapshot_module_close(m);
    return -1;
  }

  if (size != 8192 && size != 32768 && size != 0) {
    snapshot_module_close(m);
    return -1;
  }

  if (size > 0) {
    if (magicdesk_eeprom.data != NULL) {
      if (magicdesk_eeprom.size != size) {
        lib_free(magicdesk_eeprom.data);
        magicdesk_eeprom.data = lib_malloc(size);
      }
    } else {
      magicdesk_eeprom.data = lib_malloc(size);
    }
    magicdesk_eeprom.size = size;

    if (SMR_BA(m, magicdesk_eeprom.data, size) < 0) {
      snapshot_module_close(m);
      return -1;
    }
  }

  snapshot_module_close(m);
  return 0;
}

/* SRAM activate/deactivate helpers */
static void magicdesk_sram_activate(void) {
  if (magicdesk_sram_filename != NULL && *magicdesk_sram_filename != '\0') {
    magicdesk_sram_enabled = 1;
    if (magicdesk_sram_ram == NULL) {
      magicdesk_sram_ram = lib_malloc(MAGICDESK_SRAM_SIZE);
      ram_init_with_pattern(magicdesk_sram_ram, MAGICDESK_SRAM_SIZE, &ramparam);
    }

    if (util_file_load(magicdesk_sram_filename, magicdesk_sram_ram,
                       MAGICDESK_SRAM_SIZE, UTIL_FILE_LOAD_RAW) < 0) {
      if (!util_file_exists(magicdesk_sram_filename)) {
        util_file_save(magicdesk_sram_filename, magicdesk_sram_ram,
                       MAGICDESK_SRAM_SIZE);
      }
    }
  } else {
    magicdesk_sram_enabled = 0;
    if (magicdesk_sram_ram != NULL) {
      lib_free(magicdesk_sram_ram);
      magicdesk_sram_ram = NULL;
    }
  }
}

static void magicdesk_sram_deactivate(void) {
  if (magicdesk_sram_ram != NULL) {
    if (magicdesk_sram_filename != NULL && *magicdesk_sram_filename != '\0') {
      if (magicdesk_sram_write_image) {
        util_file_save(magicdesk_sram_filename, magicdesk_sram_ram,
                       MAGICDESK_SRAM_SIZE);
      }
    }
    lib_free(magicdesk_sram_ram);
    magicdesk_sram_ram = NULL;
  }
  magicdesk_sram_enabled = 0;
}

/* EEPROM activate/deactivate helpers */
static void magicdesk_eeprom_activate(void) {
  if (magicdesk_eeprom_filename != NULL && *magicdesk_eeprom_filename != '\0') {
    magicdesk_eeprom_enabled = 1;
    magicdesk_eeprom_open_image(magicdesk_eeprom_filename, magicdesk_eeprom_rw);
  } else {
    magicdesk_eeprom_enabled = 0;
    magicdesk_eeprom_close_image(magicdesk_eeprom_rw);
  }
}

static void magicdesk_eeprom_deactivate(void) {
  if (magicdesk_eeprom_enabled) {
    if (magicdesk_eeprom_write_image) {
      magicdesk_eeprom_flush_image();
    }
    magicdesk_eeprom_close_image(magicdesk_eeprom_rw);
  }
  magicdesk_eeprom_enabled = 0;
}

static void magicdesk_io1_store(uint16_t addr, uint8_t value) {
  if (magicdesk_sram_enabled || magicdesk_eeprom_enabled) {
    switch (addr & 0x03) {
    case 0:
      regval = value & (0x80 | bankmask);
      cart_romlbank_set_slotmain(value & bankmask);
      cart_set_port_game_slotmain(0);
      if (value & 0x80) {
        cart_set_port_exrom_slotmain(0);
      } else {
        cart_set_port_exrom_slotmain(1);
      }
      cart_port_config_changed_slotmain();
      break;
    case 1:
      magicdesk_page_reg = value;
      break;
    case 2:
      /* unused */
      break;
    case 3:
      magicdesk_ctrl_reg = value;
      break;
    }
  } else {
    regval = value & (0x80 | bankmask);
    cart_romlbank_set_slotmain(value & bankmask);
    cart_set_port_game_slotmain(0);
    if (value & 0x80) {
      cart_set_port_exrom_slotmain(0);
    } else {
      cart_set_port_exrom_slotmain(1);
    }
    cart_port_config_changed_slotmain();
  }
  DBG(("MAGICDESK: Reg: %02x (Bank: %d of %d, %s)\n", regval,
       (regval & bankmask), bankmask + 1,
       (regval & 0x80) ? "disabled" : "enabled"));
}

static uint8_t magicdesk_io1_peek(uint16_t addr) {
  if (magicdesk_sram_enabled || magicdesk_eeprom_enabled) {
    switch (addr & 0x03) {
    case 0:
      return regval;
    case 1:
      return magicdesk_page_reg;
    case 2:
      return 0;
    case 3:
      return magicdesk_ctrl_reg;
    }
  }
  return regval;
}

static io_source_t magicdesk_io2_device;

static uint8_t magicdesk_io2_read(uint16_t addr) {
  magicdesk_io2_device.io_source_valid = 0;

  int memory_select = (magicdesk_ctrl_reg >> 5) & 1;

  if (memory_select == 1) {
    if (magicdesk_sram_enabled && magicdesk_sram_ram != NULL) {
      magicdesk_io2_device.io_source_valid = 1;
      uint32_t bank = magicdesk_ctrl_reg & 1;
      uint32_t page = magicdesk_page_reg;
      uint32_t offset = addr & 0xff;
      return magicdesk_sram_ram[(bank << 16) | (page << 8) | offset];
    }
  } else {
    if (magicdesk_eeprom_enabled) {
      magicdesk_io2_device.io_source_valid = 1;
      return magicdesk_eeprom_read(addr);
    }
  }

  return 0;
}

static void magicdesk_io2_store(uint16_t addr, uint8_t value) {
  int memory_select = (magicdesk_ctrl_reg >> 5) & 1;

  if (memory_select == 1) {
    if (magicdesk_sram_enabled && magicdesk_sram_ram != NULL) {
      uint32_t bank = magicdesk_ctrl_reg & 1;
      uint32_t page = magicdesk_page_reg;
      uint32_t offset = addr & 0xff;
      magicdesk_sram_ram[(bank << 16) | (page << 8) | offset] = value;
    }
  } else {
    if (magicdesk_eeprom_enabled) {
      magicdesk_eeprom_store(addr, value);
    }
  }
}

static int magicdesk_dump(void) {
  mon_out("Reg: %02x (Bank: %d of %d, %s)\n", regval, (regval & bankmask),
          bankmask + 1, (regval & 0x80) ? "disabled" : "enabled");
  if (magicdesk_sram_enabled || magicdesk_eeprom_enabled) {
    mon_out("Page Reg: %02x, Ctrl Reg: %02x\n", magicdesk_page_reg,
            magicdesk_ctrl_reg);
    mon_out("SRAM Enabled: %d, EEPROM Enabled: %d\n", magicdesk_sram_enabled,
            magicdesk_eeprom_enabled);
  }
  return 0;
}

static io_source_t magicdesk_device = {
    CARTRIDGE_NAME_MAGIC_DESK, /* name of the device */
    IO_DETACH_CART, /* use cartridge ID to detach the device when involved in a
                       read-collision */
    IO_DETACH_NO_RESOURCE, /* does not use a resource for detach */
    0xde00,
    0xdeff,
    0xff,                /* range for the device, address is ignored, reg:$de00,
                            mirrors:$de01-$deff */
    0,                   /* read is never valid, reg is write only */
    magicdesk_io1_store, /* store function */
    NULL,                /* NO poke function */
    NULL,                /* read function */
    magicdesk_io1_peek,  /* peek function */
    magicdesk_dump,      /* device state information dump function */
    CARTRIDGE_MAGIC_DESK, /* cartridge ID */
    IO_PRIO_NORMAL, /* normal priority, device read needs to be checked for
                       collisions */
    0, /* insertion order, gets filled in by the registration function */
    IO_MIRROR_NONE /* NO mirroring */
};

static io_source_t magicdesk_io2_device = {
    CARTRIDGE_NAME_MAGIC_DESK, /* name of the device */
    IO_DETACH_CART,            /* use cartridge ID to detach */
    IO_DETACH_NO_RESOURCE,
    0xdf00,
    0xdfff,
    0xff,                /* range: $df00-$dfff, mirror: 0xff */
    0,                   /* read validity checked dynamically */
    magicdesk_io2_store, /* store function */
    NULL,
    magicdesk_io2_read, /* read function */
    magicdesk_io2_read, /* peek function */
    magicdesk_dump,
    CARTRIDGE_MAGIC_DESK,
    IO_PRIO_NORMAL,
    0,
    IO_MIRROR_NONE};

static io_source_list_t *magicdesk_list_item = NULL;
static io_source_list_t *magicdesk_io2_list_item = NULL;

static const export_resource_t export_res = {
    CARTRIDGE_NAME_MAGIC_DESK, 0, 1, &magicdesk_device, &magicdesk_io2_device,
    CARTRIDGE_MAGIC_DESK};

/* ---------------------------------------------------------------------*/

void magicdesk_config_init(void) {
  cart_config_changed_slotmain(CMODE_8KGAME, CMODE_8KGAME, CMODE_READ);
  magicdesk_io1_store((uint16_t)0xde00, 0);
  magicdesk_page_reg = 0;
  magicdesk_ctrl_reg = 0;
  magicdesk_eeprom_reset();
}

void magicdesk_config_setup(uint8_t *rawcart) {
  memcpy(roml_banks, rawcart, 0x2000 * MAXBANKS);
  cart_config_changed_slotmain(CMODE_8KGAME, CMODE_8KGAME, CMODE_READ);
}

/* ---------------------------------------------------------------------*/

static int magicdesk_common_attach(void) {
  if (export_add(&export_res) < 0) {
    return -1;
  }
  magicdesk_list_item = io_source_register(&magicdesk_device);
  magicdesk_io2_list_item = io_source_register(&magicdesk_io2_device);
  magicdesk_enabled = 1;
  magicdesk_sram_activate();
  magicdesk_eeprom_activate();

  if (cart_getid_slotmain() == CARTRIDGE_NONE) {
    cart_set_port_exrom_slotmain(0);
    cart_set_port_game_slotmain(0);
    cart_port_config_changed_slotmain();
  }
  return 0;
}

int magicdesk_bin_attach(const char *filename, uint8_t *rawcart) {
  bankmask = 0x7f;
  if (util_file_load(filename, rawcart, 0x100000, UTIL_FILE_LOAD_SKIP_ADDRESS) <
      0) {
    bankmask = 0x3f;
    if (util_file_load(filename, rawcart, 0x80000,
                       UTIL_FILE_LOAD_SKIP_ADDRESS) < 0) {
      bankmask = 0x1f;
      if (util_file_load(filename, rawcart, 0x40000,
                         UTIL_FILE_LOAD_SKIP_ADDRESS) < 0) {
        bankmask = 0x0f;
        if (util_file_load(filename, rawcart, 0x20000,
                           UTIL_FILE_LOAD_SKIP_ADDRESS) < 0) {
          bankmask = 0x07;
          if (util_file_load(filename, rawcart, 0x10000,
                             UTIL_FILE_LOAD_SKIP_ADDRESS) < 0) {
            bankmask = 0x03;
            if (util_file_load(filename, rawcart, 0x8000,
                               UTIL_FILE_LOAD_SKIP_ADDRESS) < 0) {
              return -1;
            }
          }
        }
      }
    }
  }
  return magicdesk_common_attach();
}

int magicdesk_crt_attach(FILE *fd, uint8_t *rawcart) {
  crt_chip_header_t chip;
  int lastbank = 0;

  while (1) {
    if (crt_read_chip_header(&chip, fd)) {
      break;
    }
    if ((chip.bank >= MAXBANKS) ||
        ((chip.start != 0x8000) && (chip.start != 0xa000)) ||
        (chip.size != 0x2000)) {
      return -1;
    }
    if (crt_read_chip(rawcart, chip.bank << 13, &chip, fd)) {
      return -1;
    }
    if (chip.bank > lastbank) {
      lastbank = chip.bank;
    }
  }
  if (lastbank >= 128) {
    /* more than 128 banks does not work */
    return -1;
  } else if (lastbank >= 64) {
    /* min 65, max 128 banks */
    bankmask = 0x7f;
  } else if (lastbank >= 32) {
    /* min 33, max 64 banks */
    bankmask = 0x3f;
  } else if (lastbank >= 16) {
    /* min 17, max 32 banks */
    bankmask = 0x1f;
  } else if (lastbank >= 8) {
    /* min 9, max 16 banks */
    bankmask = 0x0f;
  } else if (lastbank >= 4) {
    /* min 5, max 8 banks */
    bankmask = 0x07;
  } else {
    /* max 4 banks */
    bankmask = 0x03;
  }
  return magicdesk_common_attach();
}

void magicdesk_detach(void) {
  magicdesk_sram_deactivate();
  magicdesk_eeprom_deactivate();

  export_remove(&export_res);
  io_source_unregister(magicdesk_list_item);
  magicdesk_list_item = NULL;
  io_source_unregister(magicdesk_io2_list_item);
  magicdesk_io2_list_item = NULL;
  magicdesk_enabled = 0;
}

void magicdesk_shutdown(void) {
  if (magicdesk_enabled) {
    magicdesk_detach();
  }
}

/* ---------------------------------------------------------------------*/

/* CARTMAGICD snapshot module format:

   type  | name       | description
   --------------------------------
   BYTE  | regval     | bank register value
   BYTE  | bankmask   | bank mask
   ARRAY | roml_banks | 128 * 8192 bytes of ROM data
   BYTE  | sram_enabled   | SRAM enabled flag
   BYTE  | eeprom_enabled | EEPROM enabled flag
   BYTE  | page_reg   | page register value
   BYTE  | ctrl_reg   | control register value
   ARRAY | sram_ram   | SRAM data (131072 bytes, only if sram_enabled != 0)
 */

#define CART_DUMP_VER_MAJOR 0
#define CART_DUMP_VER_MINOR 3
#define SNAP_MODULE_NAME "CARTMAGICD"

int magicdesk_snapshot_write_module(snapshot_t *s) {
  snapshot_module_t *m;

  m = snapshot_module_create(s, SNAP_MODULE_NAME, CART_DUMP_VER_MAJOR,
                             CART_DUMP_VER_MINOR);
  if (m == NULL) {
    return -1;
  }

  if (0 || (SMW_B(m, (uint8_t)regval) < 0) ||
      (SMW_B(m, (uint8_t)bankmask) < 0) ||
      (SMW_BA(m, roml_banks, 0x2000 * MAXBANKS) < 0) ||
      (SMW_B(m, (uint8_t)magicdesk_sram_enabled) < 0) ||
      (SMW_B(m, (uint8_t)magicdesk_eeprom_enabled) < 0) ||
      (SMW_B(m, magicdesk_page_reg) < 0) ||
      (SMW_B(m, magicdesk_ctrl_reg) < 0)) {
    snapshot_module_close(m);
    return -1;
  }

  if (magicdesk_sram_enabled) {
    if (SMW_BA(m, magicdesk_sram_ram, MAGICDESK_SRAM_SIZE) < 0) {
      snapshot_module_close(m);
      return -1;
    }
  }

  snapshot_module_close(m);

  if (magicdesk_eeprom_enabled) {
    if (magicdesk_eeprom_snapshot_write(s) < 0) {
      return -1;
    }
  }

  return 0;
}

int magicdesk_snapshot_read_module(snapshot_t *s) {
  uint8_t vmajor, vminor;
  snapshot_module_t *m;

  m = snapshot_module_open(s, SNAP_MODULE_NAME, &vmajor, &vminor);
  if (m == NULL) {
    return -1;
  }

  if (vmajor != CART_DUMP_VER_MAJOR || vminor < 2) {
    snapshot_module_close(m);
    return -1;
  }

  if (0 || (SMR_B(m, &regval) < 0) || (SMR_B(m, &bankmask) < 0) ||
      (SMR_BA(m, roml_banks, 0x2000 * MAXBANKS) < 0)) {
    snapshot_module_close(m);
    return -1;
  }

  uint8_t sram_enabled = 0;
  uint8_t eeprom_enabled = 0;
  uint8_t page_reg = 0;
  uint8_t ctrl_reg = 0;

  if (vminor >= 3) {
    if (0 || (SMR_B(m, &sram_enabled) < 0) || (SMR_B(m, &eeprom_enabled) < 0) ||
        (SMR_B(m, &page_reg) < 0) || (SMR_B(m, &ctrl_reg) < 0)) {
      snapshot_module_close(m);
      return -1;
    }

    if (sram_enabled) {
      magicdesk_sram_ram = lib_malloc(MAGICDESK_SRAM_SIZE);
      if (SMR_BA(m, magicdesk_sram_ram, MAGICDESK_SRAM_SIZE) < 0) {
        snapshot_module_close(m);
        lib_free(magicdesk_sram_ram);
        magicdesk_sram_ram = NULL;
        return -1;
      }
    }
  }

  snapshot_module_close(m);

  magicdesk_sram_enabled = sram_enabled;
  magicdesk_eeprom_enabled = eeprom_enabled;
  magicdesk_page_reg = page_reg;
  magicdesk_ctrl_reg = ctrl_reg;

  if (magicdesk_common_attach() == -1) {
    return -1;
  }

  if (eeprom_enabled && vminor >= 3) {
    if (magicdesk_eeprom_snapshot_read(s) < 0) {
      return -1;
    }
  }

  magicdesk_io1_store(0xde00, regval);
  return 0;
}

/* Resources & command-line callbacks */
static int set_magicdesk_sram_filename(const char *name, void *param) {
  if (magicdesk_sram_filename != NULL && name != NULL &&
      strcmp(name, magicdesk_sram_filename) == 0) {
    return 0;
  }

  if (name != NULL && *name != '\0') {
    if (util_check_filename_access(name) < 0) {
      return -1;
    }
  }

  if (magicdesk_enabled) {
    magicdesk_sram_deactivate();
    util_string_set(&magicdesk_sram_filename, name);
    magicdesk_sram_activate();
  } else {
    util_string_set(&magicdesk_sram_filename, name);
  }
  return 0;
}

static int set_magicdesk_sram_rw(int val, void *param) {
  magicdesk_sram_rw = val ? 1 : 0;
  return 0;
}

static int set_magicdesk_sram_write(int val, void *param) {
  magicdesk_sram_write_image = val ? 1 : 0;
  return 0;
}

static int set_magicdesk_eeprom_filename(const char *name, void *param) {
  if (magicdesk_eeprom_filename != NULL && name != NULL &&
      strcmp(name, magicdesk_eeprom_filename) == 0) {
    return 0;
  }

  if (name != NULL && *name != '\0') {
    if (util_check_filename_access(name) < 0) {
      return -1;
    }
  }

  if (magicdesk_enabled) {
    magicdesk_eeprom_deactivate();
    util_string_set(&magicdesk_eeprom_filename, name);
    magicdesk_eeprom_activate();
  } else {
    util_string_set(&magicdesk_eeprom_filename, name);
  }
  return 0;
}

static int set_magicdesk_eeprom_rw(int val, void *param) {
  magicdesk_eeprom_rw = val ? 1 : 0;
  return 0;
}

static int set_magicdesk_eeprom_write(int val, void *param) {
  magicdesk_eeprom_write_image = val ? 1 : 0;
  return 0;
}

static int set_magicdesk_plus_enabled(int val, void *param) {
  int new_val = val ? 1 : 0;
  if (magicdesk_plus_enabled == new_val) {
    return 0;
  }

  /* power-cycle the machine when toggling Plus emulation on or off */
  cart_power_off();

  magicdesk_plus_enabled = new_val;

  if (magicdesk_plus_enabled) {
    int active_cart = cart_getid_slotmain();
    if (active_cart != CARTRIDGE_NONE && active_cart != CARTRIDGE_MAGIC_DESK &&
        active_cart != CARTRIDGE_MAGIC_DESK_16) {
      resources_set_int("CartridgeType", CARTRIDGE_NONE);
      resources_set_string("CartridgeFile", "");
    }

    if (cart_getid_slotmain() == CARTRIDGE_NONE) {
      if (!magicdesk_enabled) {
        magicdesk_common_attach();
      }
    }
  } else {
    if (cart_getid_slotmain() == CARTRIDGE_NONE) {
      if (magicdesk_enabled) {
        magicdesk_detach();
      }
    }
  }
  return 0;
}

/* --------------------------------------------------------------------------
 * Public SRAM save/flush API (called from c64carthooks.c)
 * -------------------------------------------------------------------------- */

/** \brief  Check if SRAM secondary image can be saved (always yes when Plus is
 * active) */
int magicdesk_can_save_sram(void) { return magicdesk_plus_enabled ? 1 : 0; }

/** \brief  Check if SRAM secondary image can be flushed (Plus active + filename
 * set) */
int magicdesk_can_flush_sram(void) {
  if (!magicdesk_plus_enabled) {
    return 0;
  }
  if (magicdesk_sram_filename == NULL || *magicdesk_sram_filename == '\0') {
    return 0;
  }
  return 1;
}

/** \brief  Save SRAM contents to \a filename */
int magicdesk_sram_save(const char *filename) {
  if (magicdesk_sram_ram == NULL) {
    return -1;
  }
  if (filename == NULL) {
    return -1;
  }
  if (util_file_save(filename, magicdesk_sram_ram, MAGICDESK_SRAM_SIZE) < 0) {
    log_message(LOG_DEFAULT, "MAGICDESK: Writing SRAM image %s failed.",
                filename);
    return -1;
  }
  log_message(LOG_DEFAULT, "MAGICDESK: Writing SRAM image %s.", filename);
  return 0;
}

/** \brief  Flush SRAM contents to the currently configured filename */
int magicdesk_sram_flush(void) {
  return magicdesk_sram_save(magicdesk_sram_filename);
}

/** \brief  Check if EEPROM tertiary image can be saved (always yes when Plus is
 * active) */
int magicdesk_can_save_eeprom(void) { return magicdesk_plus_enabled ? 1 : 0; }

/** \brief  Check if EEPROM tertiary image can be flushed (Plus active +
 * filename set) */
int magicdesk_can_flush_eeprom(void) {
  if (!magicdesk_plus_enabled) {
    return 0;
  }
  if (magicdesk_eeprom_filename == NULL || *magicdesk_eeprom_filename == '\0') {
    return 0;
  }
  return 1;
}

/** \brief  Save EEPROM contents to \a filename */
int magicdesk_eeprom_save(const char *filename) {
  if (magicdesk_eeprom.data == NULL) {
    return -1;
  }
  if (filename == NULL) {
    return -1;
  }
  if (magicdesk_eeprom_save_image(filename) < 0) {
    log_message(LOG_DEFAULT, "MAGICDESK: Writing EEPROM image %s failed.",
                filename);
    return -1;
  }
  log_message(LOG_DEFAULT, "MAGICDESK: Writing EEPROM image %s.", filename);
  return 0;
}

/** \brief  Flush EEPROM contents to the currently configured filename */
int magicdesk_eeprom_flush(void) {
  return magicdesk_eeprom_save(magicdesk_eeprom_filename);
}

static const resource_string_t resources_string[] = {
    {"MagicDeskSRAMImage", "", RES_EVENT_NO, NULL, &magicdesk_sram_filename,
     set_magicdesk_sram_filename, NULL},
    {"MagicDeskEEPROMImage", "", RES_EVENT_NO, NULL, &magicdesk_eeprom_filename,
     set_magicdesk_eeprom_filename, NULL},
    RESOURCE_STRING_LIST_END};

static const resource_int_t resources_int[] = {
    {"MagicDeskPlus", 0, RES_EVENT_NO, NULL, &magicdesk_plus_enabled,
     set_magicdesk_plus_enabled, NULL},
    {"MagicDeskSRAMRW", 1, RES_EVENT_NO, NULL, &magicdesk_sram_rw,
     set_magicdesk_sram_rw, NULL},
    {"MagicDeskSRAMWrite", 1, RES_EVENT_NO, NULL, &magicdesk_sram_write_image,
     set_magicdesk_sram_write, NULL},
    {"MagicDeskEEPROMRW", 1, RES_EVENT_NO, NULL, &magicdesk_eeprom_rw,
     set_magicdesk_eeprom_rw, NULL},
    {"MagicDeskEEPROMWrite", 1, RES_EVENT_NO, NULL,
     &magicdesk_eeprom_write_image, set_magicdesk_eeprom_write, NULL},
    RESOURCE_INT_LIST_END};

int magicdesk_resources_init(void) {
  if (resources_register_string(resources_string) < 0) {
    return -1;
  }
  return resources_register_int(resources_int);
}

void magicdesk_resources_shutdown(void) {
  lib_free(magicdesk_sram_filename);
  magicdesk_sram_filename = NULL;
  lib_free(magicdesk_eeprom_filename);
  magicdesk_eeprom_filename = NULL;
}

static const cmdline_option_t cmdline_options[] = {
    {"-magicdeskplus", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskPlus", (resource_value_t)1, NULL,
     "Enable Magic Desk Plus emulation"},
    {"+magicdeskplus", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskPlus", (resource_value_t)0, NULL,
     "Disable Magic Desk Plus emulation"},
    {"-magicdesksramimage", SET_RESOURCE, CMDLINE_ATTRIB_NEED_ARGS, NULL, NULL,
     "MagicDeskSRAMImage", NULL, "<filename>",
     "Specify Magic Desk SRAM image filename"},
    {"-magicdesksramrw", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskSRAMRW", (resource_value_t)1, NULL,
     "Enable writes to Magic Desk SRAM image"},
    {"+magicdesksramrw", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskSRAMRW", (resource_value_t)0, NULL,
     "Disable writes to Magic Desk SRAM image"},
    {"-magicdesksramwrite", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskSRAMWrite", (resource_value_t)1, NULL,
     "Enable saving of the Magic Desk SRAM image at exit"},
    {"+magicdesksramwrite", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskSRAMWrite", (resource_value_t)0, NULL,
     "Disable saving of the Magic Desk SRAM image at exit"},

    {"-magicdeskeepromimage", SET_RESOURCE, CMDLINE_ATTRIB_NEED_ARGS, NULL,
     NULL, "MagicDeskEEPROMImage", NULL, "<filename>",
     "Specify Magic Desk EEPROM image filename"},
    {"-magicdeskeepromrw", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskEEPROMRW", (resource_value_t)1, NULL,
     "Enable writes to Magic Desk EEPROM image"},
    {"+magicdeskeepromrw", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskEEPROMRW", (resource_value_t)0, NULL,
     "Disable writes to Magic Desk EEPROM image"},
    {"-magicdeskeepromwrite", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskEEPROMWrite", (resource_value_t)1, NULL,
     "Enable saving of the Magic Desk EEPROM image at exit"},
    {"+magicdeskeepromwrite", SET_RESOURCE, CMDLINE_ATTRIB_NONE, NULL, NULL,
     "MagicDeskEEPROMWrite", (resource_value_t)0, NULL,
     "Disable saving of the Magic Desk EEPROM image at exit"},
    CMDLINE_LIST_END};

int magicdesk_cmdline_options_init(void) {
  return cmdline_register_options(cmdline_options);
}
