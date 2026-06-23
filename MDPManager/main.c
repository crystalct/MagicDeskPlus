/**
 * @file sram_manager.c
 * @brief Schermata di controllo "GESTIONE SRAM" per Commodore 64 - Versione per
 * oscar64
 */

#include <c64/kernalio.h>
#include <stdbool.h>
#include <stdint.h>

#define ENG 1
#define ITA 2

#if defined(LANG) && (LANG == ENG)
#include "ENG.h"
#elif defined(LANG) && (LANG == ITA)
#include "ITA.h"
#else
#include "ITA.h"
#endif

#include "magicdeskplus.h"

/* Dichiarazioni funzioni di visualizzazione */
void print_at(const char *text, uint8_t row, uint8_t col, uint8_t color);
void print_centered(const char *text, uint8_t row, uint8_t color);
void clear_row(uint8_t row, uint8_t color);
void clear_screen(uint8_t fill_color);

/* Stato globale della SRAM rilevato all'avvio */
static uint8_t sram_status = MDP_DETECT_ABSENT;
static bool lzo_enabled = false;

/* Stato globale della EEPROM rilevato all'avvio */
static uint8_t eeprom_status = MDP_DETECT_ABSENT;
static uint8_t eeprom_size_kb = 0; /* 8 o 32 */
static bool sram_mode_active = true; /* true = SRAM, false = EEPROM */

/* Strutture dati per il loader PRG */
#define MAX_PRG_FILES 30
#define VISIBLE_FILES 13
#define FILE_LIST_START_ROW 7

static char prg_names[MAX_PRG_FILES][17];
static uint16_t prg_blocks_arr[MAX_PRG_FILES];
static uint8_t prg_count = 0;

#define VIC_BORDER_COLOR ((volatile uint8_t *)0xd020)

#define VIC_BG_COLOR ((volatile uint8_t *)0xd021)
#define SCREEN_RAM ((volatile uint8_t *)0x0400)
#define COLOR_RAM ((volatile uint8_t *)0xd800)

#define COLOR_BLACK 0
#define COLOR_WHITE 1
#define COLOR_RED 2
#define COLOR_CYAN 3
#define COLOR_PURPLE 4
#define COLOR_GREEN 5
#define COLOR_BLUE 6
#define COLOR_YELLOW 7
#define COLOR_ORANGE 8
#define COLOR_BROWN 9
#define COLOR_LIGHT_RED 10
#define COLOR_DARK_GRAY 11
#define COLOR_MEDIUM_GRAY 12
#define COLOR_LIGHT_GREEN 13
#define COLOR_LIGHT_BLUE 14
#define COLOR_LIGHT_GRAY 15

#define KEY_F1 133
#define KEY_F3 134
#define KEY_F5 135
#define KEY_F7 136
#define KEY_CURSOR_DOWN 17
#define KEY_CURSOR_UP 145

// Variabile globale volatile per garantire la scrittura assoluta dall'Assembly
volatile uint8_t last_key;

static uint8_t ascii_to_screencode(char c) {
  if (c >= 'a' && c <= 'z')
    return c - 'a' + 1;
  if (c >= 'A' && c <= 'Z')
    return c - 'A' + 1;
  if (c >= '0' && c <= '9')
    return c - '0' + 48;
  if (c == ' ')
    return 32;
  if (c == '_')
    return 95;
  if (c == 164)
    return 164; // Cursore PETSCII $A4
  return (uint8_t)c;
}

static char hex_digit(uint8_t val) {
  if (val < 10)
    return '0' + val;
  return 'A' + (val - 10);
}

static uint8_t get_printable_screencode(uint8_t val) {
  if (val >= 32 && val <= 63)
    return val;
  if (val >= 65 && val <= 90)
    return val - 64;
  if (val >= 97 && val <= 122)
    return val - 96;
  return 46; // Punto '.'
}

static int mystrlen(const char *str) {
  int len = 0;
  while (str[len] != '\0')
    len++;
  return len;
}

// Converte un intero a 16 bit in stringa decimale
void uint16_to_str(uint16_t val, char *buf) {
  int i = 0;
  if (val == 0) {
    buf[i++] = '0';
  } else {
    char temp[6];
    int t = 0;
    while (val > 0) {
      temp[t++] = '0' + (val % 10);
      val /= 10;
    }
    while (t > 0) {
      buf[i++] = temp[--t];
    }
  }
  buf[i] = '\0';
}

void clear_screen(uint8_t fill_color) {
  uint16_t i;
  for (i = 0; i < 1000; i++) {
    SCREEN_RAM[i] = 32;
    COLOR_RAM[i] = fill_color;
  }
  if (fill_color != COLOR_BLACK) {
    print_centered(STR_APP_TITLE, 1, COLOR_CYAN);
  }
}

void print_at(const char *text, uint8_t row, uint8_t col, uint8_t color) {
  int len = mystrlen(text);
  if (col + len > 40)
    len = 40 - col;
  uint16_t offset = (row * 40) + col;
  int i;
  for (i = 0; i < len; i++) {
    SCREEN_RAM[offset + i] = ascii_to_screencode(text[i]);
    COLOR_RAM[offset + i] = color;
  }
}

void clear_row(uint8_t row, uint8_t color) {
  uint16_t offset = row * 40;
  int i;
  for (i = 0; i < 40; i++) {
    SCREEN_RAM[offset + i] = 32;
    COLOR_RAM[offset + i] = color;
  }
}

void print_centered(const char *text, uint8_t row, uint8_t color) {
  clear_row(row, color);
  int len = mystrlen(text);
  int start_col = (40 - len) / 2;
  print_at(text, row, start_col, color);
}

// Lettura tastiera sicura tramite variabile globale fissa
uint8_t get_key(void) {
  last_key = 0;
  __asm {
        jsr $ff9f // SCNKEY: scansiona tastiera fisica
        jsr $ffe4 // GETIN: preleva carattere dal buffer
        sta last_key // Salva nell'indirizzo di memoria globale assoluto
  }
  ;
  return last_key;
}

uint16_t parse_hex_address(const char *buf, int len) {
  uint16_t val = 0;
  int i;
  for (i = 0; i < len; i++) {
    char c = buf[i];
    uint8_t digit = (c >= 'A') ? (c - 'A' + 10) : (c - '0');
    val = (val << 4) | digit;
  }
  return val;
}

// Legge lo stato del canale 15 fino alla fine (CR o EOF) per svuotare il buffer
// del drive e prevenire blocchi del bus seriale.
void read_dos_status(char *buf, int max_len) {
  int idx = 0;
  char ch;
  bool eof_reached = false;
  int safety = 0;

  if (buf && max_len > 0) {
    buf[0] = '\0';
  }

  if (krnio_chkin(15)) {
    while (!eof_reached && safety < 80) {
      ch = krnio_chrin();
      safety++;
      uint8_t status = krnio_status();

      if (status & (KRNIO_TIMEOUT | KRNIO_NODEVICE)) {
        break;
      }
      if (ch == 13 || (status & KRNIO_EOF)) {
        eof_reached = true;
      }
      if (buf && idx < (max_len - 1) && ch != 13) {
        buf[idx++] = ch;
      }
    }
    if (buf) {
      buf[idx] = '\0';
    }
    krnio_clrchn();
  }
}

// Azione reale di controllo spazio sul floppy (Device 8)
void check_floppy(void) {
  uint8_t key = 0;
  bool success = false;
  char disk_name[20];
  {
    const char *def_name = STR_SCONOSCIUTO;
    int i = 0;
    while (def_name[i] != '\0' && i < 19) {
      disk_name[i] = def_name[i];
      i++;
    }
    disk_name[i] = '\0';
  }
  uint16_t blocks_free = 0;
  uint8_t drive_error_type =
      0; // 0 = OK, 1 = Non comunica, 2 = Floppy assente, 3 = Altro errore DOS
  char dos_status[40];

  while (!success) {
    clear_screen(COLOR_DARK_GRAY);
    print_centered(sram_mode_active ? STR_DUMP_SU_FLOPPY : (STR_F5_EEPROM + 4), 3, COLOR_YELLOW);
    print_centered(STR_ACCESSO_AL_DRIVE, 11, COLOR_CYAN);

    drive_error_type = 0;
    dos_status[0] = '\0';

    // Pulizia preventiva dello stato I/O seriale
    krnio_clrchn();

    // Primo controllo: invia comando "I0" (Initialize) al drive
    // Forza la lettura della BAM, rilevando subito disco assente (errore 74)
    krnio_setnam("I0");
    if (!krnio_open(15, 8, 15)) {
      drive_error_type = 1; // Non comunica
    } else {
      if (krnio_status() & KRNIO_NODEVICE) {
        drive_error_type = 1; // Non comunica
      } else {
        read_dos_status(dos_status, 40);

        int len_status = mystrlen(dos_status);
        if (len_status >= 2) {
          if (dos_status[0] == '7' && dos_status[1] == '4') {
            drive_error_type = 2; // Floppy assente (Drive Not Ready)
          } else if (dos_status[0] != '0' || dos_status[1] != '0') {
            drive_error_type = 3; // Altro errore DOS
          }
        } else {
          drive_error_type = 1;
        }
      }
      krnio_close(15);
    }

    // Se la diagnostica preliminare è OK, prova a leggere la directory
    if (drive_error_type == 0) {
      krnio_setnam("$");
      if (krnio_open(2, 8, 0)) {
        if (krnio_chkin(2)) {
          // Salta i primi due byte dell'indirizzo di caricamento BASIC
          krnio_chrin();
          krnio_chrin();

          if (krnio_status() & (KRNIO_TIMEOUT | KRNIO_NODEVICE)) {
            drive_error_type = 3;
          }

          int ch;
          bool is_first = true;

          // Loop di lettura sequenziale della directory
          while (drive_error_type == 0 && (ch = krnio_chrin()) > 0) {
            unsigned line;
            char buff[40];

            krnio_chrin(); // Salta il secondo byte del link BASIC
            ch = krnio_chrin();
            line = ch;
            ch = krnio_chrin();
            line += 256 * ch; // Numero di blocchi o riga BASIC

            if (krnio_status() & (KRNIO_TIMEOUT | KRNIO_NODEVICE))
              break;

            int n = 0;
            while ((ch = krnio_chrin()) > 0) {
              if (krnio_status() & (KRNIO_TIMEOUT | KRNIO_NODEVICE))
                break;
              if (n < 39)
                buff[n++] = ch;
            }
            buff[n] = 0;

            if (is_first) {
              // Estrae il nome del disco racchiuso tra virgolette nel primo
              // record
              int start = 0;
              while (buff[start] != '\0' && buff[start] != '"')
                start++;
              if (buff[start] == '"') {
                start++;
                int end = start;
                while (buff[end] != '\0' && buff[end] != '"')
                  end++;
                int k = 0;
                for (int idx_name = start; idx_name < end && k < 16;
                     idx_name++) {
                  disk_name[k++] = buff[idx_name];
                }
                disk_name[k] = '\0';
              }
              is_first = false;
            } else {
              // L'ultimo record conterrà il totale dei blocchi liberi
              blocks_free = line;
            }
          }
          krnio_clrchn();
          if (drive_error_type == 0)
            success = true;
        } else {
          drive_error_type = 3;
        }
        krnio_close(2);
      } else {
        drive_error_type = 3;
      }
    }

    if (!success) {
      clear_screen(COLOR_DARK_GRAY);
      print_centered(sram_mode_active ? STR_DUMP_SU_FLOPPY : (STR_F5_EEPROM + 4), 3, COLOR_YELLOW);

      if (drive_error_type == 1) {
        print_centered(STR_ERR_NO_COMMUNICATION, 11, COLOR_RED);
        print_centered(STR_ERR_CHECK_CABLE, 13, COLOR_YELLOW);
      } else if (drive_error_type == 2) {
        print_centered(STR_ERR_NO_DISK, 11, COLOR_RED);
        print_centered(STR_ERR_INSERT_DISK, 13, COLOR_YELLOW);
      } else if (drive_error_type == 3) {
        print_centered(STR_ERR_DOS_ERROR, 9, COLOR_RED);
        if (dos_status[0] != '\0') {
          print_centered(dos_status, 11, COLOR_CYAN);
        } else {
          print_centered(STR_ERR_CANT_READ_DIR, 11, COLOR_CYAN);
        }
        print_centered(STR_ERR_CHECK_DISK, 13, COLOR_YELLOW);
      } else {
        print_centered(STR_ERR_ACCESS_UNIT_8, 11, COLOR_RED);
        print_centered(STR_ERR_CHECK_UNIT, 13, COLOR_YELLOW);
      }

      print_centered(STR_PREMI_RETURN_RIPROVARE, 17, COLOR_WHITE);
      print_centered(STR_PREMI_M_TORNARE_MENU, 19, COLOR_LIGHT_GREEN);

      while (1) {
        key = get_key();
        if (key == 13) {
          break; // Riprova il ciclo
        }
        if (key == 'm' || key == 'M') {
          return; // Ritorna al menu
        }
      }
    }
  }

  // Visualizza i dati ricavati dal disco
  clear_screen(COLOR_DARK_GRAY);
  print_centered(sram_mode_active ? STR_DUMP_SU_FLOPPY : (STR_F5_EEPROM + 4), 3, COLOR_YELLOW);
  char msg_disk[40];
  {
    const char *def_disco = STR_DISCO;
    int i = 0;
    while (def_disco[i] != '\0' && i < 39) {
      msg_disk[i] = def_disco[i];
      i++;
    }
    msg_disk[i] = '\0';
  }
  int len = mystrlen(msg_disk);
  int k = 0;
  while (disk_name[k] != '\0' && len < 39) {
    msg_disk[len++] = disk_name[k++];
  }
  msg_disk[len] = '\0';
  print_centered(msg_disk, 11, COLOR_CYAN);

  char msg_blocks[40];
  {
    const char *def_blocks = STR_SPAZIO_LIBERO;
    int i = 0;
    while (def_blocks[i] != '\0' && i < 39) {
      msg_blocks[i] = def_blocks[i];
      i++;
    }
    msg_blocks[i] = '\0';
  }
  char blocks_str[10];
  uint16_to_str(blocks_free, blocks_str);
  len = mystrlen(msg_blocks);
  k = 0;
  while (blocks_str[k] != '\0' && len < 39) {
    msg_blocks[len++] = blocks_str[k++];
  }
  const char *suff_blks = STR_BLOCCHI;
  k = 0;
  while (suff_blks[k] != '\0' && len < 39) {
    msg_blocks[len++] = suff_blks[k++];
  }
  // Calcolo approssimativo in KB (1 blocco = 256 byte, quindi 4 blocchi = 1 KB)
  uint16_t kb_free = blocks_free / 4;
  char kb_str[10];
  uint16_to_str(kb_free, kb_str);
  k = 0;
  while (kb_str[k] != '\0' && len < 39) {
    msg_blocks[len++] = kb_str[k++];
  }
  const char *suff_kb = STR_KB;
  k = 0;
  while (suff_kb[k] != '\0' && len < 39) {
    msg_blocks[len++] = suff_kb[k++];
  }
  msg_blocks[len] = '\0';
  print_centered(msg_blocks, 13, COLOR_GREEN);

  // Un backup di 128K SRAM (131072 byte) necessita di 517 blocchi sul floppy (254 byte utili per settore)
  uint16_t req_blocks = sram_mode_active ? 517 : (eeprom_size_kb == 32 ? 131 : 35);
  if (blocks_free < req_blocks) {
    if (sram_mode_active) {
      print_centered(STR_WARN_NO_SPACE, 15, COLOR_RED);
    } else {
      print_centered(eeprom_size_kb == 32 ? STR_WARN_NO_SPACE_32 : STR_WARN_NO_SPACE_8, 15, COLOR_RED);
    }
  } else {
    if (sram_mode_active) {
      print_centered(STR_SPACE_OK, 15, COLOR_LIGHT_GREEN);
    } else {
      print_centered(eeprom_size_kb == 32 ? STR_SPACE_OK_32 : STR_SPACE_OK_8, 15, COLOR_LIGHT_GREEN);
    }
  }

  print_centered(STR_PREMI_RETURN_TORNARE, 23, COLOR_WHITE);
  while (1) {
    key = get_key();
    if (key == 13)
      break;
  }
}

bool compress_and_write_page(const uint8_t *src) {
  int src_len = 256;
  int i = 0;
  uint8_t lit_buf[127];
  int lit_count = 0;
  
  while (i < src_len) {
    int best_len = 0;
    int best_dist = 0;
    int max_dist = (i < 255) ? i : 255;
    
    for (int dist = 1; dist <= max_dist; dist++) {
      int prev_pos = i - dist;
      if (src[prev_pos + best_len] != src[i + best_len]) {
        continue;
      }
      
      int len = 0;
      while (i + len < src_len && len < 127 && src[prev_pos + len] == src[i + len]) {
        len++;
      }
      if (len > best_len) {
        best_len = len;
        best_dist = dist;
        if (best_len == 127) {
          break;
        }
      }
    }
    
    if (best_len >= 3) {
      if (lit_count > 0) {
        krnio_chrout((char)lit_count);
        if (krnio_status() != KRNIO_OK) return false;
        for (int j = 0; j < lit_count; j++) {
          krnio_chrout((char)lit_buf[j]);
          if (krnio_status() != KRNIO_OK) return false;
        }
        lit_count = 0;
      }
      
      krnio_chrout((char)(0x80 | best_len));
      if (krnio_status() != KRNIO_OK) return false;
      krnio_chrout((char)best_dist);
      if (krnio_status() != KRNIO_OK) return false;
      
      i += best_len;
    } else {
      lit_buf[lit_count++] = src[i];
      i++;
      
      if (lit_count == 127) {
        krnio_chrout((char)127);
        if (krnio_status() != KRNIO_OK) return false;
        for (int j = 0; j < 127; j++) {
          krnio_chrout((char)lit_buf[j]);
          if (krnio_status() != KRNIO_OK) return false;
        }
        lit_count = 0;
      }
    }
  }
  
  if (lit_count > 0) {
    krnio_chrout((char)lit_count);
    if (krnio_status() != KRNIO_OK) return false;
    for (int j = 0; j < lit_count; j++) {
      krnio_chrout((char)lit_buf[j]);
      if (krnio_status() != KRNIO_OK) return false;
    }
  }
  
  krnio_chrout(0);
  return (krnio_status() == KRNIO_OK);
}void verify_backup(void) {
  bool absent = sram_mode_active ? (sram_status == MDP_DETECT_ABSENT) : (eeprom_status == MDP_DETECT_ABSENT);
  if (absent) {
    clear_row(23, COLOR_DARK_GRAY);
    print_centered(sram_mode_active ? STR_SRAM_ASSENTE_ERR : STR_EEPROM_ASSENTE_ERR, 15, COLOR_RED);
  } else {
    bool exists_lzo = false;
    bool exists_normal = false;
    clear_row(23, COLOR_DARK_GRAY);
    print_centered(STR_CHECK_EXISTING, 15, COLOR_CYAN);

    const char *filename_lzo_r = sram_mode_active ? "SRAMBACKUPLZO,S,R" : "EEPROMBACKUPLZO,S,R";
    const char *filename_normal_r = sram_mode_active ? "SRAMBACKUP,S,R" : "EEPROMBACKUP,S,R";

    // 1. Controlla se il file compresso LZO esiste
    krnio_setnam(filename_lzo_r);
    if (krnio_open(3, 8, 3)) {
      krnio_setnam("");
      if (krnio_open(15, 8, 15)) {
        char temp_status[40];
        read_dos_status(temp_status, 40);
        if (temp_status[0] == '0' && temp_status[1] == '0') {
          exists_lzo = true;
        }
        krnio_close(15);
      }
      krnio_close(3);
    } else {
      krnio_setnam("");
      if (krnio_open(15, 8, 15)) {
        krnio_close(15);
      }
    }

    // 2. Controlla se il file normale esiste
    krnio_setnam(filename_normal_r);
    if (krnio_open(3, 8, 3)) {
      krnio_setnam("");
      if (krnio_open(15, 8, 15)) {
        char temp_status[40];
        read_dos_status(temp_status, 40);
        if (temp_status[0] == '0' && temp_status[1] == '0') {
          exists_normal = true;
        }
        krnio_close(15);
      }
      krnio_close(3);
    } else {
      krnio_setnam("");
      if (krnio_open(15, 8, 15)) {
        krnio_close(15);
      }
    }
    clear_row(15, COLOR_DARK_GRAY);

    bool use_lzo_for_restore = false;
    bool exists = false;

    // Auto-rilevamento in base all'impostazione corrente F7 e ai file presenti sul floppy
    if (lzo_enabled) {
      if (exists_lzo) {
        exists = true;
        use_lzo_for_restore = true;
      } else if (exists_normal) {
        exists = true;
        use_lzo_for_restore = false;
      }
    } else {
      if (exists_normal) {
        exists = true;
        use_lzo_for_restore = false;
      } else if (exists_lzo) {
        exists = true;
        use_lzo_for_restore = true;
      }
    }

    if (!exists) {
      print_centered(STR_ERR_FILE_NOT_FOUND, 19, COLOR_RED);
    } else {
      print_centered(STR_VERIFY_RUNNING, 19, COLOR_CYAN);

      krnio_setnam(use_lzo_for_restore ? filename_lzo_r : filename_normal_r);
      if (krnio_open(3, 8, 3)) {
        if (krnio_chkin(3)) {
          uint8_t old_shadow = mdp_ctrl_shadow;
          uint16_t total_pages = sram_mode_active ? 512 : (eeprom_size_kb == 32 ? 128 : 32);
          uint16_t pages_read;
          int offset;
          bool read_ok = true;
          uint32_t diff_count = 0;

          if (sram_mode_active) {
            mdp_sram_enable();
          } else {
            mdp_eeprom_enable();
          }

          for (pages_read = 0; pages_read < total_pages; pages_read++) {
            uint8_t pct = (uint8_t)(((uint32_t)pages_read * 100) / total_pages);
            char pct_str[8];
            uint16_to_str(pct, pct_str);
            int pct_len = mystrlen(pct_str);
            pct_str[pct_len] = '%';
            pct_str[pct_len + 1] = '\0';
            print_centered(pct_str, 19, COLOR_YELLOW);

            if (sram_mode_active) {
              mdp_set_bank(pages_read >> 8);
              mdp_set_page(pages_read & 0xFF);
            } else {
              mdp_set_page(pages_read);
            }

            if (use_lzo_for_restore) {
              uint8_t page_buf[256];
              int bytes_read = krnio_read_lzo(3, (char *)page_buf);
              if (bytes_read != 256) {
                read_ok = false;
                break;
              }
              for (offset = 0; offset < 256; offset++) {
                uint8_t val = mdp_read_byte((uint8_t)offset);
                if (val != page_buf[offset]) {
                  diff_count++;
                }
              }
            } else {
              for (offset = 0; offset < 256; offset++) {
                uint8_t val = krnio_chrin();
                uint8_t status = krnio_status();
                if (status != KRNIO_OK && status != KRNIO_EOF) {
                  read_ok = false;
                  break;
                }
                uint8_t actual_val = mdp_read_byte((uint8_t)offset);
                if (actual_val != val) {
                  diff_count++;
                }
              }
            }
            if (!read_ok) break;
          }

          mdp_ctrl_shadow = old_shadow;
          *MDP_REG_CTRL = mdp_ctrl_shadow;

          krnio_clrchn();

          if (read_ok) {
            print_centered("100%", 19, COLOR_YELLOW);
            if (diff_count == 0) {
              print_centered(STR_VERIFY_OK, 19, COLOR_GREEN);
            } else {
              char err_msg[40];
              const char *prefix = STR_VERIFY_FAIL;
              int idx = 0;
              while (prefix[idx] != '\0' && idx < 30) {
                err_msg[idx] = prefix[idx];
                idx++;
              }
              char num_str[10];
              uint16_t diff_16 = (diff_count > 65535) ? 65535 : (uint16_t)diff_count;
              uint16_to_str(diff_16, num_str);
              int num_len = mystrlen(num_str);
              int j = 0;
              while (num_str[j] != '\0' && idx < 39) {
                err_msg[idx++] = num_str[j++];
              }
              err_msg[idx] = '\0';
              print_centered(err_msg, 19, COLOR_RED);
            }
          } else {
            char dos_err[40];
            dos_err[0] = '\0';
            krnio_setnam("");
            if (krnio_open(15, 8, 15)) {
              read_dos_status(dos_err, 40);
              krnio_close(15);
            }
            print_centered(STR_ERR_DOS_ERROR, 19, COLOR_RED);
            if (dos_err[0] != '\0') {
              print_centered(dos_err, 19, COLOR_CYAN);
            }
          }
        } else {
          print_centered(STR_ERR_CHANNEL, 19, COLOR_RED);
        }
        krnio_close(3);
      } else {
        print_centered(STR_ERR_OPEN_READ, 19, COLOR_RED);
      }
    }
  }

  print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
  while (get_key() != 13)
    ;
}

void show_dump_screen(void) {
  clear_screen(COLOR_DARK_GRAY);
  print_centered(sram_mode_active ? STR_DUMP_SU_FLOPPY : (STR_F5_EEPROM + 4), 3, COLOR_YELLOW);
  print_at(STR_F3_ESEGUI_DUMP, 9, 10, COLOR_WHITE);
  print_at(STR_F5_RESTORE_DUMP, 11, 10, COLOR_WHITE);
  print_at(STR_F5_VERIFICA_BACKUP, 13, 10, COLOR_WHITE);
  print_at(lzo_enabled ? STR_F7_LZO_ON : STR_F7_LZO_OFF, 15, 10, COLOR_WHITE);
  print_centered(STR_PREMI_M_PER_MENU, 23, COLOR_LIGHT_GREEN);

  while (1) {
    uint8_t key = get_key();
    if (key == 'm' || key == 'M')
      break;

    if (key == KEY_F1) {
      bool absent = sram_mode_active ? (sram_status == MDP_DETECT_ABSENT) : (eeprom_status == MDP_DETECT_ABSENT);
      if (absent) {
        clear_row(23, COLOR_DARK_GRAY);
        print_centered(sram_mode_active ? STR_SRAM_ASSENTE_ERR : STR_EEPROM_ASSENTE_ERR, 15, COLOR_RED);
      } else {
        bool exists = false;
        clear_row(23, COLOR_DARK_GRAY);
        print_centered(STR_CHECK_EXISTING, 15, COLOR_CYAN);

        const char *filename_r = sram_mode_active ? 
          (lzo_enabled ? "SRAMBACKUPLZO,S,R" : "SRAMBACKUP,S,R") :
          (lzo_enabled ? "EEPROMBACKUPLZO,S,R" : "EEPROMBACKUP,S,R");
        const char *filename_w = sram_mode_active ? 
          (lzo_enabled ? "SRAMBACKUPLZO,S,W" : "SRAMBACKUP,S,W") :
          (lzo_enabled ? "EEPROMBACKUPLZO,S,W" : "EEPROMBACKUP,S,W");
        const char *filename_scratch = sram_mode_active ?
          (lzo_enabled ? "S0:SRAMBACKUPLZO" : "S0:SRAMBACKUP") :
          (lzo_enabled ? "S0:EEPROMBACKUPLZO" : "S0:EEPROMBACKUP");

        // 1. Prova ad aprire il file SEQ per lettura
        krnio_setnam(filename_r);
        if (krnio_open(3, 8, 3)) {
          // 2. Apri il canale dei comandi DOS (secondario 15) per leggere lo
          // stato reale
          krnio_setnam("");
          if (krnio_open(15, 8, 15)) {
            char temp_status[40];
            read_dos_status(temp_status, 40);

            // Se lo stato DOS inizia con "00", significa che il file esiste ed è
            // stato aperto correttamente
            if (temp_status[0] == '0' && temp_status[1] == '0') {
              exists = true;
            }
            krnio_close(15); // Chiude il canale dei comandi liberandolo
          }
          krnio_close(3); // Chiude il file aperto per il test
        } else {
          // Se krnio_open fallisce drasticamente sul canale, assicuriamoci di
          // pulire lo stato di errore del drive
          krnio_setnam("");
          if (krnio_open(15, 8, 15)) {
            krnio_close(15); // Spegne il LED rosso lampeggiante del 1541
          }
        }
        // Cancella la scritta di controllo file esistente
        clear_row(15, COLOR_DARK_GRAY);

        bool proceed = true;
        if (exists) {
          print_centered(STR_FILE_EXISTS_OVERWRITE, 17, COLOR_YELLOW);
          while (1) {
            uint8_t k = get_key();
            if (k != 0) {
              if (k == 'y' || k == 'Y') {
                // Invia comando "Scratch" (S0:) al canale 15 per eliminare il
                // file esistente
                print_centered(STR_DELETING_PREVIOUS, 19, COLOR_CYAN);
                krnio_setnam(filename_scratch);
                if (krnio_open(15, 8, 15)) {
                  krnio_close(15); // Esegue e spegne il LED
                }
                break;
              } else if (k == 'n' || k == 'N') {
                print_centered(STR_OP_CANCELED, 19, COLOR_RED);
                proceed = false;
                break;
              }
            }
          }
        }

        if (proceed) {
          print_centered(STR_WRITING_FILE, 19, COLOR_CYAN);

          // Crea il file SEQ in scrittura usando il suffisso standard C64 DOS
          // ",S,W"
          krnio_setnam(filename_w);
          if (krnio_open(3, 8, 3)) {
            if (krnio_chkout(3)) {
              uint8_t old_shadow = mdp_ctrl_shadow;
              uint16_t total_pages = sram_mode_active ? 512 : (eeprom_size_kb == 32 ? 128 : 32);
              uint16_t pages_written;
              int offset;
              bool write_ok = true;

              if (sram_mode_active) {
                mdp_sram_enable();
              } else {
                mdp_eeprom_enable();
              }

              for (pages_written = 0; pages_written < total_pages; pages_written++) {
                uint8_t pct = (uint8_t)(((uint32_t)pages_written * 100) / total_pages);
                char pct_str[8];
                uint16_to_str(pct, pct_str);
                int pct_len = mystrlen(pct_str);
                pct_str[pct_len] = '%';
                pct_str[pct_len + 1] = '\0';
                print_centered(pct_str, 19, COLOR_YELLOW);

                if (sram_mode_active) {
                  mdp_set_bank(pages_written >> 8);
                  mdp_set_page(pages_written & 0xFF);
                } else {
                  mdp_set_page(pages_written);
                }

                if (lzo_enabled) {
                  uint8_t page_buf[256];
                  for (offset = 0; offset < 256; offset++) {
                    page_buf[offset] = mdp_read_byte((uint8_t)offset);
                  }
                  if (!compress_and_write_page(page_buf)) {
                    write_ok = false;
                    break;
                  }
                } else {
                  for (offset = 0; offset < 256; offset++) {
                    krnio_chrout(mdp_read_byte((uint8_t)offset));
                    if (krnio_status() != KRNIO_OK) {
                      write_ok = false;
                      break;
                    }
                  }
                }
              }

              mdp_ctrl_shadow = old_shadow;
              *MDP_REG_CTRL = mdp_ctrl_shadow;

              krnio_clrchn();

              if (write_ok) {
                print_centered("100%", 19, COLOR_YELLOW);
                print_centered(STR_DUMP_SUCCESS, 19, COLOR_GREEN);
              } else {
                char dos_err[40];
                dos_err[0] = '\0';
                krnio_setnam("");
                if (krnio_open(15, 8, 15)) {
                  read_dos_status(dos_err, 40);
                  krnio_close(15);
                }
                print_centered(STR_ERR_DOS_ERROR, 19, COLOR_RED);
                if (dos_err[0] != '\0') {
                  print_centered(dos_err, 19, COLOR_CYAN);
                }
              }
            } else {
              print_centered(STR_ERR_CHANNEL, 19, COLOR_RED);
            }
            krnio_close(3);
          } else {
            print_centered(STR_ERR_OPEN_WRITE, 19, COLOR_RED);
          }
        }
      }

      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13)
        ;

      // Ripristina l'interfaccia iniziale del dump
      clear_screen(COLOR_DARK_GRAY);
      print_centered(sram_mode_active ? STR_DUMP_SU_FLOPPY : (STR_F5_EEPROM + 4), 3, COLOR_YELLOW);
      print_at(STR_F3_ESEGUI_DUMP, 9, 10, COLOR_WHITE);
      print_at(STR_F5_RESTORE_DUMP, 11, 10, COLOR_WHITE);
      print_at(STR_F5_VERIFICA_BACKUP, 13, 10, COLOR_WHITE);
      print_at(lzo_enabled ? STR_F7_LZO_ON : STR_F7_LZO_OFF, 15, 10, COLOR_WHITE);
      print_centered(STR_PREMI_M_PER_MENU, 23, COLOR_LIGHT_GREEN);
    }

    if (key == KEY_F3) {
      bool absent = sram_mode_active ? (sram_status == MDP_DETECT_ABSENT) : (eeprom_status == MDP_DETECT_ABSENT);
      if (absent) {
        clear_row(23, COLOR_DARK_GRAY);
        print_centered(sram_mode_active ? STR_SRAM_ASSENTE_ERR : STR_EEPROM_ASSENTE_ERR, 15, COLOR_RED);
      } else {
        bool exists_lzo = false;
        bool exists_normal = false;
        clear_row(23, COLOR_DARK_GRAY);
        print_centered(STR_CHECK_EXISTING, 15, COLOR_CYAN);

        const char *filename_lzo_r = sram_mode_active ? "SRAMBACKUPLZO,S,R" : "EEPROMBACKUPLZO,S,R";
        const char *filename_normal_r = sram_mode_active ? "SRAMBACKUP,S,R" : "EEPROMBACKUP,S,R";

        // 1. Controlla se il file compresso LZO esiste
        krnio_setnam(filename_lzo_r);
        if (krnio_open(3, 8, 3)) {
          krnio_setnam("");
          if (krnio_open(15, 8, 15)) {
            char temp_status[40];
            read_dos_status(temp_status, 40);
            if (temp_status[0] == '0' && temp_status[1] == '0') {
              exists_lzo = true;
            }
            krnio_close(15);
          }
          krnio_close(3);
        } else {
          krnio_setnam("");
          if (krnio_open(15, 8, 15)) {
            krnio_close(15);
          }
        }

        // 2. Controlla se il file normale esiste
        krnio_setnam(filename_normal_r);
        if (krnio_open(3, 8, 3)) {
          krnio_setnam("");
          if (krnio_open(15, 8, 15)) {
            char temp_status[40];
            read_dos_status(temp_status, 40);
            if (temp_status[0] == '0' && temp_status[1] == '0') {
              exists_normal = true;
            }
            krnio_close(15);
          }
          krnio_close(3);
        } else {
          krnio_setnam("");
          if (krnio_open(15, 8, 15)) {
            krnio_close(15);
          }
        }
        clear_row(15, COLOR_DARK_GRAY);

        bool use_lzo_for_restore = false;
        bool exists = false;

        // Auto-rilevamento in base all'impostazione corrente F7 e ai file presenti sul floppy
        if (lzo_enabled) {
          if (exists_lzo) {
            exists = true;
            use_lzo_for_restore = true;
          } else if (exists_normal) {
            exists = true;
            use_lzo_for_restore = false;
          }
        } else {
          if (exists_normal) {
            exists = true;
            use_lzo_for_restore = false;
          } else if (exists_lzo) {
            exists = true;
            use_lzo_for_restore = true;
          }
        }

        if (!exists) {
          print_centered(STR_ERR_FILE_NOT_FOUND, 19, COLOR_RED);
        } else {
          print_centered(STR_READING_FILE, 19, COLOR_CYAN);

          krnio_setnam(use_lzo_for_restore ? filename_lzo_r : filename_normal_r);
          if (krnio_open(3, 8, 3)) {
            if (krnio_chkin(3)) {
              uint8_t old_shadow = mdp_ctrl_shadow;
              uint16_t total_pages = sram_mode_active ? 512 : (eeprom_size_kb == 32 ? 128 : 32);
              uint16_t pages_read;
              int offset;
              bool read_ok = true;

              if (sram_mode_active) {
                mdp_sram_enable();
              } else {
                mdp_eeprom_enable();
              }

              for (pages_read = 0; pages_read < total_pages; pages_read++) {
                uint8_t pct = (uint8_t)(((uint32_t)pages_read * 100) / total_pages);
                char pct_str[8];
                uint16_to_str(pct, pct_str);
                int pct_len = mystrlen(pct_str);
                pct_str[pct_len] = '%';
                pct_str[pct_len + 1] = '\0';
                print_centered(pct_str, 19, COLOR_YELLOW);

                if (sram_mode_active) {
                  mdp_set_bank(pages_read >> 8);
                  mdp_set_page(pages_read & 0xFF);
                } else {
                  mdp_set_page(pages_read);
                }

                uint8_t page_buf[256];
                if (use_lzo_for_restore) {
                  int bytes_read = krnio_read_lzo(3, (char *)page_buf);
                  if (bytes_read != 256) {
                    read_ok = false;
                    break;
                  }
                } else {
                  for (offset = 0; offset < 256; offset++) {
                    uint8_t val = krnio_chrin();
                    uint8_t status = krnio_status();
                    if (status != KRNIO_OK && status != KRNIO_EOF) {
                      read_ok = false;
                      break;
                    }
                    page_buf[offset] = val;
                  }
                  if (!read_ok) break;
                }

                if (sram_mode_active) {
                  for (offset = 0; offset < 256; offset++) {
                    mdp_write_byte((uint8_t)offset, page_buf[offset]);
                  }
                } else {
                  if (!mdp_eeprom_write_cart_page((uint8_t)pages_read, page_buf, eeprom_size_kb)) {
                    read_ok = false;
                    break;
                  }
                }
                if (!read_ok) break;
              }

              mdp_ctrl_shadow = old_shadow;
              *MDP_REG_CTRL = mdp_ctrl_shadow;

              krnio_clrchn();

              if (read_ok) {
                print_centered("100%", 19, COLOR_YELLOW);
                print_centered(STR_RESTORE_SUCCESS, 19, COLOR_GREEN);
              } else {
                char dos_err[40];
                dos_err[0] = '\0';
                krnio_setnam("");
                if (krnio_open(15, 8, 15)) {
                  read_dos_status(dos_err, 40);
                  krnio_close(15);
                }
                print_centered(STR_ERR_DOS_ERROR, 19, COLOR_RED);
                if (dos_err[0] != '\0') {
                  print_centered(dos_err, 19, COLOR_CYAN);
                }
              }
            } else {
              print_centered(STR_ERR_CHANNEL, 19, COLOR_RED);
            }
            krnio_close(3);
          } else {
            print_centered(STR_ERR_OPEN_READ, 19, COLOR_RED);
          }
        }
      }

      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13)
        ;

      // Ripristina l'interfaccia iniziale del dump
      clear_screen(COLOR_DARK_GRAY);
      print_centered(sram_mode_active ? STR_DUMP_SU_FLOPPY : (STR_F5_EEPROM + 4), 3, COLOR_YELLOW);
      print_at(STR_F3_ESEGUI_DUMP, 9, 10, COLOR_WHITE);
      print_at(STR_F5_RESTORE_DUMP, 11, 10, COLOR_WHITE);
      print_at(STR_F5_VERIFICA_BACKUP, 13, 10, COLOR_WHITE);
      print_at(lzo_enabled ? STR_F7_LZO_ON : STR_F7_LZO_OFF, 15, 10, COLOR_WHITE);
      print_centered(STR_PREMI_M_PER_MENU, 23, COLOR_LIGHT_GREEN);
    }

    if (key == KEY_F5) {
      verify_backup();
      clear_screen(COLOR_DARK_GRAY);
      print_centered(sram_mode_active ? STR_DUMP_SU_FLOPPY : (STR_F5_EEPROM + 4), 3, COLOR_YELLOW);
      print_at(STR_F3_ESEGUI_DUMP, 9, 10, COLOR_WHITE);
      print_at(STR_F5_RESTORE_DUMP, 11, 10, COLOR_WHITE);
      print_at(STR_F5_VERIFICA_BACKUP, 13, 10, COLOR_WHITE);
      print_at(lzo_enabled ? STR_F7_LZO_ON : STR_F7_LZO_OFF, 15, 10, COLOR_WHITE);
      print_centered(STR_PREMI_M_PER_MENU, 23, COLOR_LIGHT_GREEN);
    }

    if (key == KEY_F7) {
      lzo_enabled = !lzo_enabled;
      clear_row(15, COLOR_DARK_GRAY);
      print_at(lzo_enabled ? STR_F7_LZO_ON : STR_F7_LZO_OFF, 15, 10, COLOR_WHITE);
    }
  }
}

/* ------------------------------------------------------------------ */
/*  Helper: input esadecimale a 2 cifre (ritorna 0-255)                */
/* ------------------------------------------------------------------ */
uint8_t prompt_hex_byte(uint8_t row, uint8_t col) {
  char buf[3] = {0};
  int len = 0;
  print_at("  ", row, col, COLOR_CYAN);

  while (1) {
    char display[3];
    int i;
    for (i = 0; i < 2; i++) {
      if (i < len)
        display[i] = buf[i];
      else if (i == len)
        display[i] = 164; // Cursore PETSCII
      else
        display[i] = ' ';
    }
    display[2] = '\0';
    print_at(display, row, col, COLOR_CYAN);

    uint8_t key = 0;
    while (key == 0)
      key = get_key();

    if (key == 13 && len > 0)
      return (uint8_t)parse_hex_address(buf, len);
    if (key == 20 && len > 0)
      len--;
    else if (len < 2) {
      char c = (char)key;
      if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') ||
          (c >= 'a' && c <= 'f')) {
        if (c >= 'a')
          c -= 32;
        buf[len++] = c;
        if (len == 2)
          return (uint8_t)parse_hex_address(buf, 2);
      }
    }
  }
}

/* ------------------------------------------------------------------ */
/*  Visualizza 64 byte della pagina SRAM corrente                      */
/* ------------------------------------------------------------------ */
void draw_sram_page_view(uint8_t base_offset) {
  int r;
  for (r = 0; r < 12; r++) {
    uint8_t off = base_offset + (r * 8);
    /* Indirizzo offset */
    char addr_str[4];
    addr_str[0] = hex_digit(off >> 4);
    addr_str[1] = hex_digit(off & 0x0F);
    addr_str[2] = ':';
    addr_str[3] = '\0';
    print_at(addr_str, 7 + r, 1, COLOR_LIGHT_BLUE);

    uint16_t screen_offset = ((7 + r) * 40) + 5;
    int i;
    for (i = 0; i < 8; i++) {
      uint8_t byte_val = mdp_read_byte(off + i);
      SCREEN_RAM[screen_offset + (i * 3)] =
          ascii_to_screencode(hex_digit(byte_val >> 4));
      SCREEN_RAM[screen_offset + (i * 3) + 1] =
          ascii_to_screencode(hex_digit(byte_val & 0x0F));
      SCREEN_RAM[screen_offset + (i * 3) + 2] = 32;
      COLOR_RAM[screen_offset + (i * 3)] = COLOR_WHITE;
      COLOR_RAM[screen_offset + (i * 3) + 1] = COLOR_WHITE;
      COLOR_RAM[screen_offset + (i * 3) + 2] = COLOR_WHITE;
    }
    /* Rappresentazione ASCII */
    for (i = 0; i < 8; i++) {
      SCREEN_RAM[screen_offset + 25 + i] =
          get_printable_screencode(mdp_read_byte(off + i));
      COLOR_RAM[screen_offset + 25 + i] = COLOR_GREEN;
    }
  }
}

/* ------------------------------------------------------------------ */
/*  Disegna la barra di stato dell'editor SRAM                         */
/* ------------------------------------------------------------------ */
void draw_sram_status_bar(uint8_t cur_page, uint8_t base_offset) {
  /* Riga 5: SRAM: ON/OFF  BANCO: 0/1  PAG: XX  OFF: XX */
  clear_row(5, COLOR_DARK_GRAY);

  if (sram_mode_active) {
    print_at(STR_SRAM_STATO, 5, 0, COLOR_CYAN);
    if (mdp_sram_is_enabled())
      print_at(STR_SRAM_ON, 5, 5, COLOR_LIGHT_GREEN);
    else
      print_at(STR_SRAM_OFF, 5, 5, COLOR_RED);

    print_at(STR_BANCO, 5, 10, COLOR_CYAN);
    char bank_ch[2];
    bank_ch[0] = '0' + mdp_get_bank();
    bank_ch[1] = '\0';
    print_at(bank_ch, 5, 16, COLOR_WHITE);

    print_at(STR_PAGINA, 5, 19, COLOR_CYAN);
    char pg[3];
    pg[0] = hex_digit(cur_page >> 4);
    pg[1] = hex_digit(cur_page & 0x0F);
    pg[2] = '\0';
    print_at(pg, 5, 23, COLOR_WHITE);

    print_at(STR_OFFSET, 5, 27, COLOR_CYAN);
    char of[3];
    of[0] = hex_digit(base_offset >> 4);
    of[1] = hex_digit(base_offset & 0x0F);
    of[2] = '\0';
    print_at(of, 5, 31, COLOR_WHITE);
  } else {
    print_at(STR_EEPROM_STATO, 5, 0, COLOR_CYAN);
    if (!mdp_sram_is_enabled())
      print_at(STR_EEPROM_ON, 5, 8, COLOR_LIGHT_GREEN);
    else
      print_at(STR_EEPROM_OFF, 5, 8, COLOR_RED);

    print_at(STR_PAGINA, 5, 14, COLOR_CYAN);
    char pg[3];
    pg[0] = hex_digit(cur_page >> 4);
    pg[1] = hex_digit(cur_page & 0x0F);
    pg[2] = '\0';
    print_at(pg, 5, 19, COLOR_WHITE);

    print_at(STR_OFFSET, 5, 23, COLOR_CYAN);
    char of[3];
    of[0] = hex_digit(base_offset >> 4);
    of[1] = hex_digit(base_offset & 0x0F);
    of[2] = '\0';
    print_at(of, 5, 27, COLOR_WHITE);
  }
}

/* ------------------------------------------------------------------ */
/*  Editor Interattivo Pagine SRAM (F1)                                */
/* ------------------------------------------------------------------ */
void show_sram_editor_screen(void) {
  uint8_t cur_page = 0;
  uint8_t base_offset = 0; /* 0x00, 0x40, 0x80, 0xC0 */

  /* Abilita la SRAM/EEPROM e imposta pagina iniziale */
  if (sram_mode_active)
    mdp_sram_enable();
  else
    mdp_eeprom_enable();

  mdp_set_page(cur_page);

  while (1) {
    clear_screen(COLOR_DARK_GRAY);
    if (sram_mode_active)
      print_centered(STR_EDITOR_SRAM_TITLE, 3, COLOR_YELLOW);
    else
      print_centered(STR_EDITOR_EEPROM_TITLE, 3, COLOR_YELLOW);

    draw_sram_status_bar(cur_page, base_offset);
    draw_sram_page_view(base_offset);

    /* Barra comandi */
    print_at(sram_mode_active ? STR_EDITOR_KEYS_1 : STR_EDITOR_KEYS_1_EEPROM, 20, 1, COLOR_LIGHT_GREEN);
    print_at(STR_EDITOR_KEYS_2, 21, 1, COLOR_GREEN);

    clear_row(23, COLOR_DARK_GRAY);

    while (1) {
      uint8_t k = get_key();
      if (k == 'm' || k == 'M') {
        if (sram_mode_active)
          mdp_sram_disable();
        else
          mdp_eeprom_disable();
        return;
      }
      if (k == 'e' || k == 'E') {
        if (mdp_sram_is_enabled())
          mdp_sram_disable();
        else
          mdp_sram_enable();
        break; /* Ridisegna */
      }
      if (k == 'b' || k == 'B') {
        if (sram_mode_active) {
          mdp_set_bank(mdp_get_bank() ? 0 : 1);
          break;
        }
      }
      if (k == 'p' || k == 'P') {
        print_at(sram_mode_active ? STR_INSERISCI_PAGINA : (eeprom_size_kb == 32 ? STR_INSERISCI_PAGINA_32 : STR_INSERISCI_PAGINA_8), 23, 1, COLOR_CYAN);
        cur_page = prompt_hex_byte(23, 21);

        uint8_t max_page = sram_mode_active ? 255 : ((eeprom_size_kb == 32) ? 127 : 31);
        if (cur_page > max_page)
          cur_page = max_page;

        mdp_set_page(cur_page);
        base_offset = 0;
        break;
      }
      if (k == 'w' || k == 'W') {
        bool is_active = sram_mode_active ? mdp_sram_is_enabled() : !mdp_sram_is_enabled();
        if (!is_active) {
          print_at(sram_mode_active ? STR_SRAM_NON_ATTIVA : STR_EEPROM_NON_ATTIVA, 23, 1, COLOR_RED);
        } else {
          print_at(STR_INSERISCI_OFFSET, 23, 1, COLOR_CYAN);
          uint8_t w_off = prompt_hex_byte(23, 21);
          clear_row(23, COLOR_DARK_GRAY);
          print_at(STR_INSERISCI_VALORE, 23, 1, COLOR_CYAN);
          uint8_t w_val = prompt_hex_byte(23, 21);

          if (sram_mode_active)
            mdp_write_byte(w_off, w_val);
          else
            mdp_eeprom_write_byte(cur_page, w_off, w_val);

          clear_row(23, COLOR_DARK_GRAY);
          print_at(STR_BYTE_SCRITTO, 23, 1, COLOR_LIGHT_GREEN);
        }
        break;
      }
      /* Navigazione offset con F1 / F3 (anche con - / +) */
      if (k == '-' || k == KEY_F1) {
        if (base_offset >= 8)
          base_offset -= 8;
        else
          base_offset = 0xa0;
        break;
      }
      if (k == '+' || k == KEY_F3) {
        if (base_offset < 0xa0)
          base_offset += 8;
        else
          base_offset = 0;
        break;
      }
      /* Navigazione pagine con Fn (F5 / F7) */
      uint8_t max_page = sram_mode_active ? 255 : ((eeprom_size_kb == 32) ? 127 : 31);
      if (k == KEY_F5) {
        if (cur_page > 0)
          cur_page--;
        else
          cur_page = max_page;
        mdp_set_page(cur_page);
        break;
      }
      if (k == KEY_F7) {
        if (cur_page < max_page)
          cur_page++;
        else
          cur_page = 0;
        mdp_set_page(cur_page);
        break;
      }
    }
  }
}

/* ------------------------------------------------------------------ */
/*  Self-Test Integrita' SRAM/EEPROM                                    */
/* ------------------------------------------------------------------ */
void sram_selftest(void) {
  clear_screen(COLOR_DARK_GRAY);
  if (sram_mode_active) {
    print_centered(STR_DIAG_TITLE, 3, COLOR_YELLOW);
    if (sram_status == MDP_DETECT_ABSENT) {
      print_centered(STR_SRAM_ASSENTE_ERR, 11, COLOR_RED);
      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13) ;
      return;
    }
  } else {
    print_centered(STR_DIAG_TITLE_EEPROM, 3, COLOR_YELLOW);
    if (eeprom_status == MDP_DETECT_ABSENT) {
      print_centered(STR_EEPROM_ASSENTE_ERR, 11, COLOR_RED);
      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13) ;
      return;
    }
  }

  print_centered(STR_SELFTEST_RUNNING, 11, COLOR_CYAN);

  uint8_t old_shadow = mdp_ctrl_shadow;
  uint8_t patterns[3];
  patterns[0] = 0xAA;
  patterns[1] = 0x55;
  patterns[2] = 0x00;
  bool failed = false;
  uint8_t fail_bank = 0;
  uint8_t fail_page = 0;

  uint8_t bank;
  uint8_t max_bank = sram_mode_active ? 2 : 1;
  uint16_t max_page = sram_mode_active ? 256 : ((eeprom_size_kb == 32) ? 128 : 32);

  for (bank = 0; bank < max_bank && !failed; bank++) {
    if (sram_mode_active) {
      mdp_set_bank(bank);
      mdp_sram_enable();
    } else {
      mdp_eeprom_enable();
    }

    /* Mostra progresso banco */
    if (sram_mode_active) {
      char bank_msg[20];
      {
        const char *sb = STR_SELFTEST_BANK;
        int i = 0;
        while (sb[i] != '\0' && i < 18) {
          bank_msg[i] = sb[i];
          i++;
        }
        bank_msg[i++] = ' ';
        bank_msg[i++] = '0' + bank;
        bank_msg[i] = '\0';
      }
      print_centered(bank_msg, 13, COLOR_WHITE);
    }

    uint16_t page;
    for (page = 0; page < max_page && !failed; page++) {
      /* Mostra progresso pagina */
      if ((page & 0x0F) == 0) {
        char pg_str[12];
        int pi = 0;
        const char *sp = STR_SELFTEST_PAGE;
        while (sp[pi] != '\0' && pi < 8) {
          pg_str[pi] = sp[pi];
          pi++;
        }
        pg_str[pi++] = ' ';
        pg_str[pi++] = hex_digit((uint8_t)(page >> 4));
        pg_str[pi++] = hex_digit((uint8_t)(page & 0x0F));
        pg_str[pi] = '\0';
        print_centered(pg_str, 15, COLOR_LIGHT_GRAY);
      }

      mdp_set_page((uint8_t)page);

      /* Salva i dati originali della pagina */
      uint8_t saved[256];
      uint16_t idx;
      for (idx = 0; idx < 256; idx++)
        saved[idx] = mdp_read_byte((uint8_t)idx);

      /* Test con ogni pattern */
      int p;
      for (p = 0; p < 3 && !failed; p++) {
        /* Scrivi il pattern */
        for (idx = 0; idx < 256; idx++) {
          if (sram_mode_active)
            mdp_write_byte((uint8_t)idx, patterns[p]);
          else
            mdp_eeprom_write_byte((uint8_t)page, (uint8_t)idx, patterns[p]);
        }

        /* Verifica */
        for (idx = 0; idx < 256; idx++) {
          if (mdp_read_byte((uint8_t)idx) != patterns[p]) {
            failed = true;
            fail_bank = bank;
            fail_page = (uint8_t)page;
            break;
          }
        }
      }

      /* Ripristina i dati originali */
      for (idx = 0; idx < 256; idx++) {
        if (sram_mode_active)
          mdp_write_byte((uint8_t)idx, saved[idx]);
        else
          mdp_eeprom_write_byte((uint8_t)page, (uint8_t)idx, saved[idx]);
      }
    }
  }

  /* Riscrivi la firma di inizializzazione */
  if (sram_mode_active)
    mdp_write_signature();
  else
    mdp_eeprom_write_signature(eeprom_size_kb);

  /* Ripristina lo stato precedente */
  mdp_ctrl_shadow = old_shadow;
  *MDP_REG_CTRL = mdp_ctrl_shadow;

  if (failed) {
    char fail_msg[40];
    const char *sf = STR_SELFTEST_FAIL;
    int i = 0;
    while (sf[i] != '\0' && i < 30) {
      fail_msg[i] = sf[i];
      i++;
    }
    if (sram_mode_active) {
      fail_msg[i++] = 'B';
      fail_msg[i++] = '0' + fail_bank;
      fail_msg[i++] = ' ';
    }
    fail_msg[i++] = 'P';
    fail_msg[i++] = hex_digit(fail_page >> 4);
    fail_msg[i++] = hex_digit(fail_page & 0x0F);
    fail_msg[i] = '\0';
    print_centered(fail_msg, 17, COLOR_RED);
  } else {
    print_centered(STR_SELFTEST_OK, 17, COLOR_LIGHT_GREEN);
  }

  print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
  while (get_key() != 13)
    ;
}

/* ------------------------------------------------------------------ */
/*  Backup RAM $C000-$CFFF su SRAM/EEPROM (16 pagine, pag 0-15)       */
/* ------------------------------------------------------------------ */
void sram_backup(void) {
  clear_screen(COLOR_DARK_GRAY);
  if (sram_mode_active) {
    print_centered(STR_DIAG_TITLE, 3, COLOR_YELLOW);
    if (sram_status == MDP_DETECT_ABSENT) {
      print_centered(STR_SRAM_ASSENTE_ERR, 11, COLOR_RED);
      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13) ;
      return;
    }
  } else {
    print_centered(STR_DIAG_TITLE_EEPROM, 3, COLOR_YELLOW);
    if (eeprom_status == MDP_DETECT_ABSENT) {
      print_centered(STR_EEPROM_ASSENTE_ERR, 11, COLOR_RED);
      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13) ;
      return;
    }
  }

  print_centered(STR_BACKUP_RUNNING, 11, COLOR_CYAN);

  uint8_t old_shadow = mdp_ctrl_shadow;
  if (sram_mode_active) {
    mdp_set_bank(0);
    mdp_sram_enable();
  } else {
    mdp_eeprom_enable();
  }

  uint8_t page;
  for (page = 0; page < 16; page++) {
    uint16_t base_addr = 0xC000 + ((uint16_t)page * 256);
    if (sram_mode_active) {
      mdp_set_page(page);
      uint16_t i;
      for (i = 0; i < 256; i++) {
        uint8_t val = *((volatile uint8_t *)(base_addr + i));
        mdp_write_byte((uint8_t)i, val);
      }
    } else {
      mdp_eeprom_write_cart_page(page, (const uint8_t *)base_addr, eeprom_size_kb);
    }
  }

  mdp_ctrl_shadow = old_shadow;
  *MDP_REG_CTRL = mdp_ctrl_shadow;

  print_centered(STR_BACKUP_OK, 15, COLOR_LIGHT_GREEN);
  print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
  while (get_key() != 13)
    ;
}

/* ------------------------------------------------------------------ */
/*  Ripristina RAM $C000-$CFFF da SRAM/EEPROM (banco 0, pag 0-15)     */
/* ------------------------------------------------------------------ */
void sram_restore(void) {
  clear_screen(COLOR_DARK_GRAY);
  if (sram_mode_active) {
    print_centered(STR_DIAG_TITLE, 3, COLOR_YELLOW);
    if (sram_status == MDP_DETECT_ABSENT) {
      print_centered(STR_SRAM_ASSENTE_ERR, 11, COLOR_RED);
      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13) ;
      return;
    }
  } else {
    print_centered(STR_DIAG_TITLE_EEPROM, 3, COLOR_YELLOW);
    if (eeprom_status == MDP_DETECT_ABSENT) {
      print_centered(STR_EEPROM_ASSENTE_ERR, 11, COLOR_RED);
      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13) ;
      return;
    }
  }

  print_centered(STR_RESTORE_RUNNING, 11, COLOR_CYAN);

  uint8_t old_shadow = mdp_ctrl_shadow;
  if (sram_mode_active) {
    mdp_set_bank(0);
    mdp_sram_enable();
  } else {
    mdp_eeprom_enable();
  }

  uint8_t page;
  for (page = 0; page < 16; page++) {
    mdp_set_page(page);
    uint16_t base_addr = 0xC000 + ((uint16_t)page * 256);
    uint16_t i;
    for (i = 0; i < 256; i++) {
      *((volatile uint8_t *)(base_addr + i)) = mdp_read_byte((uint8_t)i);
    }
  }

  mdp_ctrl_shadow = old_shadow;
  *MDP_REG_CTRL = mdp_ctrl_shadow;

  print_centered(STR_RESTORE_OK, 15, COLOR_LIGHT_GREEN);
  print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
  while (get_key() != 13)
    ;
}

/* ------------------------------------------------------------------ */
/*  Formatta SRAM/EEPROM: riempie con $00 e scrive firma               */
/* ------------------------------------------------------------------ */
void sram_format(void) {
  clear_screen(COLOR_DARK_GRAY);
  if (sram_mode_active) {
    print_centered(STR_DIAG_TITLE, 3, COLOR_YELLOW);
    if (sram_status == MDP_DETECT_ABSENT) {
      print_centered(STR_SRAM_ASSENTE_ERR, 11, COLOR_RED);
      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13) ;
      return;
    }
    print_centered(STR_FORMAT_CONFIRM, 11, COLOR_YELLOW);
  } else {
    print_centered(STR_DIAG_TITLE_EEPROM, 3, COLOR_YELLOW);
    if (eeprom_status == MDP_DETECT_ABSENT) {
      print_centered(STR_EEPROM_ASSENTE_ERR, 11, COLOR_RED);
      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13) ;
      return;
    }
    print_centered(STR_FORMAT_CONFIRM_EEPROM, 11, COLOR_YELLOW);
  }

  while (1) {
    uint8_t k = get_key();
    if (k == 'n' || k == 'N') {
      print_centered(STR_OP_CANCELED, 15, COLOR_RED);
      print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
      while (get_key() != 13)
        ;
      return;
    }
    if (k == 'y' || k == 'Y')
      break;
  }

  print_centered(STR_FORMAT_RUNNING, 15, COLOR_CYAN);

  uint8_t old_shadow = mdp_ctrl_shadow;

  if (sram_mode_active) {
    uint8_t bank;
    for (bank = 0; bank < 2; bank++) {
      mdp_set_bank(bank);
      mdp_sram_enable();

      uint16_t page;
      for (page = 0; page < 256; page++) {
        mdp_set_page((uint8_t)page);
        uint16_t i;
        for (i = 0; i < 256; i++)
          mdp_write_byte((uint8_t)i, 0x00);
      }
    }
    mdp_write_signature();
    sram_status = MDP_DETECT_PRESENT_INIT;
  } else {
    mdp_eeprom_enable();
    uint8_t zero_buf[256];
    uint16_t i;
    for (i = 0; i < 256; i++) zero_buf[i] = 0x00;
    
    uint16_t max_page = (eeprom_size_kb == 32) ? 128 : 32;
    uint16_t page;
    for (page = 0; page < max_page; page++) {
      mdp_eeprom_write_cart_page((uint8_t)page, zero_buf, eeprom_size_kb);
    }
    mdp_eeprom_write_signature(eeprom_size_kb);
    eeprom_status = MDP_DETECT_PRESENT_INIT;
  }

  mdp_ctrl_shadow = old_shadow;
  *MDP_REG_CTRL = mdp_ctrl_shadow;

  print_centered(STR_FORMAT_OK, 17, COLOR_LIGHT_GREEN);
  print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
  while (get_key() != 13)
    ;
}

/* ------------------------------------------------------------------ */
/*  Legge la directory del floppy e filtra i file PRG                   */
/* ------------------------------------------------------------------ */
bool read_prg_directory(void) {
  prg_count = 0;

  krnio_setnam("$");
  if (!krnio_open(2, 8, 0))
    return false;

  if (!krnio_chkin(2)) {
    krnio_close(2);
    return false;
  }

  /* Salta i primi 2 byte dell'header BASIC */
  krnio_chrin();
  krnio_chrin();

  if (krnio_status() & (KRNIO_TIMEOUT | KRNIO_NODEVICE)) {
    krnio_clrchn();
    krnio_close(2);
    return false;
  }

  int ch;
  bool is_first = true;

  while ((ch = krnio_chrin()) > 0 && prg_count < MAX_PRG_FILES) {
    uint16_t line;
    char buff[40];

    krnio_chrin(); /* Secondo byte del link BASIC */
    ch = krnio_chrin();
    line = (uint8_t)ch;
    ch = krnio_chrin();
    line += 256 * (uint8_t)ch;

    if (krnio_status() & (KRNIO_TIMEOUT | KRNIO_NODEVICE))
      break;

    int n = 0;
    while ((ch = krnio_chrin()) > 0) {
      if (krnio_status() & (KRNIO_TIMEOUT | KRNIO_NODEVICE))
        break;
      if (n < 39)
        buff[n++] = (char)ch;
    }
    buff[n] = 0;

    if (is_first) {
      is_first = false;
      continue; /* Salta l'header del disco */
    }

    /* Trova il filename tra le virgolette */
    int start = 0;
    while (buff[start] != '\0' && buff[start] != '"')
      start++;
    if (buff[start] != '"')
      continue;
    start++;
    int end = start;
    while (buff[end] != '\0' && buff[end] != '"')
      end++;
    if (buff[end] != '"')
      continue;

    /* Cerca il tipo PRG dopo la chiusura del filename */
    bool is_prg = false;
    int t = end + 1;
    while (buff[t] != '\0') {
      if (buff[t] == 'P' && buff[t + 1] == 'R' && buff[t + 2] == 'G') {
        is_prg = true;
        break;
      }
      t++;
    }

    if (!is_prg)
      continue;

    /* Salva il filename (rimuove spazi di padding $A0) */
    int k = 0;
    int idx;
    for (idx = start; idx < end && k < 16; idx++) {
      prg_names[prg_count][k++] = buff[idx];
    }
    while (k > 0 && ((uint8_t)prg_names[prg_count][k - 1] == 160 ||
                      prg_names[prg_count][k - 1] == ' '))
      k--;
    prg_names[prg_count][k] = '\0';
    prg_blocks_arr[prg_count] = line;
    prg_count++;
  }

  krnio_clrchn();
  krnio_close(2);
  return true;
}

/* ------------------------------------------------------------------ */
/*  Disegna la lista file PRG con indicatore di selezione               */
/* ------------------------------------------------------------------ */
void draw_scroll_pos(uint8_t selected) {
  clear_row(21, COLOR_DARK_GRAY);
  if (prg_count > VISIBLE_FILES) {
    char pos_str[10];
    char num[6];
    int pi = 0;
    int ni;
    uint16_to_str(selected + 1, num);
    ni = 0;
    while (num[ni])
      pos_str[pi++] = num[ni++];
    pos_str[pi++] = '/';
    uint16_to_str(prg_count, num);
    ni = 0;
    while (num[ni])
      pos_str[pi++] = num[ni++];
    pos_str[pi] = '\0';
    print_centered(pos_str, 21, COLOR_LIGHT_GRAY);
  }
}

void draw_file_item(uint8_t file_idx, uint8_t scroll_offset, bool is_sel) {
  if (file_idx < scroll_offset || file_idx >= scroll_offset + VISIBLE_FILES)
    return;
  if (file_idx >= prg_count)
    return;

  uint8_t screen_row = FILE_LIST_START_ROW + (file_idx - scroll_offset);
  clear_row(screen_row, COLOR_DARK_GRAY);

  uint8_t name_color = is_sel ? COLOR_YELLOW : COLOR_WHITE;
  uint8_t blk_color = is_sel ? COLOR_CYAN : COLOR_LIGHT_GRAY;

  print_at(is_sel ? ">" : " ", screen_row, 1, name_color);
  print_at(prg_names[file_idx], screen_row, 3, name_color);

  /* Block count allineato a destra */
  char blk_str[10];
  uint16_to_str(prg_blocks_arr[file_idx], blk_str);
  int bl = mystrlen(blk_str);
  const char *suf = STR_PRG_BLOCKS;
  int s = 0;
  while (suf[s] != '\0' && bl < 9) {
    blk_str[bl++] = suf[s++];
  }
  blk_str[bl] = '\0';

  uint8_t col = (uint8_t)(39 - bl);
  if (col < 22)
    col = 22;
  print_at(blk_str, screen_row, col, blk_color);
}

void draw_file_list(uint8_t selected, uint8_t scroll_offset) {
  uint8_t row;
  for (row = 0; row < VISIBLE_FILES; row++) {
    uint8_t file_idx = scroll_offset + row;
    if (file_idx >= prg_count) {
      clear_row(FILE_LIST_START_ROW + row, COLOR_DARK_GRAY);
      continue;
    }
    draw_file_item(file_idx, scroll_offset, (file_idx == selected));
  }
  draw_scroll_pos(selected);
}

/* ------------------------------------------------------------------ */
/*  Carica il file PRG selezionato nella SRAM                          */
/* ------------------------------------------------------------------ */
void load_prg_to_sram(uint8_t file_index) {
  clear_screen(COLOR_DARK_GRAY);
  print_centered(STR_PRG_TITLE, 3, COLOR_YELLOW);

  if (sram_status == MDP_DETECT_ABSENT) {
    print_centered(STR_SRAM_ASSENTE_ERR, 11, COLOR_RED);
    print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
    while (get_key() != 13)
      ;
    return;
  }

  print_centered(STR_PRG_LOADING, 11, COLOR_CYAN);

  /* Costruisci "FILENAME,P,R" */
  char open_name[22];
  int i = 0;
  int k = 0;
  while (prg_names[file_index][k] != '\0' && i < 16) {
    open_name[i++] = prg_names[file_index][k++];
  }
  open_name[i++] = ',';
  open_name[i++] = 'P';
  open_name[i++] = ',';
  open_name[i++] = 'R';
  open_name[i] = '\0';

  krnio_setnam(open_name);
  if (!krnio_open(3, 8, 3)) {
    print_centered(STR_ERR_OPEN_READ, 13, COLOR_RED);
    krnio_setnam("");
    if (krnio_open(15, 8, 15)) {
      krnio_close(15);
    }
    print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
    while (get_key() != 13)
      ;
    return;
  }

  if (!krnio_chkin(3)) {
    krnio_close(3);
    print_centered(STR_ERR_CHANNEL, 13, COLOR_RED);
    print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
    while (get_key() != 13)
      ;
    return;
  }

  /* Salta i primi 2 byte (indirizzo di caricamento PRG) */
  krnio_chrin();
  krnio_chrin();

  uint8_t old_shadow = mdp_ctrl_shadow;
  mdp_set_bank(0);
  mdp_sram_enable();
  mdp_set_page(0);

  uint8_t page = 0;
  uint8_t offset = 0;
  uint8_t bank = 0;
  uint16_t pages_written = 0;
  bool read_ok = true;

  while (1) {
    uint8_t val = krnio_chrin();
    uint8_t status = krnio_status();

    if (status & (KRNIO_TIMEOUT | KRNIO_NODEVICE)) {
      read_ok = false;
      break;
    }

    mdp_write_byte(offset, val);

    bool is_eof = (status & KRNIO_EOF) != 0;

    offset++;
    if (offset == 0) { /* Wrap: pagina piena */
      page++;
      pages_written++;

      if (page == 0) { /* Wrap: banco pieno */
        bank++;
        if (bank >= 2)
          break; /* SRAM piena */
        mdp_set_bank(bank);
      }
      mdp_set_page(page);

      /* Mostra progresso ogni 16 pagine */
      if ((page & 0x0F) == 0) {
        char pg_msg[12];
        int pi = 0;
        const char *sp = STR_PAGINA;
        while (sp[pi] != '\0' && pi < 5) {
          pg_msg[pi] = sp[pi];
          pi++;
        }
        pg_msg[pi++] = ' ';
        pg_msg[pi++] = hex_digit(page >> 4);
        pg_msg[pi++] = hex_digit(page & 0x0F);
        pg_msg[pi] = '\0';
        print_centered(pg_msg, 13, COLOR_LIGHT_GRAY);
      }
    }

    if (is_eof)
      break;
  }

  /* Pagina parzialmente scritta */
  if (offset > 0)
    pages_written++;

  mdp_ctrl_shadow = old_shadow;
  *MDP_REG_CTRL = mdp_ctrl_shadow;

  krnio_clrchn();
  krnio_close(3);

  if (read_ok) {
    print_centered(STR_PRG_LOADED_OK, 15, COLOR_LIGHT_GREEN);

    /* Mostra conteggio pagine scritte */
    char pg_msg[25];
    char num[6];
    uint16_to_str(pages_written, num);
    int pi = 0;
    int ni = 0;
    while (num[ni])
      pg_msg[pi++] = num[ni++];
    const char *suf = STR_PRG_PAGES_WRITTEN;
    ni = 0;
    while (suf[ni] != '\0' && pi < 24) {
      pg_msg[pi++] = suf[ni++];
    }
    pg_msg[pi] = '\0';
    print_centered(pg_msg, 17, COLOR_CYAN);
  } else {
    print_centered(STR_ERR_DOS_ERROR, 15, COLOR_RED);
  }

  print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
  while (get_key() != 13)
    ;
}

/* ------------------------------------------------------------------ */
/*  Schermata principale del loader PRG                                 */
/* ------------------------------------------------------------------ */
void show_prg_loader_screen(void) {
  clear_screen(COLOR_DARK_GRAY);
  print_centered(STR_PRG_TITLE, 3, COLOR_YELLOW);
  print_centered(STR_PRG_READING_DIR, 11, COLOR_CYAN);

  bool dir_ok = read_prg_directory();

  if (!dir_ok) {
    clear_row(11, COLOR_DARK_GRAY);
    print_centered(STR_ERR_ACCESS_UNIT_8, 11, COLOR_RED);
    print_centered(STR_ERR_CHECK_UNIT, 13, COLOR_YELLOW);
    print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
    while (get_key() != 13)
      ;
    return;
  }

  if (prg_count == 0) {
    clear_row(11, COLOR_DARK_GRAY);
    print_centered(STR_PRG_NO_FILES, 11, COLOR_RED);
    print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
    while (get_key() != 13)
      ;
    return;
  }

  uint8_t selected = 0;
  uint8_t scroll_offset = 0;

  clear_screen(COLOR_DARK_GRAY);
  print_centered(STR_PRG_TITLE, 3, COLOR_YELLOW);
  draw_file_list(selected, scroll_offset);
  print_centered(STR_PRG_HELP_BAR, 23, COLOR_LIGHT_GREEN);

  while (1) {
    uint8_t k = get_key();
    if (k == 0)
      continue;

    if (k == 'm' || k == 'M')
      return;

    if (k == KEY_CURSOR_DOWN && selected < prg_count - 1) {
      uint8_t prev_selected = selected;
      selected++;
      if (selected >= scroll_offset + VISIBLE_FILES) {
        scroll_offset = selected - VISIBLE_FILES + 1;
        draw_file_list(selected, scroll_offset);
      } else {
        draw_file_item(prev_selected, scroll_offset, false);
        draw_file_item(selected, scroll_offset, true);
        draw_scroll_pos(selected);
      }
    }

    if (k == KEY_CURSOR_UP && selected > 0) {
      uint8_t prev_selected = selected;
      selected--;
      if (selected < scroll_offset) {
        scroll_offset = selected;
        draw_file_list(selected, scroll_offset);
      } else {
        draw_file_item(prev_selected, scroll_offset, false);
        draw_file_item(selected, scroll_offset, true);
        draw_scroll_pos(selected);
      }
    }

    if (k == 13) {
      load_prg_to_sram(selected);
      return;
    }
  }
}

/* ------------------------------------------------------------------ */
/*  Schermata Diagnostica SRAM/EEPROM (F3)                             */
/* ------------------------------------------------------------------ */
void show_sram_diag_screen(void) {
  while (1) {
    clear_screen(COLOR_DARK_GRAY);
    if (sram_mode_active) {
      print_centered(STR_DIAG_TITLE, 3, COLOR_YELLOW);
      print_at(STR_F1_SELFTEST, 9, 8, COLOR_WHITE);
      print_at(STR_F3_CARICA_PRG, 11, 8, COLOR_WHITE);
      print_at(STR_F5_DA_DEFINIRE, 13, 8, COLOR_WHITE);
      print_at(STR_F7_FORMAT, 15, 8, COLOR_WHITE);
    } else {
      print_centered(STR_DIAG_TITLE_EEPROM, 3, COLOR_YELLOW);
      print_at(STR_F1_SELFTEST, 9, 8, COLOR_WHITE);
      print_at(STR_F3_BACKUP_EEPROM, 11, 8, COLOR_WHITE);
      print_at(STR_F5_RESTORE_EEPROM, 13, 8, COLOR_WHITE);
      print_at(STR_F7_FORMAT_EEPROM, 15, 8, COLOR_WHITE);
    }
    print_centered(STR_PREMI_M_PER_MENU, 23, COLOR_LIGHT_GREEN);

    while (1) {
      uint8_t k = get_key();
      if (k == 'm' || k == 'M')
        return;
      if (k == KEY_F1) {
        sram_selftest();
        break;
      }
      if (k == KEY_F3) {
        if (sram_mode_active)
          show_prg_loader_screen();
        else
          sram_backup();
        break;
      }
      if (k == KEY_F5) {
        if (!sram_mode_active) {
          sram_restore();
        } else {
          check_floppy();
        }
        break;
      }
      if (k == KEY_F7) {
        sram_format();
        break;
      }
    }
  }
}

/* ------------------------------------------------------------------ */
/*  Menu Principale                                                    */
/* ------------------------------------------------------------------ */
void draw_main_menu(void) {
  clear_screen(COLOR_DARK_GRAY);

  if (sram_mode_active) {
    print_centered(STR_GESTIONE_SRAM, 3, COLOR_YELLOW);

    /* Mostra stato SRAM rilevato */
    if (sram_status == MDP_DETECT_ABSENT) {
      print_centered(STR_SRAM_ASSENTE, 5, COLOR_RED);
    } else {
      print_at(STR_SRAM_PRESENTE, 5, 5, COLOR_LIGHT_GREEN);
      if (sram_status == MDP_DETECT_PRESENT_INIT)
        print_at(STR_SRAM_INIZIALIZZATA, 5, 21, COLOR_GREEN);
      else
        print_at(STR_SRAM_NON_INIZIALIZZATA, 5, 21, COLOR_YELLOW);
    }

    print_at(STR_F1_FUNZIONE_1, 9, 10, COLOR_WHITE);
    print_at(STR_F3_FUNZIONE_2, 11, 10, COLOR_WHITE);
    print_at(STR_F5_DUMP_FLOPPY, 13, 10, COLOR_WHITE);
  } else {
    print_centered(STR_GESTIONE_EEPROM, 3, COLOR_YELLOW);

    /* Mostra stato EEPROM rilevato */
    if (eeprom_status == MDP_DETECT_ABSENT) {
      print_centered(STR_EEPROM_ASSENTE, 5, COLOR_RED);
    } else {
      if (eeprom_size_kb == 32)
        print_at(STR_EEPROM_PRESENTE_32, 5, 5, COLOR_LIGHT_GREEN);
      else
        print_at(STR_EEPROM_PRESENTE_8, 5, 5, COLOR_LIGHT_GREEN);

      if (eeprom_status == MDP_DETECT_PRESENT_INIT)
        print_at(STR_SRAM_INIZIALIZZATA, 5, 27, COLOR_GREEN);
      else
        print_at(STR_SRAM_NON_INIZIALIZZATA, 5, 27, COLOR_YELLOW);
    }

    print_at(STR_F1_EEPROM, 9, 10, COLOR_WHITE);
    print_at(STR_F3_EEPROM, 11, 10, COLOR_WHITE);
    print_at(STR_F5_EEPROM, 13, 10, COLOR_WHITE);
  }

  print_at(STR_F7_TOGGLE_SRAM_EEPROM, 15, 10, COLOR_WHITE);
  print_centered(STR_PREMI_X_USCIRE, 23, COLOR_LIGHT_GREEN);
}

int main(void) {
  // Disabilita la ROM della Magic Desk Plus per evitare sovrapposizioni 
  // con la RAM a partire da $8000 (disabilita segnale EXROM)
  *MDP_REG_BANK = 0x80;

  *VIC_BORDER_COLOR = COLOR_BLACK;
  *VIC_BG_COLOR = COLOR_BLACK;
 
  // Pulisce la tabella file del Kernal e ripristina I/O predefiniti
  // Necessario per evitare conflitti con file residui dal caricamento BASIC
  __asm {
        jsr $ffe7 // CLALL
  }
  ;

  /* Rilevamento SRAM all'avvio */
  clear_screen(COLOR_DARK_GRAY);
  print_centered(STR_GESTIONE_SRAM, 3, COLOR_YELLOW);
  print_centered(STR_RILEVAMENTO_SRAM, 11, COLOR_CYAN);
  sram_status = mdp_detect_sram();

  /* Se presente ma non inizializzata, chiedi all'utente */
  if (sram_status == MDP_DETECT_PRESENT_UNINIT) {
    print_centered(STR_SRAM_INIT_PROMPT, 13, COLOR_YELLOW);
    while (1) {
      uint8_t k = get_key();
      if (k == 'y' || k == 'Y') {
        mdp_write_signature();
        sram_status = MDP_DETECT_PRESENT_INIT;
        print_centered(STR_SRAM_INIT_OK, 15, COLOR_LIGHT_GREEN);
        print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
        while (get_key() != 13)
          ;
        break;
      }
      if (k == 'n' || k == 'N')
        break;
    }
  }

  /* Rilevamento EEPROM all'avvio */
  clear_screen(COLOR_DARK_GRAY);
  print_centered(STR_GESTIONE_EEPROM, 3, COLOR_YELLOW);
  print_centered(STR_RILEVAMENTO_EEPROM, 11, COLOR_CYAN);
  eeprom_status = mdp_detect_eeprom(&eeprom_size_kb);

  /* Se presente ma non inizializzata, chiedi all'utente */
  if (eeprom_status == MDP_DETECT_PRESENT_UNINIT) {
    print_centered(STR_EEPROM_INIT_PROMPT, 13, COLOR_YELLOW);
    while (1) {
      uint8_t k = get_key();
      if (k == 'y' || k == 'Y') {
        mdp_eeprom_write_signature(eeprom_size_kb);
        eeprom_status = MDP_DETECT_PRESENT_INIT;
        print_centered(STR_EEPROM_INIT_OK, 15, COLOR_LIGHT_GREEN);
        print_centered(STR_PREMI_RETURN_CONTINUARE, 23, COLOR_WHITE);
        while (get_key() != 13)
          ;
        break;
      }
      if (k == 'n' || k == 'N')
        break;
    }
  }

  draw_main_menu();
  while (1) {
    uint8_t key = get_key();
    if (key != 0) {
      if (key == KEY_F1)
        show_sram_editor_screen();
      else if (key == KEY_F3)
        show_sram_diag_screen();
      else if (key == KEY_F5)
        show_dump_screen();
      else if (key == KEY_F7) {
        sram_mode_active = !sram_mode_active;
      }
      else if (key == 'x' || key == 'X') {
        mdp_sram_disable();
        clear_screen(COLOR_BLACK);
        print_at(STR_EXIT_QUOTE, 0, 0, COLOR_WHITE);
        break;
      }
      draw_main_menu();
    }
  }
  return 0;
}