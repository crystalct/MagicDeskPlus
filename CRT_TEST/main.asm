* = $8000
 
     .word coldstart            ; coldstart vector
     .word warmstart            ; warmstart vector
     .byte $C3,$C2,$CD,$38,$30  ; "CBM8O". Autostart string
 
coldstart
     sei
     stx $d016
     jsr $fda3 ;Prepare IRQ
     jsr $fd50 ;Init memory. Rewrite this routine to speed up boot process.
     jsr $fd15 ;Init I/O
     jsr $ff5b ;Init video
     cli
 
     jsr $ff9e ; Legge la tastiera  
     lda $cb
     cmp #$3f
     bne warmstart
 
     ldx #(disable_end - disable_start - 1)
-
     lda disable_start,x
     sta $0340,x
     dex
     bpl -
 
     jmp $0340
 
disable_start
     lda #$80
     sta $de00
     jmp $fce2
disable_end
 
PRG_BANK   = $1D      ; Inserisci qui la pagina Magic Desk di partenza del PRG
PRG_LENGTH = $41AA    ; Inserisci qui la lunghezza totale del file PRG

warmstart
     jsr $ff9e  ; Legge la tastiera
     
     lda $cb
     cmp #$04      ; Codice tasto F1
     beq _do_transfer
     jmp mainprogram

_do_transfer:

     ldx #0
-
     lda transfer_start,x
     sta $0340,x
     inx
     cpx #(transfer_end - transfer_start)
     bne -

     jmp $0340

transfer_start:
     sei
     lda #PRG_BANK
     sta $de00

     ; Leggi l'indirizzo di destinazione dai primi due byte del PRG
     lda $8000
     sta $fd
     lda $8001
     sta $fe

     ; Inizializza il puntatore sorgente ($8002)
     lda #<$8002
     sta $fb
     lda #>$8002
     sta $fc

     ; Inizializza contatore lunghezza (PRG_LENGTH - 2)
     lda #<(PRG_LENGTH - 2)
     sta $f9
     lda #>(PRG_LENGTH - 2)
     sta $fa

     ldx #PRG_BANK
     ldy #0
copy_loop:
     lda $fa
     bne _do_copy
     lda $f9
     beq copy_done
_do_copy:
     lda ($fb),y
     sta ($fd),y

     inc $fd
     bne _inc_src
     inc $fe
_inc_src:
     inc $fb
     bne _dec_len
     inc $fc
     lda $fc
     cmp #$a0
     bne _dec_len
     
     ; Passaggio alla pagina successiva (Bank crossing)
     lda #$80
     sta $fc
     inx
     stx $de00
_dec_len:
     lda $f9
     bne _dec_lo
     dec $fa
_dec_lo:
     dec $f9
     clc
     bcc copy_loop

copy_done:
     lda #$80
     sta $de00       ; Disabilita Magic Desk

     cli
     jsr $080d       ; Salta all'avvio del programma in RAM
     jmp $fce2       ; Reset
transfer_end:

mainprogram
     ; Pulisce lo schermo
     ldx #0
     lda #$20
_clr_scr:
     sta $0400,x
     sta $0500,x
     sta $0600,x
     sta $0700,x
     dex
     bne _clr_scr

     ; Imposta il bordo e lo sfondo di colore nero (0)
     lda #$00
     sta $d020
     sta $d021

     ; Stampa "MAGIC DESK PLUS" al centro e imposta il colore verde chiaro (13 = $0D)
     ldx #0
_print_loop:
     lda text_msg,x
     sta $05ec,x       ; $05ec è l'indirizzo per il centro (riga 12, colonna 12)
     lda #$0d
     sta $d9ec,x       ; $d9ec è l'indirizzo corrispondente nella Color RAM ($d800 + $01ec)
     inx
     cpx #15
     bne _print_loop

_infinite_loop:
     jmp _infinite_loop

text_msg:
     ; "MAGIC DESK PLUS" in Screen Codes
     .byte $0D, $01, $07, $09, $03, $20, $04, $05, $13, $0B, $20, $10, $0C, $15, $13
