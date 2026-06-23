; =============================================================================
; English Localization (ENG)
; =============================================================================

header_text
        .null   "magicdesk ram"
free_text
        .null   "blocks free."
fmt_msg
        .byte   PETSCII_CR
        .null   "format complete"
val_msg
        .byte   PETSCII_CR
        .null   "validation complete"

; Stringhe per mdp-init.asm
init_loading_msg
        .byte   PETSCII_CR
        .null   "loading mdp-hook..."
init_err_msg
        .byte   PETSCII_CR
        .null   "file not found or drive not ready!"
init_ready_msg
        .byte   PETSCII_CR
        .null   "mdp file system ready."
