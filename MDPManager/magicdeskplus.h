#ifndef MAGICDESKPLUS_H
#define MAGICDESKPLUS_H

/**
 * @file magicdeskplus.h
 * @brief Hardware abstraction layer per la cartuccia Magic Desk Plus.
 *
 * Registri:
 *   $DE00 - Bank switching ROM classico (inalterato)
 *   $DE01 - Selezione pagina SRAM (0-255), una pagina = 256 byte
 *   $DE03 - Controllo SRAM:
 *            Bit 0: selezione porzione (0 = prima 64KB, 1 = seconda 64KB)
 *            Bit 5: abilitazione SRAM (1 = attiva, 0 = disattivata)
 *
 * Finestra I/O:
 *   $DF00 - $DFFF (256 byte) - accesso alla pagina SRAM selezionata
 *
 * Byte di identificazione:
 *   Indirizzo assoluto $1FFFE-$1FFFF (Banco 1, Pagina 255, offset $FE-$FF)
 *   Valori attesi: $CA, $F1 = "SRAM inizializzata"
 */

#include <stdint.h>
#include <stdbool.h>

/* ------------------------------------------------------------------ */
/*  Registri hardware                                                  */
/* ------------------------------------------------------------------ */

#define MDP_REG_BANK    ((volatile uint8_t *)0xDE00)  /* ROM bank (classico) */
#define MDP_REG_PAGE    ((volatile uint8_t *)0xDE01)  /* Pagina SRAM 0-255   */
#define MDP_REG_CTRL    ((volatile uint8_t *)0xDE03)  /* Controllo SRAM      */

#define MDP_SRAM_WINDOW ((volatile uint8_t *)0xDF00)  /* Finestra 256 byte   */

/* Bit mask per $DE03 */
#define MDP_CTRL_BANK_BIT  0x01   /* Bit 0: selezione porzione 64KB */
#define MDP_CTRL_SRAM_BIT  0x20   /* Bit 5: abilitazione SRAM      */

/* Byte di identificazione per SRAM inizializzata */
#define MDP_SIGNATURE_0    0xCA
#define MDP_SIGNATURE_1    0xF1

/* Posizione della firma: Banco 1, Pagina 255, offset 254-255 */
#define MDP_SIG_BANK       1
#define MDP_SIG_PAGE       255
#define MDP_SIG_OFFSET_0   0xFE
#define MDP_SIG_OFFSET_1   0xFF

/* Risultati del rilevamento SRAM */
#define MDP_DETECT_ABSENT         0   /* SRAM non presente/non funzionante */
#define MDP_DETECT_PRESENT_INIT   1   /* SRAM presente e inizializzata     */
#define MDP_DETECT_PRESENT_UNINIT 2   /* SRAM presente ma non inizializzata */

/* ------------------------------------------------------------------ */
/*  Variabile di stato del registro $DE03                              */
/* ------------------------------------------------------------------ */

/* Manteniamo una copia software del valore corrente di $DE03,
   poiché il registro hardware potrebbe non essere leggibile. */
static uint8_t mdp_ctrl_shadow = 0x00;

/* ------------------------------------------------------------------ */
/*  Funzioni di controllo SRAM                                         */
/* ------------------------------------------------------------------ */

/** Abilita la SRAM (Bit 5 = 1) */
static void mdp_sram_enable(void) {
  mdp_ctrl_shadow |= MDP_CTRL_SRAM_BIT;
  *MDP_REG_CTRL = mdp_ctrl_shadow;
}

/** Disabilita la SRAM (Bit 5 = 0) */
static void mdp_sram_disable(void) {
  mdp_ctrl_shadow &= ~MDP_CTRL_SRAM_BIT;
  *MDP_REG_CTRL = mdp_ctrl_shadow;
}

/** Ritorna true se la SRAM è attualmente abilitata (nella copia shadow) */
static bool mdp_sram_is_enabled(void) {
  return (mdp_ctrl_shadow & MDP_CTRL_SRAM_BIT) != 0;
}

/** Seleziona il banco SRAM (0 = prima porzione 64KB, 1 = seconda porzione) */
static void mdp_set_bank(uint8_t bank) {
  if (bank)
    mdp_ctrl_shadow |= MDP_CTRL_BANK_BIT;
  else
    mdp_ctrl_shadow &= ~MDP_CTRL_BANK_BIT;
  *MDP_REG_CTRL = mdp_ctrl_shadow;
}

/** Ritorna il banco attualmente selezionato (0 o 1) */
static uint8_t mdp_get_bank(void) {
  return (mdp_ctrl_shadow & MDP_CTRL_BANK_BIT) ? 1 : 0;
}

/** Seleziona la pagina SRAM (0-255) nella finestra $DF00-$DFFF */
static void mdp_set_page(uint8_t page) {
  *MDP_REG_PAGE = page;
}

/** Legge un byte dalla pagina SRAM corrente all'offset dato (0-255) */
static uint8_t mdp_read_byte(uint8_t offset) {
  return MDP_SRAM_WINDOW[offset];
}

/** Scrive un byte nella pagina SRAM corrente all'offset dato (0-255) */
static void mdp_write_byte(uint8_t offset, uint8_t value) {
  MDP_SRAM_WINDOW[offset] = value;
}

/* ------------------------------------------------------------------ */
/*  Rilevamento e inizializzazione SRAM                                */
/* ------------------------------------------------------------------ */

/**
 * Rileva la presenza e lo stato della SRAM.
 *
 * Ritorna:
 *   MDP_DETECT_ABSENT         - SRAM non presente o non funzionante
 *   MDP_DETECT_PRESENT_INIT   - SRAM presente e inizializzata ($CA,$F1)
 *   MDP_DETECT_PRESENT_UNINIT - SRAM presente ma non inizializzata
 */
static uint8_t mdp_detect_sram(void) {
  uint8_t old_shadow = mdp_ctrl_shadow;
  uint8_t result = MDP_DETECT_ABSENT;

  /* Abilita SRAM e seleziona Banco 1 */
  mdp_ctrl_shadow = MDP_CTRL_SRAM_BIT | MDP_CTRL_BANK_BIT;
  *MDP_REG_CTRL = mdp_ctrl_shadow;

  /* Seleziona Pagina 255 */
  mdp_set_page(MDP_SIG_PAGE);

  /* Leggi i byte di firma */
  uint8_t b0 = MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0];
  uint8_t b1 = MDP_SRAM_WINDOW[MDP_SIG_OFFSET_1];

  if (b0 == MDP_SIGNATURE_0 && b1 == MDP_SIGNATURE_1) {
    result = MDP_DETECT_PRESENT_INIT;
  } else {
    /* Test di funzionalita': salva, scrivi, verifica, ripristina */
    uint8_t saved0 = b0;
    uint8_t saved1 = b1;

    MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0] = MDP_SIGNATURE_0;
    MDP_SRAM_WINDOW[MDP_SIG_OFFSET_1] = MDP_SIGNATURE_1;

    uint8_t v0 = MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0];
    uint8_t v1 = MDP_SRAM_WINDOW[MDP_SIG_OFFSET_1];

    if (v0 == MDP_SIGNATURE_0 && v1 == MDP_SIGNATURE_1) {
      result = MDP_DETECT_PRESENT_UNINIT;
    }

    /* Ripristina i valori originali */
    MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0] = saved0;
    MDP_SRAM_WINDOW[MDP_SIG_OFFSET_1] = saved1;
  }

  /* Ripristina lo stato precedente dei registri */
  mdp_ctrl_shadow = old_shadow;
  *MDP_REG_CTRL = mdp_ctrl_shadow;

  return result;
}

/**
 * Scrive la firma di inizializzazione $CA,$F1 agli ultimi due byte
 * della SRAM (Banco 1, Pagina 255, offset $FE-$FF).
 */
static void mdp_write_signature(void) {
  uint8_t old_shadow = mdp_ctrl_shadow;

  mdp_ctrl_shadow = MDP_CTRL_SRAM_BIT | MDP_CTRL_BANK_BIT;
  *MDP_REG_CTRL = mdp_ctrl_shadow;
  mdp_set_page(MDP_SIG_PAGE);

  MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0] = MDP_SIGNATURE_0;
  MDP_SRAM_WINDOW[MDP_SIG_OFFSET_1] = MDP_SIGNATURE_1;

  mdp_ctrl_shadow = old_shadow;
  *MDP_REG_CTRL = mdp_ctrl_shadow;
}

/* ------------------------------------------------------------------ */
/*  Rilevamento e controllo EEPROM                                     */
/* ------------------------------------------------------------------ */

#define MDP_EEPROM_SIG_PAGE_8    31
#define MDP_EEPROM_SIG_PAGE_32   127

static void mdp_eeprom_enable(void) {
  /* Clearing Bit 5 enables EEPROM and disables SRAM */
  mdp_ctrl_shadow &= ~MDP_CTRL_SRAM_BIT;
  *MDP_REG_CTRL = mdp_ctrl_shadow;
}

static void mdp_eeprom_disable(void) {
  /* Setting Bit 5 enables SRAM and disables EEPROM */
  mdp_ctrl_shadow |= MDP_CTRL_SRAM_BIT;
  *MDP_REG_CTRL = mdp_ctrl_shadow;
}

/* Delay di 0.5ms esatti per C64 PAL, con salvataggio registro X */
static void delay_0_5ms(void) {
    __asm {
        txa
        ldx #95
    delay_loop:
        dex
        bne delay_loop
        tax
    }
}

static bool mdp_eeprom_write_byte(uint8_t page, uint8_t offset, uint8_t value) {
  mdp_eeprom_enable();
  mdp_set_page(page);
  MDP_SRAM_WINDOW[offset] = value;
  
  /* Data Polling con timeout di ~20ms (40 tentativi * 0.5ms) */
  uint8_t timeout = 40;
  while (timeout > 0) {
    if ((MDP_SRAM_WINDOW[offset] & 0x80) == (value & 0x80)) {
      return true;
    }
    delay_0_5ms();
    timeout--;
  }
  return false;
}

static bool mdp_eeprom_write_cart_page(uint8_t page, const uint8_t *buffer, uint8_t eeprom_size_kb) {
  mdp_eeprom_enable();
  mdp_set_page(page);

  if (eeprom_size_kb == 32) {
    /* AT28C256: 64-byte hardware page writes. Una pagina cartuccia (256 byte) = 4 burst da 64 */
    uint16_t offset;
    for (offset = 0; offset < 256; offset += 64) {
      uint8_t i;
      /* Burst di 64 byte in loop stretto per stare nei 150us tra byte consecutivi */
      for (i = 0; i < 64; i++) {
        MDP_SRAM_WINDOW[offset + i] = buffer[offset + i];
      }
      
      /* Data Polling sull'ultimo byte scritto */
      uint8_t last_offset = offset + 63;
      uint8_t expected = buffer[last_offset];
      uint8_t timeout = 40; /* 20ms */
      bool ok = false;
      while (timeout > 0) {
        if ((MDP_SRAM_WINDOW[last_offset] & 0x80) == (expected & 0x80)) {
          ok = true;
          break;
        }
        delay_0_5ms();
        timeout--;
      }
      if (!ok) return false;
    }
    return true;
  } else {
    /* AT28C64: scrittura byte per byte */
    uint16_t offset;
    for (offset = 0; offset < 256; offset++) {
      if (!mdp_eeprom_write_byte(page, (uint8_t)offset, buffer[offset])) {
        return false;
      }
    }
    return true;
  }
}

static uint8_t mdp_detect_eeprom(uint8_t *detected_size_kb) {
  uint8_t old_shadow = mdp_ctrl_shadow;
  uint8_t result = MDP_DETECT_ABSENT;

  mdp_eeprom_enable();

  /* 1. Test if EEPROM is present and writable at page 31 
     (Page 31 is valid for both 8KB and 32KB EEPROMs) */
  mdp_set_page(MDP_EEPROM_SIG_PAGE_8);
  uint8_t orig_8 = MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0];
  uint8_t test_val_8 = (uint8_t)~orig_8;

  mdp_eeprom_write_byte(MDP_EEPROM_SIG_PAGE_8, MDP_SIG_OFFSET_0, test_val_8);
  mdp_set_page(MDP_EEPROM_SIG_PAGE_8);
  uint8_t read_8 = MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0];

  /* Restore original value */
  mdp_eeprom_write_byte(MDP_EEPROM_SIG_PAGE_8, MDP_SIG_OFFSET_0, orig_8);

  if (read_8 != test_val_8) {
    /* Cannot write, EEPROM absent or not functional */
    mdp_ctrl_shadow = old_shadow;
    *MDP_REG_CTRL = mdp_ctrl_shadow;
    return MDP_DETECT_ABSENT;
  }

  /* 2. EEPROM is present. Now check size via aliasing between page 127 and 31.
     In an 8KB EEPROM, address lines A13 and A14 are not connected,
     so page 127 (01111111) aliases to page 31 (00011111). */
  mdp_set_page(MDP_EEPROM_SIG_PAGE_32);
  uint8_t orig_32 = MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0];

  /* Use a value guaranteed to be different from what's currently at page 31 */
  uint8_t test_val_32 = (uint8_t)~orig_8;

  mdp_eeprom_write_byte(MDP_EEPROM_SIG_PAGE_32, MDP_SIG_OFFSET_0, test_val_32);

  /* Read back from page 31 to check if it changed */
  mdp_set_page(MDP_EEPROM_SIG_PAGE_8);
  uint8_t read_alias = MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0];

  /* Restore original value at page 127 */
  mdp_eeprom_write_byte(MDP_EEPROM_SIG_PAGE_32, MDP_SIG_OFFSET_0, orig_32);

  if (read_alias == test_val_32) {
    /* Writing to 127 changed 31 -> Aliased -> 8KB */
    *detected_size_kb = 8;
  } else {
    /* Not aliased -> 32KB */
    *detected_size_kb = 32;
  }

  /* 3. Check if initialized for the detected size */
  uint8_t sig_page = (*detected_size_kb == 32) ? MDP_EEPROM_SIG_PAGE_32 : MDP_EEPROM_SIG_PAGE_8;
  mdp_set_page(sig_page);
  
  if (MDP_SRAM_WINDOW[MDP_SIG_OFFSET_0] == MDP_SIGNATURE_0 &&
      MDP_SRAM_WINDOW[MDP_SIG_OFFSET_1] == MDP_SIGNATURE_1) {
    result = MDP_DETECT_PRESENT_INIT;
  } else {
    result = MDP_DETECT_PRESENT_UNINIT;
  }

  /* Restore register state */
  mdp_ctrl_shadow = old_shadow;
  *MDP_REG_CTRL = mdp_ctrl_shadow;

  return result;
}

static void mdp_eeprom_write_signature(uint8_t size_kb) {
  uint8_t page = (size_kb == 32) ? MDP_EEPROM_SIG_PAGE_32 : MDP_EEPROM_SIG_PAGE_8;
  mdp_eeprom_write_byte(page, MDP_SIG_OFFSET_0, MDP_SIGNATURE_0);
  mdp_eeprom_write_byte(page, MDP_SIG_OFFSET_1, MDP_SIGNATURE_1);
}

#endif /* MAGICDESKPLUS_H */
