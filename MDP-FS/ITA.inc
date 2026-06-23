; =============================================================================
; Italian Localization (ITA)
; =============================================================================

header_text
        .null   "magicdesk ram"
free_text
        .null   "blocchi liberi."
fmt_msg
        .byte   PETSCII_CR
        .null   "formattazione avvenuta"
val_msg
        .byte   PETSCII_CR
        .null   "validazione completata"

; Stringhe per mdp-init.asm
init_loading_msg
        .byte   PETSCII_CR
        .null   "caricamento mdp-hook..."
init_err_msg
        .byte   PETSCII_CR
        .null   "file non trovato o drive non pronto!"
init_ready_msg
        .byte   PETSCII_CR
        .null   "mdp file system pronto."
