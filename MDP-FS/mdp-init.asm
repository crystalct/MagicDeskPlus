; =============================================================================
; mdp-init.asm — Installer dei MagicDesk Plus Hooks (IOPEN, ILOAD, ISAVE)
; Compilatore: 64tass (con flag -a)
; Target: Commodore 64
; Caricamento: $0801
;
; Questo programma va eseguito via BASIC (RUN) DOPO aver caricato
; mdp-hook.prg a $C006 con: LOAD "mdp-hook.prg",8,1
;
; Operazioni svolte:
;   1. Salva il vecchio vettore IOPEN ($031A/$031B) in $C000/$C001
;   2. Salva il vecchio vettore ILOAD ($0330/$0331) in $C002/$C003
;   3. Salva il vecchio vettore ISAVE ($0332/$0333) in $C004/$C005
;   4. Scrive il nuovo vettore IOPEN ($C006) in $031A/$031B
;   5. Scrive il nuovo vettore ILOAD ($C009) in $0330/$0331
;   6. Scrive il nuovo vettore ISAVE ($C00C) in $0332/$0333
;   7. Ritorna al BASIC
; =============================================================================

; --- Costanti KERNAL ---
IOPEN_VEC       = $031A         ; Vettore IOPEN in Pagina 3 (lo/hi)
ILOAD_VEC       = $0330         ; Vettore ILOAD in Pagina 3 (lo/hi)
ISAVE_VEC       = $0332         ; Vettore ISAVE in Pagina 3 (lo/hi)

SETLFS          = $FFBA         ; Imposta i parametri logici del file
SETNAM          = $FFBD         ; Imposta il nome del file
LOAD            = $FFD5         ; Routine di caricamento RAM
CHROUT          = $FFD2         ; Stampa carattere a video
LAST_DEV        = $BA           ; Ultimo device utilizzato
PETSCII_CR      = 13            ; Carriage Return

; --- Layout a $C000 ---
OLD_IOPEN_LO    = $C000         ; Byte LO del vecchio vettore IOPEN salvato
OLD_IOPEN_HI    = $C001         ; Byte HI del vecchio vettore IOPEN salvato
OLD_ILOAD_LO    = $C002         ; Byte LO del vecchio vettore ILOAD salvato
OLD_ILOAD_HI    = $C003         ; Byte HI del vecchio vettore ILOAD salvato
OLD_ISAVE_LO    = $C004         ; Byte LO del vecchio vettore ISAVE salvato
OLD_ISAVE_HI    = $C005         ; Byte HI del vecchio vettore ISAVE salvato

HOOK_IOPEN      = $C006         ; Indirizzo entry point IOPEN (JMP mdp_open_hook)
HOOK_ILOAD      = $C009         ; Indirizzo entry point ILOAD (JMP mdp_load_hook)
HOOK_ISAVE      = $C00C         ; Indirizzo entry point ISAVE (JMP mdp_save_hook)

; =============================================================================
; BASIC stub: 10 SYS <indirizzo_installer>
; =============================================================================
* = $0801

        .word   (+), 10
        .null   $9e, format("%d", installer)
+       .word   0

; =============================================================================
; INSTALLER
; =============================================================================
installer

        ; Stampa messaggio di inizio caricamento
        ldx     #<init_loading_msg
        ldy     #>init_loading_msg
        jsr     print_msg

        ; --- 0. Carica mdp-hook.prg in memoria ---
        ; Configurazione LFS: A=numero file (1), X=device ($BA), Y=secondary address (1 = Load Assoluto)
        lda     #1
        ldx     LAST_DEV
        bne     valid_dev
        ldx     #8              ; Fallback a 8 se per caso $BA = 0
valid_dev
        ldy     #1
        jsr     SETLFS

        ; Configurazione Nome: mdp-hook
        lda     #8              ; Lunghezza nome "mdp-hook"
        ldx     #<hook_name
        ldy     #>hook_name
        jsr     SETNAM

        ; Esecuzione LOAD
        lda     #0              ; A=0 significa LOAD (A=1 per VERIFY)
        jsr     LOAD
        bcs     load_error      ; Se il Carry è impostato, c'è stato un errore (file non trovato)

        ; --- 1. Salva il vecchio vettore IOPEN ($031A/$031B) in $C000/$C001 ---
        lda     IOPEN_VEC
        sta     OLD_IOPEN_LO
        lda     IOPEN_VEC + 1
        sta     OLD_IOPEN_HI

        ; --- 2. Salva il vecchio vettore ILOAD ($0330/$0331) in $C002/$C003 ---
        lda     ILOAD_VEC
        sta     OLD_ILOAD_LO
        lda     ILOAD_VEC + 1
        sta     OLD_ILOAD_HI

        ; --- 3. Salva il vecchio vettore ISAVE ($0332/$0333) in $C004/$C005 ---
        lda     ISAVE_VEC
        sta     OLD_ISAVE_LO
        lda     ISAVE_VEC + 1
        sta     OLD_ISAVE_HI

        ; --- 4. Installa il nuovo vettore IOPEN: punta a HOOK_IOPEN ($C006) ---
        lda     #<HOOK_IOPEN
        sta     IOPEN_VEC
        lda     #>HOOK_IOPEN
        sta     IOPEN_VEC + 1

        ; --- 5. Installa il nuovo vettore ILOAD: punta a HOOK_ILOAD ($C009) ---
        lda     #<HOOK_ILOAD
        sta     ILOAD_VEC
        lda     #>HOOK_ILOAD
        sta     ILOAD_VEC + 1

        ; --- 6. Installa il nuovo vettore ISAVE: punta a HOOK_ISAVE ($C00C) ---
        lda     #<HOOK_ISAVE
        sta     ISAVE_VEC
        lda     #>HOOK_ISAVE
        sta     ISAVE_VEC + 1

        ; Stampa messaggio di sistema pronto
        ldx     #<init_ready_msg
        ldy     #>init_ready_msg
        jsr     print_msg

        ; --- 7. Ritorna al BASIC ---
        rts

load_error
        ; Errore durante il caricamento (es. file non trovato)
        ; Stampa messaggio errore e interrompe l'installazione
        ldx     #<init_err_msg
        ldy     #>init_err_msg
        jsr     print_msg
        rts

; =============================================================================
; Routine di supporto
; =============================================================================
; PRINT_MSG
; Stampa una stringa NUL-terminata a video tramite CHROUT
; Input: X = LSB puntatore, Y = MSB puntatore
; Usa "Self-Modifying Code" per evitare l'uso della Zero Page (100% safe)
print_msg
        stx     pm_loop + 1
        sty     pm_loop + 2
        ldx     #0
pm_loop
        lda     $FFFF, x            ; L'indirizzo $FFFF viene sovrascritto a runtime!
        beq     pm_done
        jsr     CHROUT
        inx
        bne     pm_loop
pm_done
        rts

; =============================================================================
; Dati
; =============================================================================
hook_name
        .text   "mdp-hook"

; =============================================================================
; Supporto Multi-Lingua (Incluso a fine file per allocazione corretta dei dati)
; =============================================================================
ENG = 0
ITA = 1

.weak
LANG = ENG
.endweak

.if LANG == ENG
    .include "ENG.inc"
.elsif LANG == ITA
    .include "ITA.inc"
.else
    .error "Lingua non valida! Usa -D LANG=ENG o -D LANG=ITA"
.endif
