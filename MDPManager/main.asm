; Compiled with 1.32.271.0
--------------------------------------------------------------------
startup: ; startup
0801 : 0b __ __ INV
0802 : 08 __ __ PHP
0803 : 0a __ __ ASL
0804 : 00 __ __ BRK
0805 : 9e __ __ INV
0806 : 32 __ __ INV
0807 : 30 36 __ BMI $083f ; (startup + 62)
0809 : 31 00 __ AND ($00),y 
080b : 00 __ __ BRK
080c : 00 __ __ BRK
080d : ba __ __ TSX
080e : 8e ff 0f STX $0fff ; (spentry + 0)
0811 : a2 4a __ LDX #$4a
0813 : a0 99 __ LDY #$99
0815 : a9 00 __ LDA #$00
0817 : 85 19 __ STA IP + 0 
0819 : 86 1a __ STX IP + 1 
081b : e0 4c __ CPX #$4c
081d : f0 0b __ BEQ $082a ; (startup + 41)
081f : 91 19 __ STA (IP + 0),y 
0821 : c8 __ __ INY
0822 : d0 fb __ BNE $081f ; (startup + 30)
0824 : e8 __ __ INX
0825 : d0 f2 __ BNE $0819 ; (startup + 24)
0827 : 91 19 __ STA (IP + 0),y 
0829 : c8 __ __ INY
082a : c0 e4 __ CPY #$e4
082c : d0 f9 __ BNE $0827 ; (startup + 38)
082e : a9 00 __ LDA #$00
0830 : a2 f7 __ LDX #$f7
0832 : d0 03 __ BNE $0837 ; (startup + 54)
0834 : 95 00 __ STA $00,x 
0836 : e8 __ __ INX
0837 : e0 f7 __ CPX #$f7
0839 : d0 f9 __ BNE $0834 ; (startup + 51)
083b : a9 4f __ LDA #$4f
083d : 85 23 __ STA SP + 0 
083f : a9 9b __ LDA #$9b
0841 : 85 24 __ STA SP + 1 
0843 : 20 80 08 JSR $0880 ; (main.s4 + 0)
0846 : a9 4c __ LDA #$4c
0848 : 85 54 __ STA $54 
084a : a9 00 __ LDA #$00
084c : 85 13 __ STA P6 
084e : a9 19 __ LDA #$19
0850 : 85 16 __ STA P9 
0852 : 60 __ __ RTS
--------------------------------------------------------------------
main: ; main()->i16
;2269, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0880 : a9 80 __ LDA #$80
0882 : 8d 00 de STA $de00 
0885 : a9 00 __ LDA #$00
0887 : 8d 20 d0 STA $d020 
088a : 8d 21 d0 STA $d021 
088d : 20 e7 ff JSR $ffe7 
0890 : a9 0b __ LDA #$0b
0892 : 85 18 __ STA P11 
0894 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
0897 : a9 03 __ LDA #$03
0899 : 85 16 __ STA P9 
089b : a9 0b __ LDA #$0b
089d : 85 15 __ STA P8 
089f : a9 07 __ LDA #$07
08a1 : 85 17 __ STA P10 
08a3 : a9 ef __ LDA #$ef
08a5 : 85 14 __ STA P7 
08a7 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
08aa : a9 0b __ LDA #$0b
08ac : 85 16 __ STA P9 
08ae : a9 0c __ LDA #$0c
08b0 : 85 15 __ STA P8 
08b2 : a9 03 __ LDA #$03
08b4 : 85 17 __ STA P10 
08b6 : a9 00 __ LDA #$00
08b8 : 85 14 __ STA P7 
08ba : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
08bd : 20 14 0c JSR $0c14 ; (mdp_detect_sram.s4 + 0)
08c0 : a5 1b __ LDA ACCU + 0 
08c2 : 8d ff 18 STA $18ff ; (sram_status + 0)
08c5 : c9 02 __ CMP #$02
08c7 : d0 29 __ BNE $08f2 ; (main.s5 + 0)
.s26:
08c9 : a9 0d __ LDA #$0d
08cb : 85 16 __ STA P9 
08cd : a9 0c __ LDA #$0c
08cf : 85 15 __ STA P8 
08d1 : a9 07 __ LDA #$07
08d3 : 85 17 __ STA P10 
08d5 : a9 62 __ LDA #$62
08d7 : 85 14 __ STA P7 
08d9 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l27:
08dc : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
08df : c9 79 __ CMP #$79
08e1 : d0 03 __ BNE $08e6 ; (main.s28 + 0)
08e3 : 4c fa 09 JMP $09fa ; (main.s31 + 0)
.s28:
08e6 : c9 59 __ CMP #$59
08e8 : f0 f9 __ BEQ $08e3 ; (main.l27 + 7)
.s29:
08ea : c9 6e __ CMP #$6e
08ec : f0 04 __ BEQ $08f2 ; (main.s5 + 0)
.s30:
08ee : c9 4e __ CMP #$4e
08f0 : d0 ea __ BNE $08dc ; (main.l27 + 0)
.s5:
08f2 : a9 0b __ LDA #$0b
08f4 : 85 18 __ STA P11 
08f6 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
08f9 : a9 03 __ LDA #$03
08fb : 85 16 __ STA P9 
08fd : a9 0c __ LDA #$0c
08ff : 85 15 __ STA P8 
0901 : a9 07 __ LDA #$07
0903 : 85 17 __ STA P10 
0905 : a9 ed __ LDA #$ed
0907 : 85 14 __ STA P7 
0909 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
090c : a9 0b __ LDA #$0b
090e : 85 16 __ STA P9 
0910 : a9 0d __ LDA #$0d
0912 : 85 15 __ STA P8 
0914 : a9 03 __ LDA #$03
0916 : 85 17 __ STA P10 
0918 : a9 00 __ LDA #$00
091a : 85 14 __ STA P7 
091c : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
091f : a9 ff __ LDA #$ff
0921 : 85 11 __ STA P4 
0923 : a9 1a __ LDA #$1a
0925 : 85 12 __ STA P5 
0927 : 20 16 0d JSR $0d16 ; (mdp_detect_eeprom.s4 + 0)
092a : a5 1b __ LDA ACCU + 0 
092c : 8d ff 27 STA $27ff ; (eeprom_status + 0)
092f : c9 02 __ CMP #$02
0931 : d0 26 __ BNE $0959 ; (main.l6 + 0)
.s19:
0933 : a9 0d __ LDA #$0d
0935 : 85 16 __ STA P9 
0937 : a9 0e __ LDA #$0e
0939 : 85 15 __ STA P8 
093b : a9 07 __ LDA #$07
093d : 85 17 __ STA P10 
093f : a9 07 __ LDA #$07
0941 : 85 14 __ STA P7 
0943 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l20:
0946 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
0949 : c9 79 __ CMP #$79
094b : f0 70 __ BEQ $09bd ; (main.s24 + 0)
.s21:
094d : c9 59 __ CMP #$59
094f : f0 6c __ BEQ $09bd ; (main.s24 + 0)
.s22:
0951 : c9 6e __ CMP #$6e
0953 : f0 04 __ BEQ $0959 ; (main.l6 + 0)
.s23:
0955 : c9 4e __ CMP #$4e
0957 : d0 ed __ BNE $0946 ; (main.l20 + 0)
.l6:
0959 : 20 6d 0e JSR $0e6d ; (draw_main_menu.s4 + 0)
.l7:
095c : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
095f : aa __ __ TAX
0960 : f0 fa __ BEQ $095c ; (main.l7 + 0)
.s8:
0962 : c9 85 __ CMP #$85
0964 : d0 06 __ BNE $096c ; (main.s9 + 0)
.s18:
0966 : 20 15 11 JSR $1115 ; (show_sram_editor_screen.s1 + 0)
0969 : 4c 59 09 JMP $0959 ; (main.l6 + 0)
.s9:
096c : c9 86 __ CMP #$86
096e : d0 06 __ BNE $0976 ; (main.s10 + 0)
.s17:
0970 : 20 67 19 JSR $1967 ; (show_sram_diag_screen.s1 + 0)
0973 : 4c 59 09 JMP $0959 ; (main.l6 + 0)
.s10:
0976 : c9 87 __ CMP #$87
0978 : d0 06 __ BNE $0980 ; (main.s11 + 0)
.s16:
097a : 20 cf 35 JSR $35cf ; (show_dump_screen.s1 + 0)
097d : 4c 59 09 JMP $0959 ; (main.l6 + 0)
.s11:
0980 : c9 88 __ CMP #$88
0982 : d0 0b __ BNE $098f ; (main.s12 + 0)
.s15:
0984 : a9 00 __ LDA #$00
0986 : cd fe 32 CMP $32fe ; (sram_mode_active + 0)
0989 : 2a __ __ ROL
098a : 8d fe 32 STA $32fe ; (sram_mode_active + 0)
098d : 90 ca __ BCC $0959 ; (main.l6 + 0)
.s12:
098f : c9 78 __ CMP #$78
0991 : f0 04 __ BEQ $0997 ; (main.s14 + 0)
.s13:
0993 : c9 58 __ CMP #$58
0995 : d0 c2 __ BNE $0959 ; (main.l6 + 0)
.s14:
0997 : a9 00 __ LDA #$00
0999 : 85 18 __ STA P11 
099b : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
099e : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
09a1 : a9 00 __ LDA #$00
09a3 : 85 11 __ STA P4 
09a5 : 85 12 __ STA P5 
09a7 : a9 01 __ LDA #$01
09a9 : 85 13 __ STA P6 
09ab : a9 48 __ LDA #$48
09ad : 85 10 __ STA P3 
09af : a9 b9 __ LDA #$b9
09b1 : 85 0f __ STA P2 
09b3 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
09b6 : a9 00 __ LDA #$00
09b8 : 85 1b __ STA ACCU + 0 
09ba : 85 1c __ STA ACCU + 1 
.s3:
09bc : 60 __ __ RTS
.s24:
09bd : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
09c0 : 85 11 __ STA P4 
09c2 : 20 2a 0e JSR $0e2a ; (mdp_eeprom_write_signature.s4 + 0)
09c5 : a9 0f __ LDA #$0f
09c7 : 85 16 __ STA P9 
09c9 : a9 01 __ LDA #$01
09cb : 8d ff 27 STA $27ff ; (eeprom_status + 0)
09ce : a9 0d __ LDA #$0d
09d0 : 85 17 __ STA P10 
09d2 : a9 4c __ LDA #$4c
09d4 : 85 14 __ STA P7 
09d6 : a9 0e __ LDA #$0e
09d8 : 85 15 __ STA P8 
09da : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
09dd : a9 17 __ LDA #$17
09df : 85 16 __ STA P9 
09e1 : a9 0c __ LDA #$0c
09e3 : 85 15 __ STA P8 
09e5 : a9 01 __ LDA #$01
09e7 : 85 17 __ STA P10 
09e9 : a9 d1 __ LDA #$d1
09eb : 85 14 __ STA P7 
09ed : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l25:
09f0 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
09f3 : c9 0d __ CMP #$0d
09f5 : d0 f9 __ BNE $09f0 ; (main.l25 + 0)
09f7 : 4c 59 09 JMP $0959 ; (main.l6 + 0)
.s31:
09fa : 20 95 0c JSR $0c95 ; (mdp_write_signature.s4 + 0)
09fd : a9 0f __ LDA #$0f
09ff : 85 16 __ STA P9 
0a01 : a9 01 __ LDA #$01
0a03 : 8d ff 18 STA $18ff ; (sram_status + 0)
0a06 : a9 0d __ LDA #$0d
0a08 : 85 17 __ STA P10 
0a0a : a9 b0 __ LDA #$b0
0a0c : 85 14 __ STA P7 
0a0e : a9 0c __ LDA #$0c
0a10 : 85 15 __ STA P8 
0a12 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
0a15 : a9 17 __ LDA #$17
0a17 : 85 16 __ STA P9 
0a19 : a9 0c __ LDA #$0c
0a1b : 85 15 __ STA P8 
0a1d : a9 01 __ LDA #$01
0a1f : 85 17 __ STA P10 
0a21 : a9 d1 __ LDA #$d1
0a23 : 85 14 __ STA P7 
0a25 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l32:
0a28 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
0a2b : c9 0d __ CMP #$0d
0a2d : d0 f9 __ BNE $0a28 ; (main.l32 + 0)
0a2f : 4c f2 08 JMP $08f2 ; (main.s5 + 0)
--------------------------------------------------------------------
clear_screen: ; clear_screen(u8)->void
;  28, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0a32 : a9 00 __ LDA #$00
0a34 : 85 43 __ STA T0 + 0 
0a36 : 85 1f __ STA ADDR + 0 
0a38 : a9 04 __ LDA #$04
0a3a : 85 44 __ STA T0 + 1 
0a3c : a6 18 __ LDX P11 ; (fill_color + 0)
0a3e : 4c 43 0a JMP $0a43 ; (clear_screen.l8 + 0)
.s9:
0a41 : e6 44 __ INC T0 + 1 
.l8:
0a43 : a9 20 __ LDA #$20
0a45 : a0 00 __ LDY #$00
0a47 : 91 43 __ STA (T0 + 0),y 
0a49 : 18 __ __ CLC
0a4a : a5 44 __ LDA T0 + 1 
0a4c : 69 d4 __ ADC #$d4
0a4e : 85 20 __ STA ADDR + 1 
0a50 : 8a __ __ TXA
0a51 : a4 43 __ LDY T0 + 0 
0a53 : 91 1f __ STA (ADDR + 0),y 
0a55 : 98 __ __ TYA
0a56 : 18 __ __ CLC
0a57 : 69 01 __ ADC #$01
0a59 : 85 43 __ STA T0 + 0 
0a5b : b0 e4 __ BCS $0a41 ; (clear_screen.s9 + 0)
.s10:
0a5d : c9 e8 __ CMP #$e8
0a5f : d0 e2 __ BNE $0a43 ; (clear_screen.l8 + 0)
.s7:
0a61 : a5 44 __ LDA T0 + 1 
0a63 : c9 07 __ CMP #$07
0a65 : d0 dc __ BNE $0a43 ; (clear_screen.l8 + 0)
.s5:
0a67 : 8a __ __ TXA
0a68 : d0 01 __ BNE $0a6b ; (clear_screen.s6 + 0)
.s3:
0a6a : 60 __ __ RTS
.s6:
0a6b : a9 01 __ LDA #$01
0a6d : 85 16 __ STA P9 
0a6f : a9 0b __ LDA #$0b
0a71 : 85 15 __ STA P8 
0a73 : a9 03 __ LDA #$03
0a75 : 85 17 __ STA P10 
0a77 : a9 d7 __ LDA #$d7
0a79 : 85 14 __ STA P7 
0a7b : 4c 7e 0a JMP $0a7e ; (print_centered.s4 + 0)
--------------------------------------------------------------------
print_centered: ; print_centered(const u8*,u8,u8)->void
;  26, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0a7e : a5 16 __ LDA P9 ; (row + 0)
0a80 : 85 0d __ STA P0 
0a82 : a5 17 __ LDA P10 ; (color + 0)
0a84 : 85 0e __ STA P1 
0a86 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
0a89 : a5 14 __ LDA P7 ; (text + 0)
0a8b : 85 0d __ STA P0 
0a8d : a5 15 __ LDA P8 ; (text + 1)
0a8f : 85 0e __ STA P1 
0a91 : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
0a94 : a5 14 __ LDA P7 ; (text + 0)
0a96 : 85 0f __ STA P2 
0a98 : a5 15 __ LDA P8 ; (text + 1)
0a9a : 85 10 __ STA P3 
0a9c : a5 16 __ LDA P9 ; (row + 0)
0a9e : 85 11 __ STA P4 
0aa0 : a5 17 __ LDA P10 ; (color + 0)
0aa2 : 85 13 __ STA P6 
0aa4 : 38 __ __ SEC
0aa5 : a9 28 __ LDA #$28
0aa7 : e5 1b __ SBC ACCU + 0 
0aa9 : aa __ __ TAX
0aaa : a9 00 __ LDA #$00
0aac : e5 1c __ SBC ACCU + 1 
0aae : a8 __ __ TAY
0aaf : 0a __ __ ASL
0ab0 : 8a __ __ TXA
0ab1 : 69 00 __ ADC #$00
0ab3 : 85 12 __ STA P5 
0ab5 : 98 __ __ TYA
0ab6 : 69 00 __ ADC #$00
0ab8 : 4a __ __ LSR
0ab9 : 66 12 __ ROR P5 
0abb : 4c 1e 0b JMP $0b1e ; (print_at.s4 + 0)
--------------------------------------------------------------------
clear_row: ; clear_row(u8,u8)->void
;  27, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0abe : a5 0d __ LDA P0 ; (row + 0)
0ac0 : 0a __ __ ASL
0ac1 : 85 1b __ STA ACCU + 0 
0ac3 : a9 00 __ LDA #$00
0ac5 : 2a __ __ ROL
0ac6 : 06 1b __ ASL ACCU + 0 
0ac8 : 2a __ __ ROL
0ac9 : aa __ __ TAX
0aca : a5 1b __ LDA ACCU + 0 
0acc : 65 0d __ ADC P0 ; (row + 0)
0ace : 85 1b __ STA ACCU + 0 
0ad0 : 8a __ __ TXA
0ad1 : 69 00 __ ADC #$00
0ad3 : 06 1b __ ASL ACCU + 0 
0ad5 : 2a __ __ ROL
0ad6 : 06 1b __ ASL ACCU + 0 
0ad8 : 2a __ __ ROL
0ad9 : 06 1b __ ASL ACCU + 0 
0adb : 2a __ __ ROL
0adc : 69 04 __ ADC #$04
0ade : 85 1c __ STA ACCU + 1 
0ae0 : a9 00 __ LDA #$00
0ae2 : 85 1f __ STA ADDR + 0 
0ae4 : a4 1b __ LDY ACCU + 0 
0ae6 : 85 1b __ STA ACCU + 0 
0ae8 : a2 28 __ LDX #$28
.l5:
0aea : a9 20 __ LDA #$20
0aec : 91 1b __ STA (ACCU + 0),y 
0aee : 18 __ __ CLC
0aef : a5 1c __ LDA ACCU + 1 
0af1 : 69 d4 __ ADC #$d4
0af3 : 85 20 __ STA ADDR + 1 
0af5 : a5 0e __ LDA P1 ; (color + 0)
0af7 : 91 1f __ STA (ADDR + 0),y 
0af9 : c8 __ __ INY
0afa : d0 02 __ BNE $0afe ; (clear_row.s7 + 0)
.s6:
0afc : e6 1c __ INC ACCU + 1 
.s7:
0afe : ca __ __ DEX
0aff : d0 e9 __ BNE $0aea ; (clear_row.l5 + 0)
.s3:
0b01 : 60 __ __ RTS
--------------------------------------------------------------------
mystrlen: ; mystrlen(const u8*)->i16
; 113, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0b02 : a9 00 __ LDA #$00
0b04 : 85 1b __ STA ACCU + 0 
0b06 : 85 1c __ STA ACCU + 1 
0b08 : a8 __ __ TAY
0b09 : b1 0d __ LDA (P0),y ; (str + 0)
0b0b : f0 10 __ BEQ $0b1d ; (mystrlen.s3 + 0)
.s6:
0b0d : a2 00 __ LDX #$00
.l7:
0b0f : c8 __ __ INY
0b10 : d0 03 __ BNE $0b15 ; (mystrlen.s9 + 0)
.s8:
0b12 : e6 0e __ INC P1 ; (str + 1)
0b14 : e8 __ __ INX
.s9:
0b15 : b1 0d __ LDA (P0),y ; (str + 0)
0b17 : d0 f6 __ BNE $0b0f ; (mystrlen.l7 + 0)
.s5:
0b19 : 86 1c __ STX ACCU + 1 
0b1b : 84 1b __ STY ACCU + 0 
.s3:
0b1d : 60 __ __ RTS
--------------------------------------------------------------------
print_at: ; print_at(const u8*,u8,u8,u8)->void
;  25, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0b1e : a5 0f __ LDA P2 ; (text + 0)
0b20 : 85 0d __ STA P0 
0b22 : 85 45 __ STA T2 + 0 
0b24 : a5 10 __ LDA P3 ; (text + 1)
0b26 : 85 0e __ STA P1 
0b28 : 85 46 __ STA T2 + 1 
0b2a : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
0b2d : a5 1b __ LDA ACCU + 0 
0b2f : 85 47 __ STA T3 + 0 
0b31 : 18 __ __ CLC
0b32 : 65 12 __ ADC P5 ; (col + 0)
0b34 : 85 43 __ STA T1 + 0 
0b36 : a5 1c __ LDA ACCU + 1 
0b38 : 85 48 __ STA T3 + 1 
0b3a : 69 00 __ ADC #$00
0b3c : 30 18 __ BMI $0b56 ; (print_at.s5 + 0)
.s11:
0b3e : f0 10 __ BEQ $0b50 ; (print_at.s10 + 0)
.s19:
0b40 : a9 28 __ LDA #$28
.s9:
0b42 : 38 __ __ SEC
0b43 : e5 12 __ SBC P5 ; (col + 0)
0b45 : 85 47 __ STA T3 + 0 
0b47 : a9 00 __ LDA #$00
0b49 : e9 00 __ SBC #$00
0b4b : 85 48 __ STA T3 + 1 
0b4d : 4c 56 0b JMP $0b56 ; (print_at.s5 + 0)
.s10:
0b50 : a9 28 __ LDA #$28
0b52 : c5 43 __ CMP T1 + 0 
0b54 : 90 ec __ BCC $0b42 ; (print_at.s9 + 0)
.s5:
0b56 : a5 48 __ LDA T3 + 1 
0b58 : 30 66 __ BMI $0bc0 ; (print_at.s3 + 0)
.s8:
0b5a : 05 47 __ ORA T3 + 0 
0b5c : f0 62 __ BEQ $0bc0 ; (print_at.s3 + 0)
.s6:
0b5e : a5 11 __ LDA P4 ; (row + 0)
0b60 : 0a __ __ ASL
0b61 : 85 1b __ STA ACCU + 0 
0b63 : a9 00 __ LDA #$00
0b65 : 2a __ __ ROL
0b66 : 06 1b __ ASL ACCU + 0 
0b68 : 2a __ __ ROL
0b69 : aa __ __ TAX
0b6a : a5 1b __ LDA ACCU + 0 
0b6c : 65 11 __ ADC P4 ; (row + 0)
0b6e : 85 43 __ STA T1 + 0 
0b70 : 8a __ __ TXA
0b71 : 69 00 __ ADC #$00
0b73 : 06 43 __ ASL T1 + 0 
0b75 : 2a __ __ ROL
0b76 : 06 43 __ ASL T1 + 0 
0b78 : 2a __ __ ROL
0b79 : 06 43 __ ASL T1 + 0 
0b7b : 2a __ __ ROL
0b7c : aa __ __ TAX
0b7d : a5 43 __ LDA T1 + 0 
0b7f : 65 12 __ ADC P5 ; (col + 0)
0b81 : 85 43 __ STA T1 + 0 
0b83 : 8a __ __ TXA
0b84 : 69 04 __ ADC #$04
0b86 : 85 44 __ STA T1 + 1 
.l7:
0b88 : a0 00 __ LDY #$00
0b8a : b1 45 __ LDA (T2 + 0),y 
0b8c : 20 c1 0b JSR $0bc1 ; (ascii_to_screencode.s4 + 0)
0b8f : a0 00 __ LDY #$00
0b91 : 84 1f __ STY ADDR + 0 
0b93 : 91 43 __ STA (T1 + 0),y 
0b95 : 18 __ __ CLC
0b96 : a5 44 __ LDA T1 + 1 
0b98 : 69 d4 __ ADC #$d4
0b9a : 85 20 __ STA ADDR + 1 
0b9c : a5 13 __ LDA P6 ; (color + 0)
0b9e : a4 43 __ LDY T1 + 0 
0ba0 : 91 1f __ STA (ADDR + 0),y 
0ba2 : 98 __ __ TYA
0ba3 : 18 __ __ CLC
0ba4 : 69 01 __ ADC #$01
0ba6 : 85 43 __ STA T1 + 0 
0ba8 : 90 02 __ BCC $0bac ; (print_at.s16 + 0)
.s15:
0baa : e6 44 __ INC T1 + 1 
.s16:
0bac : e6 45 __ INC T2 + 0 
0bae : d0 02 __ BNE $0bb2 ; (print_at.s18 + 0)
.s17:
0bb0 : e6 46 __ INC T2 + 1 
.s18:
0bb2 : a5 47 __ LDA T3 + 0 
0bb4 : d0 02 __ BNE $0bb8 ; (print_at.s13 + 0)
.s12:
0bb6 : c6 48 __ DEC T3 + 1 
.s13:
0bb8 : c6 47 __ DEC T3 + 0 
0bba : d0 cc __ BNE $0b88 ; (print_at.l7 + 0)
.s14:
0bbc : a5 48 __ LDA T3 + 1 
0bbe : d0 c8 __ BNE $0b88 ; (print_at.l7 + 0)
.s3:
0bc0 : 60 __ __ RTS
--------------------------------------------------------------------
ascii_to_screencode: ; ascii_to_screencode(u8)->u8
;  81, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0bc1 : c9 61 __ CMP #$61
0bc3 : 90 07 __ BCC $0bcc ; (ascii_to_screencode.s5 + 0)
.s8:
0bc5 : c9 7b __ CMP #$7b
0bc7 : b0 03 __ BCS $0bcc ; (ascii_to_screencode.s5 + 0)
.s9:
0bc9 : 69 a0 __ ADC #$a0
.s3:
0bcb : 60 __ __ RTS
.s5:
0bcc : c9 41 __ CMP #$41
0bce : 90 fb __ BCC $0bcb ; (ascii_to_screencode.s3 + 0)
.s6:
0bd0 : c9 5b __ CMP #$5b
0bd2 : b0 f7 __ BCS $0bcb ; (ascii_to_screencode.s3 + 0)
.s7:
0bd4 : 69 c0 __ ADC #$c0
0bd6 : 60 __ __ RTS
--------------------------------------------------------------------
0bd7 : __ __ __ BYT 4d 41 47 49 43 20 44 45 53 4b 20 50 4c 55 53 20 : MAGIC DESK PLUS 
0be7 : __ __ __ BYT 4d 41 4e 41 47 45 52 00                         : MANAGER.
--------------------------------------------------------------------
0bef : __ __ __ BYT 47 45 53 54 49 4f 4e 45 20 53 52 41 4d 00       : GESTIONE SRAM.
--------------------------------------------------------------------
0bfd : __ __ __ BYT 20 20 00                                        :   .
--------------------------------------------------------------------
0c00 : __ __ __ BYT 52 49 4c 45 56 41 4d 45 4e 54 4f 20 53 52 41 4d : RILEVAMENTO SRAM
0c10 : __ __ __ BYT 2e 2e 2e 00                                     : ....
--------------------------------------------------------------------
mdp_detect_sram: ; mdp_detect_sram()->u8
; 125, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0c14 : a9 21 __ LDA #$21
0c16 : 8d 03 de STA $de03 
0c19 : a9 ff __ LDA #$ff
0c1b : 8d 01 de STA $de01 
0c1e : ad fe df LDA $dffe 
0c21 : ae ff df LDX $dfff 
0c24 : 86 1b __ STX ACCU + 0 
0c26 : aa __ __ TAX
0c27 : a0 00 __ LDY #$00
0c29 : e0 ca __ CPX #$ca
0c2b : d0 10 __ BNE $0c3d ; (mdp_detect_sram.s5 + 0)
.s10:
0c2d : a5 1b __ LDA ACCU + 0 
0c2f : c9 f1 __ CMP #$f1
0c31 : d0 0a __ BNE $0c3d ; (mdp_detect_sram.s5 + 0)
.s11:
0c33 : c8 __ __ INY
.s7:
0c34 : 84 1b __ STY ACCU + 0 
0c36 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
0c39 : 8d 03 de STA $de03 
.s3:
0c3c : 60 __ __ RTS
.s5:
0c3d : a9 ca __ LDA #$ca
0c3f : 8d fe df STA $dffe 
0c42 : a9 f1 __ LDA #$f1
0c44 : 8d ff df STA $dfff 
0c47 : ad fe df LDA $dffe 
0c4a : c9 ca __ CMP #$ca
0c4c : d0 09 __ BNE $0c57 ; (mdp_detect_sram.s6 + 0)
.s8:
0c4e : ad ff df LDA $dfff 
0c51 : c9 f1 __ CMP #$f1
0c53 : d0 02 __ BNE $0c57 ; (mdp_detect_sram.s6 + 0)
.s9:
0c55 : a0 02 __ LDY #$02
.s6:
0c57 : 8e fe df STX $dffe 
0c5a : a5 1b __ LDA ACCU + 0 
0c5c : 8d ff df STA $dfff 
0c5f : 4c 34 0c JMP $0c34 ; (mdp_detect_sram.s7 + 0)
--------------------------------------------------------------------
0c62 : __ __ __ BYT 53 52 41 4d 20 44 41 20 49 4e 49 5a 49 41 4c 49 : SRAM DA INIZIALI
0c72 : __ __ __ BYT 5a 5a 41 52 45 2e 20 49 4e 49 54 3f 20 59 2f 4e : ZZARE. INIT? Y/N
0c82 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
get_key: ; get_key()->u8
; 179, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0c83 : a9 00 __ LDA #$00
0c85 : 8d 99 4a STA $4a99 ; (last_key + 0)
0c88 : 20 9f ff JSR $ff9f 
0c8b : 20 e4 ff JSR $ffe4 
0c8e : 8d 99 4a STA $4a99 ; (last_key + 0)
.s3:
0c91 : ad 99 4a LDA $4a99 ; (last_key + 0)
0c94 : 60 __ __ RTS
--------------------------------------------------------------------
mdp_write_signature: ; mdp_write_signature()->void
; 173, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0c95 : a9 21 __ LDA #$21
0c97 : 8d 03 de STA $de03 
0c9a : a9 ff __ LDA #$ff
0c9c : 8d 01 de STA $de01 
0c9f : a9 ca __ LDA #$ca
0ca1 : 8d fe df STA $dffe 
0ca4 : a9 f1 __ LDA #$f1
0ca6 : 8d ff df STA $dfff 
0ca9 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
0cac : 8d 03 de STA $de03 
.s3:
0caf : 60 __ __ RTS
--------------------------------------------------------------------
0cb0 : __ __ __ BYT 53 52 41 4d 20 49 4e 49 5a 49 41 4c 49 5a 5a 41 : SRAM INIZIALIZZA
0cc0 : __ __ __ BYT 54 41 21 20 20 20 20 20 20 20 20 20 20 20 20 20 : TA!             
0cd0 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
0cd1 : __ __ __ BYT 50 52 45 4d 49 20 52 45 54 55 52 4e 20 50 45 52 : PREMI RETURN PER
0ce1 : __ __ __ BYT 20 43 4f 4e 54 49 4e 55 41 52 45 00             :  CONTINUARE.
--------------------------------------------------------------------
0ced : __ __ __ BYT 47 45 53 54 49 4f 4e 45 20 45 45 50 52 4f 4d 00 : GESTIONE EEPROM.
--------------------------------------------------------------------
0cfd : __ __ __ BYT 24 00                                           : $.
--------------------------------------------------------------------
0cff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
0d00 : __ __ __ BYT 52 49 4c 45 56 41 4d 45 4e 54 4f 20 45 45 50 52 : RILEVAMENTO EEPR
0d10 : __ __ __ BYT 4f 4d 2e 2e 2e 00                               : OM....
--------------------------------------------------------------------
mdp_detect_eeprom: ; mdp_detect_eeprom(u8*)->u8
; 277, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0d16 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
0d19 : 85 48 __ STA T2 + 0 
0d1b : a9 1f __ LDA #$1f
0d1d : 85 0e __ STA P1 
0d1f : a9 fe __ LDA #$fe
0d21 : 85 0f __ STA P2 
0d23 : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
0d26 : a9 1f __ LDA #$1f
0d28 : 8d 01 de STA $de01 
0d2b : ad fe df LDA $dffe 
0d2e : 85 49 __ STA T3 + 0 
0d30 : 49 ff __ EOR #$ff
0d32 : 85 47 __ STA T1 + 0 
0d34 : 85 10 __ STA P3 
0d36 : 20 cb 0d JSR $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
0d39 : a5 49 __ LDA T3 + 0 
0d3b : 85 10 __ STA P3 
0d3d : a9 1f __ LDA #$1f
0d3f : 8d 01 de STA $de01 
0d42 : ad fe df LDA $dffe 
0d45 : 85 46 __ STA T0 + 0 
0d47 : 20 cb 0d JSR $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
0d4a : a5 47 __ LDA T1 + 0 
0d4c : c5 46 __ CMP T0 + 0 
0d4e : f0 0d __ BEQ $0d5d ; (mdp_detect_eeprom.s5 + 0)
.s16:
0d50 : a5 48 __ LDA T2 + 0 
0d52 : 8d 03 de STA $de03 
0d55 : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
0d58 : a9 00 __ LDA #$00
.s3:
0d5a : 85 1b __ STA ACCU + 0 
0d5c : 60 __ __ RTS
.s5:
0d5d : 85 10 __ STA P3 
0d5f : a9 7f __ LDA #$7f
0d61 : 85 0e __ STA P1 
0d63 : 8d 01 de STA $de01 
0d66 : ad fe df LDA $dffe 
0d69 : 85 46 __ STA T0 + 0 
0d6b : 20 cb 0d JSR $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
0d6e : a5 46 __ LDA T0 + 0 
0d70 : 85 10 __ STA P3 
0d72 : a9 1f __ LDA #$1f
0d74 : 8d 01 de STA $de01 
0d77 : ad fe df LDA $dffe 
0d7a : 85 49 __ STA T3 + 0 
0d7c : 20 cb 0d JSR $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
0d7f : a5 49 __ LDA T3 + 0 
0d81 : c5 47 __ CMP T1 + 0 
0d83 : d0 04 __ BNE $0d89 ; (mdp_detect_eeprom.s6 + 0)
.s15:
0d85 : a9 08 __ LDA #$08
0d87 : d0 02 __ BNE $0d8b ; (mdp_detect_eeprom.s7 + 0)
.s6:
0d89 : a9 20 __ LDA #$20
.s7:
0d8b : a0 00 __ LDY #$00
0d8d : 91 11 __ STA (P4),y ; (detected_size_kb + 0)
0d8f : a5 48 __ LDA T2 + 0 
0d91 : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
0d94 : b1 11 __ LDA (P4),y ; (detected_size_kb + 0)
0d96 : c9 20 __ CMP #$20
0d98 : d0 04 __ BNE $0d9e ; (mdp_detect_eeprom.s8 + 0)
.s14:
0d9a : a9 7f __ LDA #$7f
0d9c : d0 02 __ BNE $0da0 ; (mdp_detect_eeprom.s9 + 0)
.s8:
0d9e : a9 1f __ LDA #$1f
.s9:
0da0 : 8d 01 de STA $de01 
0da3 : ad fe df LDA $dffe 
0da6 : c9 ca __ CMP #$ca
0da8 : d0 0b __ BNE $0db5 ; (mdp_detect_eeprom.s10 + 0)
.s12:
0daa : ad ff df LDA $dfff 
0dad : c9 f1 __ CMP #$f1
0daf : d0 04 __ BNE $0db5 ; (mdp_detect_eeprom.s10 + 0)
.s13:
0db1 : a9 01 __ LDA #$01
0db3 : d0 02 __ BNE $0db7 ; (mdp_detect_eeprom.s11 + 0)
.s10:
0db5 : a9 02 __ LDA #$02
.s11:
0db7 : a6 48 __ LDX T2 + 0 
0db9 : 8e 03 de STX $de03 
0dbc : 4c 5a 0d JMP $0d5a ; (mdp_detect_eeprom.s3 + 0)
--------------------------------------------------------------------
mdp_eeprom_enable: ; mdp_eeprom_enable()->void
; 194, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0dbf : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
0dc2 : 29 df __ AND #$df
0dc4 : 8d 03 de STA $de03 
0dc7 : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
.s3:
0dca : 60 __ __ RTS
--------------------------------------------------------------------
mdp_eeprom_write_byte: ; mdp_eeprom_write_byte(u8,u8,u8)->bool
; 218, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0dcb : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
0dce : a5 0e __ LDA P1 ; (page + 0)
0dd0 : 8d 01 de STA $de01 
0dd3 : a5 10 __ LDA P3 ; (value + 0)
0dd5 : a6 0f __ LDX P2 ; (offset + 0)
0dd7 : 86 43 __ STX T1 + 0 
0dd9 : 9d 00 df STA $df00,x 
0ddc : 29 80 __ AND #$80
0dde : 85 44 __ STA T2 + 0 
0de0 : a9 28 __ LDA #$28
0de2 : 85 45 __ STA T3 + 0 
.l5:
0de4 : a6 43 __ LDX T1 + 0 
0de6 : bd 00 df LDA $df00,x 
0de9 : 29 80 __ AND #$80
0deb : c5 44 __ CMP T2 + 0 
0ded : f0 0c __ BEQ $0dfb ; (mdp_eeprom_write_byte.s8 + 0)
.s6:
0def : 20 ff 0d JSR $0dff ; (delay_0_5ms.s4 + 0)
0df2 : c6 45 __ DEC T3 + 0 
0df4 : d0 ee __ BNE $0de4 ; (mdp_eeprom_write_byte.l5 + 0)
.s7:
0df6 : a9 00 __ LDA #$00
.s3:
0df8 : 85 1b __ STA ACCU + 0 
0dfa : 60 __ __ RTS
.s8:
0dfb : a9 01 __ LDA #$01
0dfd : d0 f9 __ BNE $0df8 ; (mdp_eeprom_write_byte.s3 + 0)
--------------------------------------------------------------------
delay_0_5ms: ; delay_0_5ms()->void
; 207, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0dff : 8a __ __ TXA
0e00 : a2 5f __ LDX #$5f
0e02 : ca __ __ DEX
0e03 : d0 fd __ BNE $0e02 ; (delay_0_5ms.s4 + 3)
0e05 : aa __ __ TAX
.s3:
0e06 : 60 __ __ RTS
--------------------------------------------------------------------
0e07 : __ __ __ BYT 45 45 50 52 4f 4d 20 44 41 20 49 4e 49 5a 49 41 : EEPROM DA INIZIA
0e17 : __ __ __ BYT 4c 49 5a 5a 41 52 45 2e 20 49 4e 49 54 3f 20 59 : LIZZARE. INIT? Y
0e27 : __ __ __ BYT 2f 4e 00                                        : /N.
--------------------------------------------------------------------
mdp_eeprom_write_signature: ; mdp_eeprom_write_signature(u8)->void
; 347, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0e2a : a9 fe __ LDA #$fe
0e2c : 85 0f __ STA P2 
0e2e : a9 ca __ LDA #$ca
0e30 : 85 10 __ STA P3 
0e32 : a5 11 __ LDA P4 ; (size_kb + 0)
0e34 : c9 20 __ CMP #$20
0e36 : d0 04 __ BNE $0e3c ; (mdp_eeprom_write_signature.s5 + 0)
.s7:
0e38 : a9 7f __ LDA #$7f
0e3a : d0 02 __ BNE $0e3e ; (mdp_eeprom_write_signature.s6 + 0)
.s5:
0e3c : a9 1f __ LDA #$1f
.s6:
0e3e : 85 0e __ STA P1 
0e40 : 20 cb 0d JSR $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
0e43 : e6 0f __ INC P2 
0e45 : a9 f1 __ LDA #$f1
0e47 : 85 10 __ STA P3 
0e49 : 4c cb 0d JMP $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
--------------------------------------------------------------------
0e4c : __ __ __ BYT 45 45 50 52 4f 4d 20 49 4e 49 5a 49 41 4c 49 5a : EEPROM INIZIALIZ
0e5c : __ __ __ BYT 5a 41 54 41 21 20 20 20 20 20 20 20 20 20 20 20 : ZATA!           
0e6c : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
draw_main_menu: ; draw_main_menu()->void
;2222, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0e6d : a9 0b __ LDA #$0b
0e6f : 85 18 __ STA P11 
0e71 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
0e74 : a9 03 __ LDA #$03
0e76 : 85 16 __ STA P9 
0e78 : a9 07 __ LDA #$07
0e7a : 85 17 __ STA P10 
0e7c : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
0e7f : f0 03 __ BEQ $0e84 ; (draw_main_menu.s5 + 0)
0e81 : 4c 50 0f JMP $0f50 ; (draw_main_menu.s16 + 0)
.s5:
0e84 : a9 ed __ LDA #$ed
0e86 : 85 14 __ STA P7 
0e88 : a9 0c __ LDA #$0c
0e8a : 85 15 __ STA P8 
0e8c : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
0e8f : ad ff 27 LDA $27ff ; (eeprom_status + 0)
0e92 : d0 16 __ BNE $0eaa ; (draw_main_menu.s9 + 0)
.s6:
0e94 : a9 05 __ LDA #$05
0e96 : 85 16 __ STA P9 
0e98 : a9 10 __ LDA #$10
0e9a : 85 15 __ STA P8 
0e9c : a9 02 __ LDA #$02
0e9e : 85 17 __ STA P10 
0ea0 : a9 5e __ LDA #$5e
0ea2 : 85 14 __ STA P7 
0ea4 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
0ea7 : 4c f1 0e JMP $0ef1 ; (draw_main_menu.s7 + 0)
.s9:
0eaa : a9 05 __ LDA #$05
0eac : 85 11 __ STA P4 
0eae : 85 12 __ STA P5 
0eb0 : a9 0d __ LDA #$0d
0eb2 : 85 13 __ STA P6 
0eb4 : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
0eb7 : c9 20 __ CMP #$20
0eb9 : f0 07 __ BEQ $0ec2 ; (draw_main_menu.s15 + 0)
.s10:
0ebb : a9 10 __ LDA #$10
0ebd : a0 89 __ LDY #$89
0ebf : 4c c6 0e JMP $0ec6 ; (draw_main_menu.s11 + 0)
.s15:
0ec2 : a9 10 __ LDA #$10
0ec4 : a0 73 __ LDY #$73
.s11:
0ec6 : 84 0f __ STY P2 
0ec8 : 85 10 __ STA P3 
0eca : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0ecd : ae ff 27 LDX $27ff ; (eeprom_status + 0)
0ed0 : ca __ __ DEX
0ed1 : f0 0b __ BEQ $0ede ; (draw_main_menu.s14 + 0)
.s12:
0ed3 : a9 07 __ LDA #$07
0ed5 : 85 13 __ STA P6 
0ed7 : a9 10 __ LDA #$10
0ed9 : a0 0e __ LDY #$0e
0edb : 4c e6 0e JMP $0ee6 ; (draw_main_menu.s13 + 0)
.s14:
0ede : a9 05 __ LDA #$05
0ee0 : 85 13 __ STA P6 
0ee2 : a9 10 __ LDA #$10
0ee4 : a0 00 __ LDY #$00
.s13:
0ee6 : 84 0f __ STY P2 
0ee8 : 85 10 __ STA P3 
0eea : a9 1b __ LDA #$1b
0eec : 85 12 __ STA P5 
0eee : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
.s7:
0ef1 : a9 09 __ LDA #$09
0ef3 : 85 11 __ STA P4 
0ef5 : a9 10 __ LDA #$10
0ef7 : 85 10 __ STA P3 
0ef9 : a9 0a __ LDA #$0a
0efb : 85 12 __ STA P5 
0efd : a9 01 __ LDA #$01
0eff : 85 13 __ STA P6 
0f01 : a9 9e __ LDA #$9e
0f03 : 85 0f __ STA P2 
0f05 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0f08 : a9 b0 __ LDA #$b0
0f0a : 85 0f __ STA P2 
0f0c : a9 10 __ LDA #$10
0f0e : 85 10 __ STA P3 
0f10 : a9 10 __ LDA #$10
0f12 : a0 c7 __ LDY #$c7
.s8:
0f14 : 84 49 __ STY T0 + 0 
0f16 : 85 4a __ STA T0 + 1 
0f18 : a9 0b __ LDA #$0b
0f1a : 85 11 __ STA P4 
0f1c : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0f1f : a5 49 __ LDA T0 + 0 
0f21 : 85 0f __ STA P2 
0f23 : a5 4a __ LDA T0 + 1 
0f25 : 85 10 __ STA P3 
0f27 : a9 0d __ LDA #$0d
0f29 : 85 11 __ STA P4 
0f2b : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0f2e : a9 0f __ LDA #$0f
0f30 : 85 11 __ STA P4 
0f32 : a9 10 __ LDA #$10
0f34 : 85 10 __ STA P3 
0f36 : a9 e3 __ LDA #$e3
0f38 : 85 0f __ STA P2 
0f3a : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0f3d : a9 17 __ LDA #$17
0f3f : 85 16 __ STA P9 
0f41 : a9 11 __ LDA #$11
0f43 : 85 15 __ STA P8 
0f45 : a9 0d __ LDA #$0d
0f47 : 85 17 __ STA P10 
0f49 : a9 00 __ LDA #$00
0f4b : 85 14 __ STA P7 
0f4d : 4c 7e 0a JMP $0a7e ; (print_centered.s4 + 0)
.s16:
0f50 : a9 ef __ LDA #$ef
0f52 : 85 14 __ STA P7 
0f54 : a9 0b __ LDA #$0b
0f56 : 85 15 __ STA P8 
0f58 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
0f5b : ad ff 18 LDA $18ff ; (sram_status + 0)
0f5e : d0 16 __ BNE $0f76 ; (draw_main_menu.s19 + 0)
.s17:
0f60 : a9 05 __ LDA #$05
0f62 : 85 16 __ STA P9 
0f64 : a9 0f __ LDA #$0f
0f66 : 85 15 __ STA P8 
0f68 : a9 02 __ LDA #$02
0f6a : 85 17 __ STA P10 
0f6c : a9 d5 __ LDA #$d5
0f6e : 85 14 __ STA P7 
0f70 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
0f73 : 4c af 0f JMP $0faf ; (draw_main_menu.s18 + 0)
.s19:
0f76 : a9 05 __ LDA #$05
0f78 : 85 11 __ STA P4 
0f7a : 85 12 __ STA P5 
0f7c : a9 0d __ LDA #$0d
0f7e : 85 13 __ STA P6 
0f80 : a9 0f __ LDA #$0f
0f82 : 85 10 __ STA P3 
0f84 : a9 e8 __ LDA #$e8
0f86 : 85 0f __ STA P2 
0f88 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0f8b : a9 15 __ LDA #$15
0f8d : 85 12 __ STA P5 
0f8f : ae ff 18 LDX $18ff ; (sram_status + 0)
0f92 : ca __ __ DEX
0f93 : f0 0b __ BEQ $0fa0 ; (draw_main_menu.s22 + 0)
.s20:
0f95 : a9 07 __ LDA #$07
0f97 : 85 13 __ STA P6 
0f99 : a9 10 __ LDA #$10
0f9b : a0 0e __ LDY #$0e
0f9d : 4c a8 0f JMP $0fa8 ; (draw_main_menu.s21 + 0)
.s22:
0fa0 : a9 05 __ LDA #$05
0fa2 : 85 13 __ STA P6 
0fa4 : a9 10 __ LDA #$10
0fa6 : a0 00 __ LDY #$00
.s21:
0fa8 : 84 0f __ STY P2 
0faa : 85 10 __ STA P3 
0fac : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
.s18:
0faf : a9 09 __ LDA #$09
0fb1 : 85 11 __ STA P4 
0fb3 : a9 10 __ LDA #$10
0fb5 : 85 10 __ STA P3 
0fb7 : a9 0a __ LDA #$0a
0fb9 : 85 12 __ STA P5 
0fbb : a9 01 __ LDA #$01
0fbd : 85 13 __ STA P6 
0fbf : a9 1f __ LDA #$1f
0fc1 : 85 0f __ STA P2 
0fc3 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0fc6 : a9 2f __ LDA #$2f
0fc8 : 85 0f __ STA P2 
0fca : a9 10 __ LDA #$10
0fcc : 85 10 __ STA P3 
0fce : a9 10 __ LDA #$10
0fd0 : a0 44 __ LDY #$44
0fd2 : 4c 14 0f JMP $0f14 ; (draw_main_menu.s8 + 0)
--------------------------------------------------------------------
0fd5 : __ __ __ BYT 53 52 41 4d 3a 20 4e 4f 4e 20 52 49 4c 45 56 41 : SRAM: NON RILEVA
0fe5 : __ __ __ BYT 54 41 00                                        : TA.
--------------------------------------------------------------------
0fe8 : __ __ __ BYT 53 52 41 4d 3a 20 50 52 45 53 45 4e 54 45 00    : SRAM: PRESENTE.
--------------------------------------------------------------------
0ff7 : __ __ __ BYT 53 52 41 4d 3a 00                               : SRAM:.
--------------------------------------------------------------------
0ffd : __ __ __ BYT 3e 00                                           : >.
--------------------------------------------------------------------
spentry:
0fff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1000 : __ __ __ BYT 49 4e 49 5a 49 41 4c 49 5a 5a 41 54 41 00       : INIZIALIZZATA.
--------------------------------------------------------------------
100e : __ __ __ BYT 44 41 20 49 4e 49 5a 49 41 4c 49 5a 5a 41 52 45 : DA INIZIALIZZARE
101e : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
101f : __ __ __ BYT 46 31 3a 20 45 44 49 54 4f 52 20 53 52 41 4d 00 : F1: EDITOR SRAM.
--------------------------------------------------------------------
102f : __ __ __ BYT 46 33 3a 20 44 49 41 47 4e 4f 53 54 49 43 41 20 : F3: DIAGNOSTICA 
103f : __ __ __ BYT 53 52 41 4d 00                                  : SRAM.
--------------------------------------------------------------------
1044 : __ __ __ BYT 46 35 3a 20 42 41 43 4b 55 50 20 53 52 41 4d 20 : F5: BACKUP SRAM 
1054 : __ __ __ BYT 53 55 20 46 4c 4f 50 50 59 00                   : SU FLOPPY.
--------------------------------------------------------------------
105e : __ __ __ BYT 45 45 50 52 4f 4d 3a 20 4e 4f 4e 20 52 49 4c 45 : EEPROM: NON RILE
106e : __ __ __ BYT 56 41 54 41 00                                  : VATA.
--------------------------------------------------------------------
1073 : __ __ __ BYT 45 45 50 52 4f 4d 20 33 32 4b 42 3a 20 50 52 45 : EEPROM 32KB: PRE
1083 : __ __ __ BYT 53 45 4e 54 45 00                               : SENTE.
--------------------------------------------------------------------
1089 : __ __ __ BYT 45 45 50 52 4f 4d 20 38 4b 42 3a 20 50 52 45 53 : EEPROM 8KB: PRES
1099 : __ __ __ BYT 45 4e 54 45 00                                  : ENTE.
--------------------------------------------------------------------
109e : __ __ __ BYT 46 31 3a 20 45 44 49 54 4f 52 20 45 45 50 52 4f : F1: EDITOR EEPRO
10ae : __ __ __ BYT 4d 00                                           : M.
--------------------------------------------------------------------
10b0 : __ __ __ BYT 46 33 3a 20 44 49 41 47 4e 4f 53 54 49 43 41 20 : F3: DIAGNOSTICA 
10c0 : __ __ __ BYT 45 45 50 52 4f 4d 00                            : EEPROM.
--------------------------------------------------------------------
10c7 : __ __ __ BYT 46 35 3a 20 42 41 43 4b 55 50 20 45 45 50 52 4f : F5: BACKUP EEPRO
10d7 : __ __ __ BYT 4d 20 53 55 20 46 4c 4f 50 50 59 00             : M SU FLOPPY.
--------------------------------------------------------------------
10e3 : __ __ __ BYT 46 37 3a 20 54 4f 47 47 4c 45 20 53 52 41 4d 2f : F7: TOGGLE SRAM/
10f3 : __ __ __ BYT 45 45 50 52 4f 4d 00                            : EEPROM.
--------------------------------------------------------------------
10fa : __ __ __ BYT 4f 4e 20 00                                     : ON .
--------------------------------------------------------------------
10fe : __ __ __ BYT 20 00                                           :  .
--------------------------------------------------------------------
1100 : __ __ __ BYT 50 52 45 4d 49 20 28 58 29 20 50 45 52 20 55 53 : PREMI (X) PER US
1110 : __ __ __ BYT 43 49 52 45 00                                  : CIRE.
--------------------------------------------------------------------
show_sram_editor_screen: ; show_sram_editor_screen()->void
;1299, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
1115 : a2 03 __ LDX #$03
1117 : b5 53 __ LDA T1 + 0,x 
1119 : 9d e8 9f STA $9fe8,x ; (show_sram_editor_screen@stack + 0)
111c : ca __ __ DEX
111d : 10 f8 __ BPL $1117 ; (show_sram_editor_screen.s1 + 2)
.s4:
111f : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
1122 : 85 54 __ STA T3 + 0 
1124 : d0 06 __ BNE $112c ; (show_sram_editor_screen.s79 + 0)
.s5:
1126 : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
1129 : 4c 2f 11 JMP $112f ; (show_sram_editor_screen.s6 + 0)
.s79:
112c : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
.s6:
112f : a9 00 __ LDA #$00
1131 : 8d 01 de STA $de01 
1134 : 85 55 __ STA T4 + 0 
1136 : a9 0b __ LDA #$0b
1138 : 85 18 __ STA P11 
.l7:
113a : a9 00 __ LDA #$00
.l81:
113c : 85 56 __ STA T5 + 0 
.l8:
113e : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
1141 : a9 03 __ LDA #$03
1143 : 85 16 __ STA P9 
1145 : a9 07 __ LDA #$07
1147 : 85 17 __ STA P10 
1149 : a5 54 __ LDA T3 + 0 
114b : d0 07 __ BNE $1154 ; (show_sram_editor_screen.s78 + 0)
.s9:
114d : a9 13 __ LDA #$13
114f : a0 e5 __ LDY #$e5
1151 : 4c 58 11 JMP $1158 ; (show_sram_editor_screen.s10 + 0)
.s78:
1154 : a9 13 __ LDA #$13
1156 : a0 d2 __ LDY #$d2
.s10:
1158 : 84 14 __ STY P7 
115a : 85 15 __ STA P8 
115c : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
115f : a5 55 __ LDA T4 + 0 
1161 : 85 14 __ STA P7 
1163 : a5 56 __ LDA T5 + 0 
1165 : 85 15 __ STA P8 
1167 : 20 fa 13 JSR $13fa ; (draw_sram_status_bar.s4 + 0)
116a : a5 15 __ LDA P8 
116c : 85 14 __ STA P7 
116e : 20 d5 15 JSR $15d5 ; (draw_sram_page_view.s1 + 0)
1171 : a9 14 __ LDA #$14
1173 : 85 11 __ STA P4 
1175 : a9 01 __ LDA #$01
1177 : 85 12 __ STA P5 
1179 : a9 0d __ LDA #$0d
117b : 85 13 __ STA P6 
117d : a5 54 __ LDA T3 + 0 
117f : d0 07 __ BNE $1188 ; (show_sram_editor_screen.s77 + 0)
.s11:
1181 : a9 17 __ LDA #$17
1183 : a0 47 __ LDY #$47
1185 : 4c 8c 11 JMP $118c ; (show_sram_editor_screen.s12 + 0)
.s77:
1188 : a9 17 __ LDA #$17
118a : a0 27 __ LDY #$27
.s12:
118c : 84 0f __ STY P2 
118e : 85 10 __ STA P3 
1190 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1193 : e6 11 __ INC P4 
1195 : a9 05 __ LDA #$05
1197 : 85 13 __ STA P6 
1199 : a9 17 __ LDA #$17
119b : 85 10 __ STA P3 
119d : a9 5f __ LDA #$5f
119f : 85 0f __ STA P2 
11a1 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
11a4 : a9 17 __ LDA #$17
11a6 : 85 0d __ STA P0 
11a8 : a9 0b __ LDA #$0b
11aa : 85 0e __ STA P1 
11ac : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
.l13:
11af : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
11b2 : c9 6d __ CMP #$6d
11b4 : d0 03 __ BNE $11b9 ; (show_sram_editor_screen.s14 + 0)
11b6 : 4c ae 13 JMP $13ae ; (show_sram_editor_screen.s74 + 0)
.s14:
11b9 : c9 4d __ CMP #$4d
11bb : f0 f9 __ BEQ $11b6 ; (show_sram_editor_screen.l13 + 7)
.s15:
11bd : c9 65 __ CMP #$65
11bf : d0 03 __ BNE $11c4 ; (show_sram_editor_screen.s16 + 0)
11c1 : 4c 9c 13 JMP $139c ; (show_sram_editor_screen.s71 + 0)
.s16:
11c4 : c9 45 __ CMP #$45
11c6 : f0 f9 __ BEQ $11c1 ; (show_sram_editor_screen.s15 + 4)
.s17:
11c8 : a8 __ __ TAY
11c9 : c0 62 __ CPY #$62
11cb : d0 03 __ BNE $11d0 ; (show_sram_editor_screen.s18 + 0)
11cd : 4c 85 13 JMP $1385 ; (show_sram_editor_screen.s69 + 0)
.s18:
11d0 : c0 42 __ CPY #$42
11d2 : f0 f9 __ BEQ $11cd ; (show_sram_editor_screen.s17 + 5)
.s19:
11d4 : c0 70 __ CPY #$70
11d6 : d0 03 __ BNE $11db ; (show_sram_editor_screen.s20 + 0)
11d8 : 4c 21 13 JMP $1321 ; (show_sram_editor_screen.s57 + 0)
.s20:
11db : c0 50 __ CPY #$50
11dd : f0 f9 __ BEQ $11d8 ; (show_sram_editor_screen.s19 + 4)
.s21:
11df : c0 77 __ CPY #$77
11e1 : f0 7a __ BEQ $125d ; (show_sram_editor_screen.s46 + 0)
.s22:
11e3 : c0 57 __ CPY #$57
11e5 : f0 76 __ BEQ $125d ; (show_sram_editor_screen.s46 + 0)
.s23:
11e7 : c0 2d __ CPY #$2d
11e9 : f0 62 __ BEQ $124d ; (show_sram_editor_screen.s43 + 0)
.s24:
11eb : c0 85 __ CPY #$85
11ed : f0 5e __ BEQ $124d ; (show_sram_editor_screen.s43 + 0)
.s25:
11ef : c0 2b __ CPY #$2b
11f1 : f0 04 __ BEQ $11f7 ; (show_sram_editor_screen.s41 + 0)
.s26:
11f3 : c0 86 __ CPY #$86
11f5 : d0 0e __ BNE $1205 ; (show_sram_editor_screen.s27 + 0)
.s41:
11f7 : a5 56 __ LDA T5 + 0 
11f9 : c9 a0 __ CMP #$a0
11fb : 90 03 __ BCC $1200 ; (show_sram_editor_screen.s42 + 0)
11fd : 4c 3a 11 JMP $113a ; (show_sram_editor_screen.l7 + 0)
.s42:
1200 : 69 08 __ ADC #$08
1202 : 4c 3c 11 JMP $113c ; (show_sram_editor_screen.l81 + 0)
.s27:
1205 : a5 54 __ LDA T3 + 0 
1207 : f0 04 __ BEQ $120d ; (show_sram_editor_screen.s28 + 0)
.s40:
1209 : a9 ff __ LDA #$ff
120b : d0 0d __ BNE $121a ; (show_sram_editor_screen.s30 + 0)
.s28:
120d : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
1210 : c9 20 __ CMP #$20
1212 : d0 04 __ BNE $1218 ; (show_sram_editor_screen.s29 + 0)
.s39:
1214 : a9 7f __ LDA #$7f
1216 : d0 02 __ BNE $121a ; (show_sram_editor_screen.s30 + 0)
.s29:
1218 : a9 1f __ LDA #$1f
.s30:
121a : 85 43 __ STA T0 + 0 
121c : 98 __ __ TYA
121d : c0 87 __ CPY #$87
121f : f0 1e __ BEQ $123f ; (show_sram_editor_screen.s36 + 0)
.s31:
1221 : c9 88 __ CMP #$88
1223 : d0 8a __ BNE $11af ; (show_sram_editor_screen.l13 + 0)
.s32:
1225 : a5 55 __ LDA T4 + 0 
1227 : c5 43 __ CMP T0 + 0 
1229 : 90 0a __ BCC $1235 ; (show_sram_editor_screen.s34 + 0)
.s33:
122b : a9 00 __ LDA #$00
.s82:
122d : 8d 01 de STA $de01 
1230 : 85 55 __ STA T4 + 0 
1232 : 4c 3e 11 JMP $113e ; (show_sram_editor_screen.l8 + 0)
.s34:
1235 : e6 55 __ INC T4 + 0 
.s35:
1237 : a5 55 __ LDA T4 + 0 
1239 : 8d 01 de STA $de01 
123c : 4c 3e 11 JMP $113e ; (show_sram_editor_screen.l8 + 0)
.s36:
123f : a5 55 __ LDA T4 + 0 
1241 : f0 05 __ BEQ $1248 ; (show_sram_editor_screen.s37 + 0)
.s38:
1243 : c6 55 __ DEC T4 + 0 
1245 : 4c 37 12 JMP $1237 ; (show_sram_editor_screen.s35 + 0)
.s37:
1248 : a5 43 __ LDA T0 + 0 
124a : 4c 2d 12 JMP $122d ; (show_sram_editor_screen.s82 + 0)
.s43:
124d : a5 56 __ LDA T5 + 0 
124f : c9 08 __ CMP #$08
1251 : b0 05 __ BCS $1258 ; (show_sram_editor_screen.s45 + 0)
.s44:
1253 : a9 a0 __ LDA #$a0
1255 : 4c 3c 11 JMP $113c ; (show_sram_editor_screen.l81 + 0)
.s45:
1258 : e9 08 __ SBC #$08
125a : 4c 3c 11 JMP $113c ; (show_sram_editor_screen.l81 + 0)
.s46:
125d : a5 54 __ LDA T3 + 0 
125f : f0 03 __ BEQ $1264 ; (show_sram_editor_screen.s47 + 0)
1261 : 4c 15 13 JMP $1315 ; (show_sram_editor_screen.s56 + 0)
.s47:
1264 : 20 a4 15 JSR $15a4 ; (mdp_sram_is_enabled.s4 + 0)
1267 : aa __ __ TAX
1268 : f0 25 __ BEQ $128f ; (show_sram_editor_screen.s52 + 0)
.s48:
126a : a9 17 __ LDA #$17
126c : 85 11 __ STA P4 
126e : a9 01 __ LDA #$01
1270 : 85 12 __ STA P5 
1272 : a9 02 __ LDA #$02
1274 : 85 13 __ STA P6 
1276 : a5 54 __ LDA T3 + 0 
1278 : d0 07 __ BNE $1281 ; (show_sram_editor_screen.s51 + 0)
.s49:
127a : a9 19 __ LDA #$19
127c : a0 15 __ LDY #$15
127e : 4c 85 12 JMP $1285 ; (show_sram_editor_screen.s50 + 0)
.s51:
1281 : a9 19 __ LDA #$19
1283 : a0 00 __ LDY #$00
.s50:
1285 : 84 0f __ STY P2 
1287 : 85 10 __ STA P3 
1289 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
128c : 4c 3e 11 JMP $113e ; (show_sram_editor_screen.l8 + 0)
.s52:
128f : a9 17 __ LDA #$17
1291 : 85 11 __ STA P4 
1293 : a9 19 __ LDA #$19
1295 : 85 10 __ STA P3 
1297 : a9 01 __ LDA #$01
1299 : 85 12 __ STA P5 
129b : a9 03 __ LDA #$03
129d : 85 13 __ STA P6 
129f : a9 2a __ LDA #$2a
12a1 : 85 0f __ STA P2 
12a3 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
12a6 : a9 17 __ LDA #$17
12a8 : 85 14 __ STA P7 
12aa : a9 15 __ LDA #$15
12ac : 85 15 __ STA P8 
12ae : 20 d9 17 JSR $17d9 ; (prompt_hex_byte.s4 + 0)
12b1 : a5 1b __ LDA ACCU + 0 
12b3 : 85 53 __ STA T1 + 0 
12b5 : a9 17 __ LDA #$17
12b7 : 85 0d __ STA P0 
12b9 : a9 0b __ LDA #$0b
12bb : 85 0e __ STA P1 
12bd : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
12c0 : a9 17 __ LDA #$17
12c2 : 85 11 __ STA P4 
12c4 : a9 19 __ LDA #$19
12c6 : 85 10 __ STA P3 
12c8 : a9 01 __ LDA #$01
12ca : 85 12 __ STA P5 
12cc : a9 03 __ LDA #$03
12ce : 85 13 __ STA P6 
12d0 : a9 3e __ LDA #$3e
12d2 : 85 0f __ STA P2 
12d4 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
12d7 : 20 d9 17 JSR $17d9 ; (prompt_hex_byte.s4 + 0)
12da : a5 54 __ LDA T3 + 0 
12dc : d0 12 __ BNE $12f0 ; (show_sram_editor_screen.s55 + 0)
.s53:
12de : a5 55 __ LDA T4 + 0 
12e0 : 85 0e __ STA P1 
12e2 : a5 53 __ LDA T1 + 0 
12e4 : 85 0f __ STA P2 
12e6 : a5 1b __ LDA ACCU + 0 
12e8 : 85 10 __ STA P3 
12ea : 20 cb 0d JSR $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
12ed : 4c f7 12 JMP $12f7 ; (show_sram_editor_screen.s54 + 0)
.s55:
12f0 : a5 1b __ LDA ACCU + 0 
12f2 : a6 53 __ LDX T1 + 0 
12f4 : 9d 00 df STA $df00,x 
.s54:
12f7 : a9 17 __ LDA #$17
12f9 : 85 0d __ STA P0 
12fb : a9 0b __ LDA #$0b
12fd : 85 0e __ STA P1 
12ff : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
1302 : a9 17 __ LDA #$17
1304 : 85 11 __ STA P4 
1306 : a9 01 __ LDA #$01
1308 : 85 12 __ STA P5 
130a : a9 0d __ LDA #$0d
130c : 85 13 __ STA P6 
130e : a9 19 __ LDA #$19
1310 : a0 52 __ LDY #$52
1312 : 4c 85 12 JMP $1285 ; (show_sram_editor_screen.s50 + 0)
.s56:
1315 : 20 a4 15 JSR $15a4 ; (mdp_sram_is_enabled.s4 + 0)
1318 : aa __ __ TAX
1319 : f0 03 __ BEQ $131e ; (show_sram_editor_screen.s56 + 9)
131b : 4c 8f 12 JMP $128f ; (show_sram_editor_screen.s52 + 0)
131e : 4c 6a 12 JMP $126a ; (show_sram_editor_screen.s48 + 0)
.s57:
1321 : a9 01 __ LDA #$01
1323 : 85 12 __ STA P5 
1325 : a9 03 __ LDA #$03
1327 : 85 13 __ STA P6 
1329 : a5 54 __ LDA T3 + 0 
132b : f0 07 __ BEQ $1334 ; (show_sram_editor_screen.s58 + 0)
.s68:
132d : a9 17 __ LDA #$17
132f : a0 9d __ LDY #$9d
1331 : 4c 46 13 JMP $1346 ; (show_sram_editor_screen.s60 + 0)
.s58:
1334 : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
1337 : c9 20 __ CMP #$20
1339 : f0 07 __ BEQ $1342 ; (show_sram_editor_screen.s67 + 0)
.s59:
133b : a9 17 __ LDA #$17
133d : a0 c5 __ LDY #$c5
133f : 4c 46 13 JMP $1346 ; (show_sram_editor_screen.s60 + 0)
.s67:
1342 : a9 17 __ LDA #$17
1344 : a0 b1 __ LDY #$b1
.s60:
1346 : 84 0f __ STY P2 
1348 : 85 10 __ STA P3 
134a : a9 17 __ LDA #$17
134c : 85 11 __ STA P4 
134e : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1351 : a9 17 __ LDA #$17
1353 : 85 14 __ STA P7 
1355 : a9 15 __ LDA #$15
1357 : 85 15 __ STA P8 
1359 : 20 d9 17 JSR $17d9 ; (prompt_hex_byte.s4 + 0)
135c : a5 1b __ LDA ACCU + 0 
135e : 85 55 __ STA T4 + 0 
1360 : a5 54 __ LDA T3 + 0 
1362 : f0 04 __ BEQ $1368 ; (show_sram_editor_screen.s61 + 0)
.s66:
1364 : a9 ff __ LDA #$ff
1366 : d0 0d __ BNE $1375 ; (show_sram_editor_screen.s80 + 0)
.s61:
1368 : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
136b : c9 20 __ CMP #$20
136d : d0 04 __ BNE $1373 ; (show_sram_editor_screen.s62 + 0)
.s65:
136f : a9 7f __ LDA #$7f
1371 : d0 02 __ BNE $1375 ; (show_sram_editor_screen.s80 + 0)
.s62:
1373 : a9 1f __ LDA #$1f
.s80:
1375 : c5 1b __ CMP ACCU + 0 
1377 : b0 04 __ BCS $137d ; (show_sram_editor_screen.s83 + 0)
.s64:
1379 : 85 55 __ STA T4 + 0 
137b : 90 02 __ BCC $137f ; (show_sram_editor_screen.s63 + 0)
.s83:
137d : a5 1b __ LDA ACCU + 0 
.s63:
137f : 8d 01 de STA $de01 
1382 : 4c 3a 11 JMP $113a ; (show_sram_editor_screen.l7 + 0)
.s69:
1385 : a5 54 __ LDA T3 + 0 
1387 : d0 03 __ BNE $138c ; (show_sram_editor_screen.s70 + 0)
1389 : 4c db 11 JMP $11db ; (show_sram_editor_screen.s20 + 0)
.s70:
138c : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
138f : 4a __ __ LSR
1390 : a9 00 __ LDA #$00
1392 : 69 ff __ ADC #$ff
1394 : 29 01 __ AND #$01
1396 : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
1399 : 4c 3e 11 JMP $113e ; (show_sram_editor_screen.l8 + 0)
.s71:
139c : 20 a4 15 JSR $15a4 ; (mdp_sram_is_enabled.s4 + 0)
139f : aa __ __ TAX
13a0 : d0 06 __ BNE $13a8 ; (show_sram_editor_screen.s73 + 0)
.s72:
13a2 : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
13a5 : 4c 3e 11 JMP $113e ; (show_sram_editor_screen.l8 + 0)
.s73:
13a8 : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
13ab : 4c 3e 11 JMP $113e ; (show_sram_editor_screen.l8 + 0)
.s74:
13ae : a5 54 __ LDA T3 + 0 
13b0 : d0 06 __ BNE $13b8 ; (show_sram_editor_screen.s76 + 0)
.s75:
13b2 : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
13b5 : 4c bb 13 JMP $13bb ; (show_sram_editor_screen.s3 + 0)
.s76:
13b8 : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
.s3:
13bb : a2 03 __ LDX #$03
13bd : bd e8 9f LDA $9fe8,x ; (show_sram_editor_screen@stack + 0)
13c0 : 95 53 __ STA T1 + 0,x 
13c2 : ca __ __ DEX
13c3 : 10 f8 __ BPL $13bd ; (show_sram_editor_screen.s3 + 2)
13c5 : 60 __ __ RTS
--------------------------------------------------------------------
mdp_sram_enable: ; mdp_sram_enable()->void
;  68, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
13c6 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
13c9 : 09 20 __ ORA #$20
13cb : 8d 03 de STA $de03 
13ce : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
.s3:
13d1 : 60 __ __ RTS
--------------------------------------------------------------------
13d2 : __ __ __ BYT 45 44 49 54 4f 52 20 50 41 47 49 4e 45 20 53 52 : EDITOR PAGINE SR
13e2 : __ __ __ BYT 41 4d 00                                        : AM.
--------------------------------------------------------------------
13e5 : __ __ __ BYT 45 44 49 54 4f 52 20 50 41 47 49 4e 45 20 45 45 : EDITOR PAGINE EE
13f5 : __ __ __ BYT 50 52 4f 4d 00                                  : PROM.
--------------------------------------------------------------------
draw_sram_status_bar: ; draw_sram_status_bar(u8,u8)->void
;1243, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
13fa : a9 05 __ LDA #$05
13fc : 85 0d __ STA P0 
13fe : a9 0b __ LDA #$0b
1400 : 85 0e __ STA P1 
1402 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
1405 : a9 05 __ LDA #$05
1407 : 85 11 __ STA P4 
1409 : a9 00 __ LDA #$00
140b : 85 12 __ STA P5 
140d : a9 03 __ LDA #$03
140f : 85 13 __ STA P6 
1411 : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
1414 : f0 03 __ BEQ $1419 ; (draw_sram_status_bar.s5 + 0)
1416 : 4c c8 14 JMP $14c8 ; (draw_sram_status_bar.s10 + 0)
.s5:
1419 : a9 cd __ LDA #$cd
141b : 85 0f __ STA P2 
141d : a9 15 __ LDA #$15
141f : 85 10 __ STA P3 
1421 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1424 : a9 08 __ LDA #$08
1426 : 85 12 __ STA P5 
1428 : 20 a4 15 JSR $15a4 ; (mdp_sram_is_enabled.s4 + 0)
142b : aa __ __ TAX
142c : d0 0b __ BNE $1439 ; (draw_sram_status_bar.s9 + 0)
.s6:
142e : a9 0d __ LDA #$0d
1430 : 85 13 __ STA P6 
1432 : a9 10 __ LDA #$10
1434 : a0 fa __ LDY #$fa
1436 : 4c 3f 14 JMP $143f ; (draw_sram_status_bar.s7 + 0)
.s9:
1439 : c6 13 __ DEC P6 
143b : a9 15 __ LDA #$15
143d : a0 ae __ LDY #$ae
.s7:
143f : 84 0f __ STY P2 
1441 : 85 10 __ STA P3 
1443 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1446 : a9 0e __ LDA #$0e
1448 : 85 12 __ STA P5 
144a : a9 15 __ LDA #$15
144c : 85 10 __ STA P3 
144e : a9 03 __ LDA #$03
1450 : 85 13 __ STA P6 
1452 : a9 b9 __ LDA #$b9
1454 : 85 0f __ STA P2 
1456 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1459 : a5 14 __ LDA P7 ; (cur_page + 0)
145b : 4a __ __ LSR
145c : 4a __ __ LSR
145d : 4a __ __ LSR
145e : 4a __ __ LSR
145f : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1462 : 8d f3 9f STA $9ff3 ; (pg[0] + 0)
1465 : a5 14 __ LDA P7 ; (cur_page + 0)
1467 : 29 0f __ AND #$0f
1469 : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
146c : 8d f4 9f STA $9ff4 ; (pg[0] + 1)
146f : a9 13 __ LDA #$13
1471 : 85 12 __ STA P5 
1473 : a9 00 __ LDA #$00
1475 : 8d f5 9f STA $9ff5 ; (pg[0] + 2)
1478 : a9 01 __ LDA #$01
147a : 85 13 __ STA P6 
147c : a9 f3 __ LDA #$f3
147e : 85 0f __ STA P2 
1480 : a9 9f __ LDA #$9f
1482 : 85 10 __ STA P3 
1484 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1487 : a9 17 __ LDA #$17
1489 : 85 12 __ STA P5 
148b : a9 15 __ LDA #$15
148d : 85 10 __ STA P3 
148f : a9 03 __ LDA #$03
1491 : 85 13 __ STA P6 
1493 : a9 c8 __ LDA #$c8
1495 : 85 0f __ STA P2 
1497 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
149a : a5 15 __ LDA P8 ; (base_offset + 0)
149c : 4a __ __ LSR
149d : 4a __ __ LSR
149e : 4a __ __ LSR
149f : 4a __ __ LSR
14a0 : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
14a3 : 8d f0 9f STA $9ff0 ; (of[0] + 0)
14a6 : a5 15 __ LDA P8 ; (base_offset + 0)
14a8 : 29 0f __ AND #$0f
14aa : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
14ad : 8d f1 9f STA $9ff1 ; (of[0] + 1)
14b0 : a9 1b __ LDA #$1b
14b2 : 85 12 __ STA P5 
14b4 : a9 00 __ LDA #$00
14b6 : 8d f2 9f STA $9ff2 ; (of[0] + 2)
14b9 : a9 9f __ LDA #$9f
14bb : a0 f0 __ LDY #$f0
.s8:
14bd : 84 0f __ STY P2 
14bf : 85 10 __ STA P3 
14c1 : a9 01 __ LDA #$01
14c3 : 85 13 __ STA P6 
14c5 : 4c 1e 0b JMP $0b1e ; (print_at.s4 + 0)
.s10:
14c8 : a9 f7 __ LDA #$f7
14ca : 85 0f __ STA P2 
14cc : a9 0f __ LDA #$0f
14ce : 85 10 __ STA P3 
14d0 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
14d3 : 20 a4 15 JSR $15a4 ; (mdp_sram_is_enabled.s4 + 0)
14d6 : aa __ __ TAX
14d7 : d0 09 __ BNE $14e2 ; (draw_sram_status_bar.s13 + 0)
.s11:
14d9 : c6 13 __ DEC P6 
14db : a9 15 __ LDA #$15
14dd : a0 ae __ LDY #$ae
14df : 4c ea 14 JMP $14ea ; (draw_sram_status_bar.s12 + 0)
.s13:
14e2 : a9 0d __ LDA #$0d
14e4 : 85 13 __ STA P6 
14e6 : a9 10 __ LDA #$10
14e8 : a0 fa __ LDY #$fa
.s12:
14ea : 84 0f __ STY P2 
14ec : 85 10 __ STA P3 
14ee : a9 05 __ LDA #$05
14f0 : 85 12 __ STA P5 
14f2 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
14f5 : a9 0a __ LDA #$0a
14f7 : 85 12 __ STA P5 
14f9 : a9 15 __ LDA #$15
14fb : 85 10 __ STA P3 
14fd : a9 03 __ LDA #$03
14ff : 85 13 __ STA P6 
1501 : a9 b2 __ LDA #$b2
1503 : 85 0f __ STA P2 
1505 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1508 : a9 10 __ LDA #$10
150a : 85 12 __ STA P5 
150c : a9 01 __ LDA #$01
150e : 85 13 __ STA P6 
1510 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
1513 : 29 01 __ AND #$01
1515 : 09 30 __ ORA #$30
1517 : 8d fc 9f STA $9ffc ; (bank_ch[0] + 0)
151a : a9 00 __ LDA #$00
151c : 8d fd 9f STA $9ffd ; (bank_ch[0] + 1)
151f : a9 fc __ LDA #$fc
1521 : 85 0f __ STA P2 
1523 : a9 9f __ LDA #$9f
1525 : 85 10 __ STA P3 
1527 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
152a : a9 13 __ LDA #$13
152c : 85 12 __ STA P5 
152e : a9 15 __ LDA #$15
1530 : 85 10 __ STA P3 
1532 : a9 03 __ LDA #$03
1534 : 85 13 __ STA P6 
1536 : a9 b9 __ LDA #$b9
1538 : 85 0f __ STA P2 
153a : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
153d : a5 14 __ LDA P7 ; (cur_page + 0)
153f : 4a __ __ LSR
1540 : 4a __ __ LSR
1541 : 4a __ __ LSR
1542 : 4a __ __ LSR
1543 : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1546 : 8d f9 9f STA $9ff9 ; (pg[0] + 0)
1549 : a5 14 __ LDA P7 ; (cur_page + 0)
154b : 29 0f __ AND #$0f
154d : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1550 : 8d fa 9f STA $9ffa ; (pg[0] + 1)
1553 : a9 17 __ LDA #$17
1555 : 85 12 __ STA P5 
1557 : a9 00 __ LDA #$00
1559 : 8d fb 9f STA $9ffb ; (pg[0] + 2)
155c : a9 01 __ LDA #$01
155e : 85 13 __ STA P6 
1560 : a9 f9 __ LDA #$f9
1562 : 85 0f __ STA P2 
1564 : a9 9f __ LDA #$9f
1566 : 85 10 __ STA P3 
1568 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
156b : a9 1b __ LDA #$1b
156d : 85 12 __ STA P5 
156f : a9 15 __ LDA #$15
1571 : 85 10 __ STA P3 
1573 : a9 03 __ LDA #$03
1575 : 85 13 __ STA P6 
1577 : a9 c8 __ LDA #$c8
1579 : 85 0f __ STA P2 
157b : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
157e : a5 15 __ LDA P8 ; (base_offset + 0)
1580 : 4a __ __ LSR
1581 : 4a __ __ LSR
1582 : 4a __ __ LSR
1583 : 4a __ __ LSR
1584 : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1587 : 8d f6 9f STA $9ff6 ; (of[0] + 0)
158a : a5 15 __ LDA P8 ; (base_offset + 0)
158c : 29 0f __ AND #$0f
158e : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1591 : 8d f7 9f STA $9ff7 ; (of[0] + 1)
1594 : a9 1f __ LDA #$1f
1596 : 85 12 __ STA P5 
1598 : a9 00 __ LDA #$00
159a : 8d f8 9f STA $9ff8 ; (of[0] + 2)
159d : a9 9f __ LDA #$9f
159f : a0 f6 __ LDY #$f6
15a1 : 4c bd 14 JMP $14bd ; (draw_sram_status_bar.s8 + 0)
--------------------------------------------------------------------
mdp_sram_is_enabled: ; mdp_sram_is_enabled()->bool
;  80, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
15a4 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
15a7 : 29 20 __ AND #$20
15a9 : f0 02 __ BEQ $15ad ; (mdp_sram_is_enabled.s3 + 0)
.s5:
15ab : a9 01 __ LDA #$01
.s3:
15ad : 60 __ __ RTS
--------------------------------------------------------------------
15ae : __ __ __ BYT 4f 46 46 00                                     : OFF.
--------------------------------------------------------------------
15b2 : __ __ __ BYT 42 41 4e 43 4f 3a 00                            : BANCO:.
--------------------------------------------------------------------
15b9 : __ __ __ BYT 50 41 47 3a 00                                  : PAG:.
--------------------------------------------------------------------
hex_digit: ; hex_digit(u8)->u8
;  97, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
15be : c9 0a __ CMP #$0a
15c0 : b0 03 __ BCS $15c5 ; (hex_digit.s5 + 0)
.s6:
15c2 : 09 30 __ ORA #$30
15c4 : 60 __ __ RTS
.s5:
15c5 : 69 36 __ ADC #$36
.s3:
15c7 : 60 __ __ RTS
--------------------------------------------------------------------
15c8 : __ __ __ BYT 4f 46 46 3a 00                                  : OFF:.
--------------------------------------------------------------------
15cd : __ __ __ BYT 45 45 50 52 4f 4d 3a 00                         : EEPROM:.
--------------------------------------------------------------------
draw_sram_page_view: ; draw_sram_page_view(u8)->void
;1206, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
15d5 : a2 03 __ LDX #$03
15d7 : b5 53 __ LDA T9 + 0,x 
15d9 : 9d ec 9f STA $9fec,x ; (draw_sram_page_view@stack + 0)
15dc : ca __ __ DEX
15dd : 10 f8 __ BPL $15d7 ; (draw_sram_page_view.s1 + 2)
.s4:
15df : a9 00 __ LDA #$00
15e1 : 85 4b __ STA T2 + 0 
15e3 : 85 4c __ STA T3 + 0 
15e5 : 85 4d __ STA T3 + 1 
15e7 : a2 1d __ LDX #$1d
15e9 : 86 4e __ STX T4 + 0 
15eb : a2 01 __ LDX #$01
15ed : 86 4f __ STX T4 + 1 
15ef : a2 07 __ LDX #$07
15f1 : 86 50 __ STX T5 + 0 
.l5:
15f3 : 0a __ __ ASL
15f4 : 0a __ __ ASL
15f5 : 0a __ __ ASL
15f6 : 18 __ __ CLC
15f7 : 65 14 __ ADC P7 ; (base_offset + 0)
15f9 : 85 51 __ STA T7 + 0 
15fb : 4a __ __ LSR
15fc : 4a __ __ LSR
15fd : 4a __ __ LSR
15fe : 4a __ __ LSR
15ff : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1602 : 8d fa 9f STA $9ffa ; (addr_str[0] + 0)
1605 : a5 51 __ LDA T7 + 0 
1607 : 29 0f __ AND #$0f
1609 : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
160c : 8d fb 9f STA $9ffb ; (addr_str[0] + 1)
160f : a5 50 __ LDA T5 + 0 
1611 : 85 11 __ STA P4 
1613 : a9 fa __ LDA #$fa
1615 : 85 0f __ STA P2 
1617 : a9 9f __ LDA #$9f
1619 : 85 10 __ STA P3 
161b : a9 01 __ LDA #$01
161d : 85 12 __ STA P5 
161f : a9 3a __ LDA #$3a
1621 : 8d fc 9f STA $9ffc ; (addr_str[0] + 2)
1624 : a9 0e __ LDA #$0e
1626 : 85 13 __ STA P6 
1628 : a9 00 __ LDA #$00
162a : 8d fd 9f STA $9ffd ; (addr_str[0] + 3)
162d : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1630 : 18 __ __ CLC
1631 : a5 4c __ LDA T3 + 0 
1633 : 69 1d __ ADC #$1d
1635 : 85 53 __ STA T9 + 0 
1637 : a5 4d __ LDA T3 + 1 
1639 : 69 05 __ ADC #$05
163b : 85 54 __ STA T9 + 1 
163d : a9 08 __ LDA #$08
163f : 85 55 __ STA T10 + 0 
1641 : a6 51 __ LDX T7 + 0 
.l6:
1643 : 86 0d __ STX P0 
1645 : 8a __ __ TXA
1646 : 20 01 17 JSR $1701 ; (mdp_read_byte.s4 + 0)
1649 : 85 56 __ STA T11 + 0 
164b : 4a __ __ LSR
164c : 4a __ __ LSR
164d : 4a __ __ LSR
164e : 4a __ __ LSR
164f : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1652 : 20 c1 0b JSR $0bc1 ; (ascii_to_screencode.s4 + 0)
1655 : a0 00 __ LDY #$00
1657 : 91 53 __ STA (T9 + 0),y 
1659 : a5 56 __ LDA T11 + 0 
165b : 29 0f __ AND #$0f
165d : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1660 : 20 c1 0b JSR $0bc1 ; (ascii_to_screencode.s4 + 0)
1663 : a0 01 __ LDY #$01
1665 : 91 53 __ STA (T9 + 0),y 
1667 : a9 20 __ LDA #$20
1669 : c8 __ __ INY
166a : 91 53 __ STA (T9 + 0),y 
166c : a9 00 __ LDA #$00
166e : 85 1f __ STA ADDR + 0 
1670 : 18 __ __ CLC
1671 : a5 54 __ LDA T9 + 1 
1673 : 69 d4 __ ADC #$d4
1675 : 85 20 __ STA ADDR + 1 
1677 : a9 01 __ LDA #$01
1679 : a4 53 __ LDY T9 + 0 
167b : 91 1f __ STA (ADDR + 0),y 
167d : 84 1f __ STY ADDR + 0 
167f : a8 __ __ TAY
1680 : 91 1f __ STA (ADDR + 0),y 
1682 : c8 __ __ INY
1683 : 91 1f __ STA (ADDR + 0),y 
1685 : 18 __ __ CLC
1686 : a5 53 __ LDA T9 + 0 
1688 : 69 03 __ ADC #$03
168a : 85 53 __ STA T9 + 0 
168c : 90 02 __ BCC $1690 ; (draw_sram_page_view.s11 + 0)
.s10:
168e : e6 54 __ INC T9 + 1 
.s11:
1690 : a6 0d __ LDX P0 
1692 : e8 __ __ INX
1693 : c6 55 __ DEC T10 + 0 
1695 : d0 ac __ BNE $1643 ; (draw_sram_page_view.l6 + 0)
.s7:
1697 : 18 __ __ CLC
1698 : a5 4e __ LDA T4 + 0 
169a : 69 19 __ ADC #$19
169c : 85 49 __ STA T0 + 0 
169e : a5 4f __ LDA T4 + 1 
16a0 : 69 04 __ ADC #$04
16a2 : 85 4a __ STA T0 + 1 
16a4 : a9 08 __ LDA #$08
16a6 : 85 52 __ STA T8 + 0 
.l8:
16a8 : a5 51 __ LDA T7 + 0 
16aa : 20 01 17 JSR $1701 ; (mdp_read_byte.s4 + 0)
16ad : 20 06 17 JSR $1706 ; (get_printable_screencode.s4 + 0)
16b0 : a0 00 __ LDY #$00
16b2 : 84 1f __ STY ADDR + 0 
16b4 : 91 49 __ STA (T0 + 0),y 
16b6 : 18 __ __ CLC
16b7 : a5 4a __ LDA T0 + 1 
16b9 : 69 d4 __ ADC #$d4
16bb : 85 20 __ STA ADDR + 1 
16bd : a9 05 __ LDA #$05
16bf : a4 49 __ LDY T0 + 0 
16c1 : 91 1f __ STA (ADDR + 0),y 
16c3 : e6 51 __ INC T7 + 0 
16c5 : 98 __ __ TYA
16c6 : 18 __ __ CLC
16c7 : 69 01 __ ADC #$01
16c9 : 85 49 __ STA T0 + 0 
16cb : 90 02 __ BCC $16cf ; (draw_sram_page_view.s13 + 0)
.s12:
16cd : e6 4a __ INC T0 + 1 
.s13:
16cf : c6 52 __ DEC T8 + 0 
16d1 : d0 d5 __ BNE $16a8 ; (draw_sram_page_view.l8 + 0)
.s9:
16d3 : 18 __ __ CLC
16d4 : a5 4e __ LDA T4 + 0 
16d6 : 69 28 __ ADC #$28
16d8 : 85 4e __ STA T4 + 0 
16da : 90 03 __ BCC $16df ; (draw_sram_page_view.s15 + 0)
.s14:
16dc : e6 4f __ INC T4 + 1 
16de : 18 __ __ CLC
.s15:
16df : a5 4c __ LDA T3 + 0 
16e1 : 69 28 __ ADC #$28
16e3 : 85 4c __ STA T3 + 0 
16e5 : 90 02 __ BCC $16e9 ; (draw_sram_page_view.s17 + 0)
.s16:
16e7 : e6 4d __ INC T3 + 1 
.s17:
16e9 : e6 50 __ INC T5 + 0 
16eb : e6 4b __ INC T2 + 0 
16ed : a5 4b __ LDA T2 + 0 
16ef : c9 0c __ CMP #$0c
16f1 : b0 03 __ BCS $16f6 ; (draw_sram_page_view.s3 + 0)
16f3 : 4c f3 15 JMP $15f3 ; (draw_sram_page_view.l5 + 0)
.s3:
16f6 : a2 03 __ LDX #$03
16f8 : bd ec 9f LDA $9fec,x ; (draw_sram_page_view@stack + 0)
16fb : 95 53 __ STA T9 + 0,x 
16fd : ca __ __ DEX
16fe : 10 f8 __ BPL $16f8 ; (draw_sram_page_view.s3 + 2)
1700 : 60 __ __ RTS
--------------------------------------------------------------------
mdp_read_byte: ; mdp_read_byte(u8)->u8
; 104, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
1701 : aa __ __ TAX
.s3:
1702 : bd 00 df LDA $df00,x 
1705 : 60 __ __ RTS
--------------------------------------------------------------------
get_printable_screencode: ; get_printable_screencode(u8)->u8
; 103, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
1706 : c9 20 __ CMP #$20
1708 : 90 17 __ BCC $1721 ; (get_printable_screencode.s7 + 0)
.s12:
170a : c9 40 __ CMP #$40
170c : 90 0a __ BCC $1718 ; (get_printable_screencode.s3 + 0)
.s5:
170e : c9 41 __ CMP #$41
1710 : 90 0f __ BCC $1721 ; (get_printable_screencode.s7 + 0)
.s10:
1712 : c9 5b __ CMP #$5b
1714 : b0 03 __ BCS $1719 ; (get_printable_screencode.s6 + 0)
.s11:
1716 : e9 3f __ SBC #$3f
.s3:
1718 : 60 __ __ RTS
.s6:
1719 : c9 61 __ CMP #$61
171b : 90 04 __ BCC $1721 ; (get_printable_screencode.s7 + 0)
.s8:
171d : c9 7b __ CMP #$7b
171f : 90 03 __ BCC $1724 ; (get_printable_screencode.s9 + 0)
.s7:
1721 : a9 2e __ LDA #$2e
1723 : 60 __ __ RTS
.s9:
1724 : e9 5f __ SBC #$5f
1726 : 60 __ __ RTS
--------------------------------------------------------------------
1727 : __ __ __ BYT 45 3a 4f 4e 2f 4f 46 46 20 42 3a 42 41 4e 43 4f : E:ON/OFF B:BANCO
1737 : __ __ __ BYT 20 50 3a 50 41 47 20 57 3a 53 43 52 49 56 49 00 :  P:PAG W:SCRIVI.
--------------------------------------------------------------------
1747 : __ __ __ BYT 45 3a 4f 4e 2f 4f 46 46 20 50 3a 50 41 47 20 57 : E:ON/OFF P:PAG W
1757 : __ __ __ BYT 3a 53 43 52 49 56 49 00                         : :SCRIVI.
--------------------------------------------------------------------
175f : __ __ __ BYT 46 31 3a 4f 46 46 2d 20 46 33 3a 4f 46 46 2b 20 : F1:OFF- F3:OFF+ 
176f : __ __ __ BYT 46 35 3a 50 41 47 2d 20 46 37 3a 50 41 47 2b 20 : F5:PAG- F7:PAG+ 
177f : __ __ __ BYT 4d 3a 4d 45 4e 55 00                            : M:MENU.
--------------------------------------------------------------------
mdp_set_bank: ; mdp_set_bank(u8)->void
;  85, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
1786 : aa __ __ TAX
1787 : d0 08 __ BNE $1791 ; (mdp_set_bank.s6 + 0)
.s5:
1789 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
178c : 29 fe __ AND #$fe
178e : 4c 96 17 JMP $1796 ; (mdp_set_bank.s3 + 0)
.s6:
1791 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
1794 : 09 01 __ ORA #$01
.s3:
1796 : 8d 03 de STA $de03 
1799 : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
179c : 60 __ __ RTS
--------------------------------------------------------------------
179d : __ __ __ BYT 50 41 47 49 4e 41 20 28 48 45 58 20 30 30 2d 46 : PAGINA (HEX 00-F
17ad : __ __ __ BYT 46 29 3a 00                                     : F):.
--------------------------------------------------------------------
17b1 : __ __ __ BYT 50 41 47 49 4e 41 20 28 48 45 58 20 30 30 2d 37 : PAGINA (HEX 00-7
17c1 : __ __ __ BYT 46 29 3a 00                                     : F):.
--------------------------------------------------------------------
17c5 : __ __ __ BYT 50 41 47 49 4e 41 20 28 48 45 58 20 30 30 2d 31 : PAGINA (HEX 00-1
17d5 : __ __ __ BYT 46 29 3a 00                                     : F):.
--------------------------------------------------------------------
prompt_hex_byte: ; prompt_hex_byte(u8,u8)->u8
;1162, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
17d9 : a9 00 __ LDA #$00
17db : 85 49 __ STA T3 + 0 
17dd : 8d fb 9f STA $9ffb ; (buf[0] + 0)
17e0 : 8d fc 9f STA $9ffc ; (buf[0] + 1)
17e3 : 8d fd 9f STA $9ffd ; (buf[0] + 2)
17e6 : a9 03 __ LDA #$03
17e8 : 85 13 __ STA P6 
17ea : a5 14 __ LDA P7 ; (row + 0)
17ec : 85 11 __ STA P4 
17ee : a9 fd __ LDA #$fd
17f0 : 85 0f __ STA P2 
17f2 : a9 0b __ LDA #$0b
17f4 : 85 10 __ STA P3 
17f6 : a5 15 __ LDA P8 ; (col + 0)
17f8 : 85 12 __ STA P5 
17fa : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
.l5:
17fd : a9 00 __ LDA #$00
17ff : c5 49 __ CMP T3 + 0 
1801 : a8 __ __ TAY
1802 : b0 11 __ BCS $1815 ; (prompt_hex_byte.s7 + 0)
.l28:
1804 : aa __ __ TAX
1805 : bd fb 9f LDA $9ffb,x ; (buf[0] + 0)
.l9:
1808 : 9d f8 9f STA $9ff8,x ; (display[0] + 0)
180b : c8 __ __ INY
180c : 98 __ __ TYA
180d : c0 02 __ CPY #$02
180f : b0 12 __ BCS $1823 ; (prompt_hex_byte.s10 + 0)
.s6:
1811 : c5 49 __ CMP T3 + 0 
1813 : 90 ef __ BCC $1804 ; (prompt_hex_byte.l28 + 0)
.s7:
1815 : c5 49 __ CMP T3 + 0 
1817 : d0 05 __ BNE $181e ; (prompt_hex_byte.s8 + 0)
.s27:
1819 : aa __ __ TAX
181a : a9 a4 __ LDA #$a4
181c : d0 ea __ BNE $1808 ; (prompt_hex_byte.l9 + 0)
.s8:
181e : aa __ __ TAX
181f : a9 20 __ LDA #$20
1821 : d0 e5 __ BNE $1808 ; (prompt_hex_byte.l9 + 0)
.s10:
1823 : a5 14 __ LDA P7 ; (row + 0)
1825 : 85 11 __ STA P4 
1827 : a5 15 __ LDA P8 ; (col + 0)
1829 : 85 12 __ STA P5 
182b : a9 03 __ LDA #$03
182d : 85 13 __ STA P6 
182f : a9 00 __ LDA #$00
1831 : 8d fa 9f STA $9ffa ; (display[0] + 2)
1834 : a9 f8 __ LDA #$f8
1836 : 85 0f __ STA P2 
1838 : a9 9f __ LDA #$9f
183a : 85 10 __ STA P3 
183c : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
.l11:
183f : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
1842 : 85 43 __ STA T0 + 0 
1844 : aa __ __ TAX
1845 : f0 f8 __ BEQ $183f ; (prompt_hex_byte.l11 + 0)
.s12:
1847 : c9 0d __ CMP #$0d
1849 : f0 56 __ BEQ $18a1 ; (prompt_hex_byte.s26 + 0)
.s13:
184b : c9 14 __ CMP #$14
184d : f0 05 __ BEQ $1854 ; (prompt_hex_byte.s24 + 0)
.s30:
184f : a5 49 __ LDA T3 + 0 
1851 : 4c 5f 18 JMP $185f ; (prompt_hex_byte.s14 + 0)
.s24:
1854 : 85 43 __ STA T0 + 0 
1856 : a5 49 __ LDA T3 + 0 
1858 : f0 05 __ BEQ $185f ; (prompt_hex_byte.s14 + 0)
.s25:
185a : c6 49 __ DEC T3 + 0 
185c : 4c fd 17 JMP $17fd ; (prompt_hex_byte.l5 + 0)
.s14:
185f : c9 02 __ CMP #$02
1861 : b0 9a __ BCS $17fd ; (prompt_hex_byte.l5 + 0)
.s15:
1863 : a5 43 __ LDA T0 + 0 
1865 : c9 30 __ CMP #$30
1867 : 90 94 __ BCC $17fd ; (prompt_hex_byte.l5 + 0)
.s23:
1869 : c9 3a __ CMP #$3a
186b : 90 16 __ BCC $1883 ; (prompt_hex_byte.s29 + 0)
.s16:
186d : c9 41 __ CMP #$41
186f : 90 8c __ BCC $17fd ; (prompt_hex_byte.l5 + 0)
.s22:
1871 : c9 47 __ CMP #$47
1873 : 90 0e __ BCC $1883 ; (prompt_hex_byte.s29 + 0)
.s17:
1875 : c9 61 __ CMP #$61
1877 : 90 84 __ BCC $17fd ; (prompt_hex_byte.l5 + 0)
.s18:
1879 : c9 67 __ CMP #$67
187b : b0 80 __ BCS $17fd ; (prompt_hex_byte.l5 + 0)
.s19:
187d : c9 61 __ CMP #$61
187f : 90 02 __ BCC $1883 ; (prompt_hex_byte.s29 + 0)
.s21:
1881 : e9 20 __ SBC #$20
.s29:
1883 : a6 49 __ LDX T3 + 0 
1885 : e8 __ __ INX
1886 : 86 49 __ STX T3 + 0 
1888 : 9d fa 9f STA $9ffa,x ; (display[0] + 2)
188b : e0 02 __ CPX #$02
188d : d0 cd __ BNE $185c ; (prompt_hex_byte.s25 + 2)
.s20:
188f : 8a __ __ TXA
.s3:
1890 : 85 0f __ STA P2 
1892 : a9 00 __ LDA #$00
1894 : 85 10 __ STA P3 
1896 : a9 9f __ LDA #$9f
1898 : 85 0e __ STA P1 
189a : a9 fb __ LDA #$fb
189c : 85 0d __ STA P0 
189e : 4c a9 18 JMP $18a9 ; (parse_hex_address.s4 + 0)
.s26:
18a1 : 85 43 __ STA T0 + 0 
18a3 : a5 49 __ LDA T3 + 0 
18a5 : d0 e9 __ BNE $1890 ; (prompt_hex_byte.s3 + 0)
18a7 : f0 b6 __ BEQ $185f ; (prompt_hex_byte.s14 + 0)
--------------------------------------------------------------------
parse_hex_address: ; parse_hex_address(const u8*,i16)->u16
; 190, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
18a9 : a9 00 __ LDA #$00
18ab : 85 43 __ STA T0 + 0 
18ad : 85 1b __ STA ACCU + 0 
18af : 85 44 __ STA T0 + 1 
18b1 : 85 1c __ STA ACCU + 1 
18b3 : a5 10 __ LDA P3 ; (len + 1)
18b5 : 30 04 __ BMI $18bb ; (parse_hex_address.s3 + 0)
.s9:
18b7 : 05 0f __ ORA P2 ; (len + 0)
18b9 : d0 01 __ BNE $18bc ; (parse_hex_address.s10 + 0)
.s3:
18bb : 60 __ __ RTS
.s10:
18bc : a6 10 __ LDX P3 ; (len + 1)
.l5:
18be : a0 00 __ LDY #$00
18c0 : b1 0d __ LDA (P0),y ; (buf + 0)
18c2 : c9 41 __ CMP #$41
18c4 : 90 05 __ BCC $18cb ; (parse_hex_address.s6 + 0)
.s8:
18c6 : 69 c8 __ ADC #$c8
18c8 : 4c cd 18 JMP $18cd ; (parse_hex_address.s7 + 0)
.s6:
18cb : e9 2f __ SBC #$2f
.s7:
18cd : a8 __ __ TAY
18ce : a5 44 __ LDA T0 + 1 
18d0 : 06 43 __ ASL T0 + 0 
18d2 : 2a __ __ ROL
18d3 : 06 43 __ ASL T0 + 0 
18d5 : 2a __ __ ROL
18d6 : 06 43 __ ASL T0 + 0 
18d8 : 2a __ __ ROL
18d9 : 06 43 __ ASL T0 + 0 
18db : 2a __ __ ROL
18dc : 85 44 __ STA T0 + 1 
18de : 85 1c __ STA ACCU + 1 
18e0 : 98 __ __ TYA
18e1 : 05 43 __ ORA T0 + 0 
18e3 : 85 43 __ STA T0 + 0 
18e5 : 85 1b __ STA ACCU + 0 
18e7 : e6 0d __ INC P0 ; (buf + 0)
18e9 : d0 02 __ BNE $18ed ; (parse_hex_address.s15 + 0)
.s14:
18eb : e6 0e __ INC P1 ; (buf + 1)
.s15:
18ed : a5 0f __ LDA P2 ; (len + 0)
18ef : d0 01 __ BNE $18f2 ; (parse_hex_address.s12 + 0)
.s11:
18f1 : ca __ __ DEX
.s12:
18f2 : c6 0f __ DEC P2 ; (len + 0)
18f4 : d0 c8 __ BNE $18be ; (parse_hex_address.l5 + 0)
.s13:
18f6 : 8a __ __ TXA
18f7 : d0 c5 __ BNE $18be ; (parse_hex_address.l5 + 0)
18f9 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_clrchn: ; krnio_clrchn()->void
;  59, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
18fa : 20 cc ff JSR $ffcc 
.s3:
18fd : 60 __ __ RTS
--------------------------------------------------------------------
mdp_ctrl_shadow:
18fe : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
sram_status:
18ff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1900 : __ __ __ BYT 53 52 41 4d 20 4e 4f 4e 20 41 54 54 49 56 41 21 : SRAM NON ATTIVA!
1910 : __ __ __ BYT 20 20 20 20 00                                  :     .
--------------------------------------------------------------------
1915 : __ __ __ BYT 45 45 50 52 4f 4d 20 4e 4f 4e 20 41 54 54 49 56 : EEPROM NON ATTIV
1925 : __ __ __ BYT 41 21 20 20 00                                  : A!  .
--------------------------------------------------------------------
192a : __ __ __ BYT 4f 46 46 53 45 54 20 28 48 45 58 20 30 30 2d 46 : OFFSET (HEX 00-F
193a : __ __ __ BYT 46 29 3a 00                                     : F):.
--------------------------------------------------------------------
193e : __ __ __ BYT 56 41 4c 4f 52 45 20 28 48 45 58 20 30 30 2d 46 : VALORE (HEX 00-F
194e : __ __ __ BYT 46 29 3a 00                                     : F):.
--------------------------------------------------------------------
1952 : __ __ __ BYT 42 59 54 45 20 53 43 52 49 54 54 4f 21 20 20 20 : BYTE SCRITTO!   
1962 : __ __ __ BYT 20 20 20 20 00                                  :     .
--------------------------------------------------------------------
show_sram_diag_screen: ; show_sram_diag_screen()->void
;2170, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
1967 : a5 53 __ LDA T0 + 0 
1969 : 8d a7 9e STA $9ea7 ; (show_sram_diag_screen@stack + 0)
196c : a5 54 __ LDA T0 + 1 
196e : 8d a8 9e STA $9ea8 ; (show_sram_diag_screen@stack + 1)
1971 : a5 55 __ LDA T2 + 0 
1973 : 8d a9 9e STA $9ea9 ; (show_sram_diag_screen@stack + 2)
.l4:
1976 : a9 0b __ LDA #$0b
1978 : 85 18 __ STA P11 
197a : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
197d : a9 03 __ LDA #$03
197f : 85 16 __ STA P9 
1981 : a9 07 __ LDA #$07
1983 : 85 17 __ STA P10 
1985 : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
1988 : 85 55 __ STA T2 + 0 
198a : d0 40 __ BNE $19cc ; (show_sram_diag_screen.s21 + 0)
.s5:
198c : a9 00 __ LDA #$00
198e : 85 14 __ STA P7 
1990 : a9 1b __ LDA #$1b
1992 : 85 15 __ STA P8 
1994 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1997 : a9 09 __ LDA #$09
1999 : 85 11 __ STA P4 
199b : a9 1a __ LDA #$1a
199d : 85 10 __ STA P3 
199f : a9 08 __ LDA #$08
19a1 : 85 12 __ STA P5 
19a3 : a9 01 __ LDA #$01
19a5 : 85 13 __ STA P6 
19a7 : a9 9e __ LDA #$9e
19a9 : 85 0f __ STA P2 
19ab : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
19ae : a9 0b __ LDA #$0b
19b0 : 85 11 __ STA P4 
19b2 : a9 1b __ LDA #$1b
19b4 : 85 10 __ STA P3 
19b6 : a9 13 __ LDA #$13
19b8 : 85 0f __ STA P2 
19ba : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
19bd : a9 2c __ LDA #$2c
19bf : 85 0f __ STA P2 
19c1 : a9 1b __ LDA #$1b
19c3 : 85 10 __ STA P3 
19c5 : a9 1b __ LDA #$1b
19c7 : a0 45 __ LDY #$45
19c9 : 4c 09 1a JMP $1a09 ; (show_sram_diag_screen.s6 + 0)
.s21:
19cc : a9 8d __ LDA #$8d
19ce : 85 14 __ STA P7 
19d0 : a9 1a __ LDA #$1a
19d2 : 85 15 __ STA P8 
19d4 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
19d7 : a9 09 __ LDA #$09
19d9 : 85 11 __ STA P4 
19db : a9 1a __ LDA #$1a
19dd : 85 10 __ STA P3 
19df : a9 08 __ LDA #$08
19e1 : 85 12 __ STA P5 
19e3 : a9 01 __ LDA #$01
19e5 : 85 13 __ STA P6 
19e7 : a9 9e __ LDA #$9e
19e9 : 85 0f __ STA P2 
19eb : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
19ee : a9 0b __ LDA #$0b
19f0 : 85 11 __ STA P4 
19f2 : a9 1a __ LDA #$1a
19f4 : 85 10 __ STA P3 
19f6 : a9 b7 __ LDA #$b7
19f8 : 85 0f __ STA P2 
19fa : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
19fd : a9 d0 __ LDA #$d0
19ff : 85 0f __ STA P2 
1a01 : a9 1a __ LDA #$1a
1a03 : 85 10 __ STA P3 
1a05 : a9 1a __ LDA #$1a
1a07 : a0 e5 __ LDY #$e5
.s6:
1a09 : 84 53 __ STY T0 + 0 
1a0b : 85 54 __ STA T0 + 1 
1a0d : a9 0d __ LDA #$0d
1a0f : 85 11 __ STA P4 
1a11 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1a14 : a5 53 __ LDA T0 + 0 
1a16 : 85 0f __ STA P2 
1a18 : a5 54 __ LDA T0 + 1 
1a1a : 85 10 __ STA P3 
1a1c : a9 0f __ LDA #$0f
1a1e : 85 11 __ STA P4 
1a20 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1a23 : a9 17 __ LDA #$17
1a25 : 85 16 __ STA P9 
1a27 : a9 1b __ LDA #$1b
1a29 : 85 15 __ STA P8 
1a2b : a9 0d __ LDA #$0d
1a2d : 85 17 __ STA P10 
1a2f : a9 59 __ LDA #$59
1a31 : 85 14 __ STA P7 
1a33 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l7:
1a36 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
1a39 : c9 6d __ CMP #$6d
1a3b : f0 40 __ BEQ $1a7d ; (show_sram_diag_screen.s3 + 0)
.s8:
1a3d : c9 4d __ CMP #$4d
1a3f : f0 3c __ BEQ $1a7d ; (show_sram_diag_screen.s3 + 0)
.s9:
1a41 : c9 85 __ CMP #$85
1a43 : d0 06 __ BNE $1a4b ; (show_sram_diag_screen.s10 + 0)
.s20:
1a45 : 20 6c 1b JSR $1b6c ; (sram_selftest.s1 + 0)
1a48 : 4c 76 19 JMP $1976 ; (show_sram_diag_screen.l4 + 0)
.s10:
1a4b : c9 86 __ CMP #$86
1a4d : f0 1e __ BEQ $1a6d ; (show_sram_diag_screen.s17 + 0)
.s11:
1a4f : c9 87 __ CMP #$87
1a51 : f0 0a __ BEQ $1a5d ; (show_sram_diag_screen.s14 + 0)
.s12:
1a53 : c9 88 __ CMP #$88
1a55 : d0 df __ BNE $1a36 ; (show_sram_diag_screen.l7 + 0)
.s13:
1a57 : 20 de 33 JSR $33de ; (sram_format.s4 + 0)
1a5a : 4c 76 19 JMP $1976 ; (show_sram_diag_screen.l4 + 0)
.s14:
1a5d : a5 55 __ LDA T2 + 0 
1a5f : d0 06 __ BNE $1a67 ; (show_sram_diag_screen.s16 + 0)
.s15:
1a61 : 20 64 2a JSR $2a64 ; (sram_restore.s4 + 0)
1a64 : 4c 76 19 JMP $1976 ; (show_sram_diag_screen.l4 + 0)
.s16:
1a67 : 20 8c 2b JSR $2b8c ; (check_floppy.s1 + 0)
1a6a : 4c 76 19 JMP $1976 ; (show_sram_diag_screen.l4 + 0)
.s17:
1a6d : a5 55 __ LDA T2 + 0 
1a6f : d0 06 __ BNE $1a77 ; (show_sram_diag_screen.s19 + 0)
.s18:
1a71 : 20 86 28 JSR $2886 ; (sram_backup.s4 + 0)
1a74 : 4c 76 19 JMP $1976 ; (show_sram_diag_screen.l4 + 0)
.s19:
1a77 : 20 d5 1e JSR $1ed5 ; (show_prg_loader_screen.s1 + 0)
1a7a : 4c 76 19 JMP $1976 ; (show_sram_diag_screen.l4 + 0)
.s3:
1a7d : ad a7 9e LDA $9ea7 ; (show_sram_diag_screen@stack + 0)
1a80 : 85 53 __ STA T0 + 0 
1a82 : ad a8 9e LDA $9ea8 ; (show_sram_diag_screen@stack + 1)
1a85 : 85 54 __ STA T0 + 1 
1a87 : ad a9 9e LDA $9ea9 ; (show_sram_diag_screen@stack + 2)
1a8a : 85 55 __ STA T2 + 0 
1a8c : 60 __ __ RTS
--------------------------------------------------------------------
1a8d : __ __ __ BYT 44 49 41 47 4e 4f 53 54 49 43 41 20 53 52 41 4d : DIAGNOSTICA SRAM
1a9d : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1a9e : __ __ __ BYT 46 31 3a 20 53 45 4c 46 2d 54 45 53 54 20 49 4e : F1: SELF-TEST IN
1aae : __ __ __ BYT 54 45 47 52 49 54 41 27 00                      : TEGRITA'.
--------------------------------------------------------------------
1ab7 : __ __ __ BYT 46 33 3a 20 43 41 52 49 43 41 20 50 52 47 20 44 : F3: CARICA PRG D
1ac7 : __ __ __ BYT 41 20 46 4c 4f 50 50 59 00                      : A FLOPPY.
--------------------------------------------------------------------
1ad0 : __ __ __ BYT 46 35 3a 20 43 4f 4e 54 52 4f 4c 4c 4f 20 46 4c : F5: CONTROLLO FL
1ae0 : __ __ __ BYT 4f 50 50 59 00                                  : OPPY.
--------------------------------------------------------------------
1ae5 : __ __ __ BYT 46 37 3a 20 46 4f 52 4d 41 54 54 41 20 53 52 41 : F7: FORMATTA SRA
1af5 : __ __ __ BYT 4d 00                                           : M.
--------------------------------------------------------------------
1af7 : __ __ __ BYT 50 41 47 49 4e 41 3a 00                         : PAGINA:.
--------------------------------------------------------------------
eeprom_size_kb:
1aff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1b00 : __ __ __ BYT 44 49 41 47 4e 4f 53 54 49 43 41 20 45 45 50 52 : DIAGNOSTICA EEPR
1b10 : __ __ __ BYT 4f 4d 00                                        : OM.
--------------------------------------------------------------------
1b13 : __ __ __ BYT 46 33 3a 20 42 41 43 4b 55 50 20 52 41 4d 20 53 : F3: BACKUP RAM S
1b23 : __ __ __ BYT 55 20 45 45 50 52 4f 4d 00                      : U EEPROM.
--------------------------------------------------------------------
1b2c : __ __ __ BYT 46 35 3a 20 52 49 50 52 49 53 54 49 4e 41 20 44 : F5: RIPRISTINA D
1b3c : __ __ __ BYT 41 20 45 45 50 52 4f 4d 00                      : A EEPROM.
--------------------------------------------------------------------
1b45 : __ __ __ BYT 46 37 3a 20 46 4f 52 4d 41 54 54 41 20 45 45 50 : F7: FORMATTA EEP
1b55 : __ __ __ BYT 52 4f 4d 00                                     : ROM.
--------------------------------------------------------------------
1b59 : __ __ __ BYT 50 52 45 4d 49 20 28 4d 29 20 50 45 52 20 4d 45 : PREMI (M) PER ME
1b69 : __ __ __ BYT 4e 55 00                                        : NU.
--------------------------------------------------------------------
sram_selftest: ; sram_selftest()->void
;1422, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
1b6c : a2 04 __ LDX #$04
1b6e : b5 53 __ LDA T9 + 0,x 
1b70 : 9d aa 9e STA $9eaa,x ; (sram_selftest@stack + 0)
1b73 : ca __ __ DEX
1b74 : 10 f8 __ BPL $1b6e ; (sram_selftest.s1 + 2)
.s4:
1b76 : a9 0b __ LDA #$0b
1b78 : 85 18 __ STA P11 
1b7a : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
1b7d : a9 03 __ LDA #$03
1b7f : 85 16 __ STA P9 
1b81 : a9 07 __ LDA #$07
1b83 : 85 17 __ STA P10 
1b85 : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
1b88 : 85 51 __ STA T7 + 0 
1b8a : f0 03 __ BEQ $1b8f ; (sram_selftest.s5 + 0)
1b8c : 4c 11 1e JMP $1e11 ; (sram_selftest.s56 + 0)
.s5:
1b8f : a9 00 __ LDA #$00
1b91 : 85 14 __ STA P7 
1b93 : a9 1b __ LDA #$1b
1b95 : 85 15 __ STA P8 
1b97 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1b9a : ad ff 27 LDA $27ff ; (eeprom_status + 0)
1b9d : d0 38 __ BNE $1bd7 ; (sram_selftest.s7 + 0)
.s6:
1b9f : a9 0b __ LDA #$0b
1ba1 : 85 16 __ STA P9 
1ba3 : a9 02 __ LDA #$02
1ba5 : 85 17 __ STA P10 
1ba7 : a9 56 __ LDA #$56
1ba9 : 85 14 __ STA P7 
1bab : a9 1e __ LDA #$1e
.s63:
1bad : 85 15 __ STA P8 
.s62:
1baf : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1bb2 : a9 17 __ LDA #$17
1bb4 : 85 16 __ STA P9 
1bb6 : a9 0c __ LDA #$0c
1bb8 : 85 15 __ STA P8 
1bba : a9 01 __ LDA #$01
1bbc : 85 17 __ STA P10 
1bbe : a9 d1 __ LDA #$d1
1bc0 : 85 14 __ STA P7 
1bc2 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l35:
1bc5 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
1bc8 : c9 0d __ CMP #$0d
1bca : d0 f9 __ BNE $1bc5 ; (sram_selftest.l35 + 0)
.s3:
1bcc : a2 04 __ LDX #$04
1bce : bd aa 9e LDA $9eaa,x ; (sram_selftest@stack + 0)
1bd1 : 95 53 __ STA T9 + 0,x 
1bd3 : ca __ __ DEX
1bd4 : 10 f8 __ BPL $1bce ; (sram_selftest.s3 + 2)
1bd6 : 60 __ __ RTS
.s7:
1bd7 : a9 0b __ LDA #$0b
1bd9 : 85 16 __ STA P9 
1bdb : a9 1e __ LDA #$1e
1bdd : 85 15 __ STA P8 
1bdf : a9 03 __ LDA #$03
1be1 : 85 17 __ STA P10 
1be3 : a9 77 __ LDA #$77
1be5 : 85 14 __ STA P7 
1be7 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1bea : a9 00 __ LDA #$00
1bec : 8d fd 9f STA $9ffd ; (patterns[0] + 2)
1bef : 85 52 __ STA T8 + 0 
1bf1 : a9 aa __ LDA #$aa
1bf3 : 8d fb 9f STA $9ffb ; (patterns[0] + 0)
1bf6 : a9 55 __ LDA #$55
1bf8 : 8d fc 9f STA $9ffc ; (patterns[0] + 1)
1bfb : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
1bfe : 85 53 __ STA T9 + 0 
1c00 : a5 51 __ LDA T7 + 0 
1c02 : f0 0c __ BEQ $1c10 ; (sram_selftest.s8 + 0)
.s55:
1c04 : a9 00 __ LDA #$00
1c06 : 85 4b __ STA T2 + 0 
1c08 : a9 01 __ LDA #$01
1c0a : 85 4c __ STA T2 + 1 
1c0c : a9 02 __ LDA #$02
1c0e : d0 11 __ BNE $1c21 ; (sram_selftest.s10 + 0)
.s8:
1c10 : a9 20 __ LDA #$20
1c12 : cd ff 1a CMP $1aff ; (eeprom_size_kb + 0)
1c15 : d0 02 __ BNE $1c19 ; (sram_selftest.s9 + 0)
.s54:
1c17 : a9 80 __ LDA #$80
.s9:
1c19 : 85 4b __ STA T2 + 0 
1c1b : a9 00 __ LDA #$00
1c1d : 85 4c __ STA T2 + 1 
1c1f : a9 01 __ LDA #$01
.s10:
1c21 : 85 4d __ STA T3 + 0 
1c23 : a9 00 __ LDA #$00
1c25 : 85 54 __ STA T10 + 0 
1c27 : 85 55 __ STA T11 + 0 
1c29 : 85 56 __ STA T12 + 0 
1c2b : a5 51 __ LDA T7 + 0 
1c2d : d0 0f __ BNE $1c3e ; (sram_selftest.l43 + 0)
.s11:
1c2f : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
.l12:
1c32 : a9 00 __ LDA #$00
1c34 : 85 4e __ STA T4 + 0 
1c36 : 85 4f __ STA T4 + 1 
.l52:
1c38 : a9 50 __ LDA #$50
1c3a : a0 00 __ LDY #$00
1c3c : f0 3d __ BEQ $1c7b ; (sram_selftest.l59 + 0)
.l43:
1c3e : a5 52 __ LDA T8 + 0 
1c40 : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
1c43 : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
1c46 : a9 54 __ LDA #$54
1c48 : a0 00 __ LDY #$00
.l58:
1c4a : 99 e7 9f STA $9fe7,y ; (bank_msg[0] + 0)
1c4d : c8 __ __ INY
1c4e : b9 88 1e LDA $1e88,y 
1c51 : d0 f7 __ BNE $1c4a ; (sram_selftest.l58 + 0)
.s44:
1c53 : a9 20 __ LDA #$20
1c55 : 99 e7 9f STA $9fe7,y ; (bank_msg[0] + 0)
1c58 : a9 0d __ LDA #$0d
1c5a : 85 16 __ STA P9 
1c5c : a9 01 __ LDA #$01
1c5e : 85 17 __ STA P10 
1c60 : a9 00 __ LDA #$00
1c62 : 99 e9 9f STA $9fe9,y ; (bank_msg[0] + 2)
1c65 : 18 __ __ CLC
1c66 : a5 52 __ LDA T8 + 0 
1c68 : 69 30 __ ADC #$30
1c6a : 99 e8 9f STA $9fe8,y ; (bank_msg[0] + 1)
1c6d : a9 e7 __ LDA #$e7
1c6f : 85 14 __ STA P7 
1c71 : a9 9f __ LDA #$9f
1c73 : 85 15 __ STA P8 
1c75 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1c78 : 4c 32 1c JMP $1c32 ; (sram_selftest.l12 + 0)
.l59:
1c7b : 99 db 9f STA $9fdb,y ; (pg_str[0] + 0)
1c7e : c8 __ __ INY
1c7f : b9 f7 1a LDA $1af7,y 
1c82 : d0 f7 __ BNE $1c7b ; (sram_selftest.l59 + 0)
.s53:
1c84 : 84 4a __ STY T1 + 0 
1c86 : a9 20 __ LDA #$20
1c88 : 99 db 9f STA $9fdb,y ; (pg_str[0] + 0)
1c8b : a5 4e __ LDA T4 + 0 
1c8d : 4a __ __ LSR
1c8e : 4a __ __ LSR
1c8f : 4a __ __ LSR
1c90 : 4a __ __ LSR
1c91 : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1c94 : a6 4a __ LDX T1 + 0 
1c96 : 9d dc 9f STA $9fdc,x ; (pg_str[0] + 1)
1c99 : a9 00 __ LDA #$00
1c9b : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1c9e : a6 4a __ LDX T1 + 0 
1ca0 : 9d dd 9f STA $9fdd,x ; (pg_str[0] + 2)
1ca3 : a9 0f __ LDA #$0f
1ca5 : 85 16 __ STA P9 
1ca7 : 85 17 __ STA P10 
1ca9 : a9 00 __ LDA #$00
1cab : 9d de 9f STA $9fde,x ; (pg_str[0] + 3)
1cae : a9 db __ LDA #$db
1cb0 : 85 14 __ STA P7 
1cb2 : a9 9f __ LDA #$9f
1cb4 : 85 15 __ STA P8 
1cb6 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l14:
1cb9 : a5 4e __ LDA T4 + 0 
1cbb : 8d 01 de STA $de01 
1cbe : a9 00 __ LDA #$00
.l60:
1cc0 : 85 0d __ STA P0 
1cc2 : 20 01 17 JSR $1701 ; (mdp_read_byte.s4 + 0)
1cc5 : a6 0d __ LDX P0 
1cc7 : 9d db 9e STA $9edb,x ; (saved[0] + 0)
1cca : e8 __ __ INX
1ccb : 8a __ __ TXA
1ccc : d0 f2 __ BNE $1cc0 ; (sram_selftest.l60 + 0)
.s15:
1cce : 85 49 __ STA T0 + 0 
.l16:
1cd0 : 85 50 __ STA T5 + 0 
.l17:
1cd2 : a6 49 __ LDX T0 + 0 
1cd4 : bd fb 9f LDA $9ffb,x ; (patterns[0] + 0)
1cd7 : 85 57 __ STA T13 + 0 
1cd9 : a5 51 __ LDA T7 + 0 
1cdb : d0 12 __ BNE $1cef ; (sram_selftest.s51 + 0)
.s18:
1cdd : a5 4e __ LDA T4 + 0 
1cdf : 85 0e __ STA P1 
1ce1 : a5 50 __ LDA T5 + 0 
1ce3 : 85 0f __ STA P2 
1ce5 : a5 57 __ LDA T13 + 0 
1ce7 : 85 10 __ STA P3 
1ce9 : 20 cb 0d JSR $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
1cec : 4c f6 1c JMP $1cf6 ; (sram_selftest.s19 + 0)
.s51:
1cef : a5 57 __ LDA T13 + 0 
1cf1 : a6 50 __ LDX T5 + 0 
1cf3 : 9d 00 df STA $df00,x 
.s19:
1cf6 : e6 50 __ INC T5 + 0 
1cf8 : d0 d8 __ BNE $1cd2 ; (sram_selftest.l17 + 0)
.s20:
1cfa : a9 00 __ LDA #$00
1cfc : 85 4a __ STA T1 + 0 
.l21:
1cfe : a5 4a __ LDA T1 + 0 
1d00 : 20 01 17 JSR $1701 ; (mdp_read_byte.s4 + 0)
1d03 : c5 57 __ CMP T13 + 0 
1d05 : f0 03 __ BEQ $1d0a ; (sram_selftest.s22 + 0)
1d07 : 4c 02 1e JMP $1e02 ; (sram_selftest.s50 + 0)
.s22:
1d0a : e6 4a __ INC T1 + 0 
1d0c : d0 f0 __ BNE $1cfe ; (sram_selftest.l21 + 0)
.s23:
1d0e : e6 49 __ INC T0 + 0 
1d10 : a5 49 __ LDA T0 + 0 
1d12 : c9 03 __ CMP #$03
1d14 : b0 04 __ BCS $1d1a ; (sram_selftest.s24 + 0)
.s49:
1d16 : a5 54 __ LDA T10 + 0 
1d18 : f0 b6 __ BEQ $1cd0 ; (sram_selftest.l16 + 0)
.s24:
1d1a : a9 00 __ LDA #$00
1d1c : 85 4a __ STA T1 + 0 
.l25:
1d1e : a4 4a __ LDY T1 + 0 
1d20 : a5 51 __ LDA T7 + 0 
1d22 : d0 11 __ BNE $1d35 ; (sram_selftest.s48 + 0)
.s26:
1d24 : 84 0f __ STY P2 
1d26 : a5 4e __ LDA T4 + 0 
1d28 : 85 0e __ STA P1 
1d2a : b9 db 9e LDA $9edb,y ; (saved[0] + 0)
1d2d : 85 10 __ STA P3 
1d2f : 20 cb 0d JSR $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
1d32 : 4c 3b 1d JMP $1d3b ; (sram_selftest.s27 + 0)
.s48:
1d35 : b9 db 9e LDA $9edb,y ; (saved[0] + 0)
1d38 : 99 00 df STA $df00,y 
.s27:
1d3b : e6 4a __ INC T1 + 0 
1d3d : d0 df __ BNE $1d1e ; (sram_selftest.l25 + 0)
.s28:
1d3f : e6 4e __ INC T4 + 0 
1d41 : d0 02 __ BNE $1d45 ; (sram_selftest.s65 + 0)
.s64:
1d43 : e6 4f __ INC T4 + 1 
.s65:
1d45 : a5 4f __ LDA T4 + 1 
1d47 : c5 4c __ CMP T2 + 1 
1d49 : d0 04 __ BNE $1d4f ; (sram_selftest.s47 + 0)
.s46:
1d4b : a5 4e __ LDA T4 + 0 
1d4d : c5 4b __ CMP T2 + 0 
.s47:
1d4f : b0 10 __ BCS $1d61 ; (sram_selftest.s29 + 0)
.s45:
1d51 : a5 54 __ LDA T10 + 0 
1d53 : d0 0c __ BNE $1d61 ; (sram_selftest.s29 + 0)
.s13:
1d55 : a5 4e __ LDA T4 + 0 
1d57 : 29 0f __ AND #$0f
1d59 : f0 03 __ BEQ $1d5e ; (sram_selftest.s13 + 9)
1d5b : 4c b9 1c JMP $1cb9 ; (sram_selftest.l14 + 0)
1d5e : 4c 38 1c JMP $1c38 ; (sram_selftest.l52 + 0)
.s29:
1d61 : e6 52 __ INC T8 + 0 
1d63 : a5 52 __ LDA T8 + 0 
1d65 : c5 4d __ CMP T3 + 0 
1d67 : b0 0e __ BCS $1d77 ; (sram_selftest.s30 + 0)
.s41:
1d69 : a5 54 __ LDA T10 + 0 
1d6b : d0 0a __ BNE $1d77 ; (sram_selftest.s30 + 0)
.s42:
1d6d : a5 51 __ LDA T7 + 0 
1d6f : f0 03 __ BEQ $1d74 ; (sram_selftest.s42 + 7)
1d71 : 4c 3e 1c JMP $1c3e ; (sram_selftest.l43 + 0)
1d74 : 4c 2f 1c JMP $1c2f ; (sram_selftest.s11 + 0)
.s30:
1d77 : a5 51 __ LDA T7 + 0 
1d79 : d0 0b __ BNE $1d86 ; (sram_selftest.s40 + 0)
.s31:
1d7b : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
1d7e : 85 11 __ STA P4 
1d80 : 20 2a 0e JSR $0e2a ; (mdp_eeprom_write_signature.s4 + 0)
1d83 : 4c 89 1d JMP $1d89 ; (sram_selftest.s32 + 0)
.s40:
1d86 : 20 95 0c JSR $0c95 ; (mdp_write_signature.s4 + 0)
.s32:
1d89 : a5 53 __ LDA T9 + 0 
1d8b : 8d 03 de STA $de03 
1d8e : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
1d91 : a5 54 __ LDA T10 + 0 
1d93 : d0 13 __ BNE $1da8 ; (sram_selftest.s36 + 0)
.s33:
1d95 : a9 0d __ LDA #$0d
1d97 : 85 17 __ STA P10 
1d99 : a9 1e __ LDA #$1e
1d9b : a0 b4 __ LDY #$b4
.s34:
1d9d : 84 14 __ STY P7 
1d9f : 85 15 __ STA P8 
1da1 : a9 11 __ LDA #$11
1da3 : 85 16 __ STA P9 
1da5 : 4c af 1b JMP $1baf ; (sram_selftest.s62 + 0)
.s36:
1da8 : a9 45 __ LDA #$45
1daa : a0 00 __ LDY #$00
.l61:
1dac : 99 b3 9e STA $9eb3,y ; (fail_msg[0] + 0)
1daf : b9 94 1e LDA $1e94,y 
1db2 : c8 __ __ INY
1db3 : c0 1e __ CPY #$1e
1db5 : d0 f5 __ BNE $1dac ; (sram_selftest.l61 + 0)
.s37:
1db7 : a5 56 __ LDA T12 + 0 
1db9 : 4a __ __ LSR
1dba : 4a __ __ LSR
1dbb : 4a __ __ LSR
1dbc : 4a __ __ LSR
1dbd : aa __ __ TAX
1dbe : a5 51 __ LDA T7 + 0 
1dc0 : f0 14 __ BEQ $1dd6 ; (sram_selftest.s38 + 0)
.s39:
1dc2 : a9 42 __ LDA #$42
1dc4 : 8d d1 9e STA $9ed1 ; (fail_msg[0] + 30)
1dc7 : a9 20 __ LDA #$20
1dc9 : 8d d3 9e STA $9ed3 ; (fail_msg[0] + 32)
1dcc : 18 __ __ CLC
1dcd : a5 55 __ LDA T11 + 0 
1dcf : 69 30 __ ADC #$30
1dd1 : 8d d2 9e STA $9ed2 ; (fail_msg[0] + 31)
1dd4 : a0 21 __ LDY #$21
.s38:
1dd6 : 84 49 __ STY T0 + 0 
1dd8 : a9 50 __ LDA #$50
1dda : 99 b3 9e STA $9eb3,y ; (fail_msg[0] + 0)
1ddd : 8a __ __ TXA
1dde : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1de1 : a6 49 __ LDX T0 + 0 
1de3 : 9d b4 9e STA $9eb4,x ; (fail_msg[0] + 1)
1de6 : a5 56 __ LDA T12 + 0 
1de8 : 29 0f __ AND #$0f
1dea : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
1ded : a6 49 __ LDX T0 + 0 
1def : 9d b5 9e STA $9eb5,x ; (fail_msg[0] + 2)
1df2 : a9 02 __ LDA #$02
1df4 : 85 17 __ STA P10 
1df6 : a9 00 __ LDA #$00
1df8 : 9d b6 9e STA $9eb6,x ; (fail_msg[0] + 3)
1dfb : a9 9e __ LDA #$9e
1dfd : a0 b3 __ LDY #$b3
1dff : 4c 9d 1d JMP $1d9d ; (sram_selftest.s34 + 0)
.s50:
1e02 : a5 4e __ LDA T4 + 0 
1e04 : 85 56 __ STA T12 + 0 
1e06 : a5 52 __ LDA T8 + 0 
1e08 : 85 55 __ STA T11 + 0 
1e0a : a9 01 __ LDA #$01
1e0c : 85 54 __ STA T10 + 0 
1e0e : 4c 0e 1d JMP $1d0e ; (sram_selftest.s23 + 0)
.s56:
1e11 : a9 8d __ LDA #$8d
1e13 : 85 14 __ STA P7 
1e15 : a9 1a __ LDA #$1a
1e17 : 85 15 __ STA P8 
1e19 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1e1c : ad ff 18 LDA $18ff ; (sram_status + 0)
1e1f : f0 03 __ BEQ $1e24 ; (sram_selftest.s57 + 0)
1e21 : 4c d7 1b JMP $1bd7 ; (sram_selftest.s7 + 0)
.s57:
1e24 : a9 0b __ LDA #$0b
1e26 : 85 16 __ STA P9 
1e28 : a9 02 __ LDA #$02
1e2a : 85 17 __ STA P10 
1e2c : a9 35 __ LDA #$35
1e2e : 85 14 __ STA P7 
1e30 : a9 1e __ LDA #$1e
1e32 : 4c ad 1b JMP $1bad ; (sram_selftest.s63 + 0)
--------------------------------------------------------------------
1e35 : __ __ __ BYT 45 52 52 4f 52 45 3a 20 53 52 41 4d 20 4e 4f 4e : ERRORE: SRAM NON
1e45 : __ __ __ BYT 20 50 52 45 53 45 4e 54 45 21 20 20 20 20 20 20 :  PRESENTE!      
1e55 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1e56 : __ __ __ BYT 45 52 52 4f 52 45 3a 20 45 45 50 52 4f 4d 20 4e : ERRORE: EEPROM N
1e66 : __ __ __ BYT 4f 4e 20 50 52 45 53 45 4e 54 45 21 20 20 20 20 : ON PRESENTE!    
1e76 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1e77 : __ __ __ BYT 54 45 53 54 20 49 4e 20 43 4f 52 53 4f 2e 2e 2e : TEST IN CORSO...
1e87 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1e88 : __ __ __ BYT 54 45 53 54 20 42 41 4e 43 4f 00                : TEST BANCO.
--------------------------------------------------------------------
1e93 : __ __ __ BYT 45 52 52 4f 52 45 21 20 50 41 47 49 4e 41 20 44 : ERRORE! PAGINA D
1ea3 : __ __ __ BYT 49 46 45 54 54 4f 53 41 3a 20 20 20 20 20 20 20 : IFETTOSA:       
1eb3 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1eb4 : __ __ __ BYT 54 45 53 54 20 53 55 50 45 52 41 54 4f 21 20 53 : TEST SUPERATO! S
1ec4 : __ __ __ BYT 52 41 4d 20 49 4e 54 45 47 52 41 2e 20 20 20 20 : RAM INTEGRA.    
1ed4 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
show_prg_loader_screen: ; show_prg_loader_screen()->void
;2092, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
1ed5 : a5 53 __ LDA T2 + 0 
1ed7 : 8d b3 9f STA $9fb3 ; (show_prg_loader_screen@stack + 0)
1eda : a5 54 __ LDA T4 + 0 
1edc : 8d b4 9f STA $9fb4 ; (show_prg_loader_screen@stack + 1)
1edf : a5 55 __ LDA T5 + 0 
1ee1 : 8d b5 9f STA $9fb5 ; (show_prg_loader_screen@stack + 2)
.s4:
1ee4 : a9 0b __ LDA #$0b
1ee6 : 85 18 __ STA P11 
1ee8 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
1eeb : a9 03 __ LDA #$03
1eed : 85 16 __ STA P9 
1eef : a9 20 __ LDA #$20
1ef1 : 85 15 __ STA P8 
1ef3 : a9 07 __ LDA #$07
1ef5 : 85 17 __ STA P10 
1ef7 : a9 55 __ LDA #$55
1ef9 : 85 14 __ STA P7 
1efb : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1efe : a9 0b __ LDA #$0b
1f00 : 85 16 __ STA P9 
1f02 : a9 20 __ LDA #$20
1f04 : 85 15 __ STA P8 
1f06 : a9 03 __ LDA #$03
1f08 : 85 17 __ STA P10 
1f0a : a9 6a __ LDA #$6a
1f0c : 85 14 __ STA P7 
1f0e : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1f11 : 20 7f 20 JSR $207f ; (read_prg_directory.s4 + 0)
1f14 : a5 1b __ LDA ACCU + 0 
1f16 : d0 27 __ BNE $1f3f ; (show_prg_loader_screen.s6 + 0)
.s5:
1f18 : a9 0b __ LDA #$0b
1f1a : 85 0d __ STA P0 
1f1c : 85 0e __ STA P1 
1f1e : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
1f21 : c6 17 __ DEC P10 
1f23 : a9 a2 __ LDA #$a2
1f25 : 85 14 __ STA P7 
1f27 : a9 22 __ LDA #$22
1f29 : 85 15 __ STA P8 
1f2b : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1f2e : a9 0d __ LDA #$0d
1f30 : 85 16 __ STA P9 
1f32 : a9 07 __ LDA #$07
1f34 : 85 17 __ STA P10 
1f36 : a9 c2 __ LDA #$c2
1f38 : 85 14 __ STA P7 
1f3a : a9 22 __ LDA #$22
1f3c : 4c 55 1f JMP $1f55 ; (show_prg_loader_screen.s27 + 0)
.s6:
1f3f : ad ff 32 LDA $32ff ; (prg_count + 0)
1f42 : d0 40 __ BNE $1f84 ; (show_prg_loader_screen.s9 + 0)
.s7:
1f44 : a9 0b __ LDA #$0b
1f46 : 85 0d __ STA P0 
1f48 : 85 0e __ STA P1 
1f4a : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
1f4d : c6 17 __ DEC P10 
1f4f : a9 e5 __ LDA #$e5
1f51 : 85 14 __ STA P7 
1f53 : a9 22 __ LDA #$22
.s27:
1f55 : 85 15 __ STA P8 
1f57 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1f5a : a9 17 __ LDA #$17
1f5c : 85 16 __ STA P9 
1f5e : a9 0c __ LDA #$0c
1f60 : 85 15 __ STA P8 
1f62 : a9 01 __ LDA #$01
1f64 : 85 17 __ STA P10 
1f66 : a9 d1 __ LDA #$d1
1f68 : 85 14 __ STA P7 
1f6a : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l8:
1f6d : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
1f70 : c9 0d __ CMP #$0d
1f72 : d0 f9 __ BNE $1f6d ; (show_prg_loader_screen.l8 + 0)
.s3:
1f74 : ad b3 9f LDA $9fb3 ; (show_prg_loader_screen@stack + 0)
1f77 : 85 53 __ STA T2 + 0 
1f79 : ad b4 9f LDA $9fb4 ; (show_prg_loader_screen@stack + 1)
1f7c : 85 54 __ STA T4 + 0 
1f7e : ad b5 9f LDA $9fb5 ; (show_prg_loader_screen@stack + 2)
1f81 : 85 55 __ STA T5 + 0 
1f83 : 60 __ __ RTS
.s9:
1f84 : 85 54 __ STA T4 + 0 
1f86 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
1f89 : a9 03 __ LDA #$03
1f8b : 85 16 __ STA P9 
1f8d : a9 20 __ LDA #$20
1f8f : 85 15 __ STA P8 
1f91 : a9 07 __ LDA #$07
1f93 : 85 17 __ STA P10 
1f95 : a9 55 __ LDA #$55
1f97 : 85 14 __ STA P7 
1f99 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1f9c : a9 00 __ LDA #$00
1f9e : 8d fe 9f STA $9ffe ; (sstack + 0)
1fa1 : 8d ff 9f STA $9fff ; (sstack + 1)
1fa4 : 20 fe 22 JSR $22fe ; (draw_file_list.s4 + 0)
1fa7 : a9 17 __ LDA #$17
1fa9 : 85 16 __ STA P9 
1fab : a9 25 __ LDA #$25
1fad : 85 15 __ STA P8 
1faf : a9 0d __ LDA #$0d
1fb1 : 85 17 __ STA P10 
1fb3 : a9 46 __ LDA #$46
1fb5 : 85 14 __ STA P7 
1fb7 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1fba : a9 00 __ LDA #$00
1fbc : 85 55 __ STA T5 + 0 
.l26:
1fbe : 85 53 __ STA T2 + 0 
.l10:
1fc0 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
1fc3 : 85 47 __ STA T3 + 0 
1fc5 : aa __ __ TAX
1fc6 : f0 f8 __ BEQ $1fc0 ; (show_prg_loader_screen.l10 + 0)
.s11:
1fc8 : c9 6d __ CMP #$6d
1fca : f0 a8 __ BEQ $1f74 ; (show_prg_loader_screen.s3 + 0)
.s12:
1fcc : c9 4d __ CMP #$4d
1fce : f0 a4 __ BEQ $1f74 ; (show_prg_loader_screen.s3 + 0)
.s13:
1fd0 : c9 11 __ CMP #$11
1fd2 : f0 4f __ BEQ $2023 ; (show_prg_loader_screen.s21 + 0)
.s14:
1fd4 : c9 91 __ CMP #$91
1fd6 : d0 3a __ BNE $2012 ; (show_prg_loader_screen.s15 + 0)
.s17:
1fd8 : a5 55 __ LDA T5 + 0 
1fda : f0 e4 __ BEQ $1fc0 ; (show_prg_loader_screen.l10 + 0)
.s18:
1fdc : 85 14 __ STA P7 
1fde : c6 55 __ DEC T5 + 0 
1fe0 : a5 55 __ LDA T5 + 0 
1fe2 : c5 53 __ CMP T2 + 0 
1fe4 : b0 0e __ BCS $1ff4 ; (show_prg_loader_screen.s19 + 0)
.s20:
1fe6 : 8d fe 9f STA $9ffe ; (sstack + 0)
1fe9 : 8d ff 9f STA $9fff ; (sstack + 1)
1fec : 20 fe 22 JSR $22fe ; (draw_file_list.s4 + 0)
1fef : a5 55 __ LDA T5 + 0 
1ff1 : 4c be 1f JMP $1fbe ; (show_prg_loader_screen.l26 + 0)
.s19:
1ff4 : a5 53 __ LDA T2 + 0 
1ff6 : 85 15 __ STA P8 
1ff8 : a9 00 __ LDA #$00
1ffa : 85 16 __ STA P9 
1ffc : 20 4c 23 JSR $234c ; (draw_file_item.s4 + 0)
1fff : a5 55 __ LDA T5 + 0 
2001 : 85 14 __ STA P7 
2003 : e6 16 __ INC P9 
2005 : 20 4c 23 JSR $234c ; (draw_file_item.s4 + 0)
2008 : a5 14 __ LDA P7 
200a : 85 18 __ STA P11 
200c : 20 bb 24 JSR $24bb ; (draw_scroll_pos.s4 + 0)
200f : 4c c0 1f JMP $1fc0 ; (show_prg_loader_screen.l10 + 0)
.s15:
2012 : a5 47 __ LDA T3 + 0 
2014 : c9 0d __ CMP #$0d
2016 : d0 a8 __ BNE $1fc0 ; (show_prg_loader_screen.l10 + 0)
.s16:
2018 : a5 55 __ LDA T5 + 0 
201a : 8d fe 9f STA $9ffe ; (sstack + 0)
201d : 20 6a 25 JSR $256a ; (load_prg_to_sram.s4 + 0)
2020 : 4c 74 1f JMP $1f74 ; (show_prg_loader_screen.s3 + 0)
.s21:
2023 : 85 47 __ STA T3 + 0 
2025 : a5 54 __ LDA T4 + 0 
2027 : e9 01 __ SBC #$01
2029 : 90 e7 __ BCC $2012 ; (show_prg_loader_screen.s15 + 0)
.s25:
202b : 85 45 __ STA T1 + 0 
202d : a5 55 __ LDA T5 + 0 
202f : c5 45 __ CMP T1 + 0 
2031 : b0 df __ BCS $2012 ; (show_prg_loader_screen.s15 + 0)
.s22:
2033 : 85 14 __ STA P7 
2035 : e6 55 __ INC T5 + 0 
2037 : a5 53 __ LDA T2 + 0 
2039 : 69 0d __ ADC #$0d
203b : b0 b7 __ BCS $1ff4 ; (show_prg_loader_screen.s19 + 0)
.s24:
203d : 85 45 __ STA T1 + 0 
203f : a5 55 __ LDA T5 + 0 
2041 : c5 45 __ CMP T1 + 0 
2043 : 90 af __ BCC $1ff4 ; (show_prg_loader_screen.s19 + 0)
.s23:
2045 : 8d fe 9f STA $9ffe ; (sstack + 0)
2048 : 69 f3 __ ADC #$f3
204a : 85 53 __ STA T2 + 0 
204c : 8d ff 9f STA $9fff ; (sstack + 1)
204f : 20 fe 22 JSR $22fe ; (draw_file_list.s4 + 0)
2052 : 4c c0 1f JMP $1fc0 ; (show_prg_loader_screen.l10 + 0)
--------------------------------------------------------------------
2055 : __ __ __ BYT 43 41 52 49 43 41 20 50 52 47 20 44 41 20 46 4c : CARICA PRG DA FL
2065 : __ __ __ BYT 4f 50 50 59 00                                  : OPPY.
--------------------------------------------------------------------
206a : __ __ __ BYT 4c 45 54 54 55 52 41 20 44 49 52 45 43 54 4f 52 : LETTURA DIRECTOR
207a : __ __ __ BYT 59 2e 2e 2e 00                                  : Y....
--------------------------------------------------------------------
read_prg_directory: ; read_prg_directory()->bool
;1771, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
207f : a9 00 __ LDA #$00
2081 : 8d ff 32 STA $32ff ; (prg_count + 0)
2084 : a9 fd __ LDA #$fd
2086 : 85 0d __ STA P0 
2088 : a9 0c __ LDA #$0c
208a : 85 0e __ STA P1 
208c : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
208f : a9 02 __ LDA #$02
2091 : 85 0d __ STA P0 
2093 : a9 00 __ LDA #$00
2095 : 85 0f __ STA P2 
2097 : a9 08 __ LDA #$08
2099 : 85 0e __ STA P1 
209b : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
209e : aa __ __ TAX
209f : d0 03 __ BNE $20a4 ; (read_prg_directory.s5 + 0)
20a1 : 4c 1e 22 JMP $221e ; (read_prg_directory.s3 + 0)
.s5:
20a4 : a9 02 __ LDA #$02
20a6 : 20 71 22 JSR $2271 ; (krnio_chkin.s4 + 0)
20a9 : aa __ __ TAX
20aa : d0 03 __ BNE $20af ; (read_prg_directory.s6 + 0)
20ac : 4c 24 22 JMP $2224 ; (read_prg_directory.s42 + 0)
.s6:
20af : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
20b2 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
20b5 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
20b8 : 29 82 __ AND #$82
20ba : f0 03 __ BEQ $20bf ; (read_prg_directory.s7 + 0)
20bc : 4c 21 22 JMP $2221 ; (read_prg_directory.s41 + 0)
.s7:
20bf : a9 01 __ LDA #$01
.l43:
20c1 : 85 4a __ STA T6 + 0 
.l8:
20c3 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
20c6 : aa __ __ TAX
20c7 : d0 03 __ BNE $20cc ; (read_prg_directory.s10 + 0)
20c9 : 4c 14 22 JMP $2214 ; (read_prg_directory.s9 + 0)
.s10:
20cc : ad ff 32 LDA $32ff ; (prg_count + 0)
20cf : c9 1e __ CMP #$1e
20d1 : b0 f6 __ BCS $20c9 ; (read_prg_directory.l8 + 6)
.s11:
20d3 : 85 4b __ STA T7 + 0 
20d5 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
20d8 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
20db : 85 48 __ STA T5 + 0 
20dd : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
20e0 : 85 49 __ STA T5 + 1 
20e2 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
20e5 : 29 82 __ AND #$82
20e7 : d0 e0 __ BNE $20c9 ; (read_prg_directory.l8 + 6)
.s12:
20e9 : 85 47 __ STA T2 + 0 
.l13:
20eb : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
20ee : 85 45 __ STA T1 + 0 
20f0 : aa __ __ TAX
20f1 : f0 16 __ BEQ $2109 ; (read_prg_directory.s14 + 0)
.s38:
20f3 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
20f6 : 29 82 __ AND #$82
20f8 : d0 0f __ BNE $2109 ; (read_prg_directory.s14 + 0)
.s39:
20fa : a6 47 __ LDX T2 + 0 
20fc : e0 27 __ CPX #$27
20fe : b0 eb __ BCS $20eb ; (read_prg_directory.l13 + 0)
.s40:
2100 : a5 45 __ LDA T1 + 0 
2102 : 9d d6 9f STA $9fd6,x ; (buff[0] + 0)
2105 : e6 47 __ INC T2 + 0 
2107 : 90 e2 __ BCC $20eb ; (read_prg_directory.l13 + 0)
.s14:
2109 : a9 00 __ LDA #$00
210b : a6 47 __ LDX T2 + 0 
210d : 9d d6 9f STA $9fd6,x ; (buff[0] + 0)
2110 : a5 4a __ LDA T6 + 0 
2112 : f0 04 __ BEQ $2118 ; (read_prg_directory.s15 + 0)
.s37:
2114 : a9 00 __ LDA #$00
2116 : f0 a9 __ BEQ $20c1 ; (read_prg_directory.l43 + 0)
.s15:
2118 : ae d6 9f LDX $9fd6 ; (buff[0] + 0)
211b : f0 a6 __ BEQ $20c3 ; (read_prg_directory.l8 + 0)
.s16:
211d : 85 43 __ STA T0 + 0 
211f : e0 22 __ CPX #$22
2121 : f0 0d __ BEQ $2130 ; (read_prg_directory.s18 + 0)
.l36:
2123 : e6 43 __ INC T0 + 0 
2125 : a4 43 __ LDY T0 + 0 
2127 : be d6 9f LDX $9fd6,y ; (buff[0] + 0)
212a : f0 97 __ BEQ $20c3 ; (read_prg_directory.l8 + 0)
.s17:
212c : e0 22 __ CPX #$22
212e : d0 f3 __ BNE $2123 ; (read_prg_directory.l36 + 0)
.s18:
2130 : a6 43 __ LDX T0 + 0 
2132 : e8 __ __ INX
2133 : 86 45 __ STX T1 + 0 
2135 : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
2138 : f0 89 __ BEQ $20c3 ; (read_prg_directory.l8 + 0)
.l19:
213a : c9 22 __ CMP #$22
213c : f0 03 __ BEQ $2141 ; (read_prg_directory.s20 + 0)
213e : 4c 0b 22 JMP $220b ; (read_prg_directory.s35 + 0)
.s20:
2141 : 86 43 __ STX T0 + 0 
2143 : e8 __ __ INX
2144 : 86 47 __ STX T2 + 0 
2146 : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
2149 : d0 03 __ BNE $214e ; (read_prg_directory.l21 + 0)
214b : 4c c3 20 JMP $20c3 ; (read_prg_directory.l8 + 0)
.l21:
214e : c9 50 __ CMP #$50
2150 : d0 10 __ BNE $2162 ; (read_prg_directory.s22 + 0)
.s23:
2152 : a6 47 __ LDX T2 + 0 
2154 : bd d7 9f LDA $9fd7,x ; (buff[0] + 1)
2157 : c9 52 __ CMP #$52
2159 : d0 07 __ BNE $2162 ; (read_prg_directory.s22 + 0)
.s24:
215b : bd d8 9f LDA $9fd8,x ; (buff[0] + 2)
215e : c9 47 __ CMP #$47
2160 : f0 0b __ BEQ $216d ; (read_prg_directory.s25 + 0)
.s22:
2162 : e8 __ __ INX
2163 : 86 47 __ STX T2 + 0 
2165 : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
2168 : d0 e4 __ BNE $214e ; (read_prg_directory.l21 + 0)
216a : 4c c3 20 JMP $20c3 ; (read_prg_directory.l8 + 0)
.s25:
216d : a0 00 __ LDY #$00
.l26:
216f : 84 47 __ STY T2 + 0 
2171 : a5 45 __ LDA T1 + 0 
2173 : c5 43 __ CMP T0 + 0 
2175 : b0 2d __ BCS $21a4 ; (read_prg_directory.s27 + 0)
.s33:
2177 : c0 10 __ CPY #$10
2179 : b0 29 __ BCS $21a4 ; (read_prg_directory.s27 + 0)
.s34:
217b : a5 4b __ LDA T7 + 0 
217d : 85 1b __ STA ACCU + 0 
217f : a9 00 __ LDA #$00
2181 : 85 1c __ STA ACCU + 1 
2183 : a9 11 __ LDA #$11
2185 : 20 ce 48 JSR $48ce ; (mul16by8 + 0)
2188 : 18 __ __ CLC
2189 : a9 aa __ LDA #$aa
218b : 65 1b __ ADC ACCU + 0 
218d : 85 1b __ STA ACCU + 0 
218f : a9 4a __ LDA #$4a
2191 : 65 1c __ ADC ACCU + 1 
2193 : 85 1c __ STA ACCU + 1 
2195 : a6 45 __ LDX T1 + 0 
2197 : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
219a : a4 47 __ LDY T2 + 0 
219c : 91 1b __ STA (ACCU + 0),y 
219e : e6 45 __ INC T1 + 0 
21a0 : c8 __ __ INY
21a1 : 4c 6f 21 JMP $216f ; (read_prg_directory.l26 + 0)
.s27:
21a4 : 98 __ __ TYA
21a5 : f0 2b __ BEQ $21d2 ; (read_prg_directory.s28 + 0)
.s29:
21a7 : a5 4b __ LDA T7 + 0 
21a9 : 85 1b __ STA ACCU + 0 
21ab : a9 00 __ LDA #$00
21ad : 85 1c __ STA ACCU + 1 
21af : a9 11 __ LDA #$11
21b1 : 20 ce 48 JSR $48ce ; (mul16by8 + 0)
21b4 : 18 __ __ CLC
21b5 : a9 aa __ LDA #$aa
21b7 : 65 1b __ ADC ACCU + 0 
21b9 : 85 43 __ STA T0 + 0 
21bb : a9 4a __ LDA #$4a
21bd : 65 1c __ ADC ACCU + 1 
21bf : 85 44 __ STA T0 + 1 
.l30:
21c1 : a4 47 __ LDY T2 + 0 
21c3 : 88 __ __ DEY
21c4 : b1 43 __ LDA (T0 + 0),y 
21c6 : c9 a0 __ CMP #$a0
21c8 : f0 04 __ BEQ $21ce ; (read_prg_directory.s32 + 0)
.s31:
21ca : c9 20 __ CMP #$20
21cc : d0 04 __ BNE $21d2 ; (read_prg_directory.s28 + 0)
.s32:
21ce : c6 47 __ DEC T2 + 0 
21d0 : d0 ef __ BNE $21c1 ; (read_prg_directory.l30 + 0)
.s28:
21d2 : a5 4b __ LDA T7 + 0 
21d4 : 85 43 __ STA T0 + 0 
21d6 : 85 1b __ STA ACCU + 0 
21d8 : a9 00 __ LDA #$00
21da : 85 1c __ STA ACCU + 1 
21dc : a9 11 __ LDA #$11
21de : 20 ce 48 JSR $48ce ; (mul16by8 + 0)
21e1 : 18 __ __ CLC
21e2 : a9 aa __ LDA #$aa
21e4 : 65 1b __ ADC ACCU + 0 
21e6 : 85 45 __ STA T1 + 0 
21e8 : a9 4a __ LDA #$4a
21ea : 65 1c __ ADC ACCU + 1 
21ec : 85 46 __ STA T1 + 1 
21ee : a9 00 __ LDA #$00
21f0 : a4 47 __ LDY T2 + 0 
21f2 : 91 45 __ STA (T1 + 0),y 
21f4 : 06 43 __ ASL T0 + 0 
21f6 : a5 48 __ LDA T5 + 0 
21f8 : a6 43 __ LDX T0 + 0 
21fa : 9d a8 4c STA $4ca8,x ; (prg_blocks_arr[0] + 0)
21fd : a5 49 __ LDA T5 + 1 
21ff : 9d a9 4c STA $4ca9,x ; (prg_blocks_arr[0] + 1)
2202 : a6 4b __ LDX T7 + 0 
2204 : e8 __ __ INX
2205 : 8e ff 32 STX $32ff ; (prg_count + 0)
2208 : 4c c3 20 JMP $20c3 ; (read_prg_directory.l8 + 0)
.s35:
220b : e8 __ __ INX
220c : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
220f : f0 f7 __ BEQ $2208 ; (read_prg_directory.s28 + 54)
2211 : 4c 3a 21 JMP $213a ; (read_prg_directory.l19 + 0)
.s9:
2214 : 20 fa 18 JSR $18fa ; (krnio_clrchn.s4 + 0)
2217 : a9 02 __ LDA #$02
2219 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
221c : a9 01 __ LDA #$01
.s3:
221e : 85 1b __ STA ACCU + 0 
2220 : 60 __ __ RTS
.s41:
2221 : 20 fa 18 JSR $18fa ; (krnio_clrchn.s4 + 0)
.s42:
2224 : a9 02 __ LDA #$02
2226 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
2229 : a9 00 __ LDA #$00
222b : f0 f1 __ BEQ $221e ; (read_prg_directory.s3 + 0)
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
;  29, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
222d : a5 0d __ LDA P0 
222f : 05 0e __ ORA P1 
2231 : f0 08 __ BEQ $223b ; (krnio_setnam.s4 + 14)
2233 : a0 ff __ LDY #$ff
2235 : c8 __ __ INY
2236 : b1 0d __ LDA (P0),y 
2238 : d0 fb __ BNE $2235 ; (krnio_setnam.s4 + 8)
223a : 98 __ __ TYA
223b : a6 0d __ LDX P0 
223d : a4 0e __ LDY P1 
223f : 20 bd ff JSR $ffbd 
.s3:
2242 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_open: ; krnio_open(u8,u8,u8)->bool
;  35, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
2243 : a9 00 __ LDA #$00
2245 : a6 0d __ LDX P0 ; (fnum + 0)
2247 : 9d 9a 4a STA $4a9a,x ; (krnio_pstatus[0] + 0)
224a : a9 00 __ LDA #$00
224c : 85 1b __ STA ACCU + 0 
224e : 85 1c __ STA ACCU + 1 
2250 : a5 0d __ LDA P0 ; (fnum + 0)
2252 : a6 0e __ LDX P1 
2254 : a4 0f __ LDY P2 
2256 : 20 ba ff JSR $ffba 
2259 : 20 c0 ff JSR $ffc0 
225c : 90 08 __ BCC $2266 ; (krnio_open.s4 + 35)
225e : a5 0d __ LDA P0 ; (fnum + 0)
2260 : 20 c3 ff JSR $ffc3 
2263 : 4c 6a 22 JMP $226a ; (krnio_open.s4 + 39)
2266 : a9 01 __ LDA #$01
2268 : 85 1b __ STA ACCU + 0 
226a : a5 1b __ LDA ACCU + 0 
226c : f0 02 __ BEQ $2270 ; (krnio_open.s3 + 0)
.s5:
226e : a9 01 __ LDA #$01
.s3:
2270 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_chkin: ; krnio_chkin(u8)->bool
;  55, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
2271 : 85 0d __ STA P0 
2273 : a6 0d __ LDX P0 
2275 : 20 c6 ff JSR $ffc6 
2278 : a9 00 __ LDA #$00
227a : 2a __ __ ROL
227b : 49 01 __ EOR #$01
227d : 85 1b __ STA ACCU + 0 
227f : a5 1b __ LDA ACCU + 0 
2281 : f0 02 __ BEQ $2285 ; (krnio_chkin.s3 + 0)
.s5:
2283 : a9 01 __ LDA #$01
.s3:
2285 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_close: ; krnio_close(u8)->void
;  39, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
2286 : 85 0d __ STA P0 
2288 : a5 0d __ LDA P0 
228a : 20 c3 ff JSR $ffc3 
.s3:
228d : 60 __ __ RTS
--------------------------------------------------------------------
krnio_chrin: ; krnio_chrin()->u8
;  67, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
228e : 20 cf ff JSR $ffcf 
2291 : 85 1b __ STA ACCU + 0 
.s3:
2293 : a5 1b __ LDA ACCU + 0 
2295 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_status: ; krnio_status()->enum krnioerr
;  43, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
2296 : 20 b7 ff JSR $ffb7 
2299 : 85 1b __ STA ACCU + 0 
229b : a9 00 __ LDA #$00
229d : 85 1c __ STA ACCU + 1 
.s3:
229f : a5 1b __ LDA ACCU + 0 
22a1 : 60 __ __ RTS
--------------------------------------------------------------------
22a2 : __ __ __ BYT 45 52 52 4f 52 45 20 44 49 20 41 43 43 45 53 53 : ERRORE DI ACCESS
22b2 : __ __ __ BYT 4f 20 41 4c 4c 27 55 4e 49 54 41 27 20 38 21 00 : O ALL'UNITA' 8!.
--------------------------------------------------------------------
22c2 : __ __ __ BYT 56 45 52 49 46 49 43 41 20 4c 27 55 4e 49 54 41 : VERIFICA L'UNITA
22d2 : __ __ __ BYT 27 20 45 20 49 4c 20 46 4c 4f 50 50 59 20 44 49 : ' E IL FLOPPY DI
22e2 : __ __ __ BYT 53 4b 00                                        : SK.
--------------------------------------------------------------------
22e5 : __ __ __ BYT 4e 45 53 53 55 4e 20 46 49 4c 45 20 50 52 47 20 : NESSUN FILE PRG 
22f5 : __ __ __ BYT 54 52 4f 56 41 54 4f 21 00                      : TROVATO!.
--------------------------------------------------------------------
draw_file_list: ; draw_file_list(u8,u8)->void
;1925, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
22fe : ad ff 9f LDA $9fff ; (sstack + 1)
2301 : 85 4e __ STA T3 + 0 
2303 : 85 4c __ STA T1 + 0 
2305 : ad ff 32 LDA $32ff ; (prg_count + 0)
2308 : 85 4f __ STA T4 + 0 
230a : a9 00 __ LDA #$00
230c : 85 4d __ STA T2 + 0 
.l5:
230e : a5 4c __ LDA T1 + 0 
2310 : c5 4f __ CMP T4 + 0 
2312 : 90 10 __ BCC $2324 ; (draw_file_list.s6 + 0)
.s12:
2314 : a9 0b __ LDA #$0b
2316 : 85 0e __ STA P1 
2318 : a5 4d __ LDA T2 + 0 
231a : 69 06 __ ADC #$06
231c : 85 0d __ STA P0 
231e : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
2321 : 4c 3a 23 JMP $233a ; (draw_file_list.s10 + 0)
.s6:
2324 : 85 14 __ STA P7 
2326 : a6 4e __ LDX T3 + 0 
2328 : 86 15 __ STX P8 
232a : cd fe 9f CMP $9ffe ; (sstack + 0)
232d : d0 04 __ BNE $2333 ; (draw_file_list.s8 + 0)
.s7:
232f : a9 01 __ LDA #$01
2331 : d0 02 __ BNE $2335 ; (draw_file_list.s9 + 0)
.s8:
2333 : a9 00 __ LDA #$00
.s9:
2335 : 85 16 __ STA P9 
2337 : 20 4c 23 JSR $234c ; (draw_file_item.s4 + 0)
.s10:
233a : e6 4c __ INC T1 + 0 
233c : e6 4d __ INC T2 + 0 
233e : a5 4d __ LDA T2 + 0 
2340 : c9 0d __ CMP #$0d
2342 : d0 ca __ BNE $230e ; (draw_file_list.l5 + 0)
.s11:
2344 : ad fe 9f LDA $9ffe ; (sstack + 0)
2347 : 85 18 __ STA P11 
2349 : 4c bb 24 JMP $24bb ; (draw_scroll_pos.s4 + 0)
--------------------------------------------------------------------
draw_file_item: ; draw_file_item(u8,u8,bool)->void
;1893, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
234c : a5 14 __ LDA P7 ; (file_idx + 0)
234e : c5 15 __ CMP P8 ; (scroll_offset + 0)
2350 : 90 17 __ BCC $2369 ; (draw_file_item.s3 + 0)
.s5:
2352 : a5 15 __ LDA P8 ; (scroll_offset + 0)
2354 : 69 0c __ ADC #$0c
2356 : 90 04 __ BCC $235c ; (draw_file_item.s16 + 0)
.s17:
2358 : a5 14 __ LDA P7 ; (file_idx + 0)
235a : b0 08 __ BCS $2364 ; (draw_file_item.s6 + 0)
.s16:
235c : 85 43 __ STA T1 + 0 
235e : a5 14 __ LDA P7 ; (file_idx + 0)
2360 : c5 43 __ CMP T1 + 0 
2362 : b0 05 __ BCS $2369 ; (draw_file_item.s3 + 0)
.s6:
2364 : cd ff 32 CMP $32ff ; (prg_count + 0)
2367 : 90 01 __ BCC $236a ; (draw_file_item.s7 + 0)
.s3:
2369 : 60 __ __ RTS
.s7:
236a : 38 __ __ SEC
236b : e5 15 __ SBC P8 ; (scroll_offset + 0)
236d : 18 __ __ CLC
236e : 69 07 __ ADC #$07
2370 : 85 0d __ STA P0 
2372 : a9 0b __ LDA #$0b
2374 : 85 0e __ STA P1 
2376 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
2379 : a5 0d __ LDA P0 
237b : 85 11 __ STA P4 
237d : a9 01 __ LDA #$01
237f : 85 12 __ STA P5 
2381 : a5 16 __ LDA P9 ; (is_sel + 0)
2383 : f0 12 __ BEQ $2397 ; (draw_file_item.s8 + 0)
.s15:
2385 : a9 07 __ LDA #$07
2387 : 85 13 __ STA P6 
2389 : 85 49 __ STA T0 + 0 
238b : a9 fd __ LDA #$fd
238d : 85 0f __ STA P2 
238f : a9 0f __ LDA #$0f
2391 : 85 10 __ STA P3 
2393 : a9 03 __ LDA #$03
2395 : d0 10 __ BNE $23a7 ; (draw_file_item.s9 + 0)
.s8:
2397 : a9 01 __ LDA #$01
2399 : 85 13 __ STA P6 
239b : 85 49 __ STA T0 + 0 
239d : a9 fe __ LDA #$fe
239f : 85 0f __ STA P2 
23a1 : a9 10 __ LDA #$10
23a3 : 85 10 __ STA P3 
23a5 : a9 0f __ LDA #$0f
.s9:
23a7 : 85 4b __ STA T4 + 0 
23a9 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
23ac : a5 49 __ LDA T0 + 0 
23ae : 85 13 __ STA P6 
23b0 : a9 03 __ LDA #$03
23b2 : 85 12 __ STA P5 
23b4 : a5 14 __ LDA P7 ; (file_idx + 0)
23b6 : 85 1b __ STA ACCU + 0 
23b8 : a9 00 __ LDA #$00
23ba : 85 1c __ STA ACCU + 1 
23bc : a9 11 __ LDA #$11
23be : 20 ce 48 JSR $48ce ; (mul16by8 + 0)
23c1 : 18 __ __ CLC
23c2 : a9 aa __ LDA #$aa
23c4 : 65 1b __ ADC ACCU + 0 
23c6 : 85 0f __ STA P2 
23c8 : a9 4a __ LDA #$4a
23ca : 65 1c __ ADC ACCU + 1 
23cc : 85 10 __ STA P3 
23ce : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
23d1 : a5 14 __ LDA P7 ; (file_idx + 0)
23d3 : 0a __ __ ASL
23d4 : aa __ __ TAX
23d5 : bd a8 4c LDA $4ca8,x ; (prg_blocks_arr[0] + 0)
23d8 : 85 0d __ STA P0 
23da : bd a9 4c LDA $4ca9,x ; (prg_blocks_arr[0] + 1)
23dd : 85 0e __ STA P1 
23df : a9 ee __ LDA #$ee
23e1 : 85 0f __ STA P2 
23e3 : a9 9f __ LDA #$9f
23e5 : 85 10 __ STA P3 
23e7 : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
23ea : a9 ee __ LDA #$ee
23ec : 85 0d __ STA P0 
23ee : a9 9f __ LDA #$9f
23f0 : 85 0e __ STA P1 
23f2 : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
23f5 : a5 1b __ LDA ACCU + 0 
23f7 : 85 49 __ STA T0 + 0 
23f9 : a5 1c __ LDA ACCU + 1 
23fb : 85 4a __ STA T0 + 1 
23fd : a9 00 __ LDA #$00
23ff : 85 43 __ STA T1 + 0 
2401 : a2 20 __ LDX #$20
.l10:
2403 : a5 4a __ LDA T0 + 1 
2405 : 30 08 __ BMI $240f ; (draw_file_item.s12 + 0)
.s14:
2407 : d0 1b __ BNE $2424 ; (draw_file_item.s11 + 0)
.s13:
2409 : a5 49 __ LDA T0 + 0 
240b : c9 09 __ CMP #$09
240d : b0 15 __ BCS $2424 ; (draw_file_item.s11 + 0)
.s12:
240f : 8a __ __ TXA
2410 : a6 49 __ LDX T0 + 0 
2412 : 9d ee 9f STA $9fee,x ; (blk_str[0] + 0)
2415 : a9 00 __ LDA #$00
2417 : e6 49 __ INC T0 + 0 
2419 : 85 4a __ STA T0 + 1 
241b : e6 43 __ INC T1 + 0 
241d : a4 43 __ LDY T1 + 0 
241f : be b6 24 LDX $24b6,y 
2422 : d0 df __ BNE $2403 ; (draw_file_item.l10 + 0)
.s11:
2424 : a5 4b __ LDA T4 + 0 
2426 : 85 13 __ STA P6 
2428 : a9 00 __ LDA #$00
242a : a6 49 __ LDX T0 + 0 
242c : 9d ee 9f STA $9fee,x ; (blk_str[0] + 0)
242f : 38 __ __ SEC
2430 : a9 27 __ LDA #$27
2432 : e5 49 __ SBC T0 + 0 
2434 : 85 12 __ STA P5 
2436 : 4c 1e 0b JMP $0b1e ; (print_at.s4 + 0)
--------------------------------------------------------------------
uint16_to_str: ; uint16_to_str(u16,u8*)->void
; 121, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
2439 : a5 0e __ LDA P1 ; (val + 1)
243b : 05 0d __ ORA P0 ; (val + 0)
243d : d0 1a __ BNE $2459 ; (uint16_to_str.s5 + 0)
.s11:
243f : a9 30 __ LDA #$30
2441 : a0 00 __ LDY #$00
2443 : 84 44 __ STY T1 + 1 
2445 : 91 0f __ STA (P2),y ; (buf + 0)
2447 : a9 01 __ LDA #$01
.s8:
2449 : 85 0d __ STA P0 ; (val + 0)
244b : 18 __ __ CLC
244c : a5 10 __ LDA P3 ; (buf + 1)
244e : 65 44 __ ADC T1 + 1 
2450 : 85 0e __ STA P1 ; (val + 1)
2452 : a9 00 __ LDA #$00
2454 : a4 0f __ LDY P2 ; (buf + 0)
2456 : 91 0d __ STA (P0),y ; (val + 0)
.s3:
2458 : 60 __ __ RTS
.s5:
2459 : a9 00 __ LDA #$00
245b : 85 43 __ STA T1 + 0 
245d : 85 44 __ STA T1 + 1 
245f : 85 45 __ STA T2 + 0 
2461 : f0 27 __ BEQ $248a ; (uint16_to_str.l6 + 0)
.s10:
2463 : a5 0d __ LDA P0 ; (val + 0)
2465 : 85 1b __ STA ACCU + 0 
2467 : a5 0e __ LDA P1 ; (val + 1)
2469 : 85 1c __ STA ACCU + 1 
246b : a9 0a __ LDA #$0a
246d : 85 03 __ STA WORK + 0 
246f : a9 00 __ LDA #$00
2471 : 85 04 __ STA WORK + 1 
2473 : 20 3c 49 JSR $493c ; (divmod + 0)
2476 : a5 1b __ LDA ACCU + 0 
2478 : 85 0d __ STA P0 ; (val + 0)
247a : a5 1c __ LDA ACCU + 1 
247c : 85 0e __ STA P1 ; (val + 1)
247e : 18 __ __ CLC
247f : a5 05 __ LDA WORK + 2 
2481 : 69 30 __ ADC #$30
2483 : a6 45 __ LDX T2 + 0 
2485 : 9d f8 9f STA $9ff8,x ; (temp[0] + 0)
2488 : e6 45 __ INC T2 + 0 
.l6:
248a : a5 0d __ LDA P0 ; (val + 0)
248c : 05 0e __ ORA P1 ; (val + 1)
248e : d0 d3 __ BNE $2463 ; (uint16_to_str.s10 + 0)
.s7:
2490 : a6 45 __ LDX T2 + 0 
2492 : f0 1d __ BEQ $24b1 ; (uint16_to_str.s17 + 0)
.s9:
2494 : a5 10 __ LDA P3 ; (buf + 1)
2496 : 85 0e __ STA P1 ; (val + 1)
2498 : a9 00 __ LDA #$00
249a : 85 0d __ STA P0 ; (val + 0)
249c : a4 0f __ LDY P2 ; (buf + 0)
.l12:
249e : bd f7 9f LDA $9ff7,x ; (zero_buf[0] + 249)
24a1 : 91 0d __ STA (P0),y ; (val + 0)
24a3 : e6 43 __ INC T1 + 0 
24a5 : d0 02 __ BNE $24a9 ; (uint16_to_str.s14 + 0)
.s13:
24a7 : e6 44 __ INC T1 + 1 
.s14:
24a9 : c8 __ __ INY
24aa : d0 02 __ BNE $24ae ; (uint16_to_str.s16 + 0)
.s15:
24ac : e6 0e __ INC P1 ; (val + 1)
.s16:
24ae : ca __ __ DEX
24af : d0 ed __ BNE $249e ; (uint16_to_str.l12 + 0)
.s17:
24b1 : a5 43 __ LDA T1 + 0 
24b3 : 4c 49 24 JMP $2449 ; (uint16_to_str.s8 + 0)
--------------------------------------------------------------------
24b6 : __ __ __ BYT 20 42 4c 4b 00                                  :  BLK.
--------------------------------------------------------------------
draw_scroll_pos: ; draw_scroll_pos(u8)->void
;1872, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
24bb : a9 15 __ LDA #$15
24bd : 85 0d __ STA P0 
24bf : a9 0b __ LDA #$0b
24c1 : 85 0e __ STA P1 
24c3 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
24c6 : ad ff 32 LDA $32ff ; (prg_count + 0)
24c9 : c9 0e __ CMP #$0e
24cb : b0 01 __ BCS $24ce ; (draw_scroll_pos.s5 + 0)
.s3:
24cd : 60 __ __ RTS
.s5:
24ce : 85 4a __ STA T4 + 0 
24d0 : a5 18 __ LDA P11 ; (selected + 0)
24d2 : 69 00 __ ADC #$00
24d4 : 85 0d __ STA P0 
24d6 : a9 00 __ LDA #$00
24d8 : 2a __ __ ROL
24d9 : 85 0e __ STA P1 
24db : a9 e8 __ LDA #$e8
24dd : 85 0f __ STA P2 
24df : a9 9f __ LDA #$9f
24e1 : 85 10 __ STA P3 
24e3 : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
24e6 : a9 00 __ LDA #$00
24e8 : 85 49 __ STA T3 + 0 
24ea : 85 43 __ STA T0 + 0 
24ec : f0 09 __ BEQ $24f7 ; (draw_scroll_pos.l6 + 0)
.s10:
24ee : a6 49 __ LDX T3 + 0 
24f0 : 9d ee 9f STA $9fee,x ; (pos_str[0] + 0)
24f3 : e6 43 __ INC T0 + 0 
24f5 : e6 49 __ INC T3 + 0 
.l6:
24f7 : a6 43 __ LDX T0 + 0 
24f9 : bd e8 9f LDA $9fe8,x ; (num[0] + 0)
24fc : d0 f0 __ BNE $24ee ; (draw_scroll_pos.s10 + 0)
.s7:
24fe : a9 2f __ LDA #$2f
2500 : a6 49 __ LDX T3 + 0 
2502 : 9d ee 9f STA $9fee,x ; (pos_str[0] + 0)
2505 : a5 4a __ LDA T4 + 0 
2507 : 85 0d __ STA P0 
2509 : a9 00 __ LDA #$00
250b : 85 0e __ STA P1 
250d : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
2510 : a6 49 __ LDX T3 + 0 
2512 : e8 __ __ INX
2513 : 86 43 __ STX T0 + 0 
2515 : ad e8 9f LDA $9fe8 ; (num[0] + 0)
2518 : f0 14 __ BEQ $252e ; (draw_scroll_pos.s8 + 0)
.s9:
251a : a2 00 __ LDX #$00
251c : 86 45 __ STX T1 + 0 
.l11:
251e : a6 43 __ LDX T0 + 0 
2520 : 9d ee 9f STA $9fee,x ; (pos_str[0] + 0)
2523 : e6 43 __ INC T0 + 0 
2525 : e6 45 __ INC T1 + 0 
2527 : a6 45 __ LDX T1 + 0 
2529 : bd e8 9f LDA $9fe8,x ; (num[0] + 0)
252c : d0 f0 __ BNE $251e ; (draw_scroll_pos.l11 + 0)
.s8:
252e : a6 43 __ LDX T0 + 0 
2530 : 9d ee 9f STA $9fee,x ; (pos_str[0] + 0)
2533 : a9 15 __ LDA #$15
2535 : 85 16 __ STA P9 
2537 : a9 0f __ LDA #$0f
2539 : 85 17 __ STA P10 
253b : a9 ee __ LDA #$ee
253d : 85 14 __ STA P7 
253f : a9 9f __ LDA #$9f
2541 : 85 15 __ STA P8 
2543 : 4c 7e 0a JMP $0a7e ; (print_centered.s4 + 0)
--------------------------------------------------------------------
2546 : __ __ __ BYT 43 55 52 53 4f 52 49 3a 4e 41 56 49 47 41 20 52 : CURSORI:NAVIGA R
2556 : __ __ __ BYT 45 54 55 52 4e 3a 43 41 52 49 43 41 20 4d 3a 4d : ETURN:CARICA M:M
2566 : __ __ __ BYT 45 4e 55 00                                     : ENU.
--------------------------------------------------------------------
load_prg_to_sram: ; load_prg_to_sram(u8)->void
;1941, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
256a : a9 0b __ LDA #$0b
256c : 85 18 __ STA P11 
256e : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
2571 : a9 03 __ LDA #$03
2573 : 85 16 __ STA P9 
2575 : a9 20 __ LDA #$20
2577 : 85 15 __ STA P8 
2579 : a9 07 __ LDA #$07
257b : 85 17 __ STA P10 
257d : a9 55 __ LDA #$55
257f : 85 14 __ STA P7 
2581 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2584 : a9 0b __ LDA #$0b
2586 : 85 16 __ STA P9 
2588 : ad ff 18 LDA $18ff ; (sram_status + 0)
258b : d0 2a __ BNE $25b7 ; (load_prg_to_sram.s6 + 0)
.s5:
258d : a9 02 __ LDA #$02
258f : 85 17 __ STA P10 
2591 : a9 35 __ LDA #$35
2593 : 85 14 __ STA P7 
2595 : a9 1e __ LDA #$1e
.s41:
2597 : 85 15 __ STA P8 
2599 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s40:
259c : a9 17 __ LDA #$17
259e : 85 16 __ STA P9 
25a0 : a9 0c __ LDA #$0c
25a2 : 85 15 __ STA P8 
25a4 : a9 01 __ LDA #$01
25a6 : 85 17 __ STA P10 
25a8 : a9 d1 __ LDA #$d1
25aa : 85 14 __ STA P7 
25ac : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l24:
25af : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
25b2 : c9 0d __ CMP #$0d
25b4 : d0 f9 __ BNE $25af ; (load_prg_to_sram.l24 + 0)
.s3:
25b6 : 60 __ __ RTS
.s6:
25b7 : a9 03 __ LDA #$03
25b9 : 85 17 __ STA P10 
25bb : a9 27 __ LDA #$27
25bd : 85 15 __ STA P8 
25bf : a9 db __ LDA #$db
25c1 : 85 14 __ STA P7 
25c3 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
25c6 : ad fe 9f LDA $9ffe ; (sstack + 0)
25c9 : 85 1b __ STA ACCU + 0 
25cb : a9 00 __ LDA #$00
25cd : 85 43 __ STA T0 + 0 
25cf : 85 1c __ STA ACCU + 1 
25d1 : a9 11 __ LDA #$11
25d3 : 20 ce 48 JSR $48ce ; (mul16by8 + 0)
25d6 : 18 __ __ CLC
25d7 : a9 aa __ LDA #$aa
25d9 : 65 1b __ ADC ACCU + 0 
25db : 85 49 __ STA T1 + 0 
25dd : a9 4a __ LDA #$4a
25df : 65 1c __ ADC ACCU + 1 
25e1 : 85 4a __ STA T1 + 1 
25e3 : a0 00 __ LDY #$00
25e5 : b1 49 __ LDA (T1 + 0),y 
25e7 : f0 11 __ BEQ $25fa ; (load_prg_to_sram.s7 + 0)
.s35:
25e9 : a2 00 __ LDX #$00
.l37:
25eb : 9d e2 9f STA $9fe2,x ; (open_name[0] + 0)
25ee : e8 __ __ INX
25ef : c8 __ __ INY
25f0 : b1 49 __ LDA (T1 + 0),y 
25f2 : f0 04 __ BEQ $25f8 ; (load_prg_to_sram.s42 + 0)
.s36:
25f4 : e0 10 __ CPX #$10
25f6 : 90 f3 __ BCC $25eb ; (load_prg_to_sram.l37 + 0)
.s42:
25f8 : 86 43 __ STX T0 + 0 
.s7:
25fa : a9 2c __ LDA #$2c
25fc : a6 43 __ LDX T0 + 0 
25fe : 9d e2 9f STA $9fe2,x ; (open_name[0] + 0)
2601 : a9 50 __ LDA #$50
2603 : 9d e3 9f STA $9fe3,x ; (open_name[0] + 1)
2606 : a9 2c __ LDA #$2c
2608 : 9d e4 9f STA $9fe4,x ; (open_name[0] + 2)
260b : a9 52 __ LDA #$52
260d : 9d e5 9f STA $9fe5,x ; (open_name[0] + 3)
2610 : a9 00 __ LDA #$00
2612 : 9d e6 9f STA $9fe6,x ; (open_name[0] + 4)
2615 : a9 e2 __ LDA #$e2
2617 : 85 0d __ STA P0 
2619 : a9 9f __ LDA #$9f
261b : 85 0e __ STA P1 
261d : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
2620 : a9 03 __ LDA #$03
2622 : 85 0d __ STA P0 
2624 : 85 0f __ STA P2 
2626 : a9 08 __ LDA #$08
2628 : 85 0e __ STA P1 
262a : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
262d : aa __ __ TAX
262e : d0 37 __ BNE $2667 ; (load_prg_to_sram.s10 + 0)
.s8:
2630 : c6 17 __ DEC P10 
2632 : a9 0d __ LDA #$0d
2634 : 85 16 __ STA P9 
2636 : a9 00 __ LDA #$00
2638 : 85 14 __ STA P7 
263a : a9 28 __ LDA #$28
263c : 85 15 __ STA P8 
263e : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2641 : a9 ff __ LDA #$ff
2643 : 85 0d __ STA P0 
2645 : a9 0c __ LDA #$0c
2647 : 85 0e __ STA P1 
2649 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
264c : a9 0f __ LDA #$0f
264e : 85 0d __ STA P0 
2650 : 85 0f __ STA P2 
2652 : a9 08 __ LDA #$08
2654 : 85 0e __ STA P1 
2656 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
2659 : aa __ __ TAX
265a : d0 03 __ BNE $265f ; (load_prg_to_sram.s9 + 0)
265c : 4c 9c 25 JMP $259c ; (load_prg_to_sram.s40 + 0)
.s9:
265f : a9 0f __ LDA #$0f
2661 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
2664 : 4c 9c 25 JMP $259c ; (load_prg_to_sram.s40 + 0)
.s10:
2667 : a9 03 __ LDA #$03
2669 : 20 71 22 JSR $2271 ; (krnio_chkin.s4 + 0)
266c : aa __ __ TAX
266d : d0 14 __ BNE $2683 ; (load_prg_to_sram.s12 + 0)
.s11:
266f : a9 03 __ LDA #$03
2671 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
2674 : c6 17 __ DEC P10 
2676 : a9 0d __ LDA #$0d
2678 : 85 16 __ STA P9 
267a : a9 1f __ LDA #$1f
267c : 85 14 __ STA P7 
267e : a9 28 __ LDA #$28
2680 : 4c 97 25 JMP $2597 ; (load_prg_to_sram.s41 + 0)
.s12:
2683 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
2686 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
2689 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
268c : 85 4d __ STA T5 + 0 
268e : a9 00 __ LDA #$00
2690 : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
2693 : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
2696 : a9 00 __ LDA #$00
2698 : 8d 01 de STA $de01 
269b : 85 4e __ STA T6 + 0 
269d : 85 4f __ STA T7 + 0 
269f : 85 50 __ STA T8 + 0 
26a1 : 85 4b __ STA T2 + 0 
26a3 : 85 4c __ STA T2 + 1 
26a5 : a9 01 __ LDA #$01
26a7 : 85 51 __ STA T9 + 0 
.l13:
26a9 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
26ac : 85 49 __ STA T1 + 0 
26ae : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
26b1 : 85 1b __ STA ACCU + 0 
26b3 : 29 82 __ AND #$82
26b5 : f0 04 __ BEQ $26bb ; (load_prg_to_sram.s14 + 0)
.s34:
26b7 : c6 51 __ DEC T9 + 0 
26b9 : f0 38 __ BEQ $26f3 ; (load_prg_to_sram.s20 + 0)
.s14:
26bb : a5 49 __ LDA T1 + 0 
26bd : a6 4f __ LDX T7 + 0 
26bf : 9d 00 df STA $df00,x 
26c2 : a5 1b __ LDA ACCU + 0 
26c4 : 29 40 __ AND #$40
26c6 : 85 52 __ STA T10 + 0 
26c8 : e6 4f __ INC T7 + 0 
26ca : d0 23 __ BNE $26ef ; (load_prg_to_sram.s19 + 0)
.s15:
26cc : e6 4b __ INC T2 + 0 
26ce : d0 02 __ BNE $26d2 ; (load_prg_to_sram.s45 + 0)
.s44:
26d0 : e6 4c __ INC T2 + 1 
.s45:
26d2 : e6 4e __ INC T6 + 0 
26d4 : d0 0d __ BNE $26e3 ; (load_prg_to_sram.s18 + 0)
.s16:
26d6 : e6 50 __ INC T8 + 0 
26d8 : a5 50 __ LDA T8 + 0 
26da : c9 02 __ CMP #$02
26dc : b0 15 __ BCS $26f3 ; (load_prg_to_sram.s20 + 0)
.s17:
26de : a9 01 __ LDA #$01
26e0 : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
.s18:
26e3 : a5 4e __ LDA T6 + 0 
26e5 : 8d 01 de STA $de01 
26e8 : 29 0f __ AND #$0f
26ea : d0 03 __ BNE $26ef ; (load_prg_to_sram.s19 + 0)
26ec : 4c 8d 27 JMP $278d ; (load_prg_to_sram.s32 + 0)
.s19:
26ef : a5 52 __ LDA T10 + 0 
26f1 : f0 b6 __ BEQ $26a9 ; (load_prg_to_sram.l13 + 0)
.s20:
26f3 : a5 4f __ LDA T7 + 0 
26f5 : f0 06 __ BEQ $26fd ; (load_prg_to_sram.s21 + 0)
.s31:
26f7 : e6 4b __ INC T2 + 0 
26f9 : d0 02 __ BNE $26fd ; (load_prg_to_sram.s21 + 0)
.s43:
26fb : e6 4c __ INC T2 + 1 
.s21:
26fd : a5 4d __ LDA T5 + 0 
26ff : 8d 03 de STA $de03 
2702 : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
2705 : 20 fa 18 JSR $18fa ; (krnio_clrchn.s4 + 0)
2708 : a9 03 __ LDA #$03
270a : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
270d : a9 0f __ LDA #$0f
270f : 85 16 __ STA P9 
2711 : a5 51 __ LDA T9 + 0 
2713 : d0 0d __ BNE $2722 ; (load_prg_to_sram.s25 + 0)
.s22:
2715 : a9 02 __ LDA #$02
2717 : 85 17 __ STA P10 
2719 : a9 28 __ LDA #$28
271b : a2 71 __ LDX #$71
.s23:
271d : 86 14 __ STX P7 
271f : 4c 97 25 JMP $2597 ; (load_prg_to_sram.s41 + 0)
.s25:
2722 : a9 0d __ LDA #$0d
2724 : 85 17 __ STA P10 
2726 : a9 28 __ LDA #$28
2728 : 85 15 __ STA P8 
272a : a9 40 __ LDA #$40
272c : 85 14 __ STA P7 
272e : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2731 : a5 4b __ LDA T2 + 0 
2733 : 85 0d __ STA P0 
2735 : a5 4c __ LDA T2 + 1 
2737 : 85 0e __ STA P1 
2739 : a9 b7 __ LDA #$b7
273b : 85 0f __ STA P2 
273d : a9 9f __ LDA #$9f
273f : 85 10 __ STA P3 
2741 : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
2744 : a2 00 __ LDX #$00
2746 : 86 43 __ STX T0 + 0 
2748 : ad b7 9f LDA $9fb7 ; (num[0] + 0)
274b : f0 12 __ BEQ $275f ; (load_prg_to_sram.s26 + 0)
.s30:
274d : 86 49 __ STX T1 + 0 
.l38:
274f : a6 43 __ LDX T0 + 0 
2751 : 9d bd 9f STA $9fbd,x ; (pg_msg[0] + 0)
2754 : e6 43 __ INC T0 + 0 
2756 : e6 49 __ INC T1 + 0 
2758 : a6 49 __ LDX T1 + 0 
275a : bd b7 9f LDA $9fb7,x ; (num[0] + 0)
275d : d0 f0 __ BNE $274f ; (load_prg_to_sram.l38 + 0)
.s26:
275f : 85 49 __ STA T1 + 0 
2761 : a9 20 __ LDA #$20
.l27:
2763 : a6 43 __ LDX T0 + 0 
2765 : e0 18 __ CPX #$18
2767 : b0 10 __ BCS $2779 ; (load_prg_to_sram.s28 + 0)
.s29:
2769 : 9d bd 9f STA $9fbd,x ; (pg_msg[0] + 0)
276c : e6 43 __ INC T0 + 0 
276e : e6 49 __ INC T1 + 0 
2770 : a6 49 __ LDX T1 + 0 
2772 : bd 61 28 LDA $2861,x 
2775 : d0 ec __ BNE $2763 ; (load_prg_to_sram.l27 + 0)
.s46:
2777 : a6 43 __ LDX T0 + 0 
.s28:
2779 : a9 00 __ LDA #$00
277b : 9d bd 9f STA $9fbd,x ; (pg_msg[0] + 0)
277e : a9 11 __ LDA #$11
2780 : 85 16 __ STA P9 
2782 : a9 03 __ LDA #$03
2784 : 85 17 __ STA P10 
2786 : a9 9f __ LDA #$9f
2788 : a2 bd __ LDX #$bd
278a : 4c 1d 27 JMP $271d ; (load_prg_to_sram.s23 + 0)
.s32:
278d : a9 50 __ LDA #$50
278f : a2 00 __ LDX #$00
.l39:
2791 : 9d d6 9f STA $9fd6,x ; (pg_msg[0] + 0)
2794 : e8 __ __ INX
2795 : bd b9 15 LDA $15b9,x 
2798 : d0 f7 __ BNE $2791 ; (load_prg_to_sram.l39 + 0)
.s33:
279a : 86 49 __ STX T1 + 0 
279c : a9 20 __ LDA #$20
279e : 9d d6 9f STA $9fd6,x ; (pg_msg[0] + 0)
27a1 : a5 4e __ LDA T6 + 0 
27a3 : 4a __ __ LSR
27a4 : 4a __ __ LSR
27a5 : 4a __ __ LSR
27a6 : 4a __ __ LSR
27a7 : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
27aa : a6 49 __ LDX T1 + 0 
27ac : 9d d7 9f STA $9fd7,x ; (pg_msg[0] + 1)
27af : a9 00 __ LDA #$00
27b1 : 20 be 15 JSR $15be ; (hex_digit.s4 + 0)
27b4 : a6 49 __ LDX T1 + 0 
27b6 : 9d d8 9f STA $9fd8,x ; (pg_msg[0] + 2)
27b9 : a9 00 __ LDA #$00
27bb : 9d d9 9f STA $9fd9,x ; (pg_msg[0] + 3)
27be : a9 0d __ LDA #$0d
27c0 : 85 16 __ STA P9 
27c2 : a9 0f __ LDA #$0f
27c4 : 85 17 __ STA P10 
27c6 : a9 d6 __ LDA #$d6
27c8 : 85 14 __ STA P7 
27ca : a9 9f __ LDA #$9f
27cc : 85 15 __ STA P8 
27ce : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
27d1 : a5 52 __ LDA T10 + 0 
27d3 : f0 03 __ BEQ $27d8 ; (load_prg_to_sram.s33 + 62)
27d5 : 4c f3 26 JMP $26f3 ; (load_prg_to_sram.s20 + 0)
27d8 : 4c a9 26 JMP $26a9 ; (load_prg_to_sram.l13 + 0)
--------------------------------------------------------------------
27db : __ __ __ BYT 43 41 52 49 43 41 4d 45 4e 54 4f 20 49 4e 20 43 : CARICAMENTO IN C
27eb : __ __ __ BYT 4f 52 53 4f 2e 2e 2e 00                         : ORSO....
--------------------------------------------------------------------
27f3 : __ __ __ BYT 53 43 4f 4e 4f 53 43 49 55 54 4f 00             : SCONOSCIUTO.
--------------------------------------------------------------------
eeprom_status:
27ff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
2800 : __ __ __ BYT 45 52 52 4f 52 45 20 44 49 20 41 50 45 52 54 55 : ERRORE DI APERTU
2810 : __ __ __ BYT 52 41 20 49 4e 20 4c 45 54 54 55 52 41 21 00    : RA IN LETTURA!.
--------------------------------------------------------------------
281f : __ __ __ BYT 45 52 52 4f 52 45 20 44 49 20 43 4f 49 4e 56 4f : ERRORE DI COINVO
282f : __ __ __ BYT 4c 47 49 4d 45 4e 54 4f 20 43 41 4e 41 4c 45 21 : LGIMENTO CANALE!
283f : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
2840 : __ __ __ BYT 50 52 47 20 43 41 52 49 43 41 54 4f 20 49 4e 20 : PRG CARICATO IN 
2850 : __ __ __ BYT 53 52 41 4d 21 20 20 20 20 20 20 20 20 20 20 20 : SRAM!           
2860 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
2861 : __ __ __ BYT 20 50 41 47 49 4e 45 20 53 43 52 49 54 54 45 00 :  PAGINE SCRITTE.
--------------------------------------------------------------------
2871 : __ __ __ BYT 45 52 52 4f 52 45 20 44 4f 53 20 52 49 4c 45 56 : ERRORE DOS RILEV
2881 : __ __ __ BYT 41 54 4f 21 00                                  : ATO!.
--------------------------------------------------------------------
sram_backup: ; sram_backup()->void
;1580, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
2886 : a9 0b __ LDA #$0b
2888 : 85 18 __ STA P11 
288a : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
288d : a9 03 __ LDA #$03
288f : 85 16 __ STA P9 
2891 : a9 07 __ LDA #$07
2893 : 85 17 __ STA P10 
2895 : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
2898 : 85 4f __ STA T4 + 0 
289a : f0 03 __ BEQ $289f ; (sram_backup.s5 + 0)
289c : 4c 6d 29 JMP $296d ; (sram_backup.s17 + 0)
.s5:
289f : a9 00 __ LDA #$00
28a1 : 85 14 __ STA P7 
28a3 : a9 1b __ LDA #$1b
28a5 : 85 15 __ STA P8 
28a7 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
28aa : ad ff 27 LDA $27ff ; (eeprom_status + 0)
28ad : d0 11 __ BNE $28c0 ; (sram_backup.s7 + 0)
.s6:
28af : a9 0b __ LDA #$0b
28b1 : 85 16 __ STA P9 
28b3 : a9 02 __ LDA #$02
28b5 : 85 17 __ STA P10 
28b7 : a9 56 __ LDA #$56
28b9 : 85 14 __ STA P7 
28bb : a9 1e __ LDA #$1e
28bd : 4c 4d 29 JMP $294d ; (sram_backup.s20 + 0)
.s7:
28c0 : a9 0b __ LDA #$0b
28c2 : 85 16 __ STA P9 
28c4 : a9 29 __ LDA #$29
28c6 : 85 15 __ STA P8 
28c8 : a9 03 __ LDA #$03
28ca : 85 17 __ STA P10 
28cc : a9 91 __ LDA #$91
28ce : 85 14 __ STA P7 
28d0 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
28d3 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
28d6 : 85 50 __ STA T5 + 0 
28d8 : a5 4f __ LDA T4 + 0 
28da : d0 06 __ BNE $28e2 ; (sram_backup.s16 + 0)
.s8:
28dc : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
28df : 4c ea 28 JMP $28ea ; (sram_backup.s9 + 0)
.s16:
28e2 : a9 00 __ LDA #$00
28e4 : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
28e7 : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
.s9:
28ea : a9 00 __ LDA #$00
28ec : 85 51 __ STA T6 + 0 
28ee : a9 c0 __ LDA #$c0
28f0 : 85 4e __ STA T1 + 1 
28f2 : a5 4f __ LDA T4 + 0 
28f4 : d0 22 __ BNE $2918 ; (sram_backup.l15 + 0)
.s10:
28f6 : a5 51 __ LDA T6 + 0 
28f8 : 85 11 __ STA P4 
28fa : a5 4e __ LDA T1 + 1 
28fc : 85 13 __ STA P6 
28fe : a9 00 __ LDA #$00
2900 : 85 12 __ STA P5 
2902 : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
2905 : 85 14 __ STA P7 
2907 : 20 a4 29 JSR $29a4 ; (mdp_eeprom_write_cart_page.s4 + 0)
.l11:
290a : e6 51 __ INC T6 + 0 
290c : a5 51 __ LDA T6 + 0 
290e : c9 10 __ CMP #$10
2910 : b0 25 __ BCS $2937 ; (sram_backup.s12 + 0)
.s14:
2912 : e6 4e __ INC T1 + 1 
2914 : a5 4f __ LDA T4 + 0 
2916 : f0 de __ BEQ $28f6 ; (sram_backup.s10 + 0)
.l15:
2918 : a5 51 __ LDA T6 + 0 
291a : 8d 01 de STA $de01 
291d : a5 4e __ LDA T1 + 1 
291f : 85 1c __ STA ACCU + 1 
2921 : a2 00 __ LDX #$00
2923 : 86 1b __ STX ACCU + 0 
.l19:
2925 : a0 00 __ LDY #$00
2927 : b1 1b __ LDA (ACCU + 0),y 
2929 : 9d 00 df STA $df00,x 
292c : e6 1b __ INC ACCU + 0 
292e : d0 02 __ BNE $2932 ; (sram_backup.s22 + 0)
.s21:
2930 : e6 1c __ INC ACCU + 1 
.s22:
2932 : e8 __ __ INX
2933 : d0 f0 __ BNE $2925 ; (sram_backup.l19 + 0)
2935 : f0 d3 __ BEQ $290a ; (sram_backup.l11 + 0)
.s12:
2937 : a5 50 __ LDA T5 + 0 
2939 : 8d 03 de STA $de03 
293c : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
293f : a9 0f __ LDA #$0f
2941 : 85 16 __ STA P9 
2943 : a9 0d __ LDA #$0d
2945 : 85 17 __ STA P10 
2947 : a9 43 __ LDA #$43
2949 : 85 14 __ STA P7 
294b : a9 2a __ LDA #$2a
.s20:
294d : 85 15 __ STA P8 
294f : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2952 : a9 17 __ LDA #$17
2954 : 85 16 __ STA P9 
2956 : a9 0c __ LDA #$0c
2958 : 85 15 __ STA P8 
295a : a9 01 __ LDA #$01
295c : 85 17 __ STA P10 
295e : a9 d1 __ LDA #$d1
2960 : 85 14 __ STA P7 
2962 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l13:
2965 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
2968 : c9 0d __ CMP #$0d
296a : d0 f9 __ BNE $2965 ; (sram_backup.l13 + 0)
.s3:
296c : 60 __ __ RTS
.s17:
296d : a9 8d __ LDA #$8d
296f : 85 14 __ STA P7 
2971 : a9 1a __ LDA #$1a
2973 : 85 15 __ STA P8 
2975 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2978 : ad ff 18 LDA $18ff ; (sram_status + 0)
297b : f0 03 __ BEQ $2980 ; (sram_backup.s18 + 0)
297d : 4c c0 28 JMP $28c0 ; (sram_backup.s7 + 0)
.s18:
2980 : a9 0b __ LDA #$0b
2982 : 85 16 __ STA P9 
2984 : a9 02 __ LDA #$02
2986 : 85 17 __ STA P10 
2988 : a9 35 __ LDA #$35
298a : 85 14 __ STA P7 
298c : a9 1e __ LDA #$1e
298e : 4c 4d 29 JMP $294d ; (sram_backup.s20 + 0)
--------------------------------------------------------------------
2991 : __ __ __ BYT 42 41 43 4b 55 50 20 49 4e 20 43 4f 52 53 4f 2e : BACKUP IN CORSO.
29a1 : __ __ __ BYT 2e 2e 00                                        : ...
--------------------------------------------------------------------
mdp_eeprom_write_cart_page: ; mdp_eeprom_write_cart_page(u8,const u8*,u8)->bool
; 235, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
29a4 : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
29a7 : a5 11 __ LDA P4 ; (page + 0)
29a9 : 8d 01 de STA $de01 
29ac : a9 00 __ LDA #$00
29ae : 85 4b __ STA T4 + 0 
29b0 : 85 4c __ STA T4 + 1 
29b2 : a5 14 __ LDA P7 ; (eeprom_size_kb + 0)
29b4 : c9 20 __ CMP #$20
29b6 : f0 2c __ BEQ $29e4 ; (mdp_eeprom_write_cart_page.l10 + 0)
.s5:
29b8 : a5 12 __ LDA P5 ; (buffer + 0)
29ba : 85 47 __ STA T2 + 0 
29bc : a9 00 __ LDA #$00
29be : 85 46 __ STA T1 + 0 
29c0 : a5 13 __ LDA P6 ; (buffer + 1)
29c2 : 85 48 __ STA T2 + 1 
29c4 : a5 11 __ LDA P4 ; (page + 0)
29c6 : 85 0e __ STA P1 
.l6:
29c8 : a4 46 __ LDY T1 + 0 
29ca : 84 0f __ STY P2 
29cc : b1 47 __ LDA (T2 + 0),y 
29ce : 85 10 __ STA P3 
29d0 : 20 cb 0d JSR $0dcb ; (mdp_eeprom_write_byte.s4 + 0)
29d3 : a5 1b __ LDA ACCU + 0 
29d5 : f0 09 __ BEQ $29e0 ; (mdp_eeprom_write_cart_page.s7 + 0)
.s8:
29d7 : e6 46 __ INC T1 + 0 
29d9 : d0 ed __ BNE $29c8 ; (mdp_eeprom_write_cart_page.l6 + 0)
.s9:
29db : a9 01 __ LDA #$01
.s3:
29dd : 85 1b __ STA ACCU + 0 
29df : 60 __ __ RTS
.s7:
29e0 : a9 00 __ LDA #$00
29e2 : f0 f9 __ BEQ $29dd ; (mdp_eeprom_write_cart_page.s3 + 0)
.l10:
29e4 : a5 12 __ LDA P5 ; (buffer + 0)
29e6 : 85 49 __ STA T3 + 0 
29e8 : a2 00 __ LDX #$00
.l14:
29ea : 8a __ __ TXA
29eb : 18 __ __ CLC
29ec : 65 4b __ ADC T4 + 0 
29ee : 85 47 __ STA T2 + 0 
29f0 : a9 00 __ LDA #$00
29f2 : 2a __ __ ROL
29f3 : a8 __ __ TAY
29f4 : 65 13 __ ADC P6 ; (buffer + 1)
29f6 : 85 4a __ STA T3 + 1 
29f8 : 98 __ __ TYA
29f9 : 18 __ __ CLC
29fa : 69 df __ ADC #$df
29fc : 85 48 __ STA T2 + 1 
29fe : a4 47 __ LDY T2 + 0 
2a00 : b1 49 __ LDA (T3 + 0),y 
2a02 : a0 00 __ LDY #$00
2a04 : 91 47 __ STA (T2 + 0),y 
2a06 : e8 __ __ INX
2a07 : e0 40 __ CPX #$40
2a09 : d0 df __ BNE $29ea ; (mdp_eeprom_write_cart_page.l14 + 0)
.s15:
2a0b : 18 __ __ CLC
2a0c : a5 4b __ LDA T4 + 0 
2a0e : 69 3f __ ADC #$3f
2a10 : 85 47 __ STA T2 + 0 
2a12 : a8 __ __ TAY
2a13 : b1 12 __ LDA (P5),y ; (buffer + 0)
2a15 : 29 80 __ AND #$80
2a17 : 85 46 __ STA T1 + 0 
2a19 : a9 28 __ LDA #$28
2a1b : 85 49 __ STA T3 + 0 
.l11:
2a1d : a6 47 __ LDX T2 + 0 
2a1f : bd 00 df LDA $df00,x 
2a22 : 29 80 __ AND #$80
2a24 : c5 46 __ CMP T1 + 0 
2a26 : d0 12 __ BNE $2a3a ; (mdp_eeprom_write_cart_page.s12 + 0)
.s13:
2a28 : a5 4b __ LDA T4 + 0 
2a2a : 69 3f __ ADC #$3f
2a2c : 85 4b __ STA T4 + 0 
2a2e : a5 4c __ LDA T4 + 1 
2a30 : 69 00 __ ADC #$00
2a32 : 85 4c __ STA T4 + 1 
2a34 : c9 01 __ CMP #$01
2a36 : 90 ac __ BCC $29e4 ; (mdp_eeprom_write_cart_page.l10 + 0)
2a38 : b0 a1 __ BCS $29db ; (mdp_eeprom_write_cart_page.s9 + 0)
.s12:
2a3a : 20 ff 0d JSR $0dff ; (delay_0_5ms.s4 + 0)
2a3d : c6 49 __ DEC T3 + 0 
2a3f : d0 dc __ BNE $2a1d ; (mdp_eeprom_write_cart_page.l11 + 0)
2a41 : f0 9d __ BEQ $29e0 ; (mdp_eeprom_write_cart_page.s7 + 0)
--------------------------------------------------------------------
2a43 : __ __ __ BYT 42 41 43 4b 55 50 20 43 4f 4d 50 4c 45 54 41 54 : BACKUP COMPLETAT
2a53 : __ __ __ BYT 4f 21 20 20 20 20 20 20 20 20 20 20 20 20 20 20 : O!              
2a63 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
sram_restore: ; sram_restore()->void
;1637, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
2a64 : a9 0b __ LDA #$0b
2a66 : 85 18 __ STA P11 
2a68 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
2a6b : a9 03 __ LDA #$03
2a6d : 85 16 __ STA P9 
2a6f : a9 07 __ LDA #$07
2a71 : 85 17 __ STA P10 
2a73 : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
2a76 : f0 03 __ BEQ $2a7b ; (sram_restore.s5 + 0)
2a78 : 4c 30 2b JMP $2b30 ; (sram_restore.s15 + 0)
.s5:
2a7b : a9 00 __ LDA #$00
2a7d : 85 14 __ STA P7 
2a7f : a9 1b __ LDA #$1b
2a81 : 85 15 __ STA P8 
2a83 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2a86 : ad ff 27 LDA $27ff ; (eeprom_status + 0)
2a89 : d0 2e __ BNE $2ab9 ; (sram_restore.s7 + 0)
.s6:
2a8b : a9 0b __ LDA #$0b
2a8d : 85 16 __ STA P9 
2a8f : a9 02 __ LDA #$02
2a91 : 85 17 __ STA P10 
2a93 : a9 56 __ LDA #$56
2a95 : 85 14 __ STA P7 
2a97 : a9 1e __ LDA #$1e
.s18:
2a99 : 85 15 __ STA P8 
2a9b : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2a9e : a9 17 __ LDA #$17
2aa0 : 85 16 __ STA P9 
2aa2 : a9 0c __ LDA #$0c
2aa4 : 85 15 __ STA P8 
2aa6 : a9 01 __ LDA #$01
2aa8 : 85 17 __ STA P10 
2aaa : a9 d1 __ LDA #$d1
2aac : 85 14 __ STA P7 
2aae : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l13:
2ab1 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
2ab4 : c9 0d __ CMP #$0d
2ab6 : d0 f9 __ BNE $2ab1 ; (sram_restore.l13 + 0)
.s3:
2ab8 : 60 __ __ RTS
.s7:
2ab9 : a9 0b __ LDA #$0b
2abb : 85 16 __ STA P9 
2abd : a9 2b __ LDA #$2b
2abf : 85 15 __ STA P8 
2ac1 : a9 03 __ LDA #$03
2ac3 : 85 17 __ STA P10 
2ac5 : a9 54 __ LDA #$54
2ac7 : 85 14 __ STA P7 
2ac9 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2acc : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
2acf : 85 4d __ STA T5 + 0 
2ad1 : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
2ad4 : d0 06 __ BNE $2adc ; (sram_restore.s14 + 0)
.s8:
2ad6 : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
2ad9 : 4c e4 2a JMP $2ae4 ; (sram_restore.s9 + 0)
.s14:
2adc : a9 00 __ LDA #$00
2ade : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
2ae1 : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
.s9:
2ae4 : a9 c0 __ LDA #$c0
2ae6 : 85 4a __ STA T1 + 1 
2ae8 : a9 00 __ LDA #$00
2aea : 85 4e __ STA T6 + 0 
.l10:
2aec : 8d 01 de STA $de01 
2aef : a5 4a __ LDA T1 + 1 
2af1 : 85 4c __ STA T2 + 1 
2af3 : a9 00 __ LDA #$00
2af5 : 85 4b __ STA T2 + 0 
.l17:
2af7 : 85 0d __ STA P0 
2af9 : 20 01 17 JSR $1701 ; (mdp_read_byte.s4 + 0)
2afc : a0 00 __ LDY #$00
2afe : 91 4b __ STA (T2 + 0),y 
2b00 : e6 4b __ INC T2 + 0 
2b02 : d0 02 __ BNE $2b06 ; (sram_restore.s20 + 0)
.s19:
2b04 : e6 4c __ INC T2 + 1 
.s20:
2b06 : 18 __ __ CLC
2b07 : a5 0d __ LDA P0 
2b09 : 69 01 __ ADC #$01
2b0b : d0 ea __ BNE $2af7 ; (sram_restore.l17 + 0)
.s11:
2b0d : e6 4a __ INC T1 + 1 
2b0f : e6 4e __ INC T6 + 0 
2b11 : a5 4e __ LDA T6 + 0 
2b13 : c9 10 __ CMP #$10
2b15 : 90 d5 __ BCC $2aec ; (sram_restore.l10 + 0)
.s12:
2b17 : a5 4d __ LDA T5 + 0 
2b19 : 8d 03 de STA $de03 
2b1c : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
2b1f : a9 0f __ LDA #$0f
2b21 : 85 16 __ STA P9 
2b23 : a9 0d __ LDA #$0d
2b25 : 85 17 __ STA P10 
2b27 : a9 6b __ LDA #$6b
2b29 : 85 14 __ STA P7 
2b2b : a9 2b __ LDA #$2b
2b2d : 4c 99 2a JMP $2a99 ; (sram_restore.s18 + 0)
.s15:
2b30 : a9 8d __ LDA #$8d
2b32 : 85 14 __ STA P7 
2b34 : a9 1a __ LDA #$1a
2b36 : 85 15 __ STA P8 
2b38 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2b3b : ad ff 18 LDA $18ff ; (sram_status + 0)
2b3e : f0 03 __ BEQ $2b43 ; (sram_restore.s16 + 0)
2b40 : 4c b9 2a JMP $2ab9 ; (sram_restore.s7 + 0)
.s16:
2b43 : a9 0b __ LDA #$0b
2b45 : 85 16 __ STA P9 
2b47 : a9 02 __ LDA #$02
2b49 : 85 17 __ STA P10 
2b4b : a9 35 __ LDA #$35
2b4d : 85 14 __ STA P7 
2b4f : a9 1e __ LDA #$1e
2b51 : 4c 99 2a JMP $2a99 ; (sram_restore.s18 + 0)
--------------------------------------------------------------------
2b54 : __ __ __ BYT 52 49 50 52 49 53 54 49 4e 4f 20 49 4e 20 43 4f : RIPRISTINO IN CO
2b64 : __ __ __ BYT 52 53 4f 2e 2e 2e 00                            : RSO....
--------------------------------------------------------------------
2b6b : __ __ __ BYT 52 49 50 52 49 53 54 49 4e 4f 20 43 4f 4d 50 4c : RIPRISTINO COMPL
2b7b : __ __ __ BYT 45 54 41 54 4f 21 20 20 20 20 20 20 20 20 20 20 : ETATO!          
2b8b : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
check_floppy: ; check_floppy()->void
; 237, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
2b8c : a5 53 __ LDA T7 + 0 
2b8e : 8d 2c 9f STA $9f2c ; (check_floppy@stack + 0)
2b91 : a5 54 __ LDA T8 + 0 
2b93 : 8d 2d 9f STA $9f2d ; (check_floppy@stack + 1)
.s4:
2b96 : a9 53 __ LDA #$53
2b98 : a0 00 __ LDY #$00
.l120:
2b9a : 99 e4 9f STA $9fe4,y ; (disk_name[0] + 0)
2b9d : c8 __ __ INY
2b9e : b9 f3 27 LDA $27f3,y 
2ba1 : d0 f7 __ BNE $2b9a ; (check_floppy.l120 + 0)
.s5:
2ba3 : 99 e4 9f STA $9fe4,y ; (disk_name[0] + 0)
2ba6 : 85 4f __ STA T4 + 0 
2ba8 : 85 50 __ STA T4 + 1 
.l6:
2baa : a9 0b __ LDA #$0b
2bac : 85 18 __ STA P11 
2bae : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
2bb1 : a9 03 __ LDA #$03
2bb3 : 85 16 __ STA P9 
2bb5 : a9 07 __ LDA #$07
2bb7 : 85 17 __ STA P10 
2bb9 : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
2bbc : 85 52 __ STA T6 + 0 
2bbe : d0 07 __ BNE $2bc7 ; (check_floppy.s119 + 0)
.s7:
2bc0 : a9 10 __ LDA #$10
2bc2 : a0 cb __ LDY #$cb
2bc4 : 4c cb 2b JMP $2bcb ; (check_floppy.s8 + 0)
.s119:
2bc7 : a9 30 __ LDA #$30
2bc9 : a0 a7 __ LDY #$a7
.s8:
2bcb : 84 14 __ STY P7 
2bcd : 85 15 __ STA P8 
2bcf : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2bd2 : a9 0b __ LDA #$0b
2bd4 : 85 16 __ STA P9 
2bd6 : a9 30 __ LDA #$30
2bd8 : 85 15 __ STA P8 
2bda : a9 03 __ LDA #$03
2bdc : 85 17 __ STA P10 
2bde : a9 bd __ LDA #$bd
2be0 : 85 14 __ STA P7 
2be2 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2be5 : a9 00 __ LDA #$00
2be7 : 8d bc 9f STA $9fbc ; (dos_status[0] + 0)
2bea : 20 fa 18 JSR $18fa ; (krnio_clrchn.s4 + 0)
2bed : a9 da __ LDA #$da
2bef : 85 0d __ STA P0 
2bf1 : a9 30 __ LDA #$30
2bf3 : 85 0e __ STA P1 
2bf5 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
2bf8 : a9 0f __ LDA #$0f
2bfa : 85 0d __ STA P0 
2bfc : 85 0f __ STA P2 
2bfe : a9 08 __ LDA #$08
2c00 : 85 0e __ STA P1 
2c02 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
2c05 : aa __ __ TAX
2c06 : d0 03 __ BNE $2c0b ; (check_floppy.s27 + 0)
2c08 : 4c a2 30 JMP $30a2 ; (check_floppy.s9 + 0)
.s27:
2c0b : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
2c0e : aa __ __ TAX
2c0f : 10 08 __ BPL $2c19 ; (check_floppy.s28 + 0)
.s118:
2c11 : a9 0f __ LDA #$0f
2c13 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
2c16 : 4c a2 30 JMP $30a2 ; (check_floppy.s9 + 0)
.s28:
2c19 : a9 28 __ LDA #$28
2c1b : 85 10 __ STA P3 
2c1d : a9 9f __ LDA #$9f
2c1f : 85 0f __ STA P2 
2c21 : a9 00 __ LDA #$00
2c23 : 85 11 __ STA P4 
2c25 : a9 bc __ LDA #$bc
2c27 : 85 0e __ STA P1 
2c29 : 20 dd 30 JSR $30dd ; (read_dos_status.s4 + 0)
2c2c : a9 bc __ LDA #$bc
2c2e : 85 0d __ STA P0 
2c30 : a9 9f __ LDA #$9f
2c32 : 85 0e __ STA P1 
2c34 : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
2c37 : a5 1c __ LDA ACCU + 1 
2c39 : 30 08 __ BMI $2c43 ; (check_floppy.s29 + 0)
.s117:
2c3b : d0 0a __ BNE $2c47 ; (check_floppy.s109 + 0)
.s116:
2c3d : a5 1b __ LDA ACCU + 0 
2c3f : c9 02 __ CMP #$02
2c41 : b0 04 __ BCS $2c47 ; (check_floppy.s109 + 0)
.s29:
2c43 : a9 01 __ LDA #$01
2c45 : d0 23 __ BNE $2c6a ; (check_floppy.s30 + 0)
.s109:
2c47 : ad bc 9f LDA $9fbc ; (dos_status[0] + 0)
2c4a : c9 37 __ CMP #$37
2c4c : d0 03 __ BNE $2c51 ; (check_floppy.s110 + 0)
2c4e : 4c 8e 30 JMP $308e ; (check_floppy.s114 + 0)
.s110:
2c51 : c9 30 __ CMP #$30
2c53 : d0 07 __ BNE $2c5c ; (check_floppy.s113 + 0)
.s111:
2c55 : ad bd 9f LDA $9fbd ; (dos_status[0] + 1)
2c58 : c9 30 __ CMP #$30
2c5a : f0 0c __ BEQ $2c68 ; (check_floppy.s112 + 0)
.s113:
2c5c : a9 0f __ LDA #$0f
.s123:
2c5e : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s32:
2c61 : a9 03 __ LDA #$03
.s124:
2c63 : 85 53 __ STA T7 + 0 
2c65 : 4c 71 2d JMP $2d71 ; (check_floppy.s10 + 0)
.s112:
2c68 : a9 00 __ LDA #$00
.s30:
2c6a : 85 53 __ STA T7 + 0 
2c6c : a9 0f __ LDA #$0f
2c6e : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
2c71 : a5 53 __ LDA T7 + 0 
2c73 : d0 f0 __ BNE $2c65 ; (check_floppy.s124 + 2)
.s31:
2c75 : a9 fd __ LDA #$fd
2c77 : 85 0d __ STA P0 
2c79 : a9 0c __ LDA #$0c
2c7b : 85 0e __ STA P1 
2c7d : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
2c80 : a9 02 __ LDA #$02
2c82 : 85 0d __ STA P0 
2c84 : a9 00 __ LDA #$00
2c86 : 85 0f __ STA P2 
2c88 : a9 08 __ LDA #$08
2c8a : 85 0e __ STA P1 
2c8c : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
2c8f : aa __ __ TAX
2c90 : f0 cf __ BEQ $2c61 ; (check_floppy.s32 + 0)
.s33:
2c92 : a9 02 __ LDA #$02
2c94 : 20 71 22 JSR $2271 ; (krnio_chkin.s4 + 0)
2c97 : aa __ __ TAX
2c98 : d0 04 __ BNE $2c9e ; (check_floppy.s35 + 0)
.s34:
2c9a : a9 02 __ LDA #$02
2c9c : d0 c0 __ BNE $2c5e ; (check_floppy.s123 + 0)
.s35:
2c9e : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
2ca1 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
2ca4 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
2ca7 : 29 82 __ AND #$82
2ca9 : f0 0b __ BEQ $2cb6 ; (check_floppy.s36 + 0)
.s108:
2cab : a9 03 __ LDA #$03
2cad : 85 53 __ STA T7 + 0 
2caf : a9 00 __ LDA #$00
2cb1 : 85 54 __ STA T8 + 0 
2cb3 : 4c 62 2d JMP $2d62 ; (check_floppy.s38 + 0)
.s36:
2cb6 : a9 01 __ LDA #$01
2cb8 : 85 54 __ STA T8 + 0 
.l125:
2cba : 85 51 __ STA T5 + 0 
2cbc : 4c c7 2c JMP $2cc7 ; (check_floppy.l37 + 0)
.s92:
2cbf : a5 4c __ LDA T2 + 0 
2cc1 : 85 4f __ STA T4 + 0 
2cc3 : a5 4d __ LDA T2 + 1 
2cc5 : 85 50 __ STA T4 + 1 
.l37:
2cc7 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
2cca : aa __ __ TAX
2ccb : f0 e6 __ BEQ $2cb3 ; (check_floppy.s108 + 8)
.s88:
2ccd : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
2cd0 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
2cd3 : 85 4c __ STA T2 + 0 
2cd5 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
2cd8 : 85 4d __ STA T2 + 1 
2cda : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
2cdd : 29 82 __ AND #$82
2cdf : d0 d2 __ BNE $2cb3 ; (check_floppy.s108 + 8)
.s89:
2ce1 : 85 4e __ STA T3 + 0 
.l90:
2ce3 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
2ce6 : 85 4b __ STA T1 + 0 
2ce8 : aa __ __ TAX
2ce9 : f0 07 __ BEQ $2cf2 ; (check_floppy.s91 + 0)
.s105:
2ceb : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
2cee : 29 82 __ AND #$82
2cf0 : f0 61 __ BEQ $2d53 ; (check_floppy.s106 + 0)
.s91:
2cf2 : a9 00 __ LDA #$00
2cf4 : a6 4e __ LDX T3 + 0 
2cf6 : 9d 94 9f STA $9f94,x ; (buff[0] + 0)
2cf9 : a5 51 __ LDA T5 + 0 
2cfb : f0 c2 __ BEQ $2cbf ; (check_floppy.s92 + 0)
.s93:
2cfd : ad 94 9f LDA $9f94 ; (buff[0] + 0)
2d00 : f0 b8 __ BEQ $2cba ; (check_floppy.l125 + 0)
.s94:
2d02 : a0 00 __ LDY #$00
2d04 : 84 49 __ STY T0 + 0 
2d06 : c9 22 __ CMP #$22
2d08 : f0 0d __ BEQ $2d17 ; (check_floppy.s96 + 0)
.l104:
2d0a : e6 49 __ INC T0 + 0 
2d0c : a4 49 __ LDY T0 + 0 
2d0e : b9 94 9f LDA $9f94,y ; (buff[0] + 0)
2d11 : f0 a7 __ BEQ $2cba ; (check_floppy.l125 + 0)
.s95:
2d13 : c9 22 __ CMP #$22
2d15 : d0 f3 __ BNE $2d0a ; (check_floppy.l104 + 0)
.s96:
2d17 : c8 __ __ INY
2d18 : 84 49 __ STY T0 + 0 
2d1a : 84 4b __ STY T1 + 0 
2d1c : b9 94 9f LDA $9f94,y ; (buff[0] + 0)
2d1f : f0 0c __ BEQ $2d2d ; (check_floppy.s97 + 0)
.l102:
2d21 : c9 22 __ CMP #$22
2d23 : f0 06 __ BEQ $2d2b ; (check_floppy.s126 + 0)
.s103:
2d25 : c8 __ __ INY
2d26 : b9 94 9f LDA $9f94,y ; (buff[0] + 0)
2d29 : d0 f6 __ BNE $2d21 ; (check_floppy.l102 + 0)
.s126:
2d2b : 84 49 __ STY T0 + 0 
.s97:
2d2d : a9 00 __ LDA #$00
2d2f : 85 4c __ STA T2 + 0 
2d31 : f0 0a __ BEQ $2d3d ; (check_floppy.l98 + 0)
.s101:
2d33 : bd 94 9f LDA $9f94,x ; (buff[0] + 0)
2d36 : 99 e4 9f STA $9fe4,y ; (disk_name[0] + 0)
2d39 : e6 4b __ INC T1 + 0 
2d3b : e6 4c __ INC T2 + 0 
.l98:
2d3d : a6 4b __ LDX T1 + 0 
2d3f : e4 49 __ CPX T0 + 0 
2d41 : b0 06 __ BCS $2d49 ; (check_floppy.s99 + 0)
.s100:
2d43 : a4 4c __ LDY T2 + 0 
2d45 : c0 10 __ CPY #$10
2d47 : 90 ea __ BCC $2d33 ; (check_floppy.s101 + 0)
.s99:
2d49 : a9 00 __ LDA #$00
2d4b : a6 4c __ LDX T2 + 0 
2d4d : 9d e4 9f STA $9fe4,x ; (disk_name[0] + 0)
2d50 : 4c ba 2c JMP $2cba ; (check_floppy.l125 + 0)
.s106:
2d53 : a4 4e __ LDY T3 + 0 
2d55 : c0 27 __ CPY #$27
2d57 : b0 8a __ BCS $2ce3 ; (check_floppy.l90 + 0)
.s107:
2d59 : a5 4b __ LDA T1 + 0 
2d5b : 99 94 9f STA $9f94,y ; (buff[0] + 0)
2d5e : e6 4e __ INC T3 + 0 
2d60 : 90 81 __ BCC $2ce3 ; (check_floppy.l90 + 0)
.s38:
2d62 : 20 fa 18 JSR $18fa ; (krnio_clrchn.s4 + 0)
2d65 : a9 02 __ LDA #$02
2d67 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
2d6a : a5 54 __ LDA T8 + 0 
2d6c : f0 03 __ BEQ $2d71 ; (check_floppy.s10 + 0)
2d6e : 4c 6b 2e JMP $2e6b ; (check_floppy.s39 + 0)
.s10:
2d71 : a9 0b __ LDA #$0b
2d73 : 85 18 __ STA P11 
2d75 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
2d78 : a9 03 __ LDA #$03
2d7a : 85 16 __ STA P9 
2d7c : a9 07 __ LDA #$07
2d7e : 85 17 __ STA P10 
2d80 : a5 52 __ LDA T6 + 0 
2d82 : d0 07 __ BNE $2d8b ; (check_floppy.s26 + 0)
.s11:
2d84 : a9 10 __ LDA #$10
2d86 : a0 cb __ LDY #$cb
2d88 : 4c 8f 2d JMP $2d8f ; (check_floppy.s12 + 0)
.s26:
2d8b : a9 30 __ LDA #$30
2d8d : a0 a7 __ LDY #$a7
.s12:
2d8f : 84 14 __ STY P7 
2d91 : 85 15 __ STA P8 
2d93 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2d96 : a9 02 __ LDA #$02
2d98 : 85 17 __ STA P10 
2d9a : a5 53 __ LDA T7 + 0 
2d9c : c9 01 __ CMP #$01
2d9e : d0 13 __ BNE $2db3 ; (check_floppy.s13 + 0)
.s25:
2da0 : a9 0b __ LDA #$0b
2da2 : 85 16 __ STA P9 
2da4 : a9 8d __ LDA #$8d
2da6 : 85 14 __ STA P7 
2da8 : a9 31 __ LDA #$31
2daa : 85 15 __ STA P8 
2dac : a9 31 __ LDA #$31
2dae : a0 b1 __ LDY #$b1
2db0 : 4c 0e 2e JMP $2e0e ; (check_floppy.s16 + 0)
.s13:
2db3 : c9 02 __ CMP #$02
2db5 : d0 13 __ BNE $2dca ; (check_floppy.s14 + 0)
.s24:
2db7 : a9 0b __ LDA #$0b
2db9 : 85 16 __ STA P9 
2dbb : a9 d9 __ LDA #$d9
2dbd : 85 14 __ STA P7 
2dbf : a9 31 __ LDA #$31
2dc1 : 85 15 __ STA P8 
2dc3 : a9 32 __ LDA #$32
2dc5 : a0 00 __ LDY #$00
2dc7 : 4c 0e 2e JMP $2e0e ; (check_floppy.s16 + 0)
.s14:
2dca : c9 03 __ CMP #$03
2dcc : f0 13 __ BEQ $2de1 ; (check_floppy.s20 + 0)
.s15:
2dce : a9 0b __ LDA #$0b
2dd0 : 85 16 __ STA P9 
2dd2 : a9 a2 __ LDA #$a2
2dd4 : 85 14 __ STA P7 
2dd6 : a9 22 __ LDA #$22
2dd8 : 85 15 __ STA P8 
2dda : a9 22 __ LDA #$22
2ddc : a0 c2 __ LDY #$c2
2dde : 4c 0e 2e JMP $2e0e ; (check_floppy.s16 + 0)
.s20:
2de1 : a9 09 __ LDA #$09
2de3 : 85 16 __ STA P9 
2de5 : a9 28 __ LDA #$28
2de7 : 85 15 __ STA P8 
2de9 : a9 71 __ LDA #$71
2deb : 85 14 __ STA P7 
2ded : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2df0 : e6 17 __ INC P10 
2df2 : a9 0b __ LDA #$0b
2df4 : 85 16 __ STA P9 
2df6 : ad bc 9f LDA $9fbc ; (dos_status[0] + 0)
2df9 : d0 07 __ BNE $2e02 ; (check_floppy.s23 + 0)
.s21:
2dfb : a9 32 __ LDA #$32
2dfd : a0 24 __ LDY #$24
2dff : 4c 06 2e JMP $2e06 ; (check_floppy.s22 + 0)
.s23:
2e02 : a9 9f __ LDA #$9f
2e04 : a0 bc __ LDY #$bc
.s22:
2e06 : 84 14 __ STY P7 
2e08 : 85 15 __ STA P8 
2e0a : a9 32 __ LDA #$32
2e0c : a0 45 __ LDY #$45
.s16:
2e0e : 84 49 __ STY T0 + 0 
2e10 : 85 4a __ STA T0 + 1 
2e12 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2e15 : a5 49 __ LDA T0 + 0 
2e17 : 85 14 __ STA P7 
2e19 : a5 4a __ LDA T0 + 1 
2e1b : 85 15 __ STA P8 
2e1d : a9 0d __ LDA #$0d
2e1f : 85 16 __ STA P9 
2e21 : a9 07 __ LDA #$07
2e23 : 85 17 __ STA P10 
2e25 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2e28 : a9 11 __ LDA #$11
2e2a : 85 16 __ STA P9 
2e2c : a9 32 __ LDA #$32
2e2e : 85 15 __ STA P8 
2e30 : a9 01 __ LDA #$01
2e32 : 85 17 __ STA P10 
2e34 : a9 65 __ LDA #$65
2e36 : 85 14 __ STA P7 
2e38 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2e3b : a9 13 __ LDA #$13
2e3d : 85 16 __ STA P9 
2e3f : a9 32 __ LDA #$32
2e41 : 85 15 __ STA P8 
2e43 : a9 0d __ LDA #$0d
2e45 : 85 17 __ STA P10 
2e47 : a9 80 __ LDA #$80
2e49 : 85 14 __ STA P7 
2e4b : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l17:
2e4e : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
2e51 : c9 0d __ CMP #$0d
2e53 : d0 03 __ BNE $2e58 ; (check_floppy.s18 + 0)
2e55 : 4c aa 2b JMP $2baa ; (check_floppy.l6 + 0)
.s18:
2e58 : c9 6d __ CMP #$6d
2e5a : f0 04 __ BEQ $2e60 ; (check_floppy.s3 + 0)
.s19:
2e5c : c9 4d __ CMP #$4d
2e5e : d0 ee __ BNE $2e4e ; (check_floppy.l17 + 0)
.s3:
2e60 : ad 2c 9f LDA $9f2c ; (check_floppy@stack + 0)
2e63 : 85 53 __ STA T7 + 0 
2e65 : ad 2d 9f LDA $9f2d ; (check_floppy@stack + 1)
2e68 : 85 54 __ STA T8 + 0 
2e6a : 60 __ __ RTS
.s39:
2e6b : a9 0b __ LDA #$0b
2e6d : 85 18 __ STA P11 
2e6f : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
2e72 : a9 03 __ LDA #$03
2e74 : 85 16 __ STA P9 
2e76 : a9 07 __ LDA #$07
2e78 : 85 17 __ STA P10 
2e7a : a5 52 __ LDA T6 + 0 
2e7c : d0 07 __ BNE $2e85 ; (check_floppy.s87 + 0)
.s40:
2e7e : a9 10 __ LDA #$10
2e80 : a0 cb __ LDY #$cb
2e82 : 4c 89 2e JMP $2e89 ; (check_floppy.s41 + 0)
.s87:
2e85 : a9 30 __ LDA #$30
2e87 : a0 a7 __ LDY #$a7
.s41:
2e89 : 84 14 __ STY P7 
2e8b : 85 15 __ STA P8 
2e8d : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2e90 : a9 44 __ LDA #$44
2e92 : a0 00 __ LDY #$00
.l121:
2e94 : 99 6c 9f STA $9f6c,y ; (msg_disk[0] + 0)
2e97 : c8 __ __ INY
2e98 : b9 9e 32 LDA $329e,y 
2e9b : d0 f7 __ BNE $2e94 ; (check_floppy.l121 + 0)
.s42:
2e9d : 99 6c 9f STA $9f6c,y ; (msg_disk[0] + 0)
2ea0 : a9 6c __ LDA #$6c
2ea2 : 85 0d __ STA P0 
2ea4 : a9 9f __ LDA #$9f
2ea6 : 85 0e __ STA P1 
2ea8 : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
2eab : a5 1b __ LDA ACCU + 0 
2ead : 85 49 __ STA T0 + 0 
2eaf : ad e4 9f LDA $9fe4 ; (disk_name[0] + 0)
2eb2 : f0 26 __ BEQ $2eda ; (check_floppy.s43 + 0)
.s83:
2eb4 : 85 4e __ STA T3 + 0 
2eb6 : a9 00 __ LDA #$00
2eb8 : 85 4b __ STA T1 + 0 
2eba : a5 1c __ LDA ACCU + 1 
2ebc : 30 08 __ BMI $2ec6 ; (check_floppy.s84 + 0)
.s86:
2ebe : d0 1a __ BNE $2eda ; (check_floppy.s43 + 0)
.l85:
2ec0 : a5 49 __ LDA T0 + 0 
2ec2 : c9 27 __ CMP #$27
2ec4 : b0 14 __ BCS $2eda ; (check_floppy.s43 + 0)
.s84:
2ec6 : a5 4e __ LDA T3 + 0 
2ec8 : a6 49 __ LDX T0 + 0 
2eca : 9d 6c 9f STA $9f6c,x ; (msg_disk[0] + 0)
2ecd : e6 49 __ INC T0 + 0 
2ecf : e6 4b __ INC T1 + 0 
2ed1 : a6 4b __ LDX T1 + 0 
2ed3 : bd e4 9f LDA $9fe4,x ; (disk_name[0] + 0)
2ed6 : 85 4e __ STA T3 + 0 
2ed8 : d0 e6 __ BNE $2ec0 ; (check_floppy.l85 + 0)
.s43:
2eda : a9 00 __ LDA #$00
2edc : a6 49 __ LDX T0 + 0 
2ede : 9d 6c 9f STA $9f6c,x ; (msg_disk[0] + 0)
2ee1 : a9 0b __ LDA #$0b
2ee3 : 85 16 __ STA P9 
2ee5 : a9 03 __ LDA #$03
2ee7 : 85 17 __ STA P10 
2ee9 : a9 6c __ LDA #$6c
2eeb : 85 14 __ STA P7 
2eed : a9 9f __ LDA #$9f
2eef : 85 15 __ STA P8 
2ef1 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2ef4 : a9 53 __ LDA #$53
2ef6 : a0 00 __ LDY #$00
.l122:
2ef8 : 99 44 9f STA $9f44,y ; (msg_blocks[0] + 0)
2efb : c8 __ __ INY
2efc : b9 a6 32 LDA $32a6,y 
2eff : d0 f7 __ BNE $2ef8 ; (check_floppy.l122 + 0)
.s44:
2f01 : 99 44 9f STA $9f44,y ; (msg_blocks[0] + 0)
2f04 : a5 4f __ LDA T4 + 0 
2f06 : 85 0d __ STA P0 
2f08 : a5 50 __ LDA T4 + 1 
2f0a : 85 0e __ STA P1 
2f0c : a9 3a __ LDA #$3a
2f0e : 85 0f __ STA P2 
2f10 : a9 9f __ LDA #$9f
2f12 : 85 10 __ STA P3 
2f14 : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
2f17 : a9 44 __ LDA #$44
2f19 : 85 0d __ STA P0 
2f1b : a9 9f __ LDA #$9f
2f1d : 85 0e __ STA P1 
2f1f : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
2f22 : a5 1b __ LDA ACCU + 0 
2f24 : 85 4c __ STA T2 + 0 
2f26 : a6 1c __ LDX ACCU + 1 
2f28 : ad 3a 9f LDA $9f3a ; (blocks_str[0] + 0)
2f2b : f0 28 __ BEQ $2f55 ; (check_floppy.s45 + 0)
.s79:
2f2d : 85 4e __ STA T3 + 0 
2f2f : a9 00 __ LDA #$00
2f31 : 85 49 __ STA T0 + 0 
2f33 : 8a __ __ TXA
2f34 : 30 08 __ BMI $2f3e ; (check_floppy.s80 + 0)
.s82:
2f36 : d0 1d __ BNE $2f55 ; (check_floppy.s45 + 0)
.l81:
2f38 : a5 4c __ LDA T2 + 0 
2f3a : c9 27 __ CMP #$27
2f3c : b0 17 __ BCS $2f55 ; (check_floppy.s45 + 0)
.s80:
2f3e : a5 4e __ LDA T3 + 0 
2f40 : a6 4c __ LDX T2 + 0 
2f42 : 9d 44 9f STA $9f44,x ; (msg_blocks[0] + 0)
2f45 : a9 00 __ LDA #$00
2f47 : e6 4c __ INC T2 + 0 
2f49 : e6 49 __ INC T0 + 0 
2f4b : aa __ __ TAX
2f4c : a4 49 __ LDY T0 + 0 
2f4e : b9 3a 9f LDA $9f3a,y ; (blocks_str[0] + 0)
2f51 : 85 4e __ STA T3 + 0 
2f53 : d0 e3 __ BNE $2f38 ; (check_floppy.l81 + 0)
.s45:
2f55 : a9 00 __ LDA #$00
2f57 : 85 49 __ STA T0 + 0 
2f59 : a9 20 __ LDA #$20
.l46:
2f5b : a8 __ __ TAY
2f5c : 8a __ __ TXA
2f5d : 30 08 __ BMI $2f67 ; (check_floppy.s76 + 0)
.s78:
2f5f : d0 1a __ BNE $2f7b ; (check_floppy.s47 + 0)
.s77:
2f61 : a5 4c __ LDA T2 + 0 
2f63 : c9 27 __ CMP #$27
2f65 : b0 14 __ BCS $2f7b ; (check_floppy.s47 + 0)
.s76:
2f67 : 98 __ __ TYA
2f68 : a6 4c __ LDX T2 + 0 
2f6a : 9d 44 9f STA $9f44,x ; (msg_blocks[0] + 0)
2f6d : a9 00 __ LDA #$00
2f6f : e6 4c __ INC T2 + 0 
2f71 : e6 49 __ INC T0 + 0 
2f73 : aa __ __ TAX
2f74 : a4 49 __ LDY T0 + 0 
2f76 : b9 b6 32 LDA $32b6,y 
2f79 : d0 e0 __ BNE $2f5b ; (check_floppy.l46 + 0)
.s47:
2f7b : 86 4d __ STX T2 + 1 
2f7d : a5 50 __ LDA T4 + 1 
2f7f : 4a __ __ LSR
2f80 : 85 0e __ STA P1 
2f82 : a5 4f __ LDA T4 + 0 
2f84 : 6a __ __ ROR
2f85 : 46 0e __ LSR P1 
2f87 : 6a __ __ ROR
2f88 : 85 0d __ STA P0 
2f8a : a9 30 __ LDA #$30
2f8c : 85 0f __ STA P2 
2f8e : a9 9f __ LDA #$9f
2f90 : 85 10 __ STA P3 
2f92 : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
2f95 : ae 30 9f LDX $9f30 ; (kb_str[0] + 0)
2f98 : f0 1d __ BEQ $2fb7 ; (check_floppy.s48 + 0)
.s73:
2f9a : a9 00 __ LDA #$00
2f9c : 85 49 __ STA T0 + 0 
2f9e : a5 4d __ LDA T2 + 1 
2fa0 : d0 15 __ BNE $2fb7 ; (check_floppy.s48 + 0)
.l75:
2fa2 : a4 4c __ LDY T2 + 0 
2fa4 : c0 27 __ CPY #$27
2fa6 : b0 0f __ BCS $2fb7 ; (check_floppy.s48 + 0)
.s74:
2fa8 : 8a __ __ TXA
2fa9 : 99 44 9f STA $9f44,y ; (msg_blocks[0] + 0)
2fac : e6 4c __ INC T2 + 0 
2fae : e6 49 __ INC T0 + 0 
2fb0 : a4 49 __ LDY T0 + 0 
2fb2 : be 30 9f LDX $9f30,y ; (kb_str[0] + 0)
2fb5 : d0 eb __ BNE $2fa2 ; (check_floppy.l75 + 0)
.s48:
2fb7 : a9 00 __ LDA #$00
2fb9 : 85 49 __ STA T0 + 0 
2fbb : a9 20 __ LDA #$20
.l49:
2fbd : aa __ __ TAX
2fbe : a5 4d __ LDA T2 + 1 
2fc0 : d0 15 __ BNE $2fd7 ; (check_floppy.s50 + 0)
.s72:
2fc2 : a4 4c __ LDY T2 + 0 
2fc4 : c0 27 __ CPY #$27
2fc6 : b0 0f __ BCS $2fd7 ; (check_floppy.s50 + 0)
.s71:
2fc8 : 8a __ __ TXA
2fc9 : 99 44 9f STA $9f44,y ; (msg_blocks[0] + 0)
2fcc : e6 4c __ INC T2 + 0 
2fce : e6 49 __ INC T0 + 0 
2fd0 : a6 49 __ LDX T0 + 0 
2fd2 : bd fb 31 LDA $31fb,x 
2fd5 : d0 e6 __ BNE $2fbd ; (check_floppy.l49 + 0)
.s50:
2fd7 : a9 00 __ LDA #$00
2fd9 : a6 4c __ LDX T2 + 0 
2fdb : 9d 44 9f STA $9f44,x ; (msg_blocks[0] + 0)
2fde : a9 0d __ LDA #$0d
2fe0 : 85 16 __ STA P9 
2fe2 : a9 05 __ LDA #$05
2fe4 : 85 17 __ STA P10 
2fe6 : a9 44 __ LDA #$44
2fe8 : 85 14 __ STA P7 
2fea : a9 9f __ LDA #$9f
2fec : 85 15 __ STA P8 
2fee : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2ff1 : a5 52 __ LDA T6 + 0 
2ff3 : f0 03 __ BEQ $2ff8 ; (check_floppy.s51 + 0)
2ff5 : 4c 81 30 JMP $3081 ; (check_floppy.s68 + 0)
.s51:
2ff8 : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
2ffb : c9 20 __ CMP #$20
2ffd : d0 04 __ BNE $3003 ; (check_floppy.s52 + 0)
.s67:
2fff : a9 83 __ LDA #$83
3001 : d0 02 __ BNE $3005 ; (check_floppy.s53 + 0)
.s52:
3003 : a9 23 __ LDA #$23
.s53:
3005 : 85 49 __ STA T0 + 0 
3007 : a5 50 __ LDA T4 + 1 
3009 : 38 __ __ SEC
300a : d0 04 __ BNE $3010 ; (check_floppy.s70 + 0)
.s66:
300c : a5 4f __ LDA T4 + 0 
300e : c5 49 __ CMP T0 + 0 
.s70:
3010 : a9 0f __ LDA #$0f
3012 : 85 16 __ STA P9 
3014 : 90 48 __ BCC $305e ; (check_floppy.s61 + 0)
.s54:
3016 : a9 0d __ LDA #$0d
3018 : 85 17 __ STA P10 
301a : a5 52 __ LDA T6 + 0 
301c : f0 21 __ BEQ $303f ; (check_floppy.s55 + 0)
.s60:
301e : a9 33 __ LDA #$33
3020 : a0 53 __ LDY #$53
.s57:
3022 : 84 14 __ STY P7 
3024 : 85 15 __ STA P8 
3026 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3029 : a9 17 __ LDA #$17
302b : 85 16 __ STA P9 
302d : a9 33 __ LDA #$33
302f : 85 15 __ STA P8 
3031 : a9 01 __ LDA #$01
3033 : 85 17 __ STA P10 
3035 : a9 c5 __ LDA #$c5
3037 : 85 14 __ STA P7 
3039 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
303c : 4c 54 30 JMP $3054 ; (check_floppy.l58 + 0)
.s55:
303f : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
3042 : c9 20 __ CMP #$20
3044 : f0 07 __ BEQ $304d ; (check_floppy.s59 + 0)
.s56:
3046 : a9 33 __ LDA #$33
3048 : a0 a0 __ LDY #$a0
304a : 4c 22 30 JMP $3022 ; (check_floppy.s57 + 0)
.s59:
304d : a9 33 __ LDA #$33
304f : a0 7a __ LDY #$7a
3051 : 4c 22 30 JMP $3022 ; (check_floppy.s57 + 0)
.l58:
3054 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
3057 : c9 0d __ CMP #$0d
3059 : d0 f9 __ BNE $3054 ; (check_floppy.l58 + 0)
305b : 4c 60 2e JMP $2e60 ; (check_floppy.s3 + 0)
.s61:
305e : a9 02 __ LDA #$02
3060 : 85 17 __ STA P10 
3062 : a5 52 __ LDA T6 + 0 
3064 : f0 06 __ BEQ $306c ; (check_floppy.s62 + 0)
.s65:
3066 : a9 32 __ LDA #$32
3068 : a0 c1 __ LDY #$c1
306a : 90 b6 __ BCC $3022 ; (check_floppy.s57 + 0)
.s62:
306c : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
306f : c9 20 __ CMP #$20
3071 : f0 07 __ BEQ $307a ; (check_floppy.s64 + 0)
.s63:
3073 : a9 33 __ LDA #$33
3075 : a0 2a __ LDY #$2a
3077 : 4c 22 30 JMP $3022 ; (check_floppy.s57 + 0)
.s64:
307a : a9 33 __ LDA #$33
307c : a0 00 __ LDY #$00
307e : 4c 22 30 JMP $3022 ; (check_floppy.s57 + 0)
.s68:
3081 : a5 50 __ LDA T4 + 1 
3083 : c9 02 __ CMP #$02
3085 : d0 89 __ BNE $3010 ; (check_floppy.s70 + 0)
.s69:
3087 : a5 4f __ LDA T4 + 0 
3089 : c9 05 __ CMP #$05
308b : 4c 10 30 JMP $3010 ; (check_floppy.s70 + 0)
.s114:
308e : ad bd 9f LDA $9fbd ; (dos_status[0] + 1)
3091 : c9 34 __ CMP #$34
3093 : f0 03 __ BEQ $3098 ; (check_floppy.s115 + 0)
3095 : 4c 5c 2c JMP $2c5c ; (check_floppy.s113 + 0)
.s115:
3098 : a9 0f __ LDA #$0f
309a : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
309d : a9 02 __ LDA #$02
309f : 4c 63 2c JMP $2c63 ; (check_floppy.s124 + 0)
.s9:
30a2 : a9 01 __ LDA #$01
30a4 : 4c 63 2c JMP $2c63 ; (check_floppy.s124 + 0)
--------------------------------------------------------------------
30a7 : __ __ __ BYT 42 41 43 4b 55 50 20 53 52 41 4d 20 53 55 20 46 : BACKUP SRAM SU F
30b7 : __ __ __ BYT 4c 4f 50 50 59 00                               : LOPPY.
--------------------------------------------------------------------
30bd : __ __ __ BYT 41 43 43 45 53 53 4f 20 41 4c 20 44 52 49 56 45 : ACCESSO AL DRIVE
30cd : __ __ __ BYT 20 49 4e 20 43 4f 52 53 4f 2e 2e 2e 00          :  IN CORSO....
--------------------------------------------------------------------
30da : __ __ __ BYT 49 30 00                                        : I0.
--------------------------------------------------------------------
read_dos_status: ; read_dos_status(u8*,i16)->void
; 203, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
30dd : a9 00 __ LDA #$00
30df : 85 43 __ STA T1 + 0 
30e1 : 85 44 __ STA T1 + 1 
30e3 : 85 47 __ STA T5 + 0 
30e5 : 85 45 __ STA T2 + 0 
30e7 : a5 0e __ LDA P1 ; (buf + 0)
30e9 : 85 46 __ STA T3 + 0 
30eb : 05 0f __ ORA P2 ; (buf + 1)
30ed : f0 0d __ BEQ $30fc ; (read_dos_status.s5 + 0)
.s23:
30ef : a5 11 __ LDA P4 ; (max_len + 1)
30f1 : 30 09 __ BMI $30fc ; (read_dos_status.s5 + 0)
.s25:
30f3 : 05 10 __ ORA P3 ; (max_len + 0)
30f5 : f0 05 __ BEQ $30fc ; (read_dos_status.s5 + 0)
.s24:
30f7 : a9 00 __ LDA #$00
30f9 : a8 __ __ TAY
30fa : 91 0e __ STA (P1),y ; (buf + 0)
.s5:
30fc : a9 0f __ LDA #$0f
30fe : 20 71 22 JSR $2271 ; (krnio_chkin.s4 + 0)
3101 : aa __ __ TAX
3102 : d0 01 __ BNE $3105 ; (read_dos_status.l6 + 0)
.s3:
3104 : 60 __ __ RTS
.l6:
3105 : a5 45 __ LDA T2 + 0 
3107 : c9 50 __ CMP #$50
3109 : b0 5c __ BCS $3167 ; (read_dos_status.s7 + 0)
.s10:
310b : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
310e : 85 48 __ STA T6 + 0 
3110 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
3113 : 85 1b __ STA ACCU + 0 
3115 : 29 82 __ AND #$82
3117 : d0 4e __ BNE $3167 ; (read_dos_status.s7 + 0)
.s11:
3119 : e6 45 __ INC T2 + 0 
311b : a5 48 __ LDA T6 + 0 
311d : c9 0d __ CMP #$0d
311f : f0 60 __ BEQ $3181 ; (read_dos_status.s21 + 0)
.s12:
3121 : 06 1b __ ASL ACCU + 0 
3123 : 30 5c __ BMI $3181 ; (read_dos_status.s21 + 0)
.s13:
3125 : a5 46 __ LDA T3 + 0 
3127 : 05 0f __ ORA P2 ; (buf + 1)
3129 : f0 da __ BEQ $3105 ; (read_dos_status.l6 + 0)
.s14:
312b : a5 10 __ LDA P3 ; (max_len + 0)
312d : 38 __ __ SEC
312e : e9 01 __ SBC #$01
3130 : 85 1b __ STA ACCU + 0 
3132 : a5 11 __ LDA P4 ; (max_len + 1)
3134 : e9 00 __ SBC #$00
3136 : 30 2b __ BMI $3163 ; (read_dos_status.s15 + 0)
.s20:
3138 : 85 1c __ STA ACCU + 1 
313a : a5 44 __ LDA T1 + 1 
313c : c5 1c __ CMP ACCU + 1 
313e : d0 04 __ BNE $3144 ; (read_dos_status.s19 + 0)
.s18:
3140 : a5 43 __ LDA T1 + 0 
3142 : c5 1b __ CMP ACCU + 0 
.s19:
3144 : b0 1d __ BCS $3163 ; (read_dos_status.s15 + 0)
.s16:
3146 : a5 48 __ LDA T6 + 0 
3148 : c9 0d __ CMP #$0d
314a : f0 17 __ BEQ $3163 ; (read_dos_status.s15 + 0)
.s17:
314c : a5 43 __ LDA T1 + 0 
314e : 85 1b __ STA ACCU + 0 
3150 : 18 __ __ CLC
3151 : a5 0f __ LDA P2 ; (buf + 1)
3153 : 65 44 __ ADC T1 + 1 
3155 : 85 1c __ STA ACCU + 1 
3157 : a5 48 __ LDA T6 + 0 
3159 : a4 46 __ LDY T3 + 0 
315b : 91 1b __ STA (ACCU + 0),y 
315d : e6 43 __ INC T1 + 0 
315f : d0 02 __ BNE $3163 ; (read_dos_status.s15 + 0)
.s26:
3161 : e6 44 __ INC T1 + 1 
.s15:
3163 : a5 47 __ LDA T5 + 0 
3165 : f0 9e __ BEQ $3105 ; (read_dos_status.l6 + 0)
.s7:
3167 : a5 46 __ LDA T3 + 0 
3169 : 05 0f __ ORA P2 ; (buf + 1)
316b : f0 11 __ BEQ $317e ; (read_dos_status.s8 + 0)
.s9:
316d : a5 43 __ LDA T1 + 0 
316f : 85 1b __ STA ACCU + 0 
3171 : 18 __ __ CLC
3172 : a5 0f __ LDA P2 ; (buf + 1)
3174 : 65 44 __ ADC T1 + 1 
3176 : 85 1c __ STA ACCU + 1 
3178 : a9 00 __ LDA #$00
317a : a4 46 __ LDY T3 + 0 
317c : 91 1b __ STA (ACCU + 0),y 
.s8:
317e : 4c fa 18 JMP $18fa ; (krnio_clrchn.s4 + 0)
.s21:
3181 : a5 46 __ LDA T3 + 0 
3183 : 05 0f __ ORA P2 ; (buf + 1)
3185 : f0 f7 __ BEQ $317e ; (read_dos_status.s8 + 0)
.s22:
3187 : a9 01 __ LDA #$01
3189 : 85 47 __ STA T5 + 0 
318b : d0 9e __ BNE $312b ; (read_dos_status.s14 + 0)
--------------------------------------------------------------------
318d : __ __ __ BYT 45 52 52 4f 52 45 3a 20 49 4c 20 44 52 49 56 45 : ERRORE: IL DRIVE
319d : __ __ __ BYT 20 31 35 34 31 20 4e 4f 4e 20 43 4f 4d 55 4e 49 :  1541 NON COMUNI
31ad : __ __ __ BYT 43 41 21 00                                     : CA!.
--------------------------------------------------------------------
31b1 : __ __ __ BYT 56 45 52 49 46 49 43 41 20 49 4c 20 43 41 56 4f : VERIFICA IL CAVO
31c1 : __ __ __ BYT 20 53 45 52 49 41 4c 45 20 45 20 4c 27 41 43 43 :  SERIALE E L'ACC
31d1 : __ __ __ BYT 45 4e 53 49 4f 4e 45 00                         : ENSIONE.
--------------------------------------------------------------------
31d9 : __ __ __ BYT 45 52 52 4f 52 45 3a 20 46 4c 4f 50 50 59 20 44 : ERRORE: FLOPPY D
31e9 : __ __ __ BYT 49 53 4b 20 4e 4f 4e 20 49 4e 53 45 52 49 54 4f : ISK NON INSERITO
31f9 : __ __ __ BYT 21 00                                           : !.
--------------------------------------------------------------------
31fb : __ __ __ BYT 20 4b 42 29 00                                  :  KB).
--------------------------------------------------------------------
3200 : __ __ __ BYT 49 4e 53 45 52 49 53 43 49 20 55 4e 20 44 49 53 : INSERISCI UN DIS
3210 : __ __ __ BYT 43 4f 20 45 20 43 48 49 55 44 49 20 4c 41 20 4c : CO E CHIUDI LA L
3220 : __ __ __ BYT 45 56 41 00                                     : EVA.
--------------------------------------------------------------------
3224 : __ __ __ BYT 49 4d 50 4f 53 53 49 42 49 4c 45 20 4c 45 47 47 : IMPOSSIBILE LEGG
3234 : __ __ __ BYT 45 52 45 20 4c 41 20 44 49 52 45 43 54 4f 52 59 : ERE LA DIRECTORY
3244 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3245 : __ __ __ BYT 56 45 52 49 46 49 43 41 20 49 4c 20 44 49 53 43 : VERIFICA IL DISC
3255 : __ __ __ BYT 48 45 54 54 4f 20 45 20 52 49 50 52 4f 56 41 00 : HETTO E RIPROVA.
--------------------------------------------------------------------
3265 : __ __ __ BYT 50 52 45 4d 49 20 52 45 54 55 52 4e 20 50 45 52 : PREMI RETURN PER
3275 : __ __ __ BYT 20 52 49 50 52 4f 56 41 52 45 00                :  RIPROVARE.
--------------------------------------------------------------------
3280 : __ __ __ BYT 50 52 45 4d 49 20 28 4d 29 20 50 45 52 20 54 4f : PREMI (M) PER TO
3290 : __ __ __ BYT 52 4e 41 52 45 20 41 4c 20 4d 45 4e 55 00       : RNARE AL MENU.
--------------------------------------------------------------------
329e : __ __ __ BYT 44 49 53 43 4f 3a 20 00                         : DISCO: .
--------------------------------------------------------------------
32a6 : __ __ __ BYT 53 50 41 5a 49 4f 20 4c 49 42 45 52 4f 3a 20 00 : SPAZIO LIBERO: .
--------------------------------------------------------------------
32b6 : __ __ __ BYT 20 42 4c 4f 43 43 48 49 20 28 00                :  BLOCCHI (.
--------------------------------------------------------------------
32c1 : __ __ __ BYT 41 54 54 45 4e 5a 49 4f 4e 45 3a 20 53 50 41 5a : ATTENZIONE: SPAZ
32d1 : __ __ __ BYT 49 4f 20 49 4e 53 55 46 46 49 43 49 45 4e 54 45 : IO INSUFFICIENTE
32e1 : __ __ __ BYT 21 20 28 3c 31 32 38 4b 42 29 00                : ! (<128KB).
--------------------------------------------------------------------
32ec : __ __ __ BYT 46 31 3a 20 45 53 45 47 55 49 20 42 41 43 4b 55 : F1: ESEGUI BACKU
32fc : __ __ __ BYT 50 00                                           : P.
--------------------------------------------------------------------
sram_mode_active:
32fe : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
prg_count:
32ff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3300 : __ __ __ BYT 41 54 54 45 4e 5a 49 4f 4e 45 3a 20 53 50 41 5a : ATTENZIONE: SPAZ
3310 : __ __ __ BYT 49 4f 20 49 4e 53 55 46 46 49 43 49 45 4e 54 45 : IO INSUFFICIENTE
3320 : __ __ __ BYT 21 20 28 3c 33 32 4b 42 29 00                   : ! (<32KB).
--------------------------------------------------------------------
332a : __ __ __ BYT 41 54 54 45 4e 5a 49 4f 4e 45 3a 20 53 50 41 5a : ATTENZIONE: SPAZ
333a : __ __ __ BYT 49 4f 20 49 4e 53 55 46 46 49 43 49 45 4e 54 45 : IO INSUFFICIENTE
334a : __ __ __ BYT 21 20 28 3c 38 4b 42 29 00                      : ! (<8KB).
--------------------------------------------------------------------
3353 : __ __ __ BYT 53 50 41 5a 49 4f 20 53 55 46 46 49 43 49 45 4e : SPAZIO SUFFICIEN
3363 : __ __ __ BYT 54 45 20 50 45 52 20 42 41 43 4b 55 50 20 28 3e : TE PER BACKUP (>
3373 : __ __ __ BYT 31 32 38 4b 42 29 00                            : 128KB).
--------------------------------------------------------------------
337a : __ __ __ BYT 53 50 41 5a 49 4f 20 53 55 46 46 49 43 49 45 4e : SPAZIO SUFFICIEN
338a : __ __ __ BYT 54 45 20 50 45 52 20 42 41 43 4b 55 50 20 28 3e : TE PER BACKUP (>
339a : __ __ __ BYT 33 32 4b 42 29 00                               : 32KB).
--------------------------------------------------------------------
33a0 : __ __ __ BYT 53 50 41 5a 49 4f 20 53 55 46 46 49 43 49 45 4e : SPAZIO SUFFICIEN
33b0 : __ __ __ BYT 54 45 20 50 45 52 20 42 41 43 4b 55 50 20 28 3e : TE PER BACKUP (>
33c0 : __ __ __ BYT 38 4b 42 29 00                                  : 8KB).
--------------------------------------------------------------------
33c5 : __ __ __ BYT 50 52 45 4d 49 20 52 45 54 55 52 4e 20 50 45 52 : PREMI RETURN PER
33d5 : __ __ __ BYT 20 54 4f 52 4e 41 52 45 00                      :  TORNARE.
--------------------------------------------------------------------
sram_format: ; sram_format()->void
;1689, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
33de : a9 0b __ LDA #$0b
33e0 : 85 18 __ STA P11 
33e2 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
33e5 : a9 03 __ LDA #$03
33e7 : 85 16 __ STA P9 
33e9 : a9 07 __ LDA #$07
33eb : 85 17 __ STA P10 
33ed : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
33f0 : 85 4e __ STA T2 + 0 
33f2 : f0 03 __ BEQ $33f7 ; (sram_format.s5 + 0)
33f4 : 4c 09 35 JMP $3509 ; (sram_format.s29 + 0)
.s5:
33f7 : a9 00 __ LDA #$00
33f9 : 85 14 __ STA P7 
33fb : a9 1b __ LDA #$1b
33fd : 85 15 __ STA P8 
33ff : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3402 : a9 0b __ LDA #$0b
3404 : 85 16 __ STA P9 
3406 : ad ff 27 LDA $27ff ; (eeprom_status + 0)
3409 : d0 0d __ BNE $3418 ; (sram_format.s7 + 0)
.s6:
340b : a9 02 __ LDA #$02
340d : 85 17 __ STA P10 
340f : a9 56 __ LDA #$56
3411 : 85 14 __ STA P7 
3413 : a9 1e __ LDA #$1e
3415 : 4c b9 34 JMP $34b9 ; (sram_format.s34 + 0)
.s7:
3418 : a9 35 __ LDA #$35
341a : a0 51 __ LDY #$51
.s8:
341c : 84 14 __ STY P7 
341e : 85 15 __ STA P8 
3420 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l9:
3423 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
3426 : c9 6e __ CMP #$6e
3428 : f0 04 __ BEQ $342e ; (sram_format.s27 + 0)
.s10:
342a : c9 4e __ CMP #$4e
342c : d0 11 __ BNE $343f ; (sram_format.s11 + 0)
.s27:
342e : a9 0f __ LDA #$0f
3430 : 85 16 __ STA P9 
3432 : a9 02 __ LDA #$02
3434 : 85 17 __ STA P10 
3436 : a9 73 __ LDA #$73
3438 : 85 14 __ STA P7 
343a : a9 35 __ LDA #$35
343c : 4c b9 34 JMP $34b9 ; (sram_format.s34 + 0)
.s11:
343f : c9 79 __ CMP #$79
3441 : f0 04 __ BEQ $3447 ; (sram_format.s13 + 0)
.s12:
3443 : c9 59 __ CMP #$59
3445 : d0 dc __ BNE $3423 ; (sram_format.l9 + 0)
.s13:
3447 : a9 0f __ LDA #$0f
3449 : 85 16 __ STA P9 
344b : a9 35 __ LDA #$35
344d : 85 15 __ STA P8 
344f : a9 03 __ LDA #$03
3451 : 85 17 __ STA P10 
3453 : a9 94 __ LDA #$94
3455 : 85 14 __ STA P7 
3457 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
345a : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
345d : 85 50 __ STA T4 + 0 
345f : a5 4e __ LDA T2 + 0 
3461 : d0 76 __ BNE $34d9 ; (sram_format.s21 + 0)
.s14:
3463 : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
3466 : a9 00 __ LDA #$00
3468 : a8 __ __ TAY
.l33:
3469 : 99 fe 9e STA $9efe,y ; (zero_buf[0] + 0)
346c : c8 __ __ INY
346d : d0 fa __ BNE $3469 ; (sram_format.l33 + 0)
.s15:
346f : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
3472 : c9 20 __ CMP #$20
3474 : 85 14 __ STA P7 
3476 : d0 04 __ BNE $347c ; (sram_format.s16 + 0)
.s20:
3478 : a9 80 __ LDA #$80
347a : d0 02 __ BNE $347e ; (sram_format.s17 + 0)
.s16:
347c : a9 20 __ LDA #$20
.s17:
347e : 85 4d __ STA T0 + 0 
3480 : a9 fe __ LDA #$fe
3482 : 85 12 __ STA P5 
3484 : a9 9e __ LDA #$9e
3486 : 85 13 __ STA P6 
3488 : 98 __ __ TYA
.l32:
3489 : 85 11 __ STA P4 
348b : 20 a4 29 JSR $29a4 ; (mdp_eeprom_write_cart_page.s4 + 0)
348e : 18 __ __ CLC
348f : a5 11 __ LDA P4 
3491 : 69 01 __ ADC #$01
3493 : c5 4d __ CMP T0 + 0 
3495 : 90 f2 __ BCC $3489 ; (sram_format.l32 + 0)
.s18:
3497 : a5 14 __ LDA P7 
3499 : 85 11 __ STA P4 
349b : 20 2a 0e JSR $0e2a ; (mdp_eeprom_write_signature.s4 + 0)
349e : a9 01 __ LDA #$01
34a0 : 8d ff 27 STA $27ff ; (eeprom_status + 0)
.s19:
34a3 : a5 50 __ LDA T4 + 0 
34a5 : 8d 03 de STA $de03 
34a8 : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
34ab : a9 11 __ LDA #$11
34ad : 85 16 __ STA P9 
34af : a9 0d __ LDA #$0d
34b1 : 85 17 __ STA P10 
34b3 : a9 ae __ LDA #$ae
34b5 : 85 14 __ STA P7 
34b7 : a9 35 __ LDA #$35
.s34:
34b9 : 85 15 __ STA P8 
34bb : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
34be : a9 17 __ LDA #$17
34c0 : 85 16 __ STA P9 
34c2 : a9 0c __ LDA #$0c
34c4 : 85 15 __ STA P8 
34c6 : a9 01 __ LDA #$01
34c8 : 85 17 __ STA P10 
34ca : a9 d1 __ LDA #$d1
34cc : 85 14 __ STA P7 
34ce : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l28:
34d1 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
34d4 : c9 0d __ CMP #$0d
34d6 : d0 f9 __ BNE $34d1 ; (sram_format.l28 + 0)
.s3:
34d8 : 60 __ __ RTS
.s21:
34d9 : a9 00 __ LDA #$00
34db : 85 4f __ STA T3 + 0 
.l22:
34dd : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
34e0 : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
34e3 : a9 00 __ LDA #$00
34e5 : 85 4d __ STA T0 + 0 
.l23:
34e7 : a6 4d __ LDX T0 + 0 
34e9 : 8e 01 de STX $de01 
34ec : aa __ __ TAX
.l35:
34ed : 9d 00 df STA $df00,x 
34f0 : e8 __ __ INX
34f1 : d0 fa __ BNE $34ed ; (sram_format.l35 + 0)
.s24:
34f3 : e6 4d __ INC T0 + 0 
34f5 : d0 f0 __ BNE $34e7 ; (sram_format.l23 + 0)
.s25:
34f7 : e6 4f __ INC T3 + 0 
34f9 : a5 4f __ LDA T3 + 0 
34fb : c9 02 __ CMP #$02
34fd : 90 de __ BCC $34dd ; (sram_format.l22 + 0)
.s26:
34ff : 20 95 0c JSR $0c95 ; (mdp_write_signature.s4 + 0)
3502 : a9 01 __ LDA #$01
3504 : 8d ff 18 STA $18ff ; (sram_status + 0)
3507 : d0 9a __ BNE $34a3 ; (sram_format.s19 + 0)
.s29:
3509 : a9 8d __ LDA #$8d
350b : 85 14 __ STA P7 
350d : a9 1a __ LDA #$1a
350f : 85 15 __ STA P8 
3511 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3514 : a9 0b __ LDA #$0b
3516 : 85 16 __ STA P9 
3518 : ad ff 18 LDA $18ff ; (sram_status + 0)
351b : f0 07 __ BEQ $3524 ; (sram_format.s30 + 0)
.s31:
351d : a9 35 __ LDA #$35
351f : a0 31 __ LDY #$31
3521 : 4c 1c 34 JMP $341c ; (sram_format.s8 + 0)
.s30:
3524 : a9 02 __ LDA #$02
3526 : 85 17 __ STA P10 
3528 : a9 35 __ LDA #$35
352a : 85 14 __ STA P7 
352c : a9 1e __ LDA #$1e
352e : 4c b9 34 JMP $34b9 ; (sram_format.s34 + 0)
--------------------------------------------------------------------
3531 : __ __ __ BYT 46 4f 52 4d 41 54 54 41 52 45 20 54 55 54 54 41 : FORMATTARE TUTTA
3541 : __ __ __ BYT 20 4c 41 20 53 52 41 4d 3f 20 28 59 2f 4e 29 00 :  LA SRAM? (Y/N).
--------------------------------------------------------------------
3551 : __ __ __ BYT 46 4f 52 4d 41 54 54 41 52 45 20 54 55 54 54 41 : FORMATTARE TUTTA
3561 : __ __ __ BYT 20 4c 41 20 45 45 50 52 4f 4d 3f 20 28 59 2f 4e :  LA EEPROM? (Y/N
3571 : __ __ __ BYT 29 00                                           : ).
--------------------------------------------------------------------
3573 : __ __ __ BYT 4f 50 45 52 41 5a 49 4f 4e 45 20 41 4e 4e 55 4c : OPERAZIONE ANNUL
3583 : __ __ __ BYT 4c 41 54 41 2e 20 20 20 20 20 20 20 20 20 20 20 : LATA.           
3593 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3594 : __ __ __ BYT 46 4f 52 4d 41 54 54 41 5a 49 4f 4e 45 20 49 4e : FORMATTAZIONE IN
35a4 : __ __ __ BYT 20 43 4f 52 53 4f 2e 2e 2e 00                   :  CORSO....
--------------------------------------------------------------------
35ae : __ __ __ BYT 46 4f 52 4d 41 54 54 41 5a 49 4f 4e 45 20 43 4f : FORMATTAZIONE CO
35be : __ __ __ BYT 4d 50 4c 45 54 41 54 41 21 20 20 20 20 20 20 20 : MPLETATA!       
35ce : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
show_dump_screen: ; show_dump_screen()->void
; 761, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
35cf : a2 0d __ LDX #$0d
35d1 : b5 53 __ LDA T0 + 0,x 
35d3 : 9d 51 9b STA $9b51,x ; (show_dump_screen@stack + 0)
35d6 : ca __ __ DEX
35d7 : 10 f8 __ BPL $35d1 ; (show_dump_screen.s1 + 2)
.s4:
35d9 : a9 0b __ LDA #$0b
35db : 85 18 __ STA P11 
35dd : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
35e0 : a9 03 __ LDA #$03
35e2 : 85 16 __ STA P9 
35e4 : a9 07 __ LDA #$07
35e6 : 85 17 __ STA P10 
35e8 : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
35eb : 85 5c __ STA T5 + 0 
35ed : d0 07 __ BNE $35f6 ; (show_dump_screen.l149 + 0)
.s18:
35ef : a9 10 __ LDA #$10
35f1 : a0 cb __ LDY #$cb
35f3 : 4c fa 35 JMP $35fa ; (show_dump_screen.l5 + 0)
.l149:
35f6 : a9 30 __ LDA #$30
35f8 : a0 a7 __ LDY #$a7
.l5:
35fa : 84 14 __ STY P7 
35fc : 85 15 __ STA P8 
35fe : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3601 : a9 09 __ LDA #$09
3603 : 85 11 __ STA P4 
3605 : a9 32 __ LDA #$32
3607 : 85 10 __ STA P3 
3609 : a9 0a __ LDA #$0a
360b : 85 12 __ STA P5 
360d : a9 01 __ LDA #$01
360f : 85 13 __ STA P6 
3611 : a9 ec __ LDA #$ec
3613 : 85 0f __ STA P2 
3615 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
3618 : a9 0b __ LDA #$0b
361a : 85 11 __ STA P4 
361c : a9 3f __ LDA #$3f
361e : 85 10 __ STA P3 
3620 : a9 0d __ LDA #$0d
3622 : 85 0f __ STA P2 
3624 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
3627 : a9 0d __ LDA #$0d
3629 : 85 11 __ STA P4 
362b : a9 3f __ LDA #$3f
362d : 85 10 __ STA P3 
362f : a9 23 __ LDA #$23
3631 : 85 0f __ STA P2 
3633 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
3636 : a9 0f __ LDA #$0f
3638 : 85 11 __ STA P4 
363a : ad 98 4a LDA $4a98 ; (lzo_enabled + 0)
363d : d0 07 __ BNE $3646 ; (show_dump_screen.s154 + 0)
.s156:
363f : a9 3f __ LDA #$3f
3641 : a0 51 __ LDY #$51
3643 : 4c 4a 36 JMP $364a ; (show_dump_screen.s6 + 0)
.s154:
3646 : a9 3f __ LDA #$3f
3648 : a0 37 __ LDY #$37
.s6:
364a : 84 0f __ STY P2 
364c : 85 10 __ STA P3 
364e : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
3651 : a9 59 __ LDA #$59
3653 : 85 14 __ STA P7 
3655 : a9 0d __ LDA #$0d
3657 : 85 17 __ STA P10 
3659 : a9 1b __ LDA #$1b
365b : 85 15 __ STA P8 
365d : a9 17 __ LDA #$17
365f : 85 16 __ STA P9 
3661 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l7:
3664 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
3667 : c9 6d __ CMP #$6d
3669 : d0 03 __ BNE $366e ; (show_dump_screen.s8 + 0)
366b : 4c 02 3f JMP $3f02 ; (show_dump_screen.s3 + 0)
.s8:
366e : c9 4d __ CMP #$4d
3670 : f0 f9 __ BEQ $366b ; (show_dump_screen.l7 + 7)
.s9:
3672 : c9 85 __ CMP #$85
3674 : d0 03 __ BNE $3679 ; (show_dump_screen.s10 + 0)
3676 : 4c 79 3b JMP $3b79 ; (show_dump_screen.s85 + 0)
.s10:
3679 : c9 86 __ CMP #$86
367b : f0 5e __ BEQ $36db ; (show_dump_screen.s19 + 0)
.s11:
367d : c9 87 __ CMP #$87
367f : d0 1c __ BNE $369d ; (show_dump_screen.s12 + 0)
.s17:
3681 : 20 b8 43 JSR $43b8 ; (verify_backup.s1 + 0)
3684 : a9 0b __ LDA #$0b
3686 : 85 18 __ STA P11 
3688 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
368b : a9 03 __ LDA #$03
368d : 85 16 __ STA P9 
368f : a9 07 __ LDA #$07
3691 : 85 17 __ STA P10 
3693 : a5 5c __ LDA T5 + 0 
3695 : f0 03 __ BEQ $369a ; (show_dump_screen.s17 + 25)
3697 : 4c f6 35 JMP $35f6 ; (show_dump_screen.l149 + 0)
369a : 4c ef 35 JMP $35ef ; (show_dump_screen.s18 + 0)
.s12:
369d : c9 88 __ CMP #$88
369f : d0 c3 __ BNE $3664 ; (show_dump_screen.l7 + 0)
.s13:
36a1 : a9 00 __ LDA #$00
36a3 : cd 98 4a CMP $4a98 ; (lzo_enabled + 0)
36a6 : 2a __ __ ROL
36a7 : 8d 98 4a STA $4a98 ; (lzo_enabled + 0)
36aa : a9 0f __ LDA #$0f
36ac : 85 0d __ STA P0 
36ae : a9 0b __ LDA #$0b
36b0 : 85 0e __ STA P1 
36b2 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
36b5 : a9 0f __ LDA #$0f
36b7 : 85 11 __ STA P4 
36b9 : a9 0a __ LDA #$0a
36bb : 85 12 __ STA P5 
36bd : a9 01 __ LDA #$01
36bf : 85 13 __ STA P6 
36c1 : ad 98 4a LDA $4a98 ; (lzo_enabled + 0)
36c4 : d0 07 __ BNE $36cd ; (show_dump_screen.s16 + 0)
.s14:
36c6 : a9 3f __ LDA #$3f
36c8 : a0 51 __ LDY #$51
36ca : 4c d1 36 JMP $36d1 ; (show_dump_screen.s15 + 0)
.s16:
36cd : a9 3f __ LDA #$3f
36cf : a0 37 __ LDY #$37
.s15:
36d1 : 84 0f __ STY P2 
36d3 : 85 10 __ STA P3 
36d5 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
36d8 : 4c 64 36 JMP $3664 ; (show_dump_screen.l7 + 0)
.s19:
36db : a9 17 __ LDA #$17
36dd : 85 0d __ STA P0 
36df : a9 0b __ LDA #$0b
36e1 : 85 0e __ STA P1 
36e3 : a9 86 __ LDA #$86
36e5 : 85 5d __ STA T6 + 0 
36e7 : a5 5c __ LDA T5 + 0 
36e9 : f0 03 __ BEQ $36ee ; (show_dump_screen.s20 + 0)
36eb : 4c 6e 3b JMP $3b6e ; (show_dump_screen.s84 + 0)
.s20:
36ee : ad ff 27 LDA $27ff ; (eeprom_status + 0)
36f1 : f0 03 __ BEQ $36f6 ; (show_dump_screen.s21 + 0)
36f3 : 4c be 37 JMP $37be ; (show_dump_screen.s23 + 0)
.s21:
36f6 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
36f9 : a9 0f __ LDA #$0f
36fb : 85 16 __ STA P9 
36fd : a9 02 __ LDA #$02
36ff : 85 17 __ STA P10 
3701 : a5 5c __ LDA T5 + 0 
3703 : d0 07 __ BNE $370c ; (show_dump_screen.s160 + 0)
.s87:
3705 : a9 1e __ LDA #$1e
3707 : a0 56 __ LDY #$56
3709 : 4c 10 37 JMP $3710 ; (show_dump_screen.s88 + 0)
.s160:
370c : a9 1e __ LDA #$1e
370e : a0 35 __ LDY #$35
.s88:
3710 : 84 14 __ STY P7 
3712 : 85 15 __ STA P8 
3714 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s158:
3717 : a9 17 __ LDA #$17
3719 : 85 16 __ STA P9 
371b : a9 0c __ LDA #$0c
371d : 85 15 __ STA P8 
371f : a9 01 __ LDA #$01
3721 : 85 17 __ STA P10 
3723 : a9 d1 __ LDA #$d1
3725 : 85 14 __ STA P7 
3727 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l89:
372a : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
372d : c9 0d __ CMP #$0d
372f : d0 f9 __ BNE $372a ; (show_dump_screen.l89 + 0)
.s90:
3731 : a9 0b __ LDA #$0b
3733 : 85 18 __ STA P11 
3735 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
3738 : a9 03 __ LDA #$03
373a : 85 16 __ STA P9 
373c : a9 07 __ LDA #$07
373e : 85 17 __ STA P10 
3740 : a5 5c __ LDA T5 + 0 
3742 : d0 07 __ BNE $374b ; (show_dump_screen.s93 + 0)
.s91:
3744 : a9 10 __ LDA #$10
3746 : a0 cb __ LDY #$cb
3748 : 4c 4f 37 JMP $374f ; (show_dump_screen.s92 + 0)
.s93:
374b : a9 30 __ LDA #$30
374d : a0 a7 __ LDY #$a7
.s92:
374f : 84 14 __ STY P7 
3751 : 85 15 __ STA P8 
3753 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3756 : a9 09 __ LDA #$09
3758 : 85 11 __ STA P4 
375a : a9 32 __ LDA #$32
375c : 85 10 __ STA P3 
375e : a9 0a __ LDA #$0a
3760 : 85 12 __ STA P5 
3762 : a9 01 __ LDA #$01
3764 : 85 13 __ STA P6 
3766 : a9 ec __ LDA #$ec
3768 : 85 0f __ STA P2 
376a : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
376d : a9 0b __ LDA #$0b
376f : 85 11 __ STA P4 
3771 : a9 3f __ LDA #$3f
3773 : 85 10 __ STA P3 
3775 : a9 0d __ LDA #$0d
3777 : 85 0f __ STA P2 
3779 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
377c : a9 0d __ LDA #$0d
377e : 85 11 __ STA P4 
3780 : a9 3f __ LDA #$3f
3782 : 85 10 __ STA P3 
3784 : a9 23 __ LDA #$23
3786 : 85 0f __ STA P2 
3788 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
378b : a9 0f __ LDA #$0f
378d : 85 11 __ STA P4 
378f : ad 98 4a LDA $4a98 ; (lzo_enabled + 0)
3792 : d0 07 __ BNE $379b ; (show_dump_screen.s155 + 0)
.s157:
3794 : a9 3f __ LDA #$3f
3796 : a0 51 __ LDY #$51
3798 : 4c 9f 37 JMP $379f ; (show_dump_screen.s22 + 0)
.s155:
379b : a9 3f __ LDA #$3f
379d : a0 37 __ LDY #$37
.s22:
379f : 84 0f __ STY P2 
37a1 : 85 10 __ STA P3 
37a3 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
37a6 : a9 59 __ LDA #$59
37a8 : 85 14 __ STA P7 
37aa : a9 0d __ LDA #$0d
37ac : 85 17 __ STA P10 
37ae : a9 1b __ LDA #$1b
37b0 : 85 15 __ STA P8 
37b2 : a9 17 __ LDA #$17
37b4 : 85 16 __ STA P9 
37b6 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
37b9 : a5 5d __ LDA T6 + 0 
37bb : 4c 9d 36 JMP $369d ; (show_dump_screen.s12 + 0)
.s23:
37be : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
37c1 : a9 0f __ LDA #$0f
37c3 : 85 16 __ STA P9 
37c5 : a9 3f __ LDA #$3f
37c7 : 85 15 __ STA P8 
37c9 : a9 03 __ LDA #$03
37cb : 85 17 __ STA P10 
37cd : a9 6c __ LDA #$6c
37cf : 85 14 __ STA P7 
37d1 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
37d4 : a5 5c __ LDA T5 + 0 
37d6 : d0 0f __ BNE $37e7 ; (show_dump_screen.s83 + 0)
.s24:
37d8 : a9 3f __ LDA #$3f
37da : 85 54 __ STA T0 + 1 
37dc : 85 56 __ STA T1 + 1 
37de : a9 3f __ LDA #$3f
37e0 : a0 bd __ LDY #$bd
37e2 : a2 a9 __ LDX #$a9
37e4 : 4c f3 37 JMP $37f3 ; (show_dump_screen.s25 + 0)
.s83:
37e7 : a9 3f __ LDA #$3f
37e9 : 85 54 __ STA T0 + 1 
37eb : 85 56 __ STA T1 + 1 
37ed : a9 3f __ LDA #$3f
37ef : a0 9a __ LDY #$9a
37f1 : a2 88 __ LDX #$88
.s25:
37f3 : 84 57 __ STY T2 + 0 
37f5 : 86 55 __ STX T1 + 0 
37f7 : 86 0d __ STX P0 
37f9 : 85 58 __ STA T2 + 1 
37fb : a5 54 __ LDA T0 + 1 
37fd : 85 0e __ STA P1 
37ff : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3802 : a9 03 __ LDA #$03
3804 : 85 0d __ STA P0 
3806 : 85 0f __ STA P2 
3808 : a9 08 __ LDA #$08
380a : 85 0e __ STA P1 
380c : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
380f : 85 53 __ STA T0 + 0 
3811 : a9 00 __ LDA #$00
3813 : 85 59 __ STA T3 + 0 
3815 : 85 5b __ STA T4 + 0 
3817 : a9 ff __ LDA #$ff
3819 : 85 0d __ STA P0 
381b : a9 0c __ LDA #$0c
381d : 85 0e __ STA P1 
381f : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3822 : a9 0f __ LDA #$0f
3824 : 85 0d __ STA P0 
3826 : 85 0f __ STA P2 
3828 : a9 08 __ LDA #$08
382a : 85 0e __ STA P1 
382c : a5 53 __ LDA T0 + 0 
382e : f0 03 __ BEQ $3833 ; (show_dump_screen.s26 + 0)
3830 : 4c 2e 3b JMP $3b2e ; (show_dump_screen.s77 + 0)
.s26:
3833 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3836 : aa __ __ TAX
3837 : f0 05 __ BEQ $383e ; (show_dump_screen.s27 + 0)
.s76:
3839 : a9 0f __ LDA #$0f
.s153:
383b : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s27:
383e : a5 57 __ LDA T2 + 0 
3840 : 85 0d __ STA P0 
3842 : a5 58 __ LDA T2 + 1 
3844 : 85 0e __ STA P1 
3846 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3849 : a9 03 __ LDA #$03
384b : 85 0d __ STA P0 
384d : 85 0f __ STA P2 
384f : a9 08 __ LDA #$08
3851 : 85 0e __ STA P1 
3853 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3856 : aa __ __ TAX
3857 : f0 03 __ BEQ $385c ; (show_dump_screen.s28 + 0)
3859 : 4c d9 3a JMP $3ad9 ; (show_dump_screen.s70 + 0)
.s28:
385c : a9 ff __ LDA #$ff
385e : 85 0d __ STA P0 
3860 : a9 0c __ LDA #$0c
3862 : 85 0e __ STA P1 
3864 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3867 : a9 0f __ LDA #$0f
3869 : 85 0d __ STA P0 
386b : 85 0f __ STA P2 
386d : a9 08 __ LDA #$08
386f : 85 0e __ STA P1 
3871 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3874 : aa __ __ TAX
3875 : f0 05 __ BEQ $387c ; (show_dump_screen.s29 + 0)
.s69:
3877 : a9 0f __ LDA #$0f
.s152:
3879 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s29:
387c : a9 0f __ LDA #$0f
387e : 85 0d __ STA P0 
3880 : a9 0b __ LDA #$0b
3882 : 85 0e __ STA P1 
3884 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
3887 : ad 98 4a LDA $4a98 ; (lzo_enabled + 0)
388a : f0 03 __ BEQ $388f ; (show_dump_screen.s30 + 0)
388c : 4c c8 3a JMP $3ac8 ; (show_dump_screen.s67 + 0)
.s30:
388f : a5 5b __ LDA T4 + 0 
3891 : f0 04 __ BEQ $3897 ; (show_dump_screen.s31 + 0)
.s66:
3893 : a9 00 __ LDA #$00
3895 : f0 11 __ BEQ $38a8 ; (show_dump_screen.s33 + 0)
.s31:
3897 : a5 59 __ LDA T3 + 0 
3899 : d0 0d __ BNE $38a8 ; (show_dump_screen.s33 + 0)
.s32:
389b : c6 17 __ DEC P10 
389d : a9 13 __ LDA #$13
389f : 85 16 __ STA P9 
38a1 : a9 42 __ LDA #$42
38a3 : a0 a4 __ LDY #$a4
38a5 : 4c 10 37 JMP $3710 ; (show_dump_screen.s88 + 0)
.s33:
38a8 : 85 5b __ STA T4 + 0 
38aa : a9 13 __ LDA #$13
38ac : 85 16 __ STA P9 
38ae : a9 42 __ LDA #$42
38b0 : 85 15 __ STA P8 
38b2 : a9 c8 __ LDA #$c8
38b4 : 85 14 __ STA P7 
38b6 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
38b9 : a5 5b __ LDA T4 + 0 
38bb : d0 08 __ BNE $38c5 ; (show_dump_screen.s35 + 0)
.s34:
38bd : a5 57 __ LDA T2 + 0 
38bf : 85 55 __ STA T1 + 0 
38c1 : a5 58 __ LDA T2 + 1 
38c3 : 85 56 __ STA T1 + 1 
.s35:
38c5 : a5 55 __ LDA T1 + 0 
38c7 : 85 0d __ STA P0 
38c9 : a5 56 __ LDA T1 + 1 
38cb : 85 0e __ STA P1 
38cd : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
38d0 : a9 03 __ LDA #$03
38d2 : 85 0d __ STA P0 
38d4 : 85 0f __ STA P2 
38d6 : a9 08 __ LDA #$08
38d8 : 85 0e __ STA P1 
38da : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
38dd : aa __ __ TAX
38de : d0 09 __ BNE $38e9 ; (show_dump_screen.s37 + 0)
.s36:
38e0 : c6 17 __ DEC P10 
38e2 : a9 28 __ LDA #$28
38e4 : a0 00 __ LDY #$00
38e6 : 4c 10 37 JMP $3710 ; (show_dump_screen.s88 + 0)
.s37:
38e9 : a9 03 __ LDA #$03
38eb : 20 71 22 JSR $2271 ; (krnio_chkin.s4 + 0)
38ee : aa __ __ TAX
38ef : d0 15 __ BNE $3906 ; (show_dump_screen.s38 + 0)
.s161:
38f1 : c6 17 __ DEC P10 
38f3 : a9 28 __ LDA #$28
38f5 : a0 1f __ LDY #$1f
.s159:
38f7 : 84 14 __ STY P7 
38f9 : 85 15 __ STA P8 
38fb : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s103:
38fe : a9 03 __ LDA #$03
3900 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
3903 : 4c 17 37 JMP $3717 ; (show_dump_screen.s158 + 0)
.s38:
3906 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
3909 : 85 5e __ STA T7 + 0 
390b : a5 5c __ LDA T5 + 0 
390d : f0 17 __ BEQ $3926 ; (show_dump_screen.s39 + 0)
.s65:
390f : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
3912 : a9 00 __ LDA #$00
3914 : 85 57 __ STA T2 + 0 
3916 : a9 02 __ LDA #$02
3918 : 85 58 __ STA T2 + 1 
.s41:
391a : a9 00 __ LDA #$00
391c : 85 59 __ STA T3 + 0 
391e : 85 5a __ STA T3 + 1 
3920 : a9 01 __ LDA #$01
3922 : 85 5f __ STA T8 + 0 
3924 : d0 15 __ BNE $393b ; (show_dump_screen.l42 + 0)
.s39:
3926 : a9 20 __ LDA #$20
3928 : cd ff 1a CMP $1aff ; (eeprom_size_kb + 0)
392b : d0 02 __ BNE $392f ; (show_dump_screen.s40 + 0)
.s64:
392d : a9 80 __ LDA #$80
.s40:
392f : 85 57 __ STA T2 + 0 
3931 : a9 00 __ LDA #$00
3933 : 85 58 __ STA T2 + 1 
3935 : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
3938 : 4c 1a 39 JMP $391a ; (show_dump_screen.s41 + 0)
.l42:
393b : a5 59 __ LDA T3 + 0 
393d : 85 1b __ STA ACCU + 0 
393f : a5 5a __ LDA T3 + 1 
3941 : 85 1c __ STA ACCU + 1 
3943 : a9 00 __ LDA #$00
3945 : 85 1d __ STA ACCU + 2 
3947 : 85 1e __ STA ACCU + 3 
3949 : a9 64 __ LDA #$64
394b : 20 06 49 JSR $4906 ; (mul32by8 + 0)
394e : a5 07 __ LDA WORK + 4 
3950 : 85 1b __ STA ACCU + 0 
3952 : a5 08 __ LDA WORK + 5 
3954 : 85 1c __ STA ACCU + 1 
3956 : a5 09 __ LDA WORK + 6 
3958 : 85 1d __ STA ACCU + 2 
395a : a5 0a __ LDA WORK + 7 
395c : 85 1e __ STA ACCU + 3 
395e : a5 57 __ LDA T2 + 0 
3960 : 85 03 __ STA WORK + 0 
3962 : a5 58 __ LDA T2 + 1 
3964 : 85 04 __ STA WORK + 1 
3966 : a9 00 __ LDA #$00
3968 : 85 0e __ STA P1 
396a : 85 05 __ STA WORK + 2 
396c : 85 06 __ STA WORK + 3 
396e : 20 c1 49 JSR $49c1 ; (divmod32 + 0)
3971 : a5 1b __ LDA ACCU + 0 
3973 : 85 0d __ STA P0 
3975 : a9 8b __ LDA #$8b
3977 : 85 0f __ STA P2 
3979 : a9 9c __ LDA #$9c
397b : 85 10 __ STA P3 
397d : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
3980 : a9 8b __ LDA #$8b
3982 : 85 0d __ STA P0 
3984 : a9 9c __ LDA #$9c
3986 : 85 0e __ STA P1 
3988 : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
398b : a9 25 __ LDA #$25
398d : a6 1b __ LDX ACCU + 0 
398f : 9d 8b 9c STA $9c8b,x ; (pct_str[0] + 0)
3992 : a9 8b __ LDA #$8b
3994 : 85 14 __ STA P7 
3996 : a9 9c __ LDA #$9c
3998 : 85 15 __ STA P8 
399a : a9 13 __ LDA #$13
399c : 85 16 __ STA P9 
399e : a9 07 __ LDA #$07
39a0 : 85 17 __ STA P10 
39a2 : a9 00 __ LDA #$00
39a4 : 9d 8c 9c STA $9c8c,x ; (pct_str[0] + 1)
39a7 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
39aa : a5 5c __ LDA T5 + 0 
39ac : f0 05 __ BEQ $39b3 ; (show_dump_screen.s43 + 0)
.s63:
39ae : a5 5a __ LDA T3 + 1 
39b0 : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
.s43:
39b3 : a5 59 __ LDA T3 + 0 
39b5 : 8d 01 de STA $de01 
39b8 : a5 5b __ LDA T4 + 0 
39ba : f0 03 __ BEQ $39bf ; (show_dump_screen.s44 + 0)
39bc : 4c aa 3a JMP $3aaa ; (show_dump_screen.s61 + 0)
.s44:
39bf : 85 55 __ STA T1 + 0 
.l45:
39c1 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
39c4 : 85 60 __ STA T9 + 0 
39c6 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
39c9 : aa __ __ TAX
39ca : f0 04 __ BEQ $39d0 ; (show_dump_screen.s46 + 0)
.s60:
39cc : c9 40 __ CMP #$40
39ce : d0 2a __ BNE $39fa ; (show_dump_screen.s49 + 0)
.s46:
39d0 : a5 60 __ LDA T9 + 0 
39d2 : a6 55 __ LDX T1 + 0 
39d4 : 9d 8b 9b STA $9b8b,x ; (page_buf[0] + 0)
39d7 : e6 55 __ INC T1 + 0 
39d9 : d0 e6 __ BNE $39c1 ; (show_dump_screen.l45 + 0)
.s47:
39db : a5 5c __ LDA T5 + 0 
39dd : f0 03 __ BEQ $39e2 ; (show_dump_screen.s48 + 0)
39df : 4c 9c 3a JMP $3a9c ; (show_dump_screen.s58 + 0)
.s48:
39e2 : a5 59 __ LDA T3 + 0 
39e4 : 85 11 __ STA P4 
39e6 : ad ff 1a LDA $1aff ; (eeprom_size_kb + 0)
39e9 : 85 14 __ STA P7 
39eb : a9 8b __ LDA #$8b
39ed : 85 12 __ STA P5 
39ef : a9 9b __ LDA #$9b
39f1 : 85 13 __ STA P6 
39f3 : 20 a4 29 JSR $29a4 ; (mdp_eeprom_write_cart_page.s4 + 0)
39f6 : a5 1b __ LDA ACCU + 0 
39f8 : d0 04 __ BNE $39fe ; (show_dump_screen.s56 + 0)
.s49:
39fa : c6 5f __ DEC T8 + 0 
39fc : f0 17 __ BEQ $3a15 ; (show_dump_screen.s50 + 0)
.s56:
39fe : e6 59 __ INC T3 + 0 
3a00 : d0 02 __ BNE $3a04 ; (show_dump_screen.s166 + 0)
.s165:
3a02 : e6 5a __ INC T3 + 1 
.s166:
3a04 : a5 5a __ LDA T3 + 1 
3a06 : c5 58 __ CMP T2 + 1 
3a08 : b0 03 __ BCS $3a0d ; (show_dump_screen.s168 + 0)
3a0a : 4c 3b 39 JMP $393b ; (show_dump_screen.l42 + 0)
.s168:
3a0d : d0 06 __ BNE $3a15 ; (show_dump_screen.s50 + 0)
.s57:
3a0f : a5 59 __ LDA T3 + 0 
3a11 : c5 57 __ CMP T2 + 0 
3a13 : 90 f5 __ BCC $3a0a ; (show_dump_screen.s166 + 6)
.s50:
3a15 : a5 5e __ LDA T7 + 0 
3a17 : 8d 03 de STA $de03 
3a1a : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
3a1d : 20 fa 18 JSR $18fa ; (krnio_clrchn.s4 + 0)
3a20 : a5 5f __ LDA T8 + 0 
3a22 : f0 1e __ BEQ $3a42 ; (show_dump_screen.s51 + 0)
.s55:
3a24 : a9 13 __ LDA #$13
3a26 : 85 16 __ STA P9 
3a28 : a9 42 __ LDA #$42
3a2a : 85 15 __ STA P8 
3a2c : a9 07 __ LDA #$07
3a2e : 85 17 __ STA P10 
3a30 : a9 5d __ LDA #$5d
3a32 : 85 14 __ STA P7 
3a34 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3a37 : a9 05 __ LDA #$05
3a39 : 85 17 __ STA P10 
3a3b : a9 43 __ LDA #$43
3a3d : a0 97 __ LDY #$97
3a3f : 4c f7 38 JMP $38f7 ; (show_dump_screen.s159 + 0)
.s51:
3a42 : 8d 63 9b STA $9b63 ; (dos_err[0] + 0)
3a45 : a9 ff __ LDA #$ff
3a47 : 85 0d __ STA P0 
3a49 : a9 0c __ LDA #$0c
3a4b : 85 0e __ STA P1 
3a4d : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3a50 : a9 0f __ LDA #$0f
3a52 : 85 0d __ STA P0 
3a54 : 85 0f __ STA P2 
3a56 : a9 08 __ LDA #$08
3a58 : 85 0e __ STA P1 
3a5a : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3a5d : aa __ __ TAX
3a5e : f0 18 __ BEQ $3a78 ; (show_dump_screen.s52 + 0)
.s54:
3a60 : a9 63 __ LDA #$63
3a62 : 85 0e __ STA P1 
3a64 : a9 00 __ LDA #$00
3a66 : 85 11 __ STA P4 
3a68 : a9 9b __ LDA #$9b
3a6a : 85 0f __ STA P2 
3a6c : a9 28 __ LDA #$28
3a6e : 85 10 __ STA P3 
3a70 : 20 dd 30 JSR $30dd ; (read_dos_status.s4 + 0)
3a73 : a9 0f __ LDA #$0f
3a75 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s52:
3a78 : a9 13 __ LDA #$13
3a7a : 85 16 __ STA P9 
3a7c : a9 28 __ LDA #$28
3a7e : 85 15 __ STA P8 
3a80 : a9 02 __ LDA #$02
3a82 : 85 17 __ STA P10 
3a84 : a9 71 __ LDA #$71
3a86 : 85 14 __ STA P7 
3a88 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3a8b : ad 63 9b LDA $9b63 ; (dos_err[0] + 0)
3a8e : d0 03 __ BNE $3a93 ; (show_dump_screen.s53 + 0)
3a90 : 4c fe 38 JMP $38fe ; (show_dump_screen.s103 + 0)
.s53:
3a93 : a9 9b __ LDA #$9b
3a95 : a0 63 __ LDY #$63
.s162:
3a97 : e6 17 __ INC P10 
3a99 : 4c f7 38 JMP $38f7 ; (show_dump_screen.s159 + 0)
.s58:
3a9c : a2 00 __ LDX #$00
.l59:
3a9e : bd 8b 9b LDA $9b8b,x ; (page_buf[0] + 0)
3aa1 : 9d 00 df STA $df00,x 
3aa4 : e8 __ __ INX
3aa5 : d0 f7 __ BNE $3a9e ; (show_dump_screen.l59 + 0)
3aa7 : 4c fe 39 JMP $39fe ; (show_dump_screen.s56 + 0)
.s61:
3aaa : a9 03 __ LDA #$03
3aac : 85 0e __ STA P1 
3aae : a9 9b __ LDA #$9b
3ab0 : 85 10 __ STA P3 
3ab2 : a9 8b __ LDA #$8b
3ab4 : 85 0f __ STA P2 
3ab6 : 20 e1 42 JSR $42e1 ; (krnio_read_lzo.s4 + 0)
3ab9 : a6 1c __ LDX ACCU + 1 
3abb : ca __ __ DEX
3abc : f0 03 __ BEQ $3ac1 ; (show_dump_screen.s62 + 0)
3abe : 4c fa 39 JMP $39fa ; (show_dump_screen.s49 + 0)
.s62:
3ac1 : a5 1b __ LDA ACCU + 0 
3ac3 : d0 f9 __ BNE $3abe ; (show_dump_screen.s61 + 20)
3ac5 : 4c db 39 JMP $39db ; (show_dump_screen.s47 + 0)
.s67:
3ac8 : a5 59 __ LDA T3 + 0 
3aca : f0 03 __ BEQ $3acf ; (show_dump_screen.s68 + 0)
3acc : 4c a8 38 JMP $38a8 ; (show_dump_screen.s33 + 0)
.s68:
3acf : a5 5b __ LDA T4 + 0 
3ad1 : d0 03 __ BNE $3ad6 ; (show_dump_screen.s68 + 7)
3ad3 : 4c 9b 38 JMP $389b ; (show_dump_screen.s32 + 0)
3ad6 : 4c 93 38 JMP $3893 ; (show_dump_screen.s66 + 0)
.s70:
3ad9 : a9 ff __ LDA #$ff
3adb : 85 0d __ STA P0 
3add : a9 0c __ LDA #$0c
3adf : 85 0e __ STA P1 
3ae1 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3ae4 : a9 0f __ LDA #$0f
3ae6 : 85 0d __ STA P0 
3ae8 : 85 0f __ STA P2 
3aea : a9 08 __ LDA #$08
3aec : 85 0e __ STA P1 
3aee : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3af1 : aa __ __ TAX
3af2 : f0 35 __ BEQ $3b29 ; (show_dump_screen.s71 + 0)
.s72:
3af4 : a9 28 __ LDA #$28
3af6 : 85 10 __ STA P3 
3af8 : a9 9c __ LDA #$9c
3afa : 85 0f __ STA P2 
3afc : a9 00 __ LDA #$00
3afe : 85 11 __ STA P4 
3b00 : a9 93 __ LDA #$93
3b02 : 85 0e __ STA P1 
3b04 : 20 dd 30 JSR $30dd ; (read_dos_status.s4 + 0)
3b07 : ad 93 9c LDA $9c93 ; (temp_status[0] + 0)
3b0a : c9 30 __ CMP #$30
3b0c : d0 16 __ BNE $3b24 ; (show_dump_screen.s73 + 0)
.s74:
3b0e : ad 94 9c LDA $9c94 ; (temp_status[0] + 1)
3b11 : c9 30 __ CMP #$30
3b13 : d0 0f __ BNE $3b24 ; (show_dump_screen.s73 + 0)
.s75:
3b15 : a9 0f __ LDA #$0f
3b17 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
3b1a : a9 03 __ LDA #$03
3b1c : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
3b1f : e6 5b __ INC T4 + 0 
3b21 : 4c 7c 38 JMP $387c ; (show_dump_screen.s29 + 0)
.s73:
3b24 : a9 0f __ LDA #$0f
3b26 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s71:
3b29 : a9 03 __ LDA #$03
3b2b : 4c 79 38 JMP $3879 ; (show_dump_screen.s152 + 0)
.s77:
3b2e : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3b31 : aa __ __ TAX
3b32 : f0 35 __ BEQ $3b69 ; (show_dump_screen.s78 + 0)
.s79:
3b34 : a9 28 __ LDA #$28
3b36 : 85 10 __ STA P3 
3b38 : a9 9c __ LDA #$9c
3b3a : 85 0f __ STA P2 
3b3c : a9 00 __ LDA #$00
3b3e : 85 11 __ STA P4 
3b40 : a9 bb __ LDA #$bb
3b42 : 85 0e __ STA P1 
3b44 : 20 dd 30 JSR $30dd ; (read_dos_status.s4 + 0)
3b47 : ad bb 9c LDA $9cbb ; (temp_status[0] + 0)
3b4a : c9 30 __ CMP #$30
3b4c : d0 16 __ BNE $3b64 ; (show_dump_screen.s80 + 0)
.s81:
3b4e : ad bc 9c LDA $9cbc ; (temp_status[0] + 1)
3b51 : c9 30 __ CMP #$30
3b53 : d0 0f __ BNE $3b64 ; (show_dump_screen.s80 + 0)
.s82:
3b55 : a9 0f __ LDA #$0f
3b57 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
3b5a : a9 03 __ LDA #$03
3b5c : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
3b5f : e6 59 __ INC T3 + 0 
3b61 : 4c 3e 38 JMP $383e ; (show_dump_screen.s27 + 0)
.s80:
3b64 : a9 0f __ LDA #$0f
3b66 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s78:
3b69 : a9 03 __ LDA #$03
3b6b : 4c 3b 38 JMP $383b ; (show_dump_screen.s153 + 0)
.s84:
3b6e : ad ff 18 LDA $18ff ; (sram_status + 0)
3b71 : f0 03 __ BEQ $3b76 ; (show_dump_screen.s84 + 8)
3b73 : 4c be 37 JMP $37be ; (show_dump_screen.s23 + 0)
3b76 : 4c f6 36 JMP $36f6 ; (show_dump_screen.s21 + 0)
.s85:
3b79 : a9 17 __ LDA #$17
3b7b : 85 0d __ STA P0 
3b7d : a9 0b __ LDA #$0b
3b7f : 85 0e __ STA P1 
3b81 : a9 85 __ LDA #$85
3b83 : 85 5d __ STA T6 + 0 
3b85 : a5 5c __ LDA T5 + 0 
3b87 : d0 03 __ BNE $3b8c ; (show_dump_screen.s148 + 0)
3b89 : 4c f7 3e JMP $3ef7 ; (show_dump_screen.s86 + 0)
.s148:
3b8c : ad ff 18 LDA $18ff ; (sram_status + 0)
3b8f : f0 e5 __ BEQ $3b76 ; (show_dump_screen.s84 + 8)
.s94:
3b91 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
3b94 : a9 0f __ LDA #$0f
3b96 : 85 16 __ STA P9 
3b98 : a9 3f __ LDA #$3f
3b9a : 85 15 __ STA P8 
3b9c : a9 03 __ LDA #$03
3b9e : 85 17 __ STA P10 
3ba0 : a9 6c __ LDA #$6c
3ba2 : 85 14 __ STA P7 
3ba4 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3ba7 : ad 98 4a LDA $4a98 ; (lzo_enabled + 0)
3baa : 85 5e __ STA T7 + 0 
3bac : a9 00 __ LDA #$00
3bae : 85 59 __ STA T3 + 0 
3bb0 : a5 5c __ LDA T5 + 0 
3bb2 : f0 03 __ BEQ $3bb7 ; (show_dump_screen.s95 + 0)
3bb4 : 4c c9 3e JMP $3ec9 ; (show_dump_screen.s145 + 0)
.s95:
3bb7 : a5 5e __ LDA T7 + 0 
3bb9 : d0 15 __ BNE $3bd0 ; (show_dump_screen.s144 + 0)
.s96:
3bbb : a9 3f __ LDA #$3f
3bbd : 85 54 __ STA T0 + 1 
3bbf : a9 ef __ LDA #$ef
3bc1 : 85 55 __ STA T1 + 0 
3bc3 : a9 3f __ LDA #$3f
3bc5 : 85 56 __ STA T1 + 1 
3bc7 : a9 40 __ LDA #$40
3bc9 : a0 46 __ LDY #$46
3bcb : a2 bd __ LDX #$bd
3bcd : 4c e2 3b JMP $3be2 ; (show_dump_screen.s97 + 0)
.s144:
3bd0 : a9 3f __ LDA #$3f
3bd2 : 85 54 __ STA T0 + 1 
3bd4 : a9 00 __ LDA #$00
3bd6 : 85 55 __ STA T1 + 0 
3bd8 : a9 40 __ LDA #$40
3bda : 85 56 __ STA T1 + 1 
3bdc : a9 40 __ LDA #$40
3bde : a0 33 __ LDY #$33
3be0 : a2 a9 __ LDX #$a9
.s97:
3be2 : 86 0d __ STX P0 
3be4 : 84 57 __ STY T2 + 0 
3be6 : 85 58 __ STA T2 + 1 
3be8 : a5 54 __ LDA T0 + 1 
3bea : 85 0e __ STA P1 
3bec : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3bef : a9 03 __ LDA #$03
3bf1 : 85 0d __ STA P0 
3bf3 : 85 0f __ STA P2 
3bf5 : a9 08 __ LDA #$08
3bf7 : 85 0e __ STA P1 
3bf9 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3bfc : aa __ __ TAX
3bfd : f0 03 __ BEQ $3c02 ; (show_dump_screen.s98 + 0)
3bff : 4c 74 3e JMP $3e74 ; (show_dump_screen.s138 + 0)
.s98:
3c02 : a9 ff __ LDA #$ff
3c04 : 85 0d __ STA P0 
3c06 : a9 0c __ LDA #$0c
3c08 : 85 0e __ STA P1 
3c0a : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3c0d : a9 0f __ LDA #$0f
3c0f : 85 0d __ STA P0 
3c11 : 85 0f __ STA P2 
3c13 : a9 08 __ LDA #$08
3c15 : 85 0e __ STA P1 
3c17 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3c1a : aa __ __ TAX
3c1b : f0 05 __ BEQ $3c22 ; (show_dump_screen.s99 + 0)
.s137:
3c1d : a9 0f __ LDA #$0f
.s151:
3c1f : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s99:
3c22 : a9 0f __ LDA #$0f
3c24 : 85 0d __ STA P0 
3c26 : a9 0b __ LDA #$0b
3c28 : 85 0e __ STA P1 
3c2a : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
3c2d : a5 59 __ LDA T3 + 0 
3c2f : f0 6b __ BEQ $3c9c ; (show_dump_screen.s100 + 0)
.s128:
3c31 : a9 11 __ LDA #$11
3c33 : 85 16 __ STA P9 
3c35 : a9 40 __ LDA #$40
3c37 : 85 15 __ STA P8 
3c39 : a9 07 __ LDA #$07
3c3b : 85 17 __ STA P10 
3c3d : a9 56 __ LDA #$56
3c3f : 85 14 __ STA P7 
3c41 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l129:
3c44 : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
3c47 : aa __ __ TAX
3c48 : f0 fa __ BEQ $3c44 ; (show_dump_screen.l129 + 0)
.s130:
3c4a : c9 79 __ CMP #$79
3c4c : f0 1b __ BEQ $3c69 ; (show_dump_screen.s135 + 0)
.s131:
3c4e : c9 59 __ CMP #$59
3c50 : f0 17 __ BEQ $3c69 ; (show_dump_screen.s135 + 0)
.s132:
3c52 : c9 6e __ CMP #$6e
3c54 : f0 04 __ BEQ $3c5a ; (show_dump_screen.s134 + 0)
.s133:
3c56 : c9 4e __ CMP #$4e
3c58 : d0 ea __ BNE $3c44 ; (show_dump_screen.l129 + 0)
.s134:
3c5a : a9 13 __ LDA #$13
3c5c : 85 16 __ STA P9 
3c5e : a9 02 __ LDA #$02
3c60 : 85 17 __ STA P10 
3c62 : a9 35 __ LDA #$35
3c64 : a0 73 __ LDY #$73
3c66 : 4c 10 37 JMP $3710 ; (show_dump_screen.s88 + 0)
.s135:
3c69 : a9 13 __ LDA #$13
3c6b : 85 16 __ STA P9 
3c6d : a9 40 __ LDA #$40
3c6f : 85 15 __ STA P8 
3c71 : a9 03 __ LDA #$03
3c73 : 85 17 __ STA P10 
3c75 : a9 79 __ LDA #$79
3c77 : 85 14 __ STA P7 
3c79 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3c7c : a5 57 __ LDA T2 + 0 
3c7e : 85 0d __ STA P0 
3c80 : a5 58 __ LDA T2 + 1 
3c82 : 85 0e __ STA P1 
3c84 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3c87 : a9 0f __ LDA #$0f
3c89 : 85 0d __ STA P0 
3c8b : 85 0f __ STA P2 
3c8d : a9 08 __ LDA #$08
3c8f : 85 0e __ STA P1 
3c91 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3c94 : aa __ __ TAX
3c95 : f0 05 __ BEQ $3c9c ; (show_dump_screen.s100 + 0)
.s136:
3c97 : a9 0f __ LDA #$0f
3c99 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s100:
3c9c : a9 13 __ LDA #$13
3c9e : 85 16 __ STA P9 
3ca0 : a9 40 __ LDA #$40
3ca2 : 85 15 __ STA P8 
3ca4 : a9 99 __ LDA #$99
3ca6 : 85 14 __ STA P7 
3ca8 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3cab : a5 55 __ LDA T1 + 0 
3cad : 85 0d __ STA P0 
3caf : a5 56 __ LDA T1 + 1 
3cb1 : 85 0e __ STA P1 
3cb3 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3cb6 : a9 03 __ LDA #$03
3cb8 : 85 0d __ STA P0 
3cba : 85 0f __ STA P2 
3cbc : a9 08 __ LDA #$08
3cbe : 85 0e __ STA P1 
3cc0 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3cc3 : aa __ __ TAX
3cc4 : d0 03 __ BNE $3cc9 ; (show_dump_screen.s102 + 0)
3cc6 : 4c 6b 3e JMP $3e6b ; (show_dump_screen.s101 + 0)
.s102:
3cc9 : a9 03 __ LDA #$03
3ccb : 20 b4 40 JSR $40b4 ; (krnio_chkout.s4 + 0)
3cce : aa __ __ TAX
3ccf : d0 03 __ BNE $3cd4 ; (show_dump_screen.s104 + 0)
3cd1 : 4c f1 38 JMP $38f1 ; (show_dump_screen.s161 + 0)
.s104:
3cd4 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
3cd7 : 85 5f __ STA T8 + 0 
3cd9 : a5 5c __ LDA T5 + 0 
3cdb : f0 17 __ BEQ $3cf4 ; (show_dump_screen.s105 + 0)
.s127:
3cdd : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
3ce0 : a9 00 __ LDA #$00
3ce2 : 85 57 __ STA T2 + 0 
3ce4 : a9 02 __ LDA #$02
3ce6 : 85 58 __ STA T2 + 1 
.s107:
3ce8 : a9 00 __ LDA #$00
3cea : 85 59 __ STA T3 + 0 
3cec : 85 5a __ STA T3 + 1 
3cee : a9 01 __ LDA #$01
3cf0 : 85 60 __ STA T9 + 0 
3cf2 : d0 15 __ BNE $3d09 ; (show_dump_screen.l108 + 0)
.s105:
3cf4 : a9 20 __ LDA #$20
3cf6 : cd ff 1a CMP $1aff ; (eeprom_size_kb + 0)
3cf9 : d0 02 __ BNE $3cfd ; (show_dump_screen.s106 + 0)
.s126:
3cfb : a9 80 __ LDA #$80
.s106:
3cfd : 85 57 __ STA T2 + 0 
3cff : a9 00 __ LDA #$00
3d01 : 85 58 __ STA T2 + 1 
3d03 : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
3d06 : 4c e8 3c JMP $3ce8 ; (show_dump_screen.s107 + 0)
.l108:
3d09 : a5 59 __ LDA T3 + 0 
3d0b : 85 1b __ STA ACCU + 0 
3d0d : a5 5a __ LDA T3 + 1 
3d0f : 85 1c __ STA ACCU + 1 
3d11 : a9 00 __ LDA #$00
3d13 : 85 1d __ STA ACCU + 2 
3d15 : 85 1e __ STA ACCU + 3 
3d17 : a9 64 __ LDA #$64
3d19 : 20 06 49 JSR $4906 ; (mul32by8 + 0)
3d1c : a5 07 __ LDA WORK + 4 
3d1e : 85 1b __ STA ACCU + 0 
3d20 : a5 08 __ LDA WORK + 5 
3d22 : 85 1c __ STA ACCU + 1 
3d24 : a5 09 __ LDA WORK + 6 
3d26 : 85 1d __ STA ACCU + 2 
3d28 : a5 0a __ LDA WORK + 7 
3d2a : 85 1e __ STA ACCU + 3 
3d2c : a5 57 __ LDA T2 + 0 
3d2e : 85 03 __ STA WORK + 0 
3d30 : a5 58 __ LDA T2 + 1 
3d32 : 85 04 __ STA WORK + 1 
3d34 : a9 00 __ LDA #$00
3d36 : 85 0e __ STA P1 
3d38 : 85 05 __ STA WORK + 2 
3d3a : 85 06 __ STA WORK + 3 
3d3c : 20 c1 49 JSR $49c1 ; (divmod32 + 0)
3d3f : a5 1b __ LDA ACCU + 0 
3d41 : 85 0d __ STA P0 
3d43 : a9 0b __ LDA #$0b
3d45 : 85 0f __ STA P2 
3d47 : a9 9e __ LDA #$9e
3d49 : 85 10 __ STA P3 
3d4b : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
3d4e : a9 0b __ LDA #$0b
3d50 : 85 0d __ STA P0 
3d52 : a9 9e __ LDA #$9e
3d54 : 85 0e __ STA P1 
3d56 : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
3d59 : a9 25 __ LDA #$25
3d5b : a6 1b __ LDX ACCU + 0 
3d5d : 9d 0b 9e STA $9e0b,x ; (pct_str[0] + 0)
3d60 : a9 0b __ LDA #$0b
3d62 : 85 14 __ STA P7 
3d64 : a9 9e __ LDA #$9e
3d66 : 85 15 __ STA P8 
3d68 : a9 13 __ LDA #$13
3d6a : 85 16 __ STA P9 
3d6c : a9 07 __ LDA #$07
3d6e : 85 17 __ STA P10 
3d70 : a9 00 __ LDA #$00
3d72 : 9d 0c 9e STA $9e0c,x ; (pct_str[0] + 1)
3d75 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3d78 : a5 5c __ LDA T5 + 0 
3d7a : f0 05 __ BEQ $3d81 ; (show_dump_screen.s109 + 0)
.s125:
3d7c : a5 5a __ LDA T3 + 1 
3d7e : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
.s109:
3d81 : a5 59 __ LDA T3 + 0 
3d83 : 8d 01 de STA $de01 
3d86 : a5 5e __ LDA T7 + 0 
3d88 : f0 03 __ BEQ $3d8d ; (show_dump_screen.s110 + 0)
3d8a : 4c 47 3e JMP $3e47 ; (show_dump_screen.s122 + 0)
.s110:
3d8d : 85 53 __ STA T0 + 0 
.l111:
3d8f : a5 53 __ LDA T0 + 0 
3d91 : 20 01 17 JSR $1701 ; (mdp_read_byte.s4 + 0)
3d94 : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
3d97 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
3d9a : aa __ __ TAX
3d9b : f0 03 __ BEQ $3da0 ; (show_dump_screen.s112 + 0)
3d9d : 4c 40 3e JMP $3e40 ; (show_dump_screen.s121 + 0)
.s112:
3da0 : e6 53 __ INC T0 + 0 
3da2 : d0 eb __ BNE $3d8f ; (show_dump_screen.l111 + 0)
.s113:
3da4 : e6 59 __ INC T3 + 0 
3da6 : d0 02 __ BNE $3daa ; (show_dump_screen.s164 + 0)
.s163:
3da8 : e6 5a __ INC T3 + 1 
.s164:
3daa : a5 5a __ LDA T3 + 1 
3dac : c5 58 __ CMP T2 + 1 
3dae : b0 03 __ BCS $3db3 ; (show_dump_screen.s167 + 0)
3db0 : 4c 09 3d JMP $3d09 ; (show_dump_screen.l108 + 0)
.s167:
3db3 : d0 06 __ BNE $3dbb ; (show_dump_screen.s114 + 0)
.s120:
3db5 : a5 59 __ LDA T3 + 0 
3db7 : c5 57 __ CMP T2 + 0 
3db9 : 90 f5 __ BCC $3db0 ; (show_dump_screen.s164 + 6)
.s114:
3dbb : a5 5f __ LDA T8 + 0 
3dbd : 8d 03 de STA $de03 
3dc0 : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
3dc3 : 20 fa 18 JSR $18fa ; (krnio_clrchn.s4 + 0)
3dc6 : a5 60 __ LDA T9 + 0 
3dc8 : f0 1e __ BEQ $3de8 ; (show_dump_screen.s115 + 0)
.s119:
3dca : a9 13 __ LDA #$13
3dcc : 85 16 __ STA P9 
3dce : a9 42 __ LDA #$42
3dd0 : 85 15 __ STA P8 
3dd2 : a9 07 __ LDA #$07
3dd4 : 85 17 __ STA P10 
3dd6 : a9 5d __ LDA #$5d
3dd8 : 85 14 __ STA P7 
3dda : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3ddd : a9 05 __ LDA #$05
3ddf : 85 17 __ STA P10 
3de1 : a9 42 __ LDA #$42
3de3 : a0 62 __ LDY #$62
3de5 : 4c f7 38 JMP $38f7 ; (show_dump_screen.s159 + 0)
.s115:
3de8 : 8d e3 9c STA $9ce3 ; (dos_err[0] + 0)
3deb : a9 ff __ LDA #$ff
3ded : 85 0d __ STA P0 
3def : a9 0c __ LDA #$0c
3df1 : 85 0e __ STA P1 
3df3 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3df6 : a9 0f __ LDA #$0f
3df8 : 85 0d __ STA P0 
3dfa : 85 0f __ STA P2 
3dfc : a9 08 __ LDA #$08
3dfe : 85 0e __ STA P1 
3e00 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3e03 : aa __ __ TAX
3e04 : f0 18 __ BEQ $3e1e ; (show_dump_screen.s116 + 0)
.s118:
3e06 : a9 e3 __ LDA #$e3
3e08 : 85 0e __ STA P1 
3e0a : a9 00 __ LDA #$00
3e0c : 85 11 __ STA P4 
3e0e : a9 9c __ LDA #$9c
3e10 : 85 0f __ STA P2 
3e12 : a9 28 __ LDA #$28
3e14 : 85 10 __ STA P3 
3e16 : 20 dd 30 JSR $30dd ; (read_dos_status.s4 + 0)
3e19 : a9 0f __ LDA #$0f
3e1b : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s116:
3e1e : a9 13 __ LDA #$13
3e20 : 85 16 __ STA P9 
3e22 : a9 28 __ LDA #$28
3e24 : 85 15 __ STA P8 
3e26 : a9 02 __ LDA #$02
3e28 : 85 17 __ STA P10 
3e2a : a9 71 __ LDA #$71
3e2c : 85 14 __ STA P7 
3e2e : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3e31 : ad e3 9c LDA $9ce3 ; (dos_err[0] + 0)
3e34 : d0 03 __ BNE $3e39 ; (show_dump_screen.s117 + 0)
3e36 : 4c fe 38 JMP $38fe ; (show_dump_screen.s103 + 0)
.s117:
3e39 : a9 9c __ LDA #$9c
3e3b : a0 e3 __ LDY #$e3
3e3d : 4c 97 3a JMP $3a97 ; (show_dump_screen.s162 + 0)
.s121:
3e40 : a9 00 __ LDA #$00
3e42 : 85 60 __ STA T9 + 0 
3e44 : 4c a4 3d JMP $3da4 ; (show_dump_screen.s113 + 0)
.s122:
3e47 : a9 00 __ LDA #$00
.l150:
3e49 : 85 0d __ STA P0 
3e4b : 20 01 17 JSR $1701 ; (mdp_read_byte.s4 + 0)
3e4e : a6 0d __ LDX P0 
3e50 : 9d 0b 9d STA $9d0b,x ; (page_buf[0] + 0)
3e53 : e8 __ __ INX
3e54 : 8a __ __ TXA
3e55 : d0 f2 __ BNE $3e49 ; (show_dump_screen.l150 + 0)
.s123:
3e57 : a9 0b __ LDA #$0b
3e59 : 85 0e __ STA P1 
3e5b : a9 9d __ LDA #$9d
3e5d : 85 0f __ STA P2 
3e5f : 20 c9 40 JSR $40c9 ; (compress_and_write_page.s4 + 0)
3e62 : a5 1b __ LDA ACCU + 0 
3e64 : d0 de __ BNE $3e44 ; (show_dump_screen.s121 + 4)
.s124:
3e66 : 85 60 __ STA T9 + 0 
3e68 : 4c bb 3d JMP $3dbb ; (show_dump_screen.s114 + 0)
.s101:
3e6b : c6 17 __ DEC P10 
3e6d : a9 42 __ LDA #$42
3e6f : a0 83 __ LDY #$83
3e71 : 4c 10 37 JMP $3710 ; (show_dump_screen.s88 + 0)
.s138:
3e74 : a9 ff __ LDA #$ff
3e76 : 85 0d __ STA P0 
3e78 : a9 0c __ LDA #$0c
3e7a : 85 0e __ STA P1 
3e7c : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
3e7f : a9 0f __ LDA #$0f
3e81 : 85 0d __ STA P0 
3e83 : 85 0f __ STA P2 
3e85 : a9 08 __ LDA #$08
3e87 : 85 0e __ STA P1 
3e89 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
3e8c : aa __ __ TAX
3e8d : f0 35 __ BEQ $3ec4 ; (show_dump_screen.s139 + 0)
.s140:
3e8f : a9 28 __ LDA #$28
3e91 : 85 10 __ STA P3 
3e93 : a9 9e __ LDA #$9e
3e95 : 85 0f __ STA P2 
3e97 : a9 00 __ LDA #$00
3e99 : 85 11 __ STA P4 
3e9b : a9 13 __ LDA #$13
3e9d : 85 0e __ STA P1 
3e9f : 20 dd 30 JSR $30dd ; (read_dos_status.s4 + 0)
3ea2 : ad 13 9e LDA $9e13 ; (temp_status[0] + 0)
3ea5 : c9 30 __ CMP #$30
3ea7 : d0 16 __ BNE $3ebf ; (show_dump_screen.s141 + 0)
.s142:
3ea9 : ad 14 9e LDA $9e14 ; (temp_status[0] + 1)
3eac : c9 30 __ CMP #$30
3eae : d0 0f __ BNE $3ebf ; (show_dump_screen.s141 + 0)
.s143:
3eb0 : a9 0f __ LDA #$0f
3eb2 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
3eb5 : a9 03 __ LDA #$03
3eb7 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
3eba : e6 59 __ INC T3 + 0 
3ebc : 4c 22 3c JMP $3c22 ; (show_dump_screen.s99 + 0)
.s141:
3ebf : a9 0f __ LDA #$0f
3ec1 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s139:
3ec4 : a9 03 __ LDA #$03
3ec6 : 4c 1f 3c JMP $3c1f ; (show_dump_screen.s151 + 0)
.s145:
3ec9 : a5 5e __ LDA T7 + 0 
3ecb : d0 15 __ BNE $3ee2 ; (show_dump_screen.s147 + 0)
.s146:
3ecd : a9 3f __ LDA #$3f
3ecf : 85 54 __ STA T0 + 1 
3ed1 : a9 e0 __ LDA #$e0
3ed3 : 85 55 __ STA T1 + 0 
3ed5 : a9 3f __ LDA #$3f
3ed7 : 85 56 __ STA T1 + 1 
3ed9 : a9 40 __ LDA #$40
3edb : a0 25 __ LDY #$25
3edd : a2 9a __ LDX #$9a
3edf : 4c e2 3b JMP $3be2 ; (show_dump_screen.s97 + 0)
.s147:
3ee2 : a9 3f __ LDA #$3f
3ee4 : 85 54 __ STA T0 + 1 
3ee6 : a9 ce __ LDA #$ce
3ee8 : 85 55 __ STA T1 + 0 
3eea : a9 3f __ LDA #$3f
3eec : 85 56 __ STA T1 + 1 
3eee : a9 40 __ LDA #$40
3ef0 : a0 14 __ LDY #$14
3ef2 : a2 88 __ LDX #$88
3ef4 : 4c e2 3b JMP $3be2 ; (show_dump_screen.s97 + 0)
.s86:
3ef7 : ad ff 27 LDA $27ff ; (eeprom_status + 0)
3efa : f0 03 __ BEQ $3eff ; (show_dump_screen.s86 + 8)
3efc : 4c 91 3b JMP $3b91 ; (show_dump_screen.s94 + 0)
3eff : 4c f6 36 JMP $36f6 ; (show_dump_screen.s21 + 0)
.s3:
3f02 : a2 0d __ LDX #$0d
3f04 : bd 51 9b LDA $9b51,x ; (show_dump_screen@stack + 0)
3f07 : 95 53 __ STA T0 + 0,x 
3f09 : ca __ __ DEX
3f0a : 10 f8 __ BPL $3f04 ; (show_dump_screen.s3 + 2)
3f0c : 60 __ __ RTS
--------------------------------------------------------------------
3f0d : __ __ __ BYT 46 33 3a 20 52 49 50 52 49 53 54 49 4e 41 20 42 : F3: RIPRISTINA B
3f1d : __ __ __ BYT 41 43 4b 55 50 00                               : ACKUP.
--------------------------------------------------------------------
3f23 : __ __ __ BYT 46 35 3a 20 56 45 52 49 46 49 43 41 20 42 41 43 : F5: VERIFICA BAC
3f33 : __ __ __ BYT 4b 55 50 00                                     : KUP.
--------------------------------------------------------------------
3f37 : __ __ __ BYT 46 37 3a 20 43 4f 4d 50 52 45 53 53 49 4f 4e 45 : F7: COMPRESSIONE
3f47 : __ __ __ BYT 20 4c 5a 4f 20 28 4f 4e 29 00                   :  LZO (ON).
--------------------------------------------------------------------
3f51 : __ __ __ BYT 46 37 3a 20 43 4f 4d 50 52 45 53 53 49 4f 4e 45 : F7: COMPRESSIONE
3f61 : __ __ __ BYT 20 4c 5a 4f 20 28 4f 46 46 29 00                :  LZO (OFF).
--------------------------------------------------------------------
3f6c : __ __ __ BYT 43 4f 4e 54 52 4f 4c 4c 4f 20 46 49 4c 45 20 45 : CONTROLLO FILE E
3f7c : __ __ __ BYT 53 49 53 54 45 4e 54 45 2e 2e 2e 00             : SISTENTE....
--------------------------------------------------------------------
3f88 : __ __ __ BYT 53 52 41 4d 42 41 43 4b 55 50 4c 5a 4f 2c 53 2c : SRAMBACKUPLZO,S,
3f98 : __ __ __ BYT 52 00                                           : R.
--------------------------------------------------------------------
3f9a : __ __ __ BYT 53 52 41 4d 42 41 43 4b 55 50 2c 53 2c 52 00    : SRAMBACKUP,S,R.
--------------------------------------------------------------------
3fa9 : __ __ __ BYT 45 45 50 52 4f 4d 42 41 43 4b 55 50 4c 5a 4f 2c : EEPROMBACKUPLZO,
3fb9 : __ __ __ BYT 53 2c 52 00                                     : S,R.
--------------------------------------------------------------------
3fbd : __ __ __ BYT 45 45 50 52 4f 4d 42 41 43 4b 55 50 2c 53 2c 52 : EEPROMBACKUP,S,R
3fcd : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3fce : __ __ __ BYT 53 52 41 4d 42 41 43 4b 55 50 4c 5a 4f 2c 53 2c : SRAMBACKUPLZO,S,
3fde : __ __ __ BYT 57 00                                           : W.
--------------------------------------------------------------------
3fe0 : __ __ __ BYT 53 52 41 4d 42 41 43 4b 55 50 2c 53 2c 57 00    : SRAMBACKUP,S,W.
--------------------------------------------------------------------
3fef : __ __ __ BYT 45 45 50 52 4f 4d 42 41 43 4b 55 50 2c 53 2c 57 : EEPROMBACKUP,S,W
3fff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
4000 : __ __ __ BYT 45 45 50 52 4f 4d 42 41 43 4b 55 50 4c 5a 4f 2c : EEPROMBACKUPLZO,
4010 : __ __ __ BYT 53 2c 57 00                                     : S,W.
--------------------------------------------------------------------
4014 : __ __ __ BYT 53 30 3a 53 52 41 4d 42 41 43 4b 55 50 4c 5a 4f : S0:SRAMBACKUPLZO
4024 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
4025 : __ __ __ BYT 53 30 3a 53 52 41 4d 42 41 43 4b 55 50 00       : S0:SRAMBACKUP.
--------------------------------------------------------------------
4033 : __ __ __ BYT 53 30 3a 45 45 50 52 4f 4d 42 41 43 4b 55 50 4c : S0:EEPROMBACKUPL
4043 : __ __ __ BYT 5a 4f 00                                        : ZO.
--------------------------------------------------------------------
4046 : __ __ __ BYT 53 30 3a 45 45 50 52 4f 4d 42 41 43 4b 55 50 00 : S0:EEPROMBACKUP.
--------------------------------------------------------------------
4056 : __ __ __ BYT 46 49 4c 45 20 54 52 4f 56 41 54 4f 21 20 53 4f : FILE TROVATO! SO
4066 : __ __ __ BYT 56 52 41 53 43 52 49 56 45 52 45 3f 20 28 59 2f : VRASCRIVERE? (Y/
4076 : __ __ __ BYT 4e 29 00                                        : N).
--------------------------------------------------------------------
4079 : __ __ __ BYT 45 4c 49 4d 49 4e 41 5a 49 4f 4e 45 20 46 49 4c : ELIMINAZIONE FIL
4089 : __ __ __ BYT 45 20 50 52 45 43 45 44 45 4e 54 45 2e 2e 2e 00 : E PRECEDENTE....
--------------------------------------------------------------------
4099 : __ __ __ BYT 53 43 52 49 54 54 55 52 41 20 46 49 4c 45 20 49 : SCRITTURA FILE I
40a9 : __ __ __ BYT 4e 20 43 4f 52 53 4f 2e 2e 2e 00                : N CORSO....
--------------------------------------------------------------------
krnio_chkout: ; krnio_chkout(u8)->bool
;  51, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
40b4 : 85 0d __ STA P0 
40b6 : a6 0d __ LDX P0 
40b8 : 20 c9 ff JSR $ffc9 
40bb : a9 00 __ LDA #$00
40bd : 2a __ __ ROL
40be : 49 01 __ EOR #$01
40c0 : 85 1b __ STA ACCU + 0 
40c2 : a5 1b __ LDA ACCU + 0 
40c4 : f0 02 __ BEQ $40c8 ; (krnio_chkout.s3 + 0)
.s5:
40c6 : a9 01 __ LDA #$01
.s3:
40c8 : 60 __ __ RTS
--------------------------------------------------------------------
compress_and_write_page: ; compress_and_write_page(const u8*)->bool
; 487, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
40c9 : a9 00 __ LDA #$00
40cb : 85 49 __ STA T6 + 0 
40cd : 85 4a __ STA T6 + 1 
.l5:
40cf : 85 4b __ STA T7 + 0 
40d1 : a5 4a __ LDA T6 + 1 
.l6:
40d3 : aa __ __ TAX
40d4 : 30 3d __ BMI $4113 ; (compress_and_write_page.s14 + 0)
.s52:
40d6 : c9 01 __ CMP #$01
40d8 : 90 39 __ BCC $4113 ; (compress_and_write_page.s14 + 0)
.s7:
40da : a5 4b __ LDA T7 + 0 
40dc : f0 20 __ BEQ $40fe ; (compress_and_write_page.s8 + 0)
.s9:
40de : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
40e1 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
40e4 : aa __ __ TAX
40e5 : d0 28 __ BNE $410f ; (compress_and_write_page.s13 + 0)
.s10:
40e7 : 85 43 __ STA T1 + 0 
40e9 : aa __ __ TAX
.l11:
40ea : bd 7f 9f LDA $9f7f,x ; (lit_buf[0] + 0)
40ed : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
40f0 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
40f3 : aa __ __ TAX
40f4 : d0 19 __ BNE $410f ; (compress_and_write_page.s13 + 0)
.s12:
40f6 : e6 43 __ INC T1 + 0 
40f8 : a6 43 __ LDX T1 + 0 
40fa : e4 4b __ CPX T7 + 0 
40fc : 90 ec __ BCC $40ea ; (compress_and_write_page.l11 + 0)
.s8:
40fe : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
4101 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
4104 : c9 01 __ CMP #$01
4106 : a9 00 __ LDA #$00
4108 : 69 ff __ ADC #$ff
410a : 29 01 __ AND #$01
.s3:
410c : 85 1b __ STA ACCU + 0 
410e : 60 __ __ RTS
.s13:
410f : a9 00 __ LDA #$00
4111 : f0 f9 __ BEQ $410c ; (compress_and_write_page.s3 + 0)
.s14:
4113 : a5 4a __ LDA T6 + 1 
4115 : 30 10 __ BMI $4127 ; (compress_and_write_page.s44 + 0)
.s46:
4117 : d0 06 __ BNE $411f ; (compress_and_write_page.s15 + 0)
.s45:
4119 : a5 49 __ LDA T6 + 0 
411b : c9 ff __ CMP #$ff
411d : 90 06 __ BCC $4125 ; (compress_and_write_page.s54 + 0)
.s15:
411f : a9 00 __ LDA #$00
4121 : a2 ff __ LDX #$ff
4123 : d0 04 __ BNE $4129 ; (compress_and_write_page.s16 + 0)
.s54:
4125 : a5 4a __ LDA T6 + 1 
.s44:
4127 : a6 49 __ LDX T6 + 0 
.s16:
4129 : 85 1c __ STA ACCU + 1 
412b : a9 00 __ LDA #$00
412d : 85 4c __ STA T8 + 0 
412f : 85 4d __ STA T9 + 0 
4131 : a5 1c __ LDA ACCU + 1 
4133 : 30 7b __ BMI $41b0 ; (compress_and_write_page.s17 + 0)
.s43:
4135 : 86 1b __ STX ACCU + 0 
4137 : d0 03 __ BNE $413c ; (compress_and_write_page.s32 + 0)
.s42:
4139 : 8a __ __ TXA
413a : f0 74 __ BEQ $41b0 ; (compress_and_write_page.s17 + 0)
.s32:
413c : a9 01 __ LDA #$01
413e : 85 43 __ STA T1 + 0 
4140 : a9 00 __ LDA #$00
4142 : 85 44 __ STA T1 + 1 
4144 : a6 0e __ LDX P1 ; (src + 0)
.l33:
4146 : 8a __ __ TXA
4147 : 18 __ __ CLC
4148 : 65 49 __ ADC T6 + 0 
414a : 85 47 __ STA T3 + 0 
414c : a5 0f __ LDA P2 ; (src + 1)
414e : 65 4a __ ADC T6 + 1 
4150 : 85 48 __ STA T3 + 1 
4152 : 38 __ __ SEC
4153 : a5 49 __ LDA T6 + 0 
4155 : e5 43 __ SBC T1 + 0 
4157 : 85 1d __ STA ACCU + 2 
4159 : a5 4a __ LDA T6 + 1 
415b : e5 44 __ SBC T1 + 1 
415d : a8 __ __ TAY
415e : 8a __ __ TXA
415f : 18 __ __ CLC
4160 : 65 1d __ ADC ACCU + 2 
4162 : 85 45 __ STA T2 + 0 
4164 : 98 __ __ TYA
4165 : 65 0f __ ADC P2 ; (src + 1)
4167 : 85 46 __ STA T2 + 1 
4169 : a4 4c __ LDY T8 + 0 
416b : b1 45 __ LDA (T2 + 0),y 
416d : d1 47 __ CMP (T3 + 0),y 
416f : d0 2d __ BNE $419e ; (compress_and_write_page.s36 + 0)
.s34:
4171 : a0 00 __ LDY #$00
.l40:
4173 : b1 45 __ LDA (T2 + 0),y 
4175 : d1 47 __ CMP (T3 + 0),y 
4177 : d0 13 __ BNE $418c ; (compress_and_write_page.s47 + 0)
.s41:
4179 : c8 __ __ INY
417a : 98 __ __ TYA
417b : 18 __ __ CLC
417c : 65 49 __ ADC T6 + 0 
417e : a5 4a __ LDA T6 + 1 
4180 : 69 00 __ ADC #$00
4182 : 30 04 __ BMI $4188 ; (compress_and_write_page.s35 + 0)
.s53:
4184 : c9 01 __ CMP #$01
4186 : b0 04 __ BCS $418c ; (compress_and_write_page.s47 + 0)
.s35:
4188 : c0 7f __ CPY #$7f
418a : 90 e7 __ BCC $4173 ; (compress_and_write_page.l40 + 0)
.s47:
418c : 84 1d __ STY ACCU + 2 
418e : a5 4c __ LDA T8 + 0 
4190 : c5 1d __ CMP ACCU + 2 
4192 : b0 0a __ BCS $419e ; (compress_and_write_page.s36 + 0)
.s39:
4194 : 84 4c __ STY T8 + 0 
4196 : a5 43 __ LDA T1 + 0 
4198 : 85 4d __ STA T9 + 0 
419a : c0 7f __ CPY #$7f
419c : f0 12 __ BEQ $41b0 ; (compress_and_write_page.s17 + 0)
.s36:
419e : e6 43 __ INC T1 + 0 
41a0 : d0 02 __ BNE $41a4 ; (compress_and_write_page.s51 + 0)
.s50:
41a2 : e6 44 __ INC T1 + 1 
.s51:
41a4 : a5 1c __ LDA ACCU + 1 
41a6 : c5 44 __ CMP T1 + 1 
41a8 : d0 04 __ BNE $41ae ; (compress_and_write_page.s38 + 0)
.s37:
41aa : a5 1b __ LDA ACCU + 0 
41ac : c5 43 __ CMP T1 + 0 
.s38:
41ae : b0 96 __ BCS $4146 ; (compress_and_write_page.l33 + 0)
.s17:
41b0 : a5 4c __ LDA T8 + 0 
41b2 : c9 03 __ CMP #$03
41b4 : 90 51 __ BCC $4207 ; (compress_and_write_page.s18 + 0)
.s31:
41b6 : a5 4b __ LDA T7 + 0 
41b8 : f0 25 __ BEQ $41df ; (compress_and_write_page.s23 + 0)
.s26:
41ba : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
41bd : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
41c0 : aa __ __ TAX
41c1 : f0 03 __ BEQ $41c6 ; (compress_and_write_page.s27 + 0)
41c3 : 4c 0f 41 JMP $410f ; (compress_and_write_page.s13 + 0)
.s27:
41c6 : 85 43 __ STA T1 + 0 
41c8 : aa __ __ TAX
.l28:
41c9 : bd 7f 9f LDA $9f7f,x ; (lit_buf[0] + 0)
41cc : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
41cf : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
41d2 : aa __ __ TAX
41d3 : d0 ee __ BNE $41c3 ; (compress_and_write_page.s26 + 9)
.s29:
41d5 : e6 43 __ INC T1 + 0 
41d7 : a6 43 __ LDX T1 + 0 
41d9 : e4 4b __ CPX T7 + 0 
41db : 90 ec __ BCC $41c9 ; (compress_and_write_page.l28 + 0)
.s30:
41dd : 85 4b __ STA T7 + 0 
.s23:
41df : a5 4c __ LDA T8 + 0 
41e1 : 09 80 __ ORA #$80
41e3 : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
41e6 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
41e9 : aa __ __ TAX
41ea : d0 d7 __ BNE $41c3 ; (compress_and_write_page.s26 + 9)
.s24:
41ec : a5 4d __ LDA T9 + 0 
41ee : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
41f1 : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
41f4 : aa __ __ TAX
41f5 : d0 cc __ BNE $41c3 ; (compress_and_write_page.s26 + 9)
.s25:
41f7 : 18 __ __ CLC
41f8 : a5 49 __ LDA T6 + 0 
41fa : 65 4c __ ADC T8 + 0 
41fc : 85 49 __ STA T6 + 0 
41fe : a5 4a __ LDA T6 + 1 
4200 : 69 00 __ ADC #$00
4202 : 85 4a __ STA T6 + 1 
4204 : 4c d3 40 JMP $40d3 ; (compress_and_write_page.l6 + 0)
.s18:
4207 : a5 49 __ LDA T6 + 0 
4209 : 85 1b __ STA ACCU + 0 
420b : a5 0f __ LDA P2 ; (src + 1)
420d : 65 4a __ ADC T6 + 1 
420f : 85 1c __ STA ACCU + 1 
4211 : a4 0e __ LDY P1 ; (src + 0)
4213 : b1 1b __ LDA (ACCU + 0),y 
4215 : a6 4b __ LDX T7 + 0 
4217 : e8 __ __ INX
4218 : 86 4b __ STX T7 + 0 
421a : 9d 7e 9f STA $9f7e,x ; (page_buf[0] + 222)
421d : e6 49 __ INC T6 + 0 
421f : d0 02 __ BNE $4223 ; (compress_and_write_page.s49 + 0)
.s48:
4221 : e6 4a __ INC T6 + 1 
.s49:
4223 : a5 4a __ LDA T6 + 1 
4225 : e0 7f __ CPX #$7f
4227 : d0 db __ BNE $4204 ; (compress_and_write_page.s25 + 13)
.s19:
4229 : 8a __ __ TXA
422a : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
422d : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
4230 : aa __ __ TAX
4231 : d0 90 __ BNE $41c3 ; (compress_and_write_page.s26 + 9)
.s20:
4233 : 85 43 __ STA T1 + 0 
4235 : aa __ __ TAX
.l21:
4236 : bd 7f 9f LDA $9f7f,x ; (lit_buf[0] + 0)
4239 : 20 4d 42 JSR $424d ; (krnio_chrout.s4 + 0)
423c : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
423f : aa __ __ TAX
4240 : d0 81 __ BNE $41c3 ; (compress_and_write_page.s26 + 9)
.s22:
4242 : e6 43 __ INC T1 + 0 
4244 : a6 43 __ LDX T1 + 0 
4246 : e0 7f __ CPX #$7f
4248 : 90 ec __ BCC $4236 ; (compress_and_write_page.l21 + 0)
424a : 4c cf 40 JMP $40cf ; (compress_and_write_page.l5 + 0)
--------------------------------------------------------------------
krnio_chrout: ; krnio_chrout(u8)->bool
;  63, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
424d : 85 0d __ STA P0 
424f : a5 0d __ LDA P0 
4251 : 20 d2 ff JSR $ffd2 
4254 : 85 1b __ STA ACCU + 0 
4256 : a5 1b __ LDA ACCU + 0 
4258 : f0 02 __ BEQ $425c ; (krnio_chrout.s3 + 0)
.s5:
425a : a9 01 __ LDA #$01
.s3:
425c : 60 __ __ RTS
--------------------------------------------------------------------
425d : __ __ __ BYT 31 30 30 25 00                                  : 100%.
--------------------------------------------------------------------
4262 : __ __ __ BYT 42 41 43 4b 55 50 20 43 4f 4d 50 4c 45 54 41 54 : BACKUP COMPLETAT
4272 : __ __ __ BYT 4f 20 43 4f 4e 20 53 55 43 43 45 53 53 4f 21 20 : O CON SUCCESSO! 
4282 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
4283 : __ __ __ BYT 45 52 52 4f 52 45 20 44 49 20 41 50 45 52 54 55 : ERRORE DI APERTU
4293 : __ __ __ BYT 52 41 20 49 4e 20 53 43 52 49 54 54 55 52 41 21 : RA IN SCRITTURA!
42a3 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
42a4 : __ __ __ BYT 45 52 52 4f 52 45 3a 20 46 49 4c 45 20 44 49 20 : ERRORE: FILE DI 
42b4 : __ __ __ BYT 42 41 43 4b 55 50 20 4e 4f 4e 20 54 52 4f 56 41 : BACKUP NON TROVA
42c4 : __ __ __ BYT 54 4f 21 00                                     : TO!.
--------------------------------------------------------------------
42c8 : __ __ __ BYT 4c 45 54 54 55 52 41 20 46 49 4c 45 20 49 4e 20 : LETTURA FILE IN 
42d8 : __ __ __ BYT 43 4f 52 53 4f 2e 2e 2e 00                      : CORSO....
--------------------------------------------------------------------
krnio_read_lzo: ; krnio_read_lzo(u8,u8*)->i16
;  93, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
42e1 : a6 0e __ LDX P1 ; (fnum + 0)
42e3 : bd 9a 4a LDA $4a9a,x ; (krnio_pstatus[0] + 0)
42e6 : c9 40 __ CMP #$40
42e8 : d0 07 __ BNE $42f1 ; (krnio_read_lzo.s5 + 0)
.s18:
42ea : a9 00 __ LDA #$00
.s21:
42ec : 85 1b __ STA ACCU + 0 
.s3:
42ee : 85 1c __ STA ACCU + 1 
42f0 : 60 __ __ RTS
.s5:
42f1 : 86 46 __ STX T4 + 0 
42f3 : 8a __ __ TXA
42f4 : 20 71 22 JSR $2271 ; (krnio_chkin.s4 + 0)
42f7 : aa __ __ TAX
42f8 : d0 04 __ BNE $42fe ; (krnio_read_lzo.s7 + 0)
.s6:
42fa : a9 ff __ LDA #$ff
42fc : d0 ee __ BNE $42ec ; (krnio_read_lzo.s21 + 0)
.s7:
42fe : a9 00 __ LDA #$00
4300 : 85 47 __ STA T5 + 0 
4302 : 85 48 __ STA T5 + 1 
.l8:
4304 : 85 45 __ STA T2 + 0 
.l9:
4306 : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
4309 : 85 43 __ STA T1 + 0 
430b : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
430e : 85 1d __ STA ACCU + 2 
4310 : aa __ __ TAX
4311 : f0 04 __ BEQ $4317 ; (krnio_read_lzo.s10 + 0)
.s17:
4313 : c9 40 __ CMP #$40
4315 : d0 21 __ BNE $4338 ; (krnio_read_lzo.s26 + 0)
.s10:
4317 : a5 45 __ LDA T2 + 0 
4319 : 30 41 __ BMI $435c ; (krnio_read_lzo.s16 + 0)
.s11:
431b : d0 20 __ BNE $433d ; (krnio_read_lzo.s15 + 0)
.s12:
431d : a5 43 __ LDA T1 + 0 
431f : f0 17 __ BEQ $4338 ; (krnio_read_lzo.s26 + 0)
.s14:
4321 : 85 45 __ STA T2 + 0 
4323 : a5 1d __ LDA ACCU + 2 
4325 : f0 df __ BEQ $4306 ; (krnio_read_lzo.l9 + 0)
.s13:
4327 : a6 46 __ LDX T4 + 0 
4329 : 9d 9a 4a STA $4a9a,x ; (krnio_pstatus[0] + 0)
432c : 20 fa 18 JSR $18fa ; (krnio_clrchn.s4 + 0)
432f : a5 47 __ LDA T5 + 0 
4331 : 85 1b __ STA ACCU + 0 
4333 : a5 48 __ LDA T5 + 1 
4335 : 4c ee 42 JMP $42ee ; (krnio_read_lzo.s3 + 0)
.s26:
4338 : a5 1d __ LDA ACCU + 2 
433a : 4c 27 43 JMP $4327 ; (krnio_read_lzo.s13 + 0)
.s15:
433d : a5 47 __ LDA T5 + 0 
433f : 85 1b __ STA ACCU + 0 
4341 : 18 __ __ CLC
4342 : a5 10 __ LDA P3 ; (data + 1)
4344 : 65 48 __ ADC T5 + 1 
4346 : 85 1c __ STA ACCU + 1 
4348 : a5 43 __ LDA T1 + 0 
434a : a4 0f __ LDY P2 ; (data + 0)
434c : 91 1b __ STA (ACCU + 0),y 
434e : c6 45 __ DEC T2 + 0 
4350 : e6 47 __ INC T5 + 0 
4352 : d0 02 __ BNE $4356 ; (krnio_read_lzo.s25 + 0)
.s24:
4354 : e6 48 __ INC T5 + 1 
.s25:
4356 : a5 1d __ LDA ACCU + 2 
4358 : d0 cd __ BNE $4327 ; (krnio_read_lzo.s13 + 0)
435a : f0 aa __ BEQ $4306 ; (krnio_read_lzo.l9 + 0)
.s16:
435c : 18 __ __ CLC
435d : a5 0f __ LDA P2 ; (data + 0)
435f : 65 47 __ ADC T5 + 0 
4361 : 85 1b __ STA ACCU + 0 
4363 : a5 10 __ LDA P3 ; (data + 1)
4365 : 65 48 __ ADC T5 + 1 
4367 : 85 1c __ STA ACCU + 1 
4369 : 38 __ __ SEC
436a : a5 1b __ LDA ACCU + 0 
436c : e5 43 __ SBC T1 + 0 
436e : 85 43 __ STA T1 + 0 
4370 : a5 1c __ LDA ACCU + 1 
4372 : e9 00 __ SBC #$00
4374 : 85 44 __ STA T1 + 1 
4376 : a5 45 __ LDA T2 + 0 
4378 : 29 7f __ AND #$7f
437a : 85 1e __ STA ACCU + 3 
437c : 18 __ __ CLC
437d : 65 47 __ ADC T5 + 0 
437f : 85 47 __ STA T5 + 0 
4381 : 90 02 __ BCC $4385 ; (krnio_read_lzo.s23 + 0)
.s22:
4383 : e6 48 __ INC T5 + 1 
.s23:
4385 : a0 00 __ LDY #$00
.l19:
4387 : b1 43 __ LDA (T1 + 0),y 
4389 : 91 1b __ STA (ACCU + 0),y 
438b : c8 __ __ INY
438c : c4 1e __ CPY ACCU + 3 
438e : d0 f7 __ BNE $4387 ; (krnio_read_lzo.l19 + 0)
.s20:
4390 : a5 1d __ LDA ACCU + 2 
4392 : d0 93 __ BNE $4327 ; (krnio_read_lzo.s13 + 0)
4394 : 4c 04 43 JMP $4304 ; (krnio_read_lzo.l8 + 0)
--------------------------------------------------------------------
4397 : __ __ __ BYT 52 49 50 52 49 53 54 49 4e 4f 20 44 41 20 46 4c : RIPRISTINO DA FL
43a7 : __ __ __ BYT 4f 50 50 59 20 43 4f 4d 50 4c 45 54 41 54 4f 21 : OPPY COMPLETATO!
43b7 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
verify_backup: ; verify_backup()->void
; 561, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
43b8 : a2 06 __ LDX #$06
43ba : b5 53 __ LDA T4 + 0,x 
43bc : 9d 3b 9e STA $9e3b,x ; (verify_backup@stack + 0)
43bf : ca __ __ DEX
43c0 : 10 f8 __ BPL $43ba ; (verify_backup.s1 + 2)
.s4:
43c2 : a9 17 __ LDA #$17
43c4 : 85 0d __ STA P0 
43c6 : a9 0b __ LDA #$0b
43c8 : 85 0e __ STA P1 
43ca : ad fe 32 LDA $32fe ; (sram_mode_active + 0)
43cd : 85 56 __ STA T6 + 0 
43cf : f0 03 __ BEQ $43d4 ; (verify_backup.s5 + 0)
43d1 : 4c 60 48 JMP $4860 ; (verify_backup.s95 + 0)
.s5:
43d4 : ad ff 27 LDA $27ff ; (eeprom_status + 0)
43d7 : d0 46 __ BNE $441f ; (verify_backup.s12 + 0)
.s6:
43d9 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
43dc : a9 0f __ LDA #$0f
43de : 85 16 __ STA P9 
43e0 : a9 02 __ LDA #$02
43e2 : 85 17 __ STA P10 
43e4 : a5 56 __ LDA T6 + 0 
43e6 : d0 07 __ BNE $43ef ; (verify_backup.s11 + 0)
.s7:
43e8 : a9 1e __ LDA #$1e
43ea : a2 56 __ LDX #$56
43ec : 4c f3 43 JMP $43f3 ; (verify_backup.s8 + 0)
.s11:
43ef : a9 1e __ LDA #$1e
43f1 : a2 35 __ LDX #$35
.s8:
43f3 : 86 14 __ STX P7 
43f5 : 85 15 __ STA P8 
43f7 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s9:
43fa : a9 17 __ LDA #$17
43fc : 85 16 __ STA P9 
43fe : a9 0c __ LDA #$0c
4400 : 85 15 __ STA P8 
4402 : a9 01 __ LDA #$01
4404 : 85 17 __ STA P10 
4406 : a9 d1 __ LDA #$d1
4408 : 85 14 __ STA P7 
440a : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l10:
440d : 20 83 0c JSR $0c83 ; (get_key.s4 + 0)
4410 : c9 0d __ CMP #$0d
4412 : d0 f9 __ BNE $440d ; (verify_backup.l10 + 0)
.s3:
4414 : a2 06 __ LDX #$06
4416 : bd 3b 9e LDA $9e3b,x ; (verify_backup@stack + 0)
4419 : 95 53 __ STA T4 + 0,x 
441b : ca __ __ DEX
441c : 10 f8 __ BPL $4416 ; (verify_backup.s3 + 2)
441e : 60 __ __ RTS
.s12:
441f : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
4422 : a9 0f __ LDA #$0f
4424 : 85 16 __ STA P9 
4426 : a9 3f __ LDA #$3f
4428 : 85 15 __ STA P8 
442a : a9 03 __ LDA #$03
442c : 85 17 __ STA P10 
442e : a9 6c __ LDA #$6c
4430 : 85 14 __ STA P7 
4432 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
4435 : a5 56 __ LDA T6 + 0 
4437 : d0 0f __ BNE $4448 ; (verify_backup.s94 + 0)
.s13:
4439 : a9 3f __ LDA #$3f
443b : 85 4a __ STA T0 + 1 
443d : 85 4c __ STA T1 + 1 
443f : a9 3f __ LDA #$3f
4441 : a2 bd __ LDX #$bd
4443 : a0 a9 __ LDY #$a9
4445 : 4c 54 44 JMP $4454 ; (verify_backup.s14 + 0)
.s94:
4448 : a9 3f __ LDA #$3f
444a : 85 4a __ STA T0 + 1 
444c : 85 4c __ STA T1 + 1 
444e : a9 3f __ LDA #$3f
4450 : a2 9a __ LDX #$9a
4452 : a0 88 __ LDY #$88
.s14:
4454 : 86 4d __ STX T2 + 0 
4456 : 84 4b __ STY T1 + 0 
4458 : 84 0d __ STY P0 
445a : 85 4e __ STA T2 + 1 
445c : a5 4a __ LDA T0 + 1 
445e : 85 0e __ STA P1 
4460 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
4463 : a9 03 __ LDA #$03
4465 : 85 0d __ STA P0 
4467 : 85 0f __ STA P2 
4469 : a9 08 __ LDA #$08
446b : 85 0e __ STA P1 
446d : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
4470 : 85 49 __ STA T0 + 0 
4472 : a9 00 __ LDA #$00
4474 : 85 51 __ STA T3 + 0 
4476 : 85 53 __ STA T4 + 0 
4478 : a9 ff __ LDA #$ff
447a : 85 0d __ STA P0 
447c : a9 0c __ LDA #$0c
447e : 85 0e __ STA P1 
4480 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
4483 : a9 0f __ LDA #$0f
4485 : 85 0d __ STA P0 
4487 : 85 0f __ STA P2 
4489 : a9 08 __ LDA #$08
448b : 85 0e __ STA P1 
448d : a5 49 __ LDA T0 + 0 
448f : f0 03 __ BEQ $4494 ; (verify_backup.s15 + 0)
4491 : 4c 20 48 JMP $4820 ; (verify_backup.s88 + 0)
.s15:
4494 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
4497 : aa __ __ TAX
4498 : f0 05 __ BEQ $449f ; (verify_backup.s16 + 0)
.s87:
449a : a9 0f __ LDA #$0f
.s98:
449c : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s16:
449f : a5 4d __ LDA T2 + 0 
44a1 : 85 0d __ STA P0 
44a3 : a5 4e __ LDA T2 + 1 
44a5 : 85 0e __ STA P1 
44a7 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
44aa : a9 03 __ LDA #$03
44ac : 85 0d __ STA P0 
44ae : 85 0f __ STA P2 
44b0 : a9 08 __ LDA #$08
44b2 : 85 0e __ STA P1 
44b4 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
44b7 : aa __ __ TAX
44b8 : f0 03 __ BEQ $44bd ; (verify_backup.s17 + 0)
44ba : 4c cb 47 JMP $47cb ; (verify_backup.s81 + 0)
.s17:
44bd : a9 ff __ LDA #$ff
44bf : 85 0d __ STA P0 
44c1 : a9 0c __ LDA #$0c
44c3 : 85 0e __ STA P1 
44c5 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
44c8 : a9 0f __ LDA #$0f
44ca : 85 0d __ STA P0 
44cc : 85 0f __ STA P2 
44ce : a9 08 __ LDA #$08
44d0 : 85 0e __ STA P1 
44d2 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
44d5 : aa __ __ TAX
44d6 : f0 05 __ BEQ $44dd ; (verify_backup.s18 + 0)
.s80:
44d8 : a9 0f __ LDA #$0f
.s97:
44da : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s18:
44dd : a9 0f __ LDA #$0f
44df : 85 0d __ STA P0 
44e1 : a9 0b __ LDA #$0b
44e3 : 85 0e __ STA P1 
44e5 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
44e8 : ad 98 4a LDA $4a98 ; (lzo_enabled + 0)
44eb : f0 03 __ BEQ $44f0 ; (verify_backup.s19 + 0)
44ed : 4c ba 47 JMP $47ba ; (verify_backup.s78 + 0)
.s19:
44f0 : a5 53 __ LDA T4 + 0 
44f2 : f0 04 __ BEQ $44f8 ; (verify_backup.s20 + 0)
.s77:
44f4 : a9 00 __ LDA #$00
44f6 : f0 11 __ BEQ $4509 ; (verify_backup.s22 + 0)
.s20:
44f8 : a5 51 __ LDA T3 + 0 
44fa : d0 0d __ BNE $4509 ; (verify_backup.s22 + 0)
.s21:
44fc : c6 17 __ DEC P10 
44fe : a9 13 __ LDA #$13
4500 : 85 16 __ STA P9 
4502 : a9 42 __ LDA #$42
4504 : a2 a4 __ LDX #$a4
4506 : 4c f3 43 JMP $43f3 ; (verify_backup.s8 + 0)
.s22:
4509 : 85 57 __ STA T7 + 0 
450b : a9 13 __ LDA #$13
450d : 85 16 __ STA P9 
450f : a9 48 __ LDA #$48
4511 : 85 15 __ STA P8 
4513 : a9 6b __ LDA #$6b
4515 : 85 14 __ STA P7 
4517 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
451a : a5 57 __ LDA T7 + 0 
451c : d0 08 __ BNE $4526 ; (verify_backup.s24 + 0)
.s23:
451e : a5 4d __ LDA T2 + 0 
4520 : 85 4b __ STA T1 + 0 
4522 : a5 4e __ LDA T2 + 1 
4524 : 85 4c __ STA T1 + 1 
.s24:
4526 : a5 4b __ LDA T1 + 0 
4528 : 85 0d __ STA P0 
452a : a5 4c __ LDA T1 + 1 
452c : 85 0e __ STA P1 
452e : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
4531 : a9 03 __ LDA #$03
4533 : 85 0d __ STA P0 
4535 : 85 0f __ STA P2 
4537 : a9 08 __ LDA #$08
4539 : 85 0e __ STA P1 
453b : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
453e : aa __ __ TAX
453f : d0 09 __ BNE $454a ; (verify_backup.s26 + 0)
.s25:
4541 : c6 17 __ DEC P10 
4543 : a9 28 __ LDA #$28
4545 : a2 00 __ LDX #$00
4547 : 4c f3 43 JMP $43f3 ; (verify_backup.s8 + 0)
.s26:
454a : a9 03 __ LDA #$03
454c : 20 71 22 JSR $2271 ; (krnio_chkin.s4 + 0)
454f : aa __ __ TAX
4550 : d0 15 __ BNE $4567 ; (verify_backup.s31 + 0)
.s27:
4552 : c6 17 __ DEC P10 
4554 : a9 28 __ LDA #$28
4556 : a2 1f __ LDX #$1f
.s28:
4558 : 86 14 __ STX P7 
.s29:
455a : 85 15 __ STA P8 
455c : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s30:
455f : a9 03 __ LDA #$03
4561 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
4564 : 4c fa 43 JMP $43fa ; (verify_backup.s9 + 0)
.s31:
4567 : ad fe 18 LDA $18fe ; (mdp_ctrl_shadow + 0)
456a : 85 58 __ STA T8 + 0 
456c : a5 56 __ LDA T6 + 0 
456e : f0 1f __ BEQ $458f ; (verify_backup.s32 + 0)
.s76:
4570 : 20 c6 13 JSR $13c6 ; (mdp_sram_enable.s4 + 0)
4573 : a9 00 __ LDA #$00
4575 : 85 51 __ STA T3 + 0 
4577 : a9 02 __ LDA #$02
4579 : 85 52 __ STA T3 + 1 
.s34:
457b : a9 00 __ LDA #$00
457d : 85 53 __ STA T4 + 0 
457f : 85 54 __ STA T4 + 1 
4581 : 85 4d __ STA T2 + 0 
4583 : 85 4e __ STA T2 + 1 
4585 : 85 4f __ STA T2 + 2 
4587 : 85 50 __ STA T2 + 3 
4589 : a9 01 __ LDA #$01
458b : 85 59 __ STA T9 + 0 
458d : d0 15 __ BNE $45a4 ; (verify_backup.l35 + 0)
.s32:
458f : a9 20 __ LDA #$20
4591 : cd ff 1a CMP $1aff ; (eeprom_size_kb + 0)
4594 : d0 02 __ BNE $4598 ; (verify_backup.s33 + 0)
.s75:
4596 : a9 80 __ LDA #$80
.s33:
4598 : 85 51 __ STA T3 + 0 
459a : a9 00 __ LDA #$00
459c : 85 52 __ STA T3 + 1 
459e : 20 bf 0d JSR $0dbf ; (mdp_eeprom_enable.s4 + 0)
45a1 : 4c 7b 45 JMP $457b ; (verify_backup.s34 + 0)
.l35:
45a4 : a5 53 __ LDA T4 + 0 
45a6 : 85 1b __ STA ACCU + 0 
45a8 : a5 54 __ LDA T4 + 1 
45aa : 85 1c __ STA ACCU + 1 
45ac : a9 00 __ LDA #$00
45ae : 85 1d __ STA ACCU + 2 
45b0 : 85 1e __ STA ACCU + 3 
45b2 : a9 64 __ LDA #$64
45b4 : 20 06 49 JSR $4906 ; (mul32by8 + 0)
45b7 : a5 07 __ LDA WORK + 4 
45b9 : 85 1b __ STA ACCU + 0 
45bb : a5 08 __ LDA WORK + 5 
45bd : 85 1c __ STA ACCU + 1 
45bf : a5 09 __ LDA WORK + 6 
45c1 : 85 1d __ STA ACCU + 2 
45c3 : a5 0a __ LDA WORK + 7 
45c5 : 85 1e __ STA ACCU + 3 
45c7 : a5 51 __ LDA T3 + 0 
45c9 : 85 03 __ STA WORK + 0 
45cb : a5 52 __ LDA T3 + 1 
45cd : 85 04 __ STA WORK + 1 
45cf : a9 00 __ LDA #$00
45d1 : 85 0e __ STA P1 
45d3 : 85 05 __ STA WORK + 2 
45d5 : 85 06 __ STA WORK + 3 
45d7 : 20 c1 49 JSR $49c1 ; (divmod32 + 0)
45da : a5 1b __ LDA ACCU + 0 
45dc : 85 0d __ STA P0 
45de : a9 a0 __ LDA #$a0
45e0 : 85 0f __ STA P2 
45e2 : a9 9f __ LDA #$9f
45e4 : 85 10 __ STA P3 
45e6 : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
45e9 : a9 a0 __ LDA #$a0
45eb : 85 0d __ STA P0 
45ed : a9 9f __ LDA #$9f
45ef : 85 0e __ STA P1 
45f1 : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
45f4 : a9 25 __ LDA #$25
45f6 : a6 1b __ LDX ACCU + 0 
45f8 : 9d a0 9f STA $9fa0,x ; (pct_str[0] + 0)
45fb : a9 a0 __ LDA #$a0
45fd : 85 14 __ STA P7 
45ff : a9 9f __ LDA #$9f
4601 : 85 15 __ STA P8 
4603 : a9 13 __ LDA #$13
4605 : 85 16 __ STA P9 
4607 : a9 07 __ LDA #$07
4609 : 85 17 __ STA P10 
460b : a9 00 __ LDA #$00
460d : 9d a1 9f STA $9fa1,x ; (pct_str[0] + 1)
4610 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
4613 : a5 56 __ LDA T6 + 0 
4615 : f0 05 __ BEQ $461c ; (verify_backup.s36 + 0)
.s74:
4617 : a5 54 __ LDA T4 + 1 
4619 : 20 86 17 JSR $1786 ; (mdp_set_bank.s4 + 0)
.s36:
461c : a5 53 __ LDA T4 + 0 
461e : 8d 01 de STA $de01 
4621 : a5 57 __ LDA T7 + 0 
4623 : f0 03 __ BEQ $4628 ; (verify_backup.s37 + 0)
4625 : 4c 7e 47 JMP $477e ; (verify_backup.s69 + 0)
.s37:
4628 : 85 49 __ STA T0 + 0 
.l38:
462a : 20 8e 22 JSR $228e ; (krnio_chrin.s4 + 0)
462d : 85 55 __ STA T5 + 0 
462f : 20 96 22 JSR $2296 ; (krnio_status.s4 + 0)
4632 : aa __ __ TAX
4633 : f0 08 __ BEQ $463d ; (verify_backup.s39 + 0)
.s67:
4635 : c9 40 __ CMP #$40
4637 : f0 04 __ BEQ $463d ; (verify_backup.s39 + 0)
.s68:
4639 : c6 59 __ DEC T9 + 0 
463b : f0 32 __ BEQ $466f ; (verify_backup.s42 + 0)
.s39:
463d : a5 49 __ LDA T0 + 0 
463f : 20 01 17 JSR $1701 ; (mdp_read_byte.s4 + 0)
4642 : c5 55 __ CMP T5 + 0 
4644 : f0 0e __ BEQ $4654 ; (verify_backup.s40 + 0)
.s66:
4646 : e6 4d __ INC T2 + 0 
4648 : d0 0a __ BNE $4654 ; (verify_backup.s40 + 0)
.s106:
464a : e6 4e __ INC T2 + 1 
464c : d0 06 __ BNE $4654 ; (verify_backup.s40 + 0)
.s104:
464e : e6 4f __ INC T2 + 2 
4650 : d0 02 __ BNE $4654 ; (verify_backup.s40 + 0)
.s103:
4652 : e6 50 __ INC T2 + 3 
.s40:
4654 : e6 49 __ INC T0 + 0 
4656 : d0 d2 __ BNE $462a ; (verify_backup.l38 + 0)
.s41:
4658 : e6 53 __ INC T4 + 0 
465a : d0 02 __ BNE $465e ; (verify_backup.s100 + 0)
.s99:
465c : e6 54 __ INC T4 + 1 
.s100:
465e : a5 54 __ LDA T4 + 1 
4660 : c5 52 __ CMP T3 + 1 
4662 : b0 03 __ BCS $4667 ; (verify_backup.s107 + 0)
4664 : 4c a4 45 JMP $45a4 ; (verify_backup.l35 + 0)
.s107:
4667 : d0 06 __ BNE $466f ; (verify_backup.s42 + 0)
.s65:
4669 : a5 53 __ LDA T4 + 0 
466b : c5 51 __ CMP T3 + 0 
466d : 90 f5 __ BCC $4664 ; (verify_backup.s100 + 6)
.s42:
466f : a5 58 __ LDA T8 + 0 
4671 : 8d 03 de STA $de03 
4674 : 8d fe 18 STA $18fe ; (mdp_ctrl_shadow + 0)
4677 : 20 fa 18 JSR $18fa ; (krnio_clrchn.s4 + 0)
467a : a5 59 __ LDA T9 + 0 
467c : d0 5c __ BNE $46da ; (verify_backup.s47 + 0)
.s43:
467e : 8d 46 9e STA $9e46 ; (dos_err[0] + 0)
4681 : a9 ff __ LDA #$ff
4683 : 85 0d __ STA P0 
4685 : a9 0c __ LDA #$0c
4687 : 85 0e __ STA P1 
4689 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
468c : a9 0f __ LDA #$0f
468e : 85 0d __ STA P0 
4690 : 85 0f __ STA P2 
4692 : a9 08 __ LDA #$08
4694 : 85 0e __ STA P1 
4696 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
4699 : aa __ __ TAX
469a : f0 18 __ BEQ $46b4 ; (verify_backup.s44 + 0)
.s46:
469c : a9 46 __ LDA #$46
469e : 85 0e __ STA P1 
46a0 : a9 00 __ LDA #$00
46a2 : 85 11 __ STA P4 
46a4 : a9 9e __ LDA #$9e
46a6 : 85 0f __ STA P2 
46a8 : a9 28 __ LDA #$28
46aa : 85 10 __ STA P3 
46ac : 20 dd 30 JSR $30dd ; (read_dos_status.s4 + 0)
46af : a9 0f __ LDA #$0f
46b1 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s44:
46b4 : a9 13 __ LDA #$13
46b6 : 85 16 __ STA P9 
46b8 : a9 28 __ LDA #$28
46ba : 85 15 __ STA P8 
46bc : a9 02 __ LDA #$02
46be : 85 17 __ STA P10 
46c0 : a9 71 __ LDA #$71
46c2 : 85 14 __ STA P7 
46c4 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
46c7 : ad 46 9e LDA $9e46 ; (dos_err[0] + 0)
46ca : d0 03 __ BNE $46cf ; (verify_backup.s45 + 0)
46cc : 4c 5f 45 JMP $455f ; (verify_backup.s30 + 0)
.s45:
46cf : a9 46 __ LDA #$46
46d1 : 85 14 __ STA P7 
46d3 : a9 9e __ LDA #$9e
46d5 : e6 17 __ INC P10 
46d7 : 4c 5a 45 JMP $455a ; (verify_backup.s29 + 0)
.s47:
46da : a9 13 __ LDA #$13
46dc : 85 16 __ STA P9 
46de : a9 42 __ LDA #$42
46e0 : 85 15 __ STA P8 
46e2 : a9 07 __ LDA #$07
46e4 : 85 17 __ STA P10 
46e6 : a9 5d __ LDA #$5d
46e8 : 85 14 __ STA P7 
46ea : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
46ed : a5 50 __ LDA T2 + 3 
46ef : d0 17 __ BNE $4708 ; (verify_backup.s48 + 0)
.s62:
46f1 : a5 4f __ LDA T2 + 2 
46f3 : d0 13 __ BNE $4708 ; (verify_backup.s48 + 0)
.s63:
46f5 : a5 4e __ LDA T2 + 1 
46f7 : d0 0f __ BNE $4708 ; (verify_backup.s48 + 0)
.s64:
46f9 : a5 4d __ LDA T2 + 0 
46fb : d0 0b __ BNE $4708 ; (verify_backup.s48 + 0)
.s61:
46fd : a9 05 __ LDA #$05
46ff : 85 17 __ STA P10 
4701 : a9 48 __ LDA #$48
4703 : a2 80 __ LDX #$80
4705 : 4c 58 45 JMP $4558 ; (verify_backup.s28 + 0)
.s48:
4708 : a9 56 __ LDA #$56
470a : a2 00 __ LDX #$00
.l96:
470c : 9d 78 9e STA $9e78,x ; (err_msg[0] + 0)
470f : e8 __ __ INX
4710 : bd a1 48 LDA $48a1,x 
4713 : d0 f7 __ BNE $470c ; (verify_backup.l96 + 0)
.s49:
4715 : 86 51 __ STX T3 + 0 
4717 : a5 50 __ LDA T2 + 3 
4719 : d0 04 __ BNE $471f ; (verify_backup.s108 + 0)
.s57:
471b : a5 4f __ LDA T2 + 2 
471d : f0 07 __ BEQ $4726 ; (verify_backup.s58 + 0)
.s108:
471f : a9 ff __ LDA #$ff
.s56:
4721 : 85 0d __ STA P0 
4723 : 4c 36 47 JMP $4736 ; (verify_backup.s51 + 0)
.s58:
4726 : a9 ff __ LDA #$ff
4728 : c5 4e __ CMP T2 + 1 
472a : d0 02 __ BNE $472e ; (verify_backup.s60 + 0)
.s59:
472c : c5 4d __ CMP T2 + 0 
.s60:
472e : 90 f1 __ BCC $4721 ; (verify_backup.s56 + 0)
.s50:
4730 : a5 4d __ LDA T2 + 0 
4732 : 85 0d __ STA P0 
4734 : a5 4e __ LDA T2 + 1 
.s51:
4736 : 85 0e __ STA P1 
4738 : a9 6e __ LDA #$6e
473a : 85 0f __ STA P2 
473c : a9 9e __ LDA #$9e
473e : 85 10 __ STA P3 
4740 : 20 39 24 JSR $2439 ; (uint16_to_str.s4 + 0)
4743 : a9 6e __ LDA #$6e
4745 : 85 0d __ STA P0 
4747 : a9 9e __ LDA #$9e
4749 : 85 0e __ STA P1 
474b : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
474e : ac 6e 9e LDY $9e6e ; (num_str[0] + 0)
4751 : f0 19 __ BEQ $476c ; (verify_backup.s109 + 0)
.s53:
4753 : a9 00 __ LDA #$00
4755 : 85 49 __ STA T0 + 0 
.l54:
4757 : a6 51 __ LDX T3 + 0 
4759 : e0 27 __ CPX #$27
475b : b0 11 __ BCS $476e ; (verify_backup.s52 + 0)
.s55:
475d : 98 __ __ TYA
475e : 9d 78 9e STA $9e78,x ; (err_msg[0] + 0)
4761 : e6 51 __ INC T3 + 0 
4763 : e6 49 __ INC T0 + 0 
4765 : a6 49 __ LDX T0 + 0 
4767 : bc 6e 9e LDY $9e6e,x ; (num_str[0] + 0)
476a : d0 eb __ BNE $4757 ; (verify_backup.l54 + 0)
.s109:
476c : a6 51 __ LDX T3 + 0 
.s52:
476e : a9 00 __ LDA #$00
4770 : 9d 78 9e STA $9e78,x ; (err_msg[0] + 0)
4773 : a9 02 __ LDA #$02
4775 : 85 17 __ STA P10 
4777 : a9 9e __ LDA #$9e
4779 : a2 78 __ LDX #$78
477b : 4c 58 45 JMP $4558 ; (verify_backup.s28 + 0)
.s69:
477e : a9 03 __ LDA #$03
4780 : 85 0e __ STA P1 
4782 : a9 9e __ LDA #$9e
4784 : 85 10 __ STA P3 
4786 : a9 a0 __ LDA #$a0
4788 : 85 0f __ STA P2 
478a : 20 e1 42 JSR $42e1 ; (krnio_read_lzo.s4 + 0)
478d : a6 1c __ LDX ACCU + 1 
478f : ca __ __ DEX
4790 : f0 03 __ BEQ $4795 ; (verify_backup.s73 + 0)
4792 : 4c 39 46 JMP $4639 ; (verify_backup.s68 + 0)
.s73:
4795 : a5 1b __ LDA ACCU + 0 
4797 : d0 f9 __ BNE $4792 ; (verify_backup.s69 + 20)
.l70:
4799 : 85 0d __ STA P0 
479b : 20 01 17 JSR $1701 ; (mdp_read_byte.s4 + 0)
479e : a6 0d __ LDX P0 
47a0 : dd a0 9e CMP $9ea0,x ; (page_buf[0] + 0)
47a3 : f0 0e __ BEQ $47b3 ; (verify_backup.s71 + 0)
.s72:
47a5 : e6 4d __ INC T2 + 0 
47a7 : d0 0a __ BNE $47b3 ; (verify_backup.s71 + 0)
.s105:
47a9 : e6 4e __ INC T2 + 1 
47ab : d0 06 __ BNE $47b3 ; (verify_backup.s71 + 0)
.s102:
47ad : e6 4f __ INC T2 + 2 
47af : d0 02 __ BNE $47b3 ; (verify_backup.s71 + 0)
.s101:
47b1 : e6 50 __ INC T2 + 3 
.s71:
47b3 : e8 __ __ INX
47b4 : 8a __ __ TXA
47b5 : d0 e2 __ BNE $4799 ; (verify_backup.l70 + 0)
47b7 : 4c 58 46 JMP $4658 ; (verify_backup.s41 + 0)
.s78:
47ba : a5 51 __ LDA T3 + 0 
47bc : f0 03 __ BEQ $47c1 ; (verify_backup.s79 + 0)
47be : 4c 09 45 JMP $4509 ; (verify_backup.s22 + 0)
.s79:
47c1 : a5 53 __ LDA T4 + 0 
47c3 : d0 03 __ BNE $47c8 ; (verify_backup.s79 + 7)
47c5 : 4c fc 44 JMP $44fc ; (verify_backup.s21 + 0)
47c8 : 4c f4 44 JMP $44f4 ; (verify_backup.s77 + 0)
.s81:
47cb : a9 ff __ LDA #$ff
47cd : 85 0d __ STA P0 
47cf : a9 0c __ LDA #$0c
47d1 : 85 0e __ STA P1 
47d3 : 20 2d 22 JSR $222d ; (krnio_setnam.s4 + 0)
47d6 : a9 0f __ LDA #$0f
47d8 : 85 0d __ STA P0 
47da : 85 0f __ STA P2 
47dc : a9 08 __ LDA #$08
47de : 85 0e __ STA P1 
47e0 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
47e3 : aa __ __ TAX
47e4 : f0 35 __ BEQ $481b ; (verify_backup.s82 + 0)
.s83:
47e6 : a9 28 __ LDA #$28
47e8 : 85 10 __ STA P3 
47ea : a9 9f __ LDA #$9f
47ec : 85 0f __ STA P2 
47ee : a9 00 __ LDA #$00
47f0 : 85 11 __ STA P4 
47f2 : a9 a8 __ LDA #$a8
47f4 : 85 0e __ STA P1 
47f6 : 20 dd 30 JSR $30dd ; (read_dos_status.s4 + 0)
47f9 : ad a8 9f LDA $9fa8 ; (temp_status[0] + 0)
47fc : c9 30 __ CMP #$30
47fe : d0 16 __ BNE $4816 ; (verify_backup.s84 + 0)
.s85:
4800 : ad a9 9f LDA $9fa9 ; (temp_status[0] + 1)
4803 : c9 30 __ CMP #$30
4805 : d0 0f __ BNE $4816 ; (verify_backup.s84 + 0)
.s86:
4807 : a9 0f __ LDA #$0f
4809 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
480c : a9 03 __ LDA #$03
480e : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
4811 : e6 53 __ INC T4 + 0 
4813 : 4c dd 44 JMP $44dd ; (verify_backup.s18 + 0)
.s84:
4816 : a9 0f __ LDA #$0f
4818 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s82:
481b : a9 03 __ LDA #$03
481d : 4c da 44 JMP $44da ; (verify_backup.s97 + 0)
.s88:
4820 : 20 43 22 JSR $2243 ; (krnio_open.s4 + 0)
4823 : aa __ __ TAX
4824 : f0 35 __ BEQ $485b ; (verify_backup.s89 + 0)
.s90:
4826 : a9 28 __ LDA #$28
4828 : 85 10 __ STA P3 
482a : a9 9f __ LDA #$9f
482c : 85 0f __ STA P2 
482e : a9 00 __ LDA #$00
4830 : 85 11 __ STA P4 
4832 : a9 d0 __ LDA #$d0
4834 : 85 0e __ STA P1 
4836 : 20 dd 30 JSR $30dd ; (read_dos_status.s4 + 0)
4839 : ad d0 9f LDA $9fd0 ; (temp_status[0] + 0)
483c : c9 30 __ CMP #$30
483e : d0 16 __ BNE $4856 ; (verify_backup.s91 + 0)
.s92:
4840 : ad d1 9f LDA $9fd1 ; (temp_status[0] + 1)
4843 : c9 30 __ CMP #$30
4845 : d0 0f __ BNE $4856 ; (verify_backup.s91 + 0)
.s93:
4847 : a9 0f __ LDA #$0f
4849 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
484c : a9 03 __ LDA #$03
484e : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
4851 : e6 51 __ INC T3 + 0 
4853 : 4c 9f 44 JMP $449f ; (verify_backup.s16 + 0)
.s91:
4856 : a9 0f __ LDA #$0f
4858 : 20 86 22 JSR $2286 ; (krnio_close.s4 + 0)
.s89:
485b : a9 03 __ LDA #$03
485d : 4c 9c 44 JMP $449c ; (verify_backup.s98 + 0)
.s95:
4860 : ad ff 18 LDA $18ff ; (sram_status + 0)
4863 : f0 03 __ BEQ $4868 ; (verify_backup.s95 + 8)
4865 : 4c 1f 44 JMP $441f ; (verify_backup.s12 + 0)
4868 : 4c d9 43 JMP $43d9 ; (verify_backup.s6 + 0)
--------------------------------------------------------------------
486b : __ __ __ BYT 56 45 52 49 46 49 43 41 20 49 4e 20 43 4f 52 53 : VERIFICA IN CORS
487b : __ __ __ BYT 4f 2e 2e 2e 00                                  : O....
--------------------------------------------------------------------
4880 : __ __ __ BYT 42 41 43 4b 55 50 20 56 45 52 49 46 49 43 41 54 : BACKUP VERIFICAT
4890 : __ __ __ BYT 4f 3a 20 43 4f 52 52 45 54 54 4f 21 20 20 20 20 : O: CORRETTO!    
48a0 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
48a1 : __ __ __ BYT 56 45 52 49 46 49 43 41 20 46 41 4c 4c 49 54 41 : VERIFICA FALLITA
48b1 : __ __ __ BYT 21 20 45 52 52 3a 20 00                         : ! ERR: .
--------------------------------------------------------------------
48b9 : __ __ __ BYT 53 45 45 20 59 4f 55 20 53 50 41 43 45 20 43 4f : SEE YOU SPACE CO
48c9 : __ __ __ BYT 57 42 4f 59 00                                  : WBOY.
--------------------------------------------------------------------
mul16by8: ; mul16by8
48ce : 4a __ __ LSR
48cf : f0 2e __ BEQ $48ff ; (mul16by8 + 49)
48d1 : a2 00 __ LDX #$00
48d3 : a0 00 __ LDY #$00
48d5 : 90 13 __ BCC $48ea ; (mul16by8 + 28)
48d7 : a4 1b __ LDY ACCU + 0 
48d9 : a6 1c __ LDX ACCU + 1 
48db : b0 0d __ BCS $48ea ; (mul16by8 + 28)
48dd : 85 02 __ STA $02 
48df : 18 __ __ CLC
48e0 : 98 __ __ TYA
48e1 : 65 1b __ ADC ACCU + 0 
48e3 : a8 __ __ TAY
48e4 : 8a __ __ TXA
48e5 : 65 1c __ ADC ACCU + 1 
48e7 : aa __ __ TAX
48e8 : a5 02 __ LDA $02 
48ea : 06 1b __ ASL ACCU + 0 
48ec : 26 1c __ ROL ACCU + 1 
48ee : 4a __ __ LSR
48ef : 90 f9 __ BCC $48ea ; (mul16by8 + 28)
48f1 : d0 ea __ BNE $48dd ; (mul16by8 + 15)
48f3 : 18 __ __ CLC
48f4 : 98 __ __ TYA
48f5 : 65 1b __ ADC ACCU + 0 
48f7 : 85 1b __ STA ACCU + 0 
48f9 : 8a __ __ TXA
48fa : 65 1c __ ADC ACCU + 1 
48fc : 85 1c __ STA ACCU + 1 
48fe : 60 __ __ RTS
48ff : b0 04 __ BCS $4905 ; (mul16by8 + 55)
4901 : 85 1b __ STA ACCU + 0 
4903 : 85 1c __ STA ACCU + 1 
4905 : 60 __ __ RTS
--------------------------------------------------------------------
mul32by8: ; mul32by8
4906 : a0 00 __ LDY #$00
4908 : 84 07 __ STY WORK + 4 
490a : 84 08 __ STY WORK + 5 
490c : 84 09 __ STY WORK + 6 
490e : 4a __ __ LSR
490f : b0 0d __ BCS $491e ; (mul32by8 + 24)
4911 : f0 26 __ BEQ $4939 ; (mul32by8 + 51)
4913 : 06 1b __ ASL ACCU + 0 
4915 : 26 1c __ ROL ACCU + 1 
4917 : 26 1d __ ROL ACCU + 2 
4919 : 26 1e __ ROL ACCU + 3 
491b : 4a __ __ LSR
491c : 90 f5 __ BCC $4913 ; (mul32by8 + 13)
491e : aa __ __ TAX
491f : 18 __ __ CLC
4920 : a5 07 __ LDA WORK + 4 
4922 : 65 1b __ ADC ACCU + 0 
4924 : 85 07 __ STA WORK + 4 
4926 : a5 08 __ LDA WORK + 5 
4928 : 65 1c __ ADC ACCU + 1 
492a : 85 08 __ STA WORK + 5 
492c : a5 09 __ LDA WORK + 6 
492e : 65 1d __ ADC ACCU + 2 
4930 : 85 09 __ STA WORK + 6 
4932 : 98 __ __ TYA
4933 : 65 1e __ ADC ACCU + 3 
4935 : a8 __ __ TAY
4936 : 8a __ __ TXA
4937 : d0 da __ BNE $4913 ; (mul32by8 + 13)
4939 : 84 0a __ STY WORK + 7 
493b : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
493c : a5 1c __ LDA ACCU + 1 
493e : d0 31 __ BNE $4971 ; (divmod + 53)
4940 : a5 04 __ LDA WORK + 1 
4942 : d0 1e __ BNE $4962 ; (divmod + 38)
4944 : 85 06 __ STA WORK + 3 
4946 : a2 04 __ LDX #$04
4948 : 06 1b __ ASL ACCU + 0 
494a : 2a __ __ ROL
494b : c5 03 __ CMP WORK + 0 
494d : 90 02 __ BCC $4951 ; (divmod + 21)
494f : e5 03 __ SBC WORK + 0 
4951 : 26 1b __ ROL ACCU + 0 
4953 : 2a __ __ ROL
4954 : c5 03 __ CMP WORK + 0 
4956 : 90 02 __ BCC $495a ; (divmod + 30)
4958 : e5 03 __ SBC WORK + 0 
495a : 26 1b __ ROL ACCU + 0 
495c : ca __ __ DEX
495d : d0 eb __ BNE $494a ; (divmod + 14)
495f : 85 05 __ STA WORK + 2 
4961 : 60 __ __ RTS
4962 : a5 1b __ LDA ACCU + 0 
4964 : 85 05 __ STA WORK + 2 
4966 : a5 1c __ LDA ACCU + 1 
4968 : 85 06 __ STA WORK + 3 
496a : a9 00 __ LDA #$00
496c : 85 1b __ STA ACCU + 0 
496e : 85 1c __ STA ACCU + 1 
4970 : 60 __ __ RTS
4971 : a5 04 __ LDA WORK + 1 
4973 : d0 1f __ BNE $4994 ; (divmod + 88)
4975 : a5 03 __ LDA WORK + 0 
4977 : 30 1b __ BMI $4994 ; (divmod + 88)
4979 : a9 00 __ LDA #$00
497b : 85 06 __ STA WORK + 3 
497d : a2 10 __ LDX #$10
497f : 06 1b __ ASL ACCU + 0 
4981 : 26 1c __ ROL ACCU + 1 
4983 : 2a __ __ ROL
4984 : c5 03 __ CMP WORK + 0 
4986 : 90 02 __ BCC $498a ; (divmod + 78)
4988 : e5 03 __ SBC WORK + 0 
498a : 26 1b __ ROL ACCU + 0 
498c : 26 1c __ ROL ACCU + 1 
498e : ca __ __ DEX
498f : d0 f2 __ BNE $4983 ; (divmod + 71)
4991 : 85 05 __ STA WORK + 2 
4993 : 60 __ __ RTS
4994 : a9 00 __ LDA #$00
4996 : 85 05 __ STA WORK + 2 
4998 : 85 06 __ STA WORK + 3 
499a : 84 02 __ STY $02 
499c : a0 10 __ LDY #$10
499e : 18 __ __ CLC
499f : 26 1b __ ROL ACCU + 0 
49a1 : 26 1c __ ROL ACCU + 1 
49a3 : 26 05 __ ROL WORK + 2 
49a5 : 26 06 __ ROL WORK + 3 
49a7 : 38 __ __ SEC
49a8 : a5 05 __ LDA WORK + 2 
49aa : e5 03 __ SBC WORK + 0 
49ac : aa __ __ TAX
49ad : a5 06 __ LDA WORK + 3 
49af : e5 04 __ SBC WORK + 1 
49b1 : 90 04 __ BCC $49b7 ; (divmod + 123)
49b3 : 86 05 __ STX WORK + 2 
49b5 : 85 06 __ STA WORK + 3 
49b7 : 88 __ __ DEY
49b8 : d0 e5 __ BNE $499f ; (divmod + 99)
49ba : 26 1b __ ROL ACCU + 0 
49bc : 26 1c __ ROL ACCU + 1 
49be : a4 02 __ LDY $02 
49c0 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32: ; divmod32
49c1 : 84 02 __ STY $02 
49c3 : a0 20 __ LDY #$20
49c5 : a9 00 __ LDA #$00
49c7 : 85 07 __ STA WORK + 4 
49c9 : 85 08 __ STA WORK + 5 
49cb : 85 09 __ STA WORK + 6 
49cd : 85 0a __ STA WORK + 7 
49cf : a5 05 __ LDA WORK + 2 
49d1 : 05 06 __ ORA WORK + 3 
49d3 : d0 78 __ BNE $4a4d ; (divmod32 + 140)
49d5 : a5 04 __ LDA WORK + 1 
49d7 : d0 27 __ BNE $4a00 ; (divmod32 + 63)
49d9 : 18 __ __ CLC
49da : 26 1b __ ROL ACCU + 0 
49dc : 26 1c __ ROL ACCU + 1 
49de : 26 1d __ ROL ACCU + 2 
49e0 : 26 1e __ ROL ACCU + 3 
49e2 : 2a __ __ ROL
49e3 : 90 05 __ BCC $49ea ; (divmod32 + 41)
49e5 : e5 03 __ SBC WORK + 0 
49e7 : 38 __ __ SEC
49e8 : b0 06 __ BCS $49f0 ; (divmod32 + 47)
49ea : c5 03 __ CMP WORK + 0 
49ec : 90 02 __ BCC $49f0 ; (divmod32 + 47)
49ee : e5 03 __ SBC WORK + 0 
49f0 : 88 __ __ DEY
49f1 : d0 e7 __ BNE $49da ; (divmod32 + 25)
49f3 : 85 07 __ STA WORK + 4 
49f5 : 26 1b __ ROL ACCU + 0 
49f7 : 26 1c __ ROL ACCU + 1 
49f9 : 26 1d __ ROL ACCU + 2 
49fb : 26 1e __ ROL ACCU + 3 
49fd : a4 02 __ LDY $02 
49ff : 60 __ __ RTS
4a00 : a5 1e __ LDA ACCU + 3 
4a02 : d0 10 __ BNE $4a14 ; (divmod32 + 83)
4a04 : a6 1d __ LDX ACCU + 2 
4a06 : 86 1e __ STX ACCU + 3 
4a08 : a6 1c __ LDX ACCU + 1 
4a0a : 86 1d __ STX ACCU + 2 
4a0c : a6 1b __ LDX ACCU + 0 
4a0e : 86 1c __ STX ACCU + 1 
4a10 : 85 1b __ STA ACCU + 0 
4a12 : a0 18 __ LDY #$18
4a14 : 18 __ __ CLC
4a15 : 26 1b __ ROL ACCU + 0 
4a17 : 26 1c __ ROL ACCU + 1 
4a19 : 26 1d __ ROL ACCU + 2 
4a1b : 26 1e __ ROL ACCU + 3 
4a1d : 26 07 __ ROL WORK + 4 
4a1f : 26 08 __ ROL WORK + 5 
4a21 : 90 0c __ BCC $4a2f ; (divmod32 + 110)
4a23 : a5 07 __ LDA WORK + 4 
4a25 : e5 03 __ SBC WORK + 0 
4a27 : aa __ __ TAX
4a28 : a5 08 __ LDA WORK + 5 
4a2a : e5 04 __ SBC WORK + 1 
4a2c : 38 __ __ SEC
4a2d : b0 0c __ BCS $4a3b ; (divmod32 + 122)
4a2f : 38 __ __ SEC
4a30 : a5 07 __ LDA WORK + 4 
4a32 : e5 03 __ SBC WORK + 0 
4a34 : aa __ __ TAX
4a35 : a5 08 __ LDA WORK + 5 
4a37 : e5 04 __ SBC WORK + 1 
4a39 : 90 04 __ BCC $4a3f ; (divmod32 + 126)
4a3b : 86 07 __ STX WORK + 4 
4a3d : 85 08 __ STA WORK + 5 
4a3f : 88 __ __ DEY
4a40 : d0 d3 __ BNE $4a15 ; (divmod32 + 84)
4a42 : 26 1b __ ROL ACCU + 0 
4a44 : 26 1c __ ROL ACCU + 1 
4a46 : 26 1d __ ROL ACCU + 2 
4a48 : 26 1e __ ROL ACCU + 3 
4a4a : a4 02 __ LDY $02 
4a4c : 60 __ __ RTS
4a4d : a0 10 __ LDY #$10
4a4f : a5 1e __ LDA ACCU + 3 
4a51 : 85 08 __ STA WORK + 5 
4a53 : a5 1d __ LDA ACCU + 2 
4a55 : 85 07 __ STA WORK + 4 
4a57 : a9 00 __ LDA #$00
4a59 : 85 1d __ STA ACCU + 2 
4a5b : 85 1e __ STA ACCU + 3 
4a5d : 18 __ __ CLC
4a5e : 26 1b __ ROL ACCU + 0 
4a60 : 26 1c __ ROL ACCU + 1 
4a62 : 26 07 __ ROL WORK + 4 
4a64 : 26 08 __ ROL WORK + 5 
4a66 : 26 09 __ ROL WORK + 6 
4a68 : 26 0a __ ROL WORK + 7 
4a6a : a5 07 __ LDA WORK + 4 
4a6c : c5 03 __ CMP WORK + 0 
4a6e : a5 08 __ LDA WORK + 5 
4a70 : e5 04 __ SBC WORK + 1 
4a72 : a5 09 __ LDA WORK + 6 
4a74 : e5 05 __ SBC WORK + 2 
4a76 : aa __ __ TAX
4a77 : a5 0a __ LDA WORK + 7 
4a79 : e5 06 __ SBC WORK + 3 
4a7b : 90 11 __ BCC $4a8e ; (divmod32 + 205)
4a7d : 86 09 __ STX WORK + 6 
4a7f : 85 0a __ STA WORK + 7 
4a81 : a5 07 __ LDA WORK + 4 
4a83 : e5 03 __ SBC WORK + 0 
4a85 : 85 07 __ STA WORK + 4 
4a87 : a5 08 __ LDA WORK + 5 
4a89 : e5 04 __ SBC WORK + 1 
4a8b : 85 08 __ STA WORK + 5 
4a8d : 38 __ __ SEC
4a8e : 88 __ __ DEY
4a8f : d0 cd __ BNE $4a5e ; (divmod32 + 157)
4a91 : 26 1b __ ROL ACCU + 0 
4a93 : 26 1c __ ROL ACCU + 1 
4a95 : a4 02 __ LDY $02 
4a97 : 60 __ __ RTS
--------------------------------------------------------------------
lzo_enabled:
4a98 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
last_key:
4a99 : __ __ __ BSS	1
--------------------------------------------------------------------
krnio_pstatus:
4a9a : __ __ __ BSS	16
--------------------------------------------------------------------
prg_names:
4aaa : __ __ __ BSS	510
--------------------------------------------------------------------
prg_blocks_arr:
4ca8 : __ __ __ BSS	60
