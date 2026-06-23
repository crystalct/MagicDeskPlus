; =============================================================================
; mdp-hook.asm — IOPEN, ILOAD & ISAVE Hooks + Format/Save/Load for MagicDesk Plus
; Compilatore: 64tass (con flag -a per conversione ASCII→PETSCII)
; Target: Commodore 64
; Caricamento: $C006  (LOAD "mdp-hook.prg",8,1)
;
; Deve essere caricato PRIMA di eseguire mdp-init.prg.
;
; Layout $C000:
;   $C000 = LO vecchio vettore IOPEN (scritto da mdp_init)
;   $C001 = HI vecchio vettore IOPEN (scritto da mdp_init)
;   $C002 = LO vecchio vettore ILOAD (scritto da mdp_init)
;   $C003 = HI vecchio vettore ILOAD (scritto da mdp_init)
;   $C004 = LO vecchio vettore ISAVE (scritto da mdp_init)
;   $C005 = HI vecchio vettore ISAVE (scritto da mdp_init)
;   $C006 = JMP mdp_open_hook (Punto d'ingresso IOPEN)
;   $C009 = JMP mdp_load_hook (Punto d'ingresso ILOAD)
;   $C00C = JMP mdp_save_hook (Punto d'ingresso ISAVE)
; =============================================================================

; --- Costanti KERNAL ---
CHROUT          = $FFD2

; --- Costanti Zero Page KERNAL ---
STATUS          = $90           ; Stato I/O KERNAL
MEMUSS          = $C3           ; Indirizzo fine caricamento / fine memoria (puntatore temporaneo)
SA              = $B9           ; Secondary Address
FA              = $BA           ; Device number
FNLEN           = $B7           ; Filename length
FNADR_LO        = $BB           ; Filename pointer LO
FNADR_HI        = $BC           ; Filename pointer HI
VERIFY_FLAG     = $BF           ; 0=LOAD, 1=VERIFY (settato all'ingresso di mdp_load_hook)
ZP_SAVE_START_LO= $2B           ; $2B/$2C puntatore iniziale del range da salvare
ZP_SAVE_START_HI= $2C
ZP_SAVE_END_LO  = $2D           ; $2D/$2E puntatore finale del range da salvare
ZP_SAVE_END_HI  = $2E

; --- CF page scratch ---
ZP_PTR          = $FB           ; $FB/$FC pointer temporaneo (2 byte)
MDP_CTRL_SHADOW = $FD           ; Shadow di $DE03 (write-only)
LOOP_PAGE       = $FE           ; Contatore pagina corrente nel ciclo azzeramento
SAVE_START_LO   = $CFF5           ; Indirizzo temporaneo per salvare il range da salvare
SAVE_START_HI   = $CFF6           
SAVE_END_LO     = $F7          
SAVE_END_HI     = $F8          
DIR_FREE_ENTRY  = $F9           ; Usato per tenere traccia dell'indice entry della directory (0-7)
ALLOC_PORTION   = $FA           ; Portion allocata correntemente
ALLOC_PAGE      = $CF52           ; Pagina allocata correntemente
TEMP_REG        = $CF2A           ; Registro temporaneo
BYTE_COUNT      = $CF92           ; Conteggio byte nel blocco dati corrente (0-253)
BLOCK_COUNT_LO  = $CF96           ; Contatore blocchi totale
BLOCK_COUNT_HI  = $CF97           
PREV_PORTION    = $CF9B           ; Portion del blocco precedente per pointer linking
PREV_PAGE       = $CF9C           ; Pagina del blocco precedente per pointer linking
DIR_CUR_ENTRY   = $CFA6           ; Entry directory corrente per il ciclo LOAD"$"
FREE_BLOCKS_LO  = $CFB0           ; Blocchi liberi totali da stampare
FREE_BLOCKS_HI  = $CFB1
BAM_BIT_IDX     = $CF23           ; Indice bit trovato nella BAM (0-7)
FIRST_BLK_PORTION = $CF9D        ; Portion primo blocco allocato (per rollback Bug #2)
FIRST_BLK_PAGE    = $CF9E        ; Pagina primo blocco allocato (per rollback Bug #2)
BAM_BYTE_IDX    = $CF24           ; Indice byte BAM (0-63)
DIR_ENTRY_OFF   = $CF22           ; Offset entry nella Directory (entry_base + 16)           

; --- Vettori vecchi handler ---
OLD_IOPEN_LO    = $C000
OLD_ILOAD_LO    = $C002
OLD_ISAVE_LO    = $C004

; --- Registri hardware MagicDesk Plus ---
PAGE_REG        = $DE01         ; Seleziona pagina SRAM (0-255)
CTRL_REG        = $DE03         ; Controllo SRAM/EEPROM (write-only, uso shadow)

; --- Finestra di I/O SRAM ---
IO_WIN          = $DF00         ; Finestra 256 byte della pagina attiva

; --- Bit mask per CTRL_REG ---
CTRL_SRAM_EN    = %00100000     ; Bit 5: 1 = SRAM abilitata
CTRL_PORTION1   = %00000001     ; Bit 0: 1 = Portion 1 (seconda 64KB)
CTRL_P0         = CTRL_SRAM_EN                  ; Portion 0: $20
CTRL_P1         = CTRL_SRAM_EN | CTRL_PORTION1  ; Portion 1: $21

; --- Costanti filesystem MDP-FS ---
SIG_BYTE0       = $CA           ; Signature byte 0
SIG_BYTE1       = $F1           ; Signature byte 1
SIG_PAGE        = 255           ; Portion 1, Pagina 255
SIG_OFFSET0     = $FE           ; Offset signature byte 0
SIG_OFFSET1     = $FF           ; Offset signature byte 1

; --- Codici PETSCII ---
PETSCII_N       = $4E
PETSCII_E       = $45
PETSCII_W       = $57
PETSCII_COLON   = $3A
PETSCII_CR      = $0D
PETSCII_DOLLAR  = $24           ; '$'
PETSCII_SPACE   = $20           ; ' '
PETSCII_QUOTE   = $22           ; '"'
PETSCII_P       = $50           ; 'P'
PETSCII_R       = $52           ; 'R'
PETSCII_G       = $47           ; 'G'

; =============================================================================
; Indirizzo di assemblaggio fisso (a partire da $C006)
; =============================================================================
* = $C006

; =============================================================================
; Vettori di salto degli entry point
; =============================================================================
        jmp     mdp_open_hook       ; $C006-$C008 (Vettore installato a $C006)
        jmp     mdp_load_hook       ; $C009-$C00B (Vettore installato a $C009)
        jmp     mdp_save_hook       ; $C00C-$C00E (Vettore installato a $C00C)

; =============================================================================
; IOPEN HOOK
; =============================================================================
mdp_open_hook

        ; --- Verifica device number ($BA) == 7 ---
        lda     FA
        cmp     #7
        bne     open_pass

        ; --- Verifica secondary address ($B9) == 15 ---
        lda     SA
        cmp     #15
        bne     open_pass

        ; --- Carica puntatore filename in ZP_PTR ---
        lda     FNADR_LO
        sta     ZP_PTR
        lda     FNADR_HI
        sta     ZP_PTR + 1

        ; --- Controlla primo carattere: 'N' o 'V' ---
        ldy     #0
        lda     (ZP_PTR), y
        cmp     #PETSCII_N
        beq     check_n
        cmp     #$56                ; PETSCII_V ('V')
        beq     check_v
        bne     open_pass

check_n
        ; --- Controlla secondo carattere ---
        iny
        lda     (ZP_PTR), y
        cmp     #PETSCII_COLON      ; "N:" trovato
        beq     open_format

        ; --- Verifica "NEW:" ---
        cmp     #PETSCII_E
        bne     open_pass
        iny
        lda     (ZP_PTR), y
        cmp     #PETSCII_W
        bne     open_pass
        iny
        lda     (ZP_PTR), y
        cmp     #PETSCII_COLON
        bne     open_pass
        beq     open_format         ; "NEW:" trovato

check_v
        iny
        lda     (ZP_PTR), y
        cmp     #PETSCII_COLON      ; "V:"
        beq     open_validate
        cmp     #$30                ; "0"
        bne     open_pass
        iny
        lda     (ZP_PTR), y
        cmp     #PETSCII_COLON      ; "V0:"
        bne     open_pass

open_validate
        jsr     mdp_validate
        clc
        rts

open_format
        jsr     mdp_format
        clc
        rts

open_pass
        jmp     (OLD_IOPEN_LO)      ; Passa al vecchio handler IOPEN

; =============================================================================
; ILOAD HOOK — Intercetta caricamento
; =============================================================================
mdp_load_hook

        ; --- Preserva A: 0=LOAD, 1=VERIFY ---
        pha
        sta     VERIFY_FLAG         ; salva il flag load/verify per uso futuro

        ; --- Verifica device number ($BA) == 7 ---
        lda     FA
        cmp     #7
        bne     load_pass

        ; --- Controlla se abbiamo un filename ---
        lda     FNLEN
        beq     load_pass           ; se lunghezza è 0, passa oltre

        ; --- Carica puntatore filename in ZP_PTR ---
        lda     FNADR_LO
        sta     ZP_PTR
        lda     FNADR_HI
        sta     ZP_PTR + 1

        ; --- Controlla se il primo carattere è '$' ---
        ldy     #0
        lda     (ZP_PTR), y
        cmp     #PETSCII_DOLLAR     ; '$'
        beq     load_is_dir         ; directory listing

        ; --- File normale: LOAD o VERIFY da SRAM ---
        pla                         ; pulisci stack (VERIFY_FLAG è già salvato)
        jmp     mdp_load_file       ; gestisce sia LOAD (A=0) che VERIFY (A=1)

load_is_dir
        pla                         ; Ripristina A prima della directory
        jmp     mdp_load_directory

load_pass
        pla                         ; Ripristina A originale prima del vecchio handler
        jmp     (OLD_ILOAD_LO)      ; Passa al vecchio handler ILOAD

; =============================================================================
; ISAVE HOOK — Intercetta salvataggio
; =============================================================================
mdp_save_hook

        ; --- Verifica device number ($BA) == 7 ---
        lda     FA
        cmp     #7
        bne     save_pass

        ; --- Controlla se abbiamo un filename ---
        lda     FNLEN
        beq     save_pass

        ; --- Salva i registri X e Y passati con il range di memoria finale ---
        stx     SAVE_END_LO
        sty     SAVE_END_HI
        
        ; --- Leggi l'indirizzo iniziale da ZP $2B/$2C ---
        lda     ZP_SAVE_START_LO
        sta     SAVE_START_LO
        lda     ZP_SAVE_START_HI
        sta     SAVE_START_HI

        ; Eseguiamo il vero salvataggio su SRAM
        jsr     mdp_save_file
        bcs     save_error
        
        ; Ritorno con successo al KERNAL
        lda     #0
        sta     STATUS
        clc
        rts

save_pass
        jmp     (OLD_ISAVE_LO)      ; Passa al vecchio handler ISAVE

save_error
        sta     STATUS              ; Salva codice errore in STATUS
        sec
        rts

; =============================================================================
; MDP_SAVE_FILE — Salva un file reale nella SRAM (MDP-FS)
; =============================================================================
mdp_save_file

        ; --- 1. Cerca uno slot directory libero ---
        ; Abilita Portion 0, Pagina 0 (Directory)
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        
        lda     #0
        sta     PAGE_REG
        
        ; Scansiona le 8 entry (ciascuna 32 byte)
        lda     #0
        sta     DIR_FREE_ENTRY
        
find_free_slot
        lda     DIR_FREE_ENTRY
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a               ; A = DIR_FREE_ENTRY * 32
        tax
        
        ; Leggi il byte di flag di stato (offset 20 della entry)
        lda     IO_WIN + 20, x
        beq     found_slot      ; Se è 0 (libero)
        cmp     #$80            ; Se è $80 (eliminato)
        beq     found_slot
        
        inc     DIR_FREE_ENTRY
        lda     DIR_FREE_ENTRY
        cmp     #8
        bne     find_free_slot
        
        ; Se siamo qui, la directory è piena!
        lda     #9                  ; Codice errore (Directory piena / Disk full)
        sec
        rts

found_slot
        ; --- 2. Copia il nome del file nella entry (riempito di spazi) ---
        ldy     #0
copy_name_loop
        cpy     FNLEN
        bcs     pad_zeros
        lda     (FNADR_LO), y
        sta     IO_WIN, x
        jmp     next_char
pad_zeros
        lda     #0              ; NUL terminator and padding
        sta     IO_WIN, x
next_char
        inx
        iny
        cpy     #16
        bne     copy_name_loop
        
        stx     DIR_ENTRY_OFF       ; Salva offset entry (= entry_base + 16)

        ; --- 3. Trova e alloca il blocco iniziale tramite la BAM ---
        lda     #CTRL_P0
        sta     CTRL_REG
        
        lda     #1
        sta     PAGE_REG            ; BAM
        
        ldy     #0
scan_bam_p0
        lda     IO_WIN, y
        cmp     #$00                ; Standard Commodore: $00 = tutti occupati, salta
        beq     next_bam_p0_byte
        
        ldx     #0
bit_search_p0
        lsr     a
        bcs     found_p0_block      ; Carry set = bit era 1 = blocco LIBERO
        inx
        cpx     #8
        bne     bit_search_p0
        
next_bam_p0_byte
        iny
        cpy     #64                 ; Scansiona tutti i 64 byte della BAM (Portion 0 e Portion 1)
        bne     scan_bam_p0
        
        ; Se siamo qui, la BAM è piena!
        lda     #9                  ; Codice errore (Disk full)
        sec
        rts

found_p0_block
        ; Salviamo indice bit e byte BAM in variabili dedicate
        stx     BAM_BIT_IDX         ; indice bit (0-7)
        sty     BAM_BYTE_IDX        ; indice byte BAM (0-63)
        
        ; Calcolo della pagina locale all'interno della Portion (0-255):
        ; Pagina = (Y mod 32) * 8 + X.
        tya
        cmp     #32
        bcc     calc_p0_page
        sec                         ; Esplicita il Carry per SBC (Bug #4: CMP lo setta già, ma rendiamo l'intento ovvio)
        sbc     #32                 ; A = Y - 32
calc_p0_page
        asl     a
        asl     a
        asl     a                   ; A = (Y mod 32) * 8
        clc
        adc     BAM_BIT_IDX         ; A = (Y mod 32) * 8 + X (Pagina 0-255)
        sta     ALLOC_PAGE
        
        ; Determina ALLOC_PORTION in base a Y
        lda     BAM_BYTE_IDX        ; A = Y
        cmp     #32
        bcc     set_alloc_p0
        lda     #1
        sta     ALLOC_PORTION       ; Y >= 32 -> Portion 1
        jmp     update_bam_p0
set_alloc_p0
        lda     #0
        sta     ALLOC_PORTION       ; Y < 32 -> Portion 0

update_bam_p0
        ; Bug #2: Salva il primo blocco allocato per il rollback in caso di Disk Full
        lda     ALLOC_PORTION
        sta     FIRST_BLK_PORTION
        lda     ALLOC_PAGE
        sta     FIRST_BLK_PAGE
        
        ; Bug #3: Ri-seleziona esplicitamente la BAM prima di modificarla
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        lda     #1
        sta     PAGE_REG            ; BAM = Portion 0, Pagina 1
        
        ldy     BAM_BYTE_IDX        ; Ripristina Y
        ldx     BAM_BIT_IDX         ; Ripristina X
        
        lda     IO_WIN, y
        and     inv_bit_mask, x     ; Standard Commodore: clear bit = blocco OCCUPATO
        sta     IO_WIN, y           ; salva byte BAM
        
        ; --- 4. Salva il blocco iniziale nella Directory entry ---
        lda     #0
        sta     PAGE_REG            ; Directory (Portion 0, Pagina 0)
        
        ldx     DIR_ENTRY_OFF       ; X = entry_base + 16
        lda     ALLOC_PORTION
        sta     IO_WIN, x           ; offset 16: Portion
        inx
        lda     ALLOC_PAGE
        sta     IO_WIN, x           ; offset 17: Pagina
        
        inx
        lda     #0
        sta     IO_WIN, x           ; offset 18: blocchi LO
        inx
        sta     IO_WIN, x           ; offset 19: blocchi HI
        
        inx
        lda     #$01                ; Stato = Attivo/Chiuso (MDP-FS standard)
        sta     IO_WIN, x           ; offset 20: Stato = Attivo
        inx
        lda     SAVE_START_LO
        sta     IO_WIN, x           ; offset 21: Indirizzo di caricamento LO
        inx
        lda     SAVE_START_HI
        sta     IO_WIN, x           ; offset 22: Indirizzo di caricamento HI

        ; --- 5. Ciclo di scrittura dei byte del file sulla SRAM ---
        lda     #0
        sta     BLOCK_COUNT_LO
        sta     BLOCK_COUNT_HI
        
        lda     SAVE_START_LO
        sta     ZP_PTR
        lda     SAVE_START_HI
        sta     ZP_PTR + 1
        
        lda     #0
        sta     BYTE_COUNT

write_data_loop
        lda     ZP_PTR
        cmp     SAVE_END_LO
        bne     continue_write
        lda     ZP_PTR + 1
        cmp     SAVE_END_HI
        bne     continue_write
        jmp     write_eof           ; Raggiunta la fine!

continue_write
        lda     ALLOC_PORTION
        beq     select_p0
        lda     #CTRL_P1
        jmp     set_ctrl
select_p0
        lda     #CTRL_P0
set_ctrl
        sta     MDP_CTRL_SHADOW     ; Bug #1: aggiorna shadow PRIMA di scrivere CTRL_REG (Spec. §5)
        sta     CTRL_REG
        lda     ALLOC_PAGE
        sta     PAGE_REG
        
        ldy     #0
        lda     (ZP_PTR), y
        ldy     BYTE_COUNT
        sta     IO_WIN, y
        
        inc     ZP_PTR
        bne     inc_byte_count
        inc     ZP_PTR + 1

inc_byte_count
        inc     BYTE_COUNT
        
        ; Controlla se abbiamo raggiunto la fine del file per evitare di allocare un blocco vuoto superfluo
        lda     ZP_PTR
        cmp     SAVE_END_LO
        bne     check_block_full
        lda     ZP_PTR + 1
        cmp     SAVE_END_HI
        bne     check_block_full
        jmp     write_eof           ; Raggiunta la fine!
        
check_block_full
        lda     BYTE_COUNT
        cmp     #254
        bne     write_data_loop
        
        lda     ALLOC_PORTION
        sta     PREV_PORTION
        lda     ALLOC_PAGE
        sta     PREV_PAGE
        
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW     ; Bug #1: aggiorna shadow PRIMA di CTRL_REG (Spec. §5)
        sta     CTRL_REG
        lda     #1
        sta     PAGE_REG            ; BAM
        
        ldy     #0
scan_bam_next
        lda     IO_WIN, y
        cmp     #$00                ; Standard Commodore: $00 = tutti occupati, salta
        beq     next_bam_next_byte
        
        ldx     #0
bit_search_next
        lsr     a
        bcs     found_next_block    ; Carry set = bit era 1 = blocco LIBERO
        inx
        cpx     #8
        bne     bit_search_next
        
next_bam_next_byte
        iny
        cpy     #64                 ; Scansiona tutti i 64 byte della BAM (Portion 0 e Portion 1)
        bne     scan_bam_next
        
        ; Bug #2: BAM piena — rollback blocchi già allocati prima di uscire
        jsr     mdp_rollback        ; Libera i blocchi nella BAM e invalida la directory entry
        lda     #9                  ; Codice errore (Disk full)
        sec
        rts

found_next_block
        ; Salviamo indice bit e byte BAM in variabili dedicate (NON clobbera ZP_PTR!)
        stx     BAM_BIT_IDX         ; indice bit (0-7)
        sty     BAM_BYTE_IDX        ; indice byte BAM (0-63)
        
        ; Calcolo della pagina locale all'interno della Portion (0-255):
        ; Pagina = (Y mod 32) * 8 + X.
        tya
        cmp     #32
        bcc     calc_next_page
        sec                         ; Esplicita il Carry per SBC (Bug #4)
        sbc     #32                 ; A = Y - 32
calc_next_page
        asl     a
        asl     a
        asl     a                   ; A = (Y mod 32) * 8
        clc
        adc     BAM_BIT_IDX         ; A = (Y mod 32) * 8 + X (Pagina 0-255)
        sta     ALLOC_PAGE
        
        ; Determina ALLOC_PORTION in base a Y
        lda     BAM_BYTE_IDX        ; A = Y
        cmp     #32
        bcc     set_next_p0
        lda     #1
        sta     ALLOC_PORTION       ; Y >= 32 -> Portion 1
        jmp     update_bam_next
set_next_p0
        lda     #0
        sta     ALLOC_PORTION       ; Y < 32 -> Portion 0

update_bam_next
        ; Bug #3: Ri-seleziona esplicitamente la BAM prima di modificarla
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        lda     #1
        sta     PAGE_REG            ; BAM = Portion 0, Pagina 1
        
        ldy     BAM_BYTE_IDX        ; Ripristina Y
        ldx     BAM_BIT_IDX         ; Ripristina X
        
        lda     IO_WIN, y
        and     inv_bit_mask, x     ; Standard Commodore: clear bit = blocco OCCUPATO
        sta     IO_WIN, y           ; salva byte BAM
        
        lda     PREV_PORTION
        beq     sel_prev_p0
        lda     #CTRL_P1
        jmp     set_prev_ctrl
sel_prev_p0
        lda     #CTRL_P0
set_prev_ctrl
        sta     MDP_CTRL_SHADOW     ; Bug #1: aggiorna shadow PRIMA di CTRL_REG (Spec. §5)
        sta     CTRL_REG
        lda     PREV_PAGE
        sta     PAGE_REG
        
        lda     ALLOC_PORTION
        sta     IO_WIN + 254
        lda     ALLOC_PAGE
        sta     IO_WIN + 255
        
        inc     BLOCK_COUNT_LO
        bne     reset_byte_count
        inc     BLOCK_COUNT_HI

reset_byte_count
        lda     #0
        sta     BYTE_COUNT
        jmp     write_data_loop

write_eof
        lda     ALLOC_PORTION
        beq     sel_last_p0
        lda     #CTRL_P1
        jmp     set_last_ctrl
sel_last_p0
        lda     #CTRL_P0
set_last_ctrl
        sta     MDP_CTRL_SHADOW     ; Bug #1: aggiorna shadow PRIMA di CTRL_REG (Spec. §5)
        sta     CTRL_REG
        lda     ALLOC_PAGE
        sta     PAGE_REG
        
        lda     #$FF
        sta     IO_WIN + 254
        lda     BYTE_COUNT
        sta     IO_WIN + 255
        
        inc     BLOCK_COUNT_LO
        bne     update_dir_blocks
        inc     BLOCK_COUNT_HI

update_dir_blocks
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW     ; Bug #1: aggiorna shadow PRIMA di CTRL_REG (Spec. §5)
        sta     CTRL_REG
        lda     #0
        sta     PAGE_REG            ; Directory (Portion 0, Pagina 0)
        
        lda     DIR_FREE_ENTRY
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        clc
        adc     #18
        tax
        
        lda     BLOCK_COUNT_LO
        sta     IO_WIN, x
        inx
        lda     BLOCK_COUNT_HI
        sta     IO_WIN, x
        clc
        rts

bit_mask
        .byte   %00000001
        .byte   %00000010
        .byte   %00000100
        .byte   %00001000
        .byte   %00010000
        .byte   %00100000
        .byte   %01000000
        .byte   %10000000

inv_bit_mask                        ; Maschera inversa: AND per liberare un bit (standard Commodore)
        .byte   %11111110
        .byte   %11111101
        .byte   %11111011
        .byte   %11110111
        .byte   %11101111
        .byte   %11011111
        .byte   %10111111
        .byte   %01111111

; =============================================================================
; MDP_ROLLBACK — Annulla un salvataggio parziale (Disk Full):
;   libera nella BAM tutti i blocchi già allocati e invalida la directory entry.
; Precondizioni: FIRST_BLK_PORTION/PAGE, PREV_PORTION/PAGE, BLOCK_COUNT_LO validi
; =============================================================================
mdp_rollback

        ; 1. Invalida la directory entry: status → 0 (libero)
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        lda     #0
        sta     PAGE_REG

        lda     DIR_FREE_ENTRY
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        clc
        adc     #20
        tax
        lda     #0
        sta     IO_WIN, x           ; offset 20: Stato = 0 (entry libera)

        ; 2. Se nessun blocco è stato ancora linkato → libera solo PREV (= primo blocco)
        lda     BLOCK_COUNT_LO
        bne     rb_walk_chain

        lda     PREV_PORTION
        sta     ALLOC_PORTION
        lda     PREV_PAGE
        sta     ALLOC_PAGE
        jsr     mdp_free_block
        rts

        ; 3. Walk della catena: BLOCK_COUNT_LO blocchi hanno il link già scritto
rb_walk_chain
        lda     FIRST_BLK_PORTION
        sta     ALLOC_PORTION
        lda     FIRST_BLK_PAGE
        sta     ALLOC_PAGE

rb_walk_loop
        ; Seleziona il blocco corrente per leggere il link (byte 254/255)
        lda     ALLOC_PORTION
        beq     rb_sel_p0
        lda     #CTRL_P1
        jmp     rb_set_ctrl
rb_sel_p0
        lda     #CTRL_P0
rb_set_ctrl
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        lda     ALLOC_PAGE
        sta     PAGE_REG

        ; Salva link al blocco successivo prima di liberare il corrente
        lda     IO_WIN + 254
        sta     TEMP_REG            ; next Portion
        lda     IO_WIN + 255
        pha                         ; push next Page

        jsr     mdp_free_block      ; Libera blocco corrente nella BAM

        lda     TEMP_REG
        sta     ALLOC_PORTION
        pla
        sta     ALLOC_PAGE

        dec     BLOCK_COUNT_LO
        bne     rb_walk_loop

        ; 4. Libera PREV (ultimo blocco della catena, link non ancora scritto)
        lda     PREV_PORTION
        sta     ALLOC_PORTION
        lda     PREV_PAGE
        sta     ALLOC_PAGE
        jsr     mdp_free_block
        rts

; =============================================================================
; MDP_FREE_BLOCK — Segna ALLOC_PORTION/ALLOC_PAGE come libero nella BAM
;   Convenzione MDP-FS/Commodore: bit 1 = libero, bit 0 = occupato
; =============================================================================
mdp_free_block

        ; BAM_BYTE = (ALLOC_PORTION * 32) + (ALLOC_PAGE / 8)
        ; BAM_BIT  = ALLOC_PAGE mod 8
        lda     ALLOC_PAGE
        and     #%00000111
        sta     TEMP_REG            ; bit index (0-7)

        lda     ALLOC_PAGE
        lsr     a
        lsr     a
        lsr     a                   ; A = ALLOC_PAGE / 8

        ldy     ALLOC_PORTION
        beq     fb_p0
        clc
        adc     #32                 ; Portion 1 → offset BAM + 32
fb_p0
        tay                         ; Y = BAM byte index (0-63)
        ldx     TEMP_REG            ; X = bit index (0-7)

        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        lda     #1
        sta     PAGE_REG            ; BAM

        lda     IO_WIN, y
        ora     bit_mask, x         ; bit = 1 → LIBERO (convenzione Commodore)
        sta     IO_WIN, y
        rts

; =============================================================================
; MDP_LOAD_DIRECTORY — Carica la directory reale leggendo la SRAM Portion 0 Pag 0
; Genera dinamicamente le righe BASIC in RAM per ogni entry del file attivo.
; =============================================================================
mdp_load_directory
        ; Prepariamo l'indirizzo di destinazione per il caricamento.
        lda     SA
        beq     use_basic_start
        
        ; Usa X/Y passati
        stx     ZP_PTR
        sty     ZP_PTR + 1
        jmp     start_gen

use_basic_start
        lda     #$01
        sta     ZP_PTR
        lda     #$08
        sta     ZP_PTR + 1

start_gen
        ; 1. Indirizzo di caricamento (Little Endian):
        ldy     #0
        lda     ZP_PTR
        sta     MEMUSS
        lda     ZP_PTR + 1
        sta     MEMUSS + 1          ; MEMUSS punta ora all'inizio effettivo della scrittura RAM
        
        ; --- RIGA 0 (Intestazione: 0 "MAGICDESK RAM    " 2A 2A) ---
        lda     #0
        sta     (MEMUSS), y         ; Next line LO (placeholder)
        iny
        sta     (MEMUSS), y         ; Next line HI (placeholder)
        iny
        
        ; Numero linea: 0 ($0000)
        lda     #0
        sta     (MEMUSS), y
        iny
        sta     (MEMUSS), y
        iny
        
        ; Token o Testo: Reverse On ($12) per l'intestazione
        lda     #$12                ; Reverse ON
        sta     (MEMUSS), y
        iny
        
        ; Scrive "MAGICDESK RAM"
        ldx     #0
dir_header_loop
        lda     header_text, x
        beq     dir_header_end
        sta     (MEMUSS), y
        iny
        inx
        jmp     dir_header_loop

dir_header_end
        ; Scrive " 2A 2A" cioè " * "
        lda     #$20                ; spazio
        sta     (MEMUSS), y
        iny
        lda     #$2A                ; '*'
        sta     (MEMUSS), y
        iny
        lda     #$2A                ; '*'
        sta     (MEMUSS), y
        iny
        
        ; Fine riga 0
        lda     #0
        sta     (MEMUSS), y
        iny
        
        ; Next Line Pointer della Riga 0.
        ; Salviamo MEMUSS in ZP_PTR temporaneamente per calcolare la fine
        lda     MEMUSS
        sta     ZP_PTR
        lda     MEMUSS + 1
        sta     ZP_PTR + 1
        
        ; Calcola ZP_PTR = MEMUSS + Y (inizio riga successiva)
        tya
        clc
        adc     MEMUSS
        sta     ZP_PTR
        lda     #0
        adc     MEMUSS + 1
        sta     ZP_PTR + 1
        
        ; Scrive il puntatore calcolato all'inizio della Riga 0
        ldy     #0
        lda     ZP_PTR
        sta     (MEMUSS), y         ; Next line LO
        iny
        lda     ZP_PTR + 1
        sta     (MEMUSS), y         ; Next line HI CORRETTO!
        
        ; ZP_PTR ora punta all'inizio delle righe dei file
        
        ; --- SCANSIONE E GENERAZIONE RIGHE DEI FILE REALI ---
        ; Dobbiamo abilitare Portion 0, Pagina 0 per leggere i file salvati.
        ; Tuttavia, per scrivere nella RAM del C64, useremo l'indirizzamento (ZP_PTR),y
        ; perciò possiamo abilitare Portion 0 e leggere la SRAM, scrivendo poi in RAM.
        ; Prepariamo il contatore di entry (0-7)
        lda     #0
        sta     DIR_CUR_ENTRY
        
dir_entry_loop
        ; Abilita SRAM Portion 0, Pagina 0
        lda     #CTRL_P0
        sta     CTRL_REG
        lda     #0
        sta     PAGE_REG
        
        ; Calcola l'offset della entry corrente in SRAM: DIR_CUR_ENTRY * 32
        lda     DIR_CUR_ENTRY
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        tax                         ; X = offset entry in SRAM (IO_WIN)
        
        ; Verifica se la entry è attiva (Stato == $01)
        lda     IO_WIN + 20, x
        cmp     #1
        beq     generate_file_line  ; Se attiva, genera la riga BASIC per questo file
        jmp     next_entry_check

generate_file_line
        ; Recuperiamo il numero di blocchi (Word little-endian all'offset 18)
        ; e usiamolo come "Line Number" della riga BASIC.
        lda     IO_WIN + 18, x      ; Blocchi LO
        sta     TEMP_REG            ; Salviamo temporaneamente
        lda     IO_WIN + 19, x      ; Blocchi HI
        sta     BLOCK_COUNT_HI      ; Salviamo
        
        ; Inizializziamo Y per scrivere la nuova riga BASIC in (ZP_PTR), y
        ldy     #0
        lda     #0
        sta     (ZP_PTR), y         ; Next line LO placeholder
        iny
        sta     (ZP_PTR), y         ; Next line HI placeholder
        iny
        
        ; Numero linea = Numero blocchi
        lda     TEMP_REG
        sta     (ZP_PTR), y         ; Line number LO
        iny
        lda     BLOCK_COUNT_HI
        sta     (ZP_PTR), y         ; Line number HI
        iny
        
        ; Spazio + virgolette prima del nome
        lda     #PETSCII_SPACE
        sta     (ZP_PTR), y
        iny
        lda     #PETSCII_QUOTE
        sta     (ZP_PTR), y
        iny
        
        ; Copiamo i 16 byte del nome del file dalla SRAM (offset X nella IO_WIN) alla RAM del C64
        ; Usiamo ZP_PTR per scrivere in RAM, quindi dobbiamo tenere traccia dell'offset SRAM.
        ; Salviamo l'offset SRAM in TEMP_REG.
        stx     TEMP_REG
        
        ldx     #0
copy_filename_to_ram
        ; Per accedere alla SRAM dobbiamo assicurarci che Portion 0 sia abilitata
        ; (lo è già, ma manteniamola attiva)
        ; Salviamo X della copia in SAVE_START_LO
        stx     SAVE_START_LO
        
        ; Calcola l'indirizzo effettivo del byte in SRAM
        txa
        clc
        adc     TEMP_REG
        tax
        lda     IO_WIN, x           ; Leggi carattere nome da SRAM
        beq     filename_copy_done  ; Se $00, abbiamo finito di copiare il nome
        
        ; Scrivi in RAM del C64
        sta     (ZP_PTR), y
        iny
        
        ; Ripristina X
        ldx     SAVE_START_LO
        inx
        cpx     #16
        bne     copy_filename_to_ram
        
filename_copy_done
        ; Ripristiniamo X all'offset originale per i calcoli successivi
        ldx     TEMP_REG
        
        ; Virgolette di chiusura + spazio + "PRG"
        lda     #PETSCII_QUOTE
        sta     (ZP_PTR), y
        iny
        lda     #PETSCII_SPACE
        sta     (ZP_PTR), y
        iny
        lda     #PETSCII_P
        sta     (ZP_PTR), y
        iny
        lda     #PETSCII_R
        sta     (ZP_PTR), y
        iny
        lda     #PETSCII_G
        sta     (ZP_PTR), y
        iny
        
        ; Fine riga (NUL)
        lda     #0
        sta     (ZP_PTR), y
        iny
        
        ; Aggiorniamo il "Next Line Pointer" di questa riga.
        ; Salviamo l'indirizzo della riga corrente (in ZP_PTR) in MEMUSS temporaneamente.
        lda     ZP_PTR
        sta     MEMUSS
        lda     ZP_PTR + 1
        sta     MEMUSS + 1
        
        ; Calcoliamo ZP_PTR = MEMUSS + Y (usa MEMUSS = vecchio ZP_PTR, evita auto-referenza)
        tya
        clc
        adc     MEMUSS
        sta     ZP_PTR
        lda     #0
        adc     MEMUSS + 1
        sta     ZP_PTR + 1
        
        ; Scrive il puntatore all'inizio della riga appena completata (MEMUSS)
        ldy     #0
        lda     ZP_PTR
        sta     (MEMUSS), y         ; Next line LO
        iny
        lda     ZP_PTR + 1
        sta     (MEMUSS), y         ; Next line HI CORRETTO!
        
        ; Riga successiva

next_entry_check
        inc     DIR_CUR_ENTRY
        lda     DIR_CUR_ENTRY
        cmp     #8
        beq     finish_dir_list     ; Se abbiamo scansionato tutte le 8 entry
        jmp     dir_entry_loop

finish_dir_list
        ; --- RIGA FINALE (Calcolo blocchi liberi e stampa "X BLOCKS FREE.") ---
        ; Dobbiamo contare quanti blocchi sono liberi nella BAM.
        ; Una BAM da 512 blocchi totali occuperebbe 64 byte.
        ; Per contare velocemente i blocchi liberi, partiamo da 512 e per ogni bit a 0 (occupato,
        ; conv. Commodore: 1=libero 0=occupato) nella BAM (64 byte di Portion 0, Pagina 1) decrementiamo il contatore. (Bug #5 fix)
        ; Abilitiamo la BAM
        lda     #CTRL_P0
        sta     CTRL_REG
        lda     #1
        sta     PAGE_REG            ; BAM
        
        ; Inizializziamo il contatore di blocchi liberi a 512 ($0200)
        lda     #0
        sta     FREE_BLOCKS_LO
        lda     #2
        sta     FREE_BLOCKS_HI      ; FREE_BLOCKS = 512
        
        ldy     #0                  ; Indice byte BAM (0-63)
scan_bam_free
        lda     IO_WIN, y
        cmp     #$FF
        beq     next_bam_free_byte  ; Se il byte è $FF, 8 blocchi liberi, nulla da decrementare
        
        ; Contiamo quanti bit sono a 0 (occupati) e decrementiamo FREE_BLOCKS per ciascuno
        ldx     #8
count_bits_loop
        lsr     a
        bcs     bit_is_free         ; Carry set = bit era 1 = LIBERO, non decrementare
        
        ; bit era 0 (OCCUPATO): decrementa FREE_BLOCKS preservando A
        sta     TEMP_REG
        lda     FREE_BLOCKS_LO
        bne     dec_lo_only
        dec     FREE_BLOCKS_HI
dec_lo_only
        dec     FREE_BLOCKS_LO
        lda     TEMP_REG
        
bit_is_free
        dex
        bne     count_bits_loop
        
next_bam_free_byte
        iny
        cpy     #64
        bne     scan_bam_free
        
        ; Ora generiamo l'ultima riga BASIC:
        ; [Next Line LO/HI] [Line Number LO/HI] [Testo: "X BLOCKS FREE."] [NUL]
        ldy     #0
        lda     #0
        sta     (ZP_PTR), y         ; Next line LO placeholder
        iny
        sta     (ZP_PTR), y         ; Next line HI placeholder
        iny
        
        ; Line number della riga = blocchi liberi
        lda     FREE_BLOCKS_LO
        sta     (ZP_PTR), y
        iny
        lda     FREE_BLOCKS_HI
        sta     (ZP_PTR), y
        iny
        
        ; Scrive "BLOCKS FREE."
        ldx     #0
dir_free_loop
        lda     free_text, x
        beq     dir_free_end
        sta     (ZP_PTR), y
        iny
        inx
        jmp     dir_free_loop

dir_free_end
        ; Fine riga dei blocchi liberi
        lda     #0
        sta     (ZP_PTR), y
        iny
        
        ; Aggiorniamo il "Next Line Pointer" per l'ultima riga.
        ; Salviamo l'indirizzo della riga corrente (in ZP_PTR) in MEMUSS.
        lda     ZP_PTR
        sta     MEMUSS
        lda     ZP_PTR + 1
        sta     MEMUSS + 1
        
        ; Calcoliamo ZP_PTR = MEMUSS + Y (usa MEMUSS = vecchio ZP_PTR, evita auto-referenza)
        tya
        clc
        adc     MEMUSS
        sta     ZP_PTR
        lda     #0
        adc     MEMUSS + 1
        sta     ZP_PTR + 1
        
        ; Scrive il puntatore all'inizio della riga dei blocchi liberi (MEMUSS)
        ldy     #0
        lda     ZP_PTR
        sta     (MEMUSS), y         ; Next line LO
        iny
        lda     ZP_PTR + 1
        sta     (MEMUSS), y         ; Next line HI CORRETTO!
        
        ; --- FINE PROGRAMMA BASIC ---
        ; Scriviamo i 2 byte NUL finali
        ldy     #0
        lda     #0
        sta     (ZP_PTR), y         ; Fine program LO = 0
        iny
        sta     (ZP_PTR), y         ; Fine program HI = 0
        iny
        
        ; Restituiamo in X/Y l'indirizzo finale di caricamento + 1.
        ; L'indirizzo finale è ZP_PTR + 2.
        tya
        clc
        adc     ZP_PTR
        tax                         ; X = LO fine caricamento + 1
        lda     #0
        adc     ZP_PTR + 1
        tay                         ; Y = HI fine caricamento + 1
        
        ; Successo
        lda     #0
        sta     STATUS
        clc
        rts

; =============================================================================
; Testi di supporto (PETSCII) - Multi-Language
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

; =============================================================================
; MDP_LOAD_FILE — Carica o verifica un file dalla SRAM nel C64
; VERIFY_FLAG ($9A): 0=LOAD, 1=VERIFY
; Precondizioni: FA=7, FNLEN>0, ZP_PTR=FNADR (punta al filename)
; Ritorno: X=end_addr_LO, Y=end_addr_HI, A=0, CLC (errore: SEC)
; =============================================================================
mdp_load_file

        ; 1. Abilita SRAM Portion 0, Pagina 0 (Directory)
        lda     #CTRL_P0
        sta     CTRL_REG
        lda     #0
        sta     PAGE_REG

        ; 2. Cerca il file nella directory (8 entry × 32 byte)
        lda     #0
        sta     DIR_CUR_ENTRY

lf_find_loop
        lda     DIR_CUR_ENTRY
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a               ; A = DIR_CUR_ENTRY * 32
        tax                     ; X = offset entry in IO_WIN

        ; Controlla stato entry (byte offset 20)
        lda     IO_WIN + 20, x
        cmp     #1
        beq     lf_check_name   ; entry attiva: confronta il nome

lf_next_entry
        inc     DIR_CUR_ENTRY
        lda     DIR_CUR_ENTRY
        cmp     #8
        bne     lf_find_loop
        ; File non trovato
        lda     #$04
        sta     STATUS
        sec
        rts

lf_check_name
        stx     TEMP_REG        ; TEMP_REG = base offset entry corrente
        ldy     #0              ; Y = indice carattere (0..FNLEN-1)

lf_cmp_loop
        cpy     FNLEN
        beq     lf_check_exact  ; tutti i caratteri FNLEN corrispondono, verifica esattezza!

        ; Leggi carattere dalla directory SRAM: IO_WIN[TEMP_REG + Y]
        tya
        clc
        adc     TEMP_REG
        tax
        lda     IO_WIN, x       ; carattere nel nome directory

        ; Confronta con il filename passato dal KERNAL: FNADR[Y]
        cmp     (ZP_PTR), y
        bne     lf_next_entry   ; mismatch → prossima entry
        iny
        jmp     lf_cmp_loop

lf_check_exact
        cpy     #16             ; Se la lunghezza richiesta è 16
        beq     lf_found        ; è un match esatto per forza
        
        ; Altrimenti, il prossimo carattere in SRAM deve essere NUL ($00)
        tya                     ; Y = FNLEN
        clc
        adc     TEMP_REG
        tax
        lda     IO_WIN, x
        beq     lf_found        ; Se è $00, il match è esatto
        jmp     lf_next_entry   ; Se non è $00, il nome in SRAM è più lungo -> scarta

lf_found
        ; Leggi Portion e Page del primo blocco dati (offset 16, 17)
        lda     DIR_CUR_ENTRY
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a               ; A = entry_base
        clc
        adc     #16
        tax                     ; X = entry_base + 16
        lda     IO_WIN, x       ; Portion del primo blocco
        sta     ALLOC_PORTION
        inx
        lda     IO_WIN, x       ; Page del primo blocco
        sta     ALLOC_PAGE
        ; Salta a offset 21 (entry_base + 21 = Load addr LO)
        inx
        inx
        inx
        inx                     ; X = entry_base + 21
        lda     IO_WIN, x       ; Indirizzo di caricamento LO
        sta     ZP_PTR
        inx
        lda     IO_WIN, x       ; Indirizzo di caricamento HI
        sta     ZP_PTR + 1

        ; Se SA != 0 (es. LOAD "file",8,1), usa MEMUSS come indirizzo destinazione
        lda     SA
        beq     lf_use_dir_addr
        lda     MEMUSS
        sta     ZP_PTR
        lda     MEMUSS + 1
        sta     ZP_PTR + 1

lf_use_dir_addr
        lda     #0
        sta     BYTE_COUNT      ; Byte index nel blocco corrente (0-253)

; ---------------------------------------------------------------
; 3. Loop principale di lettura blocchi dalla SRAM
; ---------------------------------------------------------------
lf_read_loop
        ; Seleziona Portion e Page correnti
        lda     ALLOC_PORTION
        beq     lf_sel_p0
        lda     #CTRL_P1
        jmp     lf_set_ctrl
lf_sel_p0
        lda     #CTRL_P0
lf_set_ctrl
        sta     CTRL_REG
        lda     ALLOC_PAGE
        sta     PAGE_REG

        ; Controlla se è l'ultimo blocco: link[254] == $FF
        lda     IO_WIN + 254
        cmp     #$FF
        beq     lf_last_block

; --- Blocco pieno: 254 byte di dati, poi segui il link ---
        ; Salva il link al blocco successivo (link[254]=Portion, link[255]=Page)
        lda     IO_WIN + 254
        sta     PREV_PORTION
        lda     IO_WIN + 255
        sta     PREV_PAGE
        lda     #0
        sta     BYTE_COUNT

lf_full_block_loop
        lda     BYTE_COUNT
        cmp     #254
        beq     lf_advance_block

        ldy     BYTE_COUNT
        lda     IO_WIN, y       ; byte dati dalla SRAM

        ldx     VERIFY_FLAG
        bne     lf_verify_full

        ; LOAD: scrivi in RAM
        ldy     #0
        sta     (ZP_PTR), y
        jmp     lf_inc_full

lf_verify_full
        ; VERIFY: confronta con RAM
        ldy     #0
        cmp     (ZP_PTR), y
        beq     lf_inc_full
        ; Mismatch: setta STATUS bit 4 (Verify Error)
        lda     STATUS
        ora     #$10
        sta     STATUS

lf_inc_full
        inc     ZP_PTR
        bne     lf_cnt_full
        inc     ZP_PTR + 1
lf_cnt_full
        inc     BYTE_COUNT
        jmp     lf_full_block_loop

lf_advance_block
        ; Passa al blocco successivo nella catena
        lda     PREV_PORTION
        sta     ALLOC_PORTION
        lda     PREV_PAGE
        sta     ALLOC_PAGE
        jmp     lf_read_loop

; --- Ultimo blocco: link[255] = numero di byte validi (0-253) ---
lf_last_block
        lda     IO_WIN + 255    ; numero di byte validi in questo blocco
        sta     TEMP_REG        ; salva il conteggio
        lda     #0
        sta     BYTE_COUNT

lf_last_block_loop
        lda     BYTE_COUNT
        cmp     TEMP_REG
        beq     lf_done         ; tutti i byte del blocco finale letti

        ldy     BYTE_COUNT
        lda     IO_WIN, y       ; byte dati

        ldx     VERIFY_FLAG
        bne     lf_verify_last

        ; LOAD: scrivi in RAM
        ldy     #0
        sta     (ZP_PTR), y
        jmp     lf_inc_last

lf_verify_last
        ; VERIFY: confronta con RAM
        ldy     #0
        cmp     (ZP_PTR), y
        beq     lf_inc_last
        ; Mismatch
        lda     STATUS
        ora     #$10
        sta     STATUS

lf_inc_last
        inc     ZP_PTR
        bne     lf_cnt_last
        inc     ZP_PTR + 1
lf_cnt_last
        inc     BYTE_COUNT
        jmp     lf_last_block_loop

lf_done
        ; Ritorna X/Y = indirizzo fine + 1
        lda     ZP_PTR
        tax
        lda     ZP_PTR + 1
        tay
        ; LOAD: azzera STATUS; VERIFY: lascia STATUS intatto (bit 4 = verify error)
        lda     VERIFY_FLAG
        bne     lf_exit
        lda     #0
        sta     STATUS
lf_exit
        clc
        rts

; =============================================================================
; MDP_FORMAT — Formatta la SRAM della MagicDesk Plus secondo MDP-FS
; =============================================================================
mdp_format

        ; ---------------------------------------------------------------
        ; A. Abilita SRAM Portion 0 (CTRL_REG = $20)
        ; ---------------------------------------------------------------
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG

        ; ---------------------------------------------------------------
        ; B. Azzera tutte le 256 pagine di Portion 0
        ; ---------------------------------------------------------------
        lda     #0
        sta     LOOP_PAGE

fmt_p0_page_loop
        lda     LOOP_PAGE
        sta     PAGE_REG            ; seleziona pagina corrente

        ; Azzera 256 byte della finestra ($DF00-$DFFF)
        lda     #0
        ldx     #0
fmt_p0_byte_loop
        sta     IO_WIN, x
        inx
        bne     fmt_p0_byte_loop    ; X wrappa 255→0: 256 iterazioni totali

        ; Pagina successiva
        inc     LOOP_PAGE
        bne     fmt_p0_page_loop    ; se non ha wrappato a 0, continua

        ; ---------------------------------------------------------------
        ; C. Abilita SRAM Portion 1 (CTRL_REG = $21)
        ; ---------------------------------------------------------------
        lda     #CTRL_P1
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG

        ; ---------------------------------------------------------------
        ; D. Azzera tutte le 256 pagine di Portion 1
        ; ---------------------------------------------------------------
        lda     #0
        sta     LOOP_PAGE

fmt_p1_page_loop
        lda     LOOP_PAGE
        sta     PAGE_REG

        lda     #0
        ldx     #0
fmt_p1_byte_loop
        sta     IO_WIN, x
        inx
        bne     fmt_p1_byte_loop

        inc     LOOP_PAGE
        bne     fmt_p1_page_loop

        ; ---------------------------------------------------------------
        ; E. Torna a Portion 0 e scrivi la BAM (Pagina 1)
        ; Standard Commodore: 1=libero, 0=occupato → riempi con $FF poi segna i blocchi riservati
        ; ---------------------------------------------------------------
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG

        lda     #1
        sta     PAGE_REG            ; Pagina 1 = BAM

        ; Riempi i 64 byte di BAM con $FF (tutti i blocchi liberi)
        lda     #$FF
        ldx     #63
fmt_bam_fill
        sta     IO_WIN, x
        dex
        bpl     fmt_bam_fill

        ; Blocchi riservati (clear bit = occupato):
        ; Byte 0: bit 0 = P0/Pag0 (Directory), bit 1 = P0/Pag1 (BAM) → $FF & ~$03 = $FC
        lda     #%11111100
        sta     IO_WIN + 0

        ; Byte 63: bit 7 = P1/Pag255 (Signature) → $FF & ~$80 = $7F
        lda     #%01111111
        sta     IO_WIN + 63

        ; ---------------------------------------------------------------
        ; F. Scrivi la signature hardware a Portion 1, Pag 255, $FE/$FF
        ; ---------------------------------------------------------------
        lda     #CTRL_P1
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG

        lda     #SIG_PAGE           ; 255
        sta     PAGE_REG

        lda     #SIG_BYTE0          ; $CA
        sta     IO_WIN + SIG_OFFSET0

        lda     #SIG_BYTE1          ; $F1
        sta     IO_WIN + SIG_OFFSET1

        ; ---------------------------------------------------------------
        ; G. Stampa messaggio di conferma
        ; ---------------------------------------------------------------
        ldx     #0
fmt_print_loop
        lda     fmt_msg, x
        beq     fmt_print_done
        jsr     CHROUT
        inx
        bne     fmt_print_loop

fmt_print_done
        rts

; (fmt_msg spostato nel file lingua)

; =============================================================================
; MDP_VALIDATE — Ricostruisce la BAM dai file attivi (V0:)
; =============================================================================
mdp_validate

        ; 1. Seleziona BAM e riempila di 1 (liberi)
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        lda     #1
        sta     PAGE_REG            ; BAM

        lda     #$FF
        ldx     #63
val_bam_fill
        sta     IO_WIN, x
        dex
        bpl     val_bam_fill

        ; 2. Segna i blocchi riservati come occupati
        lda     #%11111100          ; P0/Pag0, P0/Pag1
        sta     IO_WIN + 0
        lda     #%01111111          ; P1/Pag255
        sta     IO_WIN + 63

        ; 3. Scansiona le 8 entry in directory
        lda     #0
        sta     DIR_CUR_ENTRY

val_dir_loop
        ; Abilita Directory
        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        lda     #0
        sta     PAGE_REG
        
        lda     DIR_CUR_ENTRY
        asl     a
        asl     a
        asl     a
        asl     a
        asl     a
        tax

        ; Controlla se attivo
        lda     IO_WIN + 20, x
        cmp     #1
        bne     val_next_entry
        
        ; Prendi Portion e Page
        lda     IO_WIN + 16, x
        sta     ALLOC_PORTION
        lda     IO_WIN + 17, x
        sta     ALLOC_PAGE

val_chain_loop
        ; Segna il blocco ALLOC_PORTION/ALLOC_PAGE come usato nella BAM
        jsr     mdp_mark_used

        ; Seleziona il blocco hardware corrente
        lda     ALLOC_PORTION
        beq     val_sel_p0
        lda     #CTRL_P1
        jmp     val_set_ctrl
val_sel_p0
        lda     #CTRL_P0
val_set_ctrl
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        lda     ALLOC_PAGE
        sta     PAGE_REG

        ; Leggi puntatore successivo
        lda     IO_WIN + 254
        cmp     #$FF
        beq     val_next_entry      ; EOF raggiunto
        
        sta     TEMP_REG
        lda     IO_WIN + 255
        sta     ALLOC_PAGE
        lda     TEMP_REG
        sta     ALLOC_PORTION
        jmp     val_chain_loop

val_next_entry
        inc     DIR_CUR_ENTRY
        lda     DIR_CUR_ENTRY
        cmp     #8
        bne     val_dir_loop
        
        ; --- Stampa messaggio di conferma ---
        ldx     #0
val_print_loop
        lda     val_msg, x
        beq     val_print_done
        jsr     CHROUT
        inx
        bne     val_print_loop

val_print_done
        rts

; =============================================================================
; MDP_MARK_USED — Segna ALLOC_PORTION/ALLOC_PAGE come occupato (0) nella BAM
; =============================================================================
mdp_mark_used

        lda     ALLOC_PAGE
        and     #%00000111
        sta     TEMP_REG            ; bit index (0-7)

        lda     ALLOC_PAGE
        lsr     a
        lsr     a
        lsr     a                   ; A = ALLOC_PAGE / 8

        ldy     ALLOC_PORTION
        beq     mu_p0
        clc
        adc     #32                 ; Portion 1 -> offset + 32
mu_p0
        tay                         ; Y = byte index
        ldx     TEMP_REG            ; X = bit index

        lda     #CTRL_P0
        sta     MDP_CTRL_SHADOW
        sta     CTRL_REG
        lda     #1
        sta     PAGE_REG            ; Seleziona BAM

        lda     IO_WIN, y
        and     inv_bit_mask, x     ; 0 = OCCUPATO
        sta     IO_WIN, y
        
        rts
