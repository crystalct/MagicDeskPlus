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
080e : 8e ff 18 STX $18ff ; (spentry + 0)
0811 : a2 49 __ LDX #$49
0813 : a0 a9 __ LDY #$a9
0815 : a9 00 __ LDA #$00
0817 : 85 19 __ STA IP + 0 
0819 : 86 1a __ STX IP + 1 
081b : e0 4b __ CPX #$4b
081d : f0 0b __ BEQ $082a ; (startup + 41)
081f : 91 19 __ STA (IP + 0),y 
0821 : c8 __ __ INY
0822 : d0 fb __ BNE $081f ; (startup + 30)
0824 : e8 __ __ INX
0825 : d0 f2 __ BNE $0819 ; (startup + 24)
0827 : 91 19 __ STA (IP + 0),y 
0829 : c8 __ __ INY
082a : c0 f3 __ CPY #$f3
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
08bd : 20 12 0c JSR $0c12 ; (mdp_detect_sram.s4 + 0)
08c0 : a5 1b __ LDA ACCU + 0 
08c2 : 8d fc 27 STA $27fc ; (sram_status + 0)
08c5 : c9 02 __ CMP #$02
08c7 : d0 29 __ BNE $08f2 ; (main.s5 + 0)
.s26:
08c9 : a9 0d __ LDA #$0d
08cb : 85 16 __ STA P9 
08cd : a9 0c __ LDA #$0c
08cf : 85 15 __ STA P8 
08d1 : a9 07 __ LDA #$07
08d3 : 85 17 __ STA P10 
08d5 : a9 60 __ LDA #$60
08d7 : 85 14 __ STA P7 
08d9 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l27:
08dc : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
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
0905 : a9 e5 __ LDA #$e5
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
091f : a9 fd __ LDA #$fd
0921 : 85 11 __ STA P4 
0923 : a9 27 __ LDA #$27
0925 : 85 12 __ STA P5 
0927 : 20 14 0d JSR $0d14 ; (mdp_detect_eeprom.s4 + 0)
092a : a5 1b __ LDA ACCU + 0 
092c : 8d fe 27 STA $27fe ; (eeprom_status + 0)
092f : c9 02 __ CMP #$02
0931 : d0 26 __ BNE $0959 ; (main.l6 + 0)
.s19:
0933 : a9 0d __ LDA #$0d
0935 : 85 16 __ STA P9 
0937 : a9 0e __ LDA #$0e
0939 : 85 15 __ STA P8 
093b : a9 07 __ LDA #$07
093d : 85 17 __ STA P10 
093f : a9 00 __ LDA #$00
0941 : 85 14 __ STA P7 
0943 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l20:
0946 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
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
0959 : 20 63 0e JSR $0e63 ; (draw_main_menu.s4 + 0)
.l7:
095c : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
095f : aa __ __ TAX
0960 : f0 fa __ BEQ $095c ; (main.l7 + 0)
.s8:
0962 : c9 85 __ CMP #$85
0964 : d0 06 __ BNE $096c ; (main.s9 + 0)
.s18:
0966 : 20 fd 10 JSR $10fd ; (show_sram_editor_screen.s1 + 0)
0969 : 4c 59 09 JMP $0959 ; (main.l6 + 0)
.s9:
096c : c9 86 __ CMP #$86
096e : d0 06 __ BNE $0976 ; (main.s10 + 0)
.s17:
0970 : 20 3c 19 JSR $193c ; (show_sram_diag_screen.s1 + 0)
0973 : 4c 59 09 JMP $0959 ; (main.l6 + 0)
.s10:
0976 : c9 87 __ CMP #$87
0978 : d0 06 __ BNE $0980 ; (main.s11 + 0)
.s16:
097a : 20 f6 34 JSR $34f6 ; (show_dump_screen.s1 + 0)
097d : 4c 59 09 JMP $0959 ; (main.l6 + 0)
.s11:
0980 : c9 88 __ CMP #$88
0982 : d0 0b __ BNE $098f ; (main.s12 + 0)
.s15:
0984 : a9 00 __ LDA #$00
0986 : cd ff 27 CMP $27ff ; (sram_mode_active + 0)
0989 : 2a __ __ ROL
098a : 8d ff 27 STA $27ff ; (sram_mode_active + 0)
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
099b : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
099e : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
09a1 : a9 00 __ LDA #$00
09a3 : 85 11 __ STA P4 
09a5 : 85 12 __ STA P5 
09a7 : a9 01 __ LDA #$01
09a9 : 85 13 __ STA P6 
09ab : a9 47 __ LDA #$47
09ad : 85 10 __ STA P3 
09af : a9 ca __ LDA #$ca
09b1 : 85 0f __ STA P2 
09b3 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
09b6 : a9 00 __ LDA #$00
09b8 : 85 1b __ STA ACCU + 0 
09ba : 85 1c __ STA ACCU + 1 
.s3:
09bc : 60 __ __ RTS
.s24:
09bd : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
09c0 : 85 11 __ STA P4 
09c2 : 20 20 0e JSR $0e20 ; (mdp_eeprom_write_signature.s4 + 0)
09c5 : a9 0f __ LDA #$0f
09c7 : 85 16 __ STA P9 
09c9 : a9 01 __ LDA #$01
09cb : 8d fe 27 STA $27fe ; (eeprom_status + 0)
09ce : a9 0d __ LDA #$0d
09d0 : 85 17 __ STA P10 
09d2 : a9 42 __ LDA #$42
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
09e9 : a9 cc __ LDA #$cc
09eb : 85 14 __ STA P7 
09ed : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l25:
09f0 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
09f3 : c9 0d __ CMP #$0d
09f5 : d0 f9 __ BNE $09f0 ; (main.l25 + 0)
09f7 : 4c 59 09 JMP $0959 ; (main.l6 + 0)
.s31:
09fa : 20 90 0c JSR $0c90 ; (mdp_write_signature.s4 + 0)
09fd : a9 0f __ LDA #$0f
09ff : 85 16 __ STA P9 
0a01 : a9 01 __ LDA #$01
0a03 : 8d fc 27 STA $27fc ; (sram_status + 0)
0a06 : a9 0d __ LDA #$0d
0a08 : 85 17 __ STA P10 
0a0a : a9 ab __ LDA #$ab
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
0a21 : a9 cc __ LDA #$cc
0a23 : 85 14 __ STA P7 
0a25 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l32:
0a28 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
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
0bef : __ __ __ BYT 53 52 41 4d 20 4d 41 4e 41 47 45 52 00          : SRAM MANAGER.
--------------------------------------------------------------------
0bfc : __ __ __ BYT 4f 4e 20 00                                     : ON .
--------------------------------------------------------------------
0c00 : __ __ __ BYT 44 45 54 45 43 54 49 4e 47 20 53 52 41 4d 2e 2e : DETECTING SRAM..
0c10 : __ __ __ BYT 2e 00                                           : ..
--------------------------------------------------------------------
mdp_detect_sram: ; mdp_detect_sram()->u8
; 125, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0c12 : a9 21 __ LDA #$21
0c14 : 8d 03 de STA $de03 
0c17 : a9 ff __ LDA #$ff
0c19 : 8d 01 de STA $de01 
0c1c : ad fe df LDA $dffe 
0c1f : ae ff df LDX $dfff 
0c22 : 86 1b __ STX ACCU + 0 
0c24 : aa __ __ TAX
0c25 : a0 00 __ LDY #$00
0c27 : e0 ca __ CPX #$ca
0c29 : d0 10 __ BNE $0c3b ; (mdp_detect_sram.s5 + 0)
.s10:
0c2b : a5 1b __ LDA ACCU + 0 
0c2d : c9 f1 __ CMP #$f1
0c2f : d0 0a __ BNE $0c3b ; (mdp_detect_sram.s5 + 0)
.s11:
0c31 : c8 __ __ INY
.s7:
0c32 : 84 1b __ STY ACCU + 0 
0c34 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
0c37 : 8d 03 de STA $de03 
.s3:
0c3a : 60 __ __ RTS
.s5:
0c3b : a9 ca __ LDA #$ca
0c3d : 8d fe df STA $dffe 
0c40 : a9 f1 __ LDA #$f1
0c42 : 8d ff df STA $dfff 
0c45 : ad fe df LDA $dffe 
0c48 : c9 ca __ CMP #$ca
0c4a : d0 09 __ BNE $0c55 ; (mdp_detect_sram.s6 + 0)
.s8:
0c4c : ad ff df LDA $dfff 
0c4f : c9 f1 __ CMP #$f1
0c51 : d0 02 __ BNE $0c55 ; (mdp_detect_sram.s6 + 0)
.s9:
0c53 : a0 02 __ LDY #$02
.s6:
0c55 : 8e fe df STX $dffe 
0c58 : a5 1b __ LDA ACCU + 0 
0c5a : 8d ff df STA $dfff 
0c5d : 4c 32 0c JMP $0c32 ; (mdp_detect_sram.s7 + 0)
--------------------------------------------------------------------
0c60 : __ __ __ BYT 53 52 41 4d 20 55 4e 49 4e 49 54 49 41 4c 49 5a : SRAM UNINITIALIZ
0c70 : __ __ __ BYT 45 44 2e 20 49 4e 49 54 3f 20 59 2f 4e 00       : ED. INIT? Y/N.
--------------------------------------------------------------------
get_key: ; get_key()->u8
; 179, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0c7e : a9 00 __ LDA #$00
0c80 : 8d fe 29 STA $29fe ; (last_key + 0)
0c83 : 20 9f ff JSR $ff9f 
0c86 : 20 e4 ff JSR $ffe4 
0c89 : 8d fe 29 STA $29fe ; (last_key + 0)
.s3:
0c8c : ad fe 29 LDA $29fe ; (last_key + 0)
0c8f : 60 __ __ RTS
--------------------------------------------------------------------
mdp_write_signature: ; mdp_write_signature()->void
; 173, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0c90 : a9 21 __ LDA #$21
0c92 : 8d 03 de STA $de03 
0c95 : a9 ff __ LDA #$ff
0c97 : 8d 01 de STA $de01 
0c9a : a9 ca __ LDA #$ca
0c9c : 8d fe df STA $dffe 
0c9f : a9 f1 __ LDA #$f1
0ca1 : 8d ff df STA $dfff 
0ca4 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
0ca7 : 8d 03 de STA $de03 
.s3:
0caa : 60 __ __ RTS
--------------------------------------------------------------------
0cab : __ __ __ BYT 53 52 41 4d 20 49 4e 49 54 49 41 4c 49 5a 45 44 : SRAM INITIALIZED
0cbb : __ __ __ BYT 21 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 : !               
0ccb : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
0ccc : __ __ __ BYT 50 52 45 53 53 20 52 45 54 55 52 4e 20 54 4f 20 : PRESS RETURN TO 
0cdc : __ __ __ BYT 43 4f 4e 54 49 4e 55 45 00                      : CONTINUE.
--------------------------------------------------------------------
0ce5 : __ __ __ BYT 45 45 50 52 4f 4d 20 4d 41 4e 41 47 45 52 00    : EEPROM MANAGER.
--------------------------------------------------------------------
mdp_eeprom_enable: ; mdp_eeprom_enable()->void
; 194, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0cf4 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
0cf7 : 29 df __ AND #$df
0cf9 : 8d 03 de STA $de03 
0cfc : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
.s3:
0cff : 60 __ __ RTS
--------------------------------------------------------------------
0d00 : __ __ __ BYT 44 45 54 45 43 54 49 4e 47 20 45 45 50 52 4f 4d : DETECTING EEPROM
0d10 : __ __ __ BYT 2e 2e 2e 00                                     : ....
--------------------------------------------------------------------
mdp_detect_eeprom: ; mdp_detect_eeprom(u8*)->u8
; 277, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0d14 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
0d17 : 85 48 __ STA T2 + 0 
0d19 : a9 1f __ LDA #$1f
0d1b : 85 0e __ STA P1 
0d1d : a9 fe __ LDA #$fe
0d1f : 85 0f __ STA P2 
0d21 : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
0d24 : a9 1f __ LDA #$1f
0d26 : 8d 01 de STA $de01 
0d29 : ad fe df LDA $dffe 
0d2c : 85 49 __ STA T3 + 0 
0d2e : 49 ff __ EOR #$ff
0d30 : 85 47 __ STA T1 + 0 
0d32 : 85 10 __ STA P3 
0d34 : 20 bd 0d JSR $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
0d37 : a5 49 __ LDA T3 + 0 
0d39 : 85 10 __ STA P3 
0d3b : a9 1f __ LDA #$1f
0d3d : 8d 01 de STA $de01 
0d40 : ad fe df LDA $dffe 
0d43 : 85 46 __ STA T0 + 0 
0d45 : 20 bd 0d JSR $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
0d48 : a5 47 __ LDA T1 + 0 
0d4a : c5 46 __ CMP T0 + 0 
0d4c : f0 0d __ BEQ $0d5b ; (mdp_detect_eeprom.s5 + 0)
.s16:
0d4e : a5 48 __ LDA T2 + 0 
0d50 : 8d 03 de STA $de03 
0d53 : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
0d56 : a9 00 __ LDA #$00
.s3:
0d58 : 85 1b __ STA ACCU + 0 
0d5a : 60 __ __ RTS
.s5:
0d5b : 85 10 __ STA P3 
0d5d : a9 7f __ LDA #$7f
0d5f : 85 0e __ STA P1 
0d61 : 8d 01 de STA $de01 
0d64 : ad fe df LDA $dffe 
0d67 : 85 46 __ STA T0 + 0 
0d69 : 20 bd 0d JSR $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
0d6c : a5 46 __ LDA T0 + 0 
0d6e : 85 10 __ STA P3 
0d70 : a9 1f __ LDA #$1f
0d72 : 8d 01 de STA $de01 
0d75 : ad fe df LDA $dffe 
0d78 : 85 49 __ STA T3 + 0 
0d7a : 20 bd 0d JSR $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
0d7d : a5 49 __ LDA T3 + 0 
0d7f : c5 47 __ CMP T1 + 0 
0d81 : d0 04 __ BNE $0d87 ; (mdp_detect_eeprom.s6 + 0)
.s15:
0d83 : a9 08 __ LDA #$08
0d85 : d0 02 __ BNE $0d89 ; (mdp_detect_eeprom.s7 + 0)
.s6:
0d87 : a9 20 __ LDA #$20
.s7:
0d89 : a0 00 __ LDY #$00
0d8b : 91 11 __ STA (P4),y ; (detected_size_kb + 0)
0d8d : a5 48 __ LDA T2 + 0 
0d8f : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
0d92 : b1 11 __ LDA (P4),y ; (detected_size_kb + 0)
0d94 : c9 20 __ CMP #$20
0d96 : d0 04 __ BNE $0d9c ; (mdp_detect_eeprom.s8 + 0)
.s14:
0d98 : a9 7f __ LDA #$7f
0d9a : d0 02 __ BNE $0d9e ; (mdp_detect_eeprom.s9 + 0)
.s8:
0d9c : a9 1f __ LDA #$1f
.s9:
0d9e : 8d 01 de STA $de01 
0da1 : ad fe df LDA $dffe 
0da4 : c9 ca __ CMP #$ca
0da6 : d0 0b __ BNE $0db3 ; (mdp_detect_eeprom.s10 + 0)
.s12:
0da8 : ad ff df LDA $dfff 
0dab : c9 f1 __ CMP #$f1
0dad : d0 04 __ BNE $0db3 ; (mdp_detect_eeprom.s10 + 0)
.s13:
0daf : a9 01 __ LDA #$01
0db1 : d0 02 __ BNE $0db5 ; (mdp_detect_eeprom.s11 + 0)
.s10:
0db3 : a9 02 __ LDA #$02
.s11:
0db5 : a6 48 __ LDX T2 + 0 
0db7 : 8e 03 de STX $de03 
0dba : 4c 58 0d JMP $0d58 ; (mdp_detect_eeprom.s3 + 0)
--------------------------------------------------------------------
mdp_eeprom_write_byte: ; mdp_eeprom_write_byte(u8,u8,u8)->bool
; 218, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0dbd : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
0dc0 : a5 0e __ LDA P1 ; (page + 0)
0dc2 : 8d 01 de STA $de01 
0dc5 : a5 10 __ LDA P3 ; (value + 0)
0dc7 : a6 0f __ LDX P2 ; (offset + 0)
0dc9 : 86 43 __ STX T1 + 0 
0dcb : 9d 00 df STA $df00,x 
0dce : 29 80 __ AND #$80
0dd0 : 85 44 __ STA T2 + 0 
0dd2 : a9 28 __ LDA #$28
0dd4 : 85 45 __ STA T3 + 0 
.l5:
0dd6 : a6 43 __ LDX T1 + 0 
0dd8 : bd 00 df LDA $df00,x 
0ddb : 29 80 __ AND #$80
0ddd : c5 44 __ CMP T2 + 0 
0ddf : f0 0c __ BEQ $0ded ; (mdp_eeprom_write_byte.s8 + 0)
.s6:
0de1 : 20 f1 0d JSR $0df1 ; (delay_0_5ms.s4 + 0)
0de4 : c6 45 __ DEC T3 + 0 
0de6 : d0 ee __ BNE $0dd6 ; (mdp_eeprom_write_byte.l5 + 0)
.s7:
0de8 : a9 00 __ LDA #$00
.s3:
0dea : 85 1b __ STA ACCU + 0 
0dec : 60 __ __ RTS
.s8:
0ded : a9 01 __ LDA #$01
0def : d0 f9 __ BNE $0dea ; (mdp_eeprom_write_byte.s3 + 0)
--------------------------------------------------------------------
delay_0_5ms: ; delay_0_5ms()->void
; 207, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0df1 : 8a __ __ TXA
0df2 : a2 5f __ LDX #$5f
0df4 : ca __ __ DEX
0df5 : d0 fd __ BNE $0df4 ; (delay_0_5ms.s4 + 3)
0df7 : aa __ __ TAX
.s3:
0df8 : 60 __ __ RTS
--------------------------------------------------------------------
0df9 : __ __ __ BYT 53 52 41 4d 3a 00                               : SRAM:.
--------------------------------------------------------------------
0dff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
0e00 : __ __ __ BYT 45 45 50 52 4f 4d 20 55 4e 49 4e 49 54 49 41 4c : EEPROM UNINITIAL
0e10 : __ __ __ BYT 49 5a 45 44 2e 20 49 4e 49 54 3f 20 59 2f 4e 00 : IZED. INIT? Y/N.
--------------------------------------------------------------------
mdp_eeprom_write_signature: ; mdp_eeprom_write_signature(u8)->void
; 347, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
0e20 : a9 fe __ LDA #$fe
0e22 : 85 0f __ STA P2 
0e24 : a9 ca __ LDA #$ca
0e26 : 85 10 __ STA P3 
0e28 : a5 11 __ LDA P4 ; (size_kb + 0)
0e2a : c9 20 __ CMP #$20
0e2c : d0 04 __ BNE $0e32 ; (mdp_eeprom_write_signature.s5 + 0)
.s7:
0e2e : a9 7f __ LDA #$7f
0e30 : d0 02 __ BNE $0e34 ; (mdp_eeprom_write_signature.s6 + 0)
.s5:
0e32 : a9 1f __ LDA #$1f
.s6:
0e34 : 85 0e __ STA P1 
0e36 : 20 bd 0d JSR $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
0e39 : e6 0f __ INC P2 
0e3b : a9 f1 __ LDA #$f1
0e3d : 85 10 __ STA P3 
0e3f : 4c bd 0d JMP $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
--------------------------------------------------------------------
0e42 : __ __ __ BYT 45 45 50 52 4f 4d 20 49 4e 49 54 49 41 4c 49 5a : EEPROM INITIALIZ
0e52 : __ __ __ BYT 45 44 21 20 20 20 20 20 20 20 20 20 20 20 20 20 : ED!             
0e62 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
draw_main_menu: ; draw_main_menu()->void
;2222, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
0e63 : a9 0b __ LDA #$0b
0e65 : 85 18 __ STA P11 
0e67 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
0e6a : a9 03 __ LDA #$03
0e6c : 85 16 __ STA P9 
0e6e : a9 07 __ LDA #$07
0e70 : 85 17 __ STA P10 
0e72 : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
0e75 : f0 03 __ BEQ $0e7a ; (draw_main_menu.s5 + 0)
0e77 : 4c 46 0f JMP $0f46 ; (draw_main_menu.s16 + 0)
.s5:
0e7a : a9 e5 __ LDA #$e5
0e7c : 85 14 __ STA P7 
0e7e : a9 0c __ LDA #$0c
0e80 : 85 15 __ STA P8 
0e82 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
0e85 : ad fe 27 LDA $27fe ; (eeprom_status + 0)
0e88 : d0 16 __ BNE $0ea0 ; (draw_main_menu.s9 + 0)
.s6:
0e8a : a9 05 __ LDA #$05
0e8c : 85 16 __ STA P9 
0e8e : a9 10 __ LDA #$10
0e90 : 85 15 __ STA P8 
0e92 : a9 02 __ LDA #$02
0e94 : 85 17 __ STA P10 
0e96 : a9 4f __ LDA #$4f
0e98 : 85 14 __ STA P7 
0e9a : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
0e9d : 4c e7 0e JMP $0ee7 ; (draw_main_menu.s7 + 0)
.s9:
0ea0 : a9 05 __ LDA #$05
0ea2 : 85 11 __ STA P4 
0ea4 : 85 12 __ STA P5 
0ea6 : a9 0d __ LDA #$0d
0ea8 : 85 13 __ STA P6 
0eaa : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
0ead : c9 20 __ CMP #$20
0eaf : f0 07 __ BEQ $0eb8 ; (draw_main_menu.s15 + 0)
.s10:
0eb1 : a9 10 __ LDA #$10
0eb3 : a0 7a __ LDY #$7a
0eb5 : 4c bc 0e JMP $0ebc ; (draw_main_menu.s11 + 0)
.s15:
0eb8 : a9 10 __ LDA #$10
0eba : a0 64 __ LDY #$64
.s11:
0ebc : 84 0f __ STY P2 
0ebe : 85 10 __ STA P3 
0ec0 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0ec3 : ae fe 27 LDX $27fe ; (eeprom_status + 0)
0ec6 : ca __ __ DEX
0ec7 : f0 0b __ BEQ $0ed4 ; (draw_main_menu.s14 + 0)
.s12:
0ec9 : a9 07 __ LDA #$07
0ecb : 85 13 __ STA P6 
0ecd : a9 10 __ LDA #$10
0ecf : a0 00 __ LDY #$00
0ed1 : 4c dc 0e JMP $0edc ; (draw_main_menu.s13 + 0)
.s14:
0ed4 : a9 05 __ LDA #$05
0ed6 : 85 13 __ STA P6 
0ed8 : a9 0f __ LDA #$0f
0eda : a0 ed __ LDY #$ed
.s13:
0edc : 84 0f __ STY P2 
0ede : 85 10 __ STA P3 
0ee0 : a9 1b __ LDA #$1b
0ee2 : 85 12 __ STA P5 
0ee4 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
.s7:
0ee7 : a9 09 __ LDA #$09
0ee9 : 85 11 __ STA P4 
0eeb : a9 10 __ LDA #$10
0eed : 85 10 __ STA P3 
0eef : a9 0a __ LDA #$0a
0ef1 : 85 12 __ STA P5 
0ef3 : a9 01 __ LDA #$01
0ef5 : 85 13 __ STA P6 
0ef7 : a9 8f __ LDA #$8f
0ef9 : 85 0f __ STA P2 
0efb : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0efe : a9 a1 __ LDA #$a1
0f00 : 85 0f __ STA P2 
0f02 : a9 10 __ LDA #$10
0f04 : 85 10 __ STA P3 
0f06 : a9 10 __ LDA #$10
0f08 : a0 b8 __ LDY #$b8
.s8:
0f0a : 84 49 __ STY T0 + 0 
0f0c : 85 4a __ STA T0 + 1 
0f0e : a9 0b __ LDA #$0b
0f10 : 85 11 __ STA P4 
0f12 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0f15 : a5 49 __ LDA T0 + 0 
0f17 : 85 0f __ STA P2 
0f19 : a5 4a __ LDA T0 + 1 
0f1b : 85 10 __ STA P3 
0f1d : a9 0d __ LDA #$0d
0f1f : 85 11 __ STA P4 
0f21 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0f24 : a9 0f __ LDA #$0f
0f26 : 85 11 __ STA P4 
0f28 : a9 10 __ LDA #$10
0f2a : 85 10 __ STA P3 
0f2c : a9 d4 __ LDA #$d4
0f2e : 85 0f __ STA P2 
0f30 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0f33 : a9 17 __ LDA #$17
0f35 : 85 16 __ STA P9 
0f37 : a9 10 __ LDA #$10
0f39 : 85 15 __ STA P8 
0f3b : a9 0d __ LDA #$0d
0f3d : 85 17 __ STA P10 
0f3f : a9 eb __ LDA #$eb
0f41 : 85 14 __ STA P7 
0f43 : 4c 7e 0a JMP $0a7e ; (print_centered.s4 + 0)
.s16:
0f46 : a9 ef __ LDA #$ef
0f48 : 85 14 __ STA P7 
0f4a : a9 0b __ LDA #$0b
0f4c : 85 15 __ STA P8 
0f4e : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
0f51 : ad fc 27 LDA $27fc ; (sram_status + 0)
0f54 : d0 16 __ BNE $0f6c ; (draw_main_menu.s19 + 0)
.s17:
0f56 : a9 05 __ LDA #$05
0f58 : 85 16 __ STA P9 
0f5a : a9 0f __ LDA #$0f
0f5c : 85 15 __ STA P8 
0f5e : a9 02 __ LDA #$02
0f60 : 85 17 __ STA P10 
0f62 : a9 cb __ LDA #$cb
0f64 : 85 14 __ STA P7 
0f66 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
0f69 : 4c a5 0f JMP $0fa5 ; (draw_main_menu.s18 + 0)
.s19:
0f6c : a9 05 __ LDA #$05
0f6e : 85 11 __ STA P4 
0f70 : 85 12 __ STA P5 
0f72 : a9 0d __ LDA #$0d
0f74 : 85 13 __ STA P6 
0f76 : a9 0f __ LDA #$0f
0f78 : 85 10 __ STA P3 
0f7a : a9 de __ LDA #$de
0f7c : 85 0f __ STA P2 
0f7e : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0f81 : a9 15 __ LDA #$15
0f83 : 85 12 __ STA P5 
0f85 : ae fc 27 LDX $27fc ; (sram_status + 0)
0f88 : ca __ __ DEX
0f89 : f0 0b __ BEQ $0f96 ; (draw_main_menu.s22 + 0)
.s20:
0f8b : a9 07 __ LDA #$07
0f8d : 85 13 __ STA P6 
0f8f : a9 10 __ LDA #$10
0f91 : a0 00 __ LDY #$00
0f93 : 4c 9e 0f JMP $0f9e ; (draw_main_menu.s21 + 0)
.s22:
0f96 : a9 05 __ LDA #$05
0f98 : 85 13 __ STA P6 
0f9a : a9 0f __ LDA #$0f
0f9c : a0 ed __ LDY #$ed
.s21:
0f9e : 84 0f __ STY P2 
0fa0 : 85 10 __ STA P3 
0fa2 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
.s18:
0fa5 : a9 09 __ LDA #$09
0fa7 : 85 11 __ STA P4 
0fa9 : a9 10 __ LDA #$10
0fab : 85 10 __ STA P3 
0fad : a9 0a __ LDA #$0a
0faf : 85 12 __ STA P5 
0fb1 : a9 01 __ LDA #$01
0fb3 : 85 13 __ STA P6 
0fb5 : a9 10 __ LDA #$10
0fb7 : 85 0f __ STA P2 
0fb9 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
0fbc : a9 20 __ LDA #$20
0fbe : 85 0f __ STA P2 
0fc0 : a9 10 __ LDA #$10
0fc2 : 85 10 __ STA P3 
0fc4 : a9 10 __ LDA #$10
0fc6 : a0 35 __ LDY #$35
0fc8 : 4c 0a 0f JMP $0f0a ; (draw_main_menu.s8 + 0)
--------------------------------------------------------------------
0fcb : __ __ __ BYT 53 52 41 4d 3a 20 4e 4f 54 20 44 45 54 45 43 54 : SRAM: NOT DETECT
0fdb : __ __ __ BYT 45 44 00                                        : ED.
--------------------------------------------------------------------
0fde : __ __ __ BYT 53 52 41 4d 3a 20 44 45 54 45 43 54 45 44 00    : SRAM: DETECTED.
--------------------------------------------------------------------
0fed : __ __ __ BYT 49 4e 49 54 49 41 4c 49 5a 45 44 00             : INITIALIZED.
--------------------------------------------------------------------
0ff9 : __ __ __ BYT 4f 46 46 00                                     : OFF.
--------------------------------------------------------------------
0ffd : __ __ __ BYT 20 20 00                                        :   .
--------------------------------------------------------------------
1000 : __ __ __ BYT 4e 4f 54 20 49 4e 49 54 49 41 4c 49 5a 45 44 00 : NOT INITIALIZED.
--------------------------------------------------------------------
1010 : __ __ __ BYT 46 31 3a 20 53 52 41 4d 20 45 44 49 54 4f 52 00 : F1: SRAM EDITOR.
--------------------------------------------------------------------
1020 : __ __ __ BYT 46 33 3a 20 53 52 41 4d 20 44 49 41 47 4e 4f 53 : F3: SRAM DIAGNOS
1030 : __ __ __ BYT 54 49 43 53 00                                  : TICS.
--------------------------------------------------------------------
1035 : __ __ __ BYT 46 35 3a 20 53 52 41 4d 20 42 41 43 4b 55 50 20 : F5: SRAM BACKUP 
1045 : __ __ __ BYT 54 4f 20 46 4c 4f 50 50 59 00                   : TO FLOPPY.
--------------------------------------------------------------------
104f : __ __ __ BYT 45 45 50 52 4f 4d 3a 20 4e 4f 54 20 44 45 54 45 : EEPROM: NOT DETE
105f : __ __ __ BYT 43 54 45 44 00                                  : CTED.
--------------------------------------------------------------------
1064 : __ __ __ BYT 45 45 50 52 4f 4d 20 33 32 4b 42 3a 20 44 45 54 : EEPROM 32KB: DET
1074 : __ __ __ BYT 45 43 54 45 44 00                               : ECTED.
--------------------------------------------------------------------
107a : __ __ __ BYT 45 45 50 52 4f 4d 20 38 4b 42 3a 20 44 45 54 45 : EEPROM 8KB: DETE
108a : __ __ __ BYT 43 54 45 44 00                                  : CTED.
--------------------------------------------------------------------
108f : __ __ __ BYT 46 31 3a 20 45 45 50 52 4f 4d 20 45 44 49 54 4f : F1: EEPROM EDITO
109f : __ __ __ BYT 52 00                                           : R.
--------------------------------------------------------------------
10a1 : __ __ __ BYT 46 33 3a 20 45 45 50 52 4f 4d 20 44 49 41 47 4e : F3: EEPROM DIAGN
10b1 : __ __ __ BYT 4f 53 54 49 43 53 00                            : OSTICS.
--------------------------------------------------------------------
10b8 : __ __ __ BYT 46 35 3a 20 45 45 50 52 4f 4d 20 42 41 43 4b 55 : F5: EEPROM BACKU
10c8 : __ __ __ BYT 50 20 54 4f 20 46 4c 4f 50 50 59 00             : P TO FLOPPY.
--------------------------------------------------------------------
10d4 : __ __ __ BYT 46 37 3a 20 54 4f 47 47 4c 45 20 53 52 41 4d 2f : F7: TOGGLE SRAM/
10e4 : __ __ __ BYT 45 45 50 52 4f 4d 00                            : EEPROM.
--------------------------------------------------------------------
10eb : __ __ __ BYT 50 52 45 53 53 20 28 58 29 20 54 4f 20 45 58 49 : PRESS (X) TO EXI
10fb : __ __ __ BYT 54 00                                           : T.
--------------------------------------------------------------------
show_sram_editor_screen: ; show_sram_editor_screen()->void
;1299, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
10fd : a2 03 __ LDX #$03
10ff : b5 53 __ LDA T1 + 0,x 
1101 : 9d e8 9f STA $9fe8,x ; (show_sram_editor_screen@stack + 0)
1104 : ca __ __ DEX
1105 : 10 f8 __ BPL $10ff ; (show_sram_editor_screen.s1 + 2)
.s4:
1107 : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
110a : 85 54 __ STA T3 + 0 
110c : d0 06 __ BNE $1114 ; (show_sram_editor_screen.s79 + 0)
.s5:
110e : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
1111 : 4c 17 11 JMP $1117 ; (show_sram_editor_screen.s6 + 0)
.s79:
1114 : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
.s6:
1117 : a9 00 __ LDA #$00
1119 : 8d 01 de STA $de01 
111c : 85 55 __ STA T4 + 0 
111e : a9 0b __ LDA #$0b
1120 : 85 18 __ STA P11 
.l7:
1122 : a9 00 __ LDA #$00
.l81:
1124 : 85 56 __ STA T5 + 0 
.l8:
1126 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
1129 : a9 03 __ LDA #$03
112b : 85 16 __ STA P9 
112d : a9 07 __ LDA #$07
112f : 85 17 __ STA P10 
1131 : a5 54 __ LDA T3 + 0 
1133 : d0 07 __ BNE $113c ; (show_sram_editor_screen.s78 + 0)
.s9:
1135 : a9 13 __ LDA #$13
1137 : a0 cb __ LDY #$cb
1139 : 4c 40 11 JMP $1140 ; (show_sram_editor_screen.s10 + 0)
.s78:
113c : a9 13 __ LDA #$13
113e : a0 ba __ LDY #$ba
.s10:
1140 : 84 14 __ STY P7 
1142 : 85 15 __ STA P8 
1144 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1147 : a5 55 __ LDA T4 + 0 
1149 : 85 14 __ STA P7 
114b : a5 56 __ LDA T5 + 0 
114d : 85 15 __ STA P8 
114f : 20 de 13 JSR $13de ; (draw_sram_status_bar.s4 + 0)
1152 : a5 15 __ LDA P8 
1154 : 85 14 __ STA P7 
1156 : 20 b5 15 JSR $15b5 ; (draw_sram_page_view.s1 + 0)
1159 : a9 14 __ LDA #$14
115b : 85 11 __ STA P4 
115d : a9 01 __ LDA #$01
115f : 85 12 __ STA P5 
1161 : a9 0d __ LDA #$0d
1163 : 85 13 __ STA P6 
1165 : a5 54 __ LDA T3 + 0 
1167 : d0 07 __ BNE $1170 ; (show_sram_editor_screen.s77 + 0)
.s11:
1169 : a9 17 __ LDA #$17
116b : a0 26 __ LDY #$26
116d : 4c 74 11 JMP $1174 ; (show_sram_editor_screen.s12 + 0)
.s77:
1170 : a9 17 __ LDA #$17
1172 : a0 07 __ LDY #$07
.s12:
1174 : 84 0f __ STY P2 
1176 : 85 10 __ STA P3 
1178 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
117b : e6 11 __ INC P4 
117d : a9 05 __ LDA #$05
117f : 85 13 __ STA P6 
1181 : a9 17 __ LDA #$17
1183 : 85 10 __ STA P3 
1185 : a9 3e __ LDA #$3e
1187 : 85 0f __ STA P2 
1189 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
118c : a9 17 __ LDA #$17
118e : 85 0d __ STA P0 
1190 : a9 0b __ LDA #$0b
1192 : 85 0e __ STA P1 
1194 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
.l13:
1197 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
119a : c9 6d __ CMP #$6d
119c : d0 03 __ BNE $11a1 ; (show_sram_editor_screen.s14 + 0)
119e : 4c 96 13 JMP $1396 ; (show_sram_editor_screen.s74 + 0)
.s14:
11a1 : c9 4d __ CMP #$4d
11a3 : f0 f9 __ BEQ $119e ; (show_sram_editor_screen.l13 + 7)
.s15:
11a5 : c9 65 __ CMP #$65
11a7 : d0 03 __ BNE $11ac ; (show_sram_editor_screen.s16 + 0)
11a9 : 4c 84 13 JMP $1384 ; (show_sram_editor_screen.s71 + 0)
.s16:
11ac : c9 45 __ CMP #$45
11ae : f0 f9 __ BEQ $11a9 ; (show_sram_editor_screen.s15 + 4)
.s17:
11b0 : a8 __ __ TAY
11b1 : c0 62 __ CPY #$62
11b3 : d0 03 __ BNE $11b8 ; (show_sram_editor_screen.s18 + 0)
11b5 : 4c 6d 13 JMP $136d ; (show_sram_editor_screen.s69 + 0)
.s18:
11b8 : c0 42 __ CPY #$42
11ba : f0 f9 __ BEQ $11b5 ; (show_sram_editor_screen.s17 + 5)
.s19:
11bc : c0 70 __ CPY #$70
11be : d0 03 __ BNE $11c3 ; (show_sram_editor_screen.s20 + 0)
11c0 : 4c 09 13 JMP $1309 ; (show_sram_editor_screen.s57 + 0)
.s20:
11c3 : c0 50 __ CPY #$50
11c5 : f0 f9 __ BEQ $11c0 ; (show_sram_editor_screen.s19 + 4)
.s21:
11c7 : c0 77 __ CPY #$77
11c9 : f0 7a __ BEQ $1245 ; (show_sram_editor_screen.s46 + 0)
.s22:
11cb : c0 57 __ CPY #$57
11cd : f0 76 __ BEQ $1245 ; (show_sram_editor_screen.s46 + 0)
.s23:
11cf : c0 2d __ CPY #$2d
11d1 : f0 62 __ BEQ $1235 ; (show_sram_editor_screen.s43 + 0)
.s24:
11d3 : c0 85 __ CPY #$85
11d5 : f0 5e __ BEQ $1235 ; (show_sram_editor_screen.s43 + 0)
.s25:
11d7 : c0 2b __ CPY #$2b
11d9 : f0 04 __ BEQ $11df ; (show_sram_editor_screen.s41 + 0)
.s26:
11db : c0 86 __ CPY #$86
11dd : d0 0e __ BNE $11ed ; (show_sram_editor_screen.s27 + 0)
.s41:
11df : a5 56 __ LDA T5 + 0 
11e1 : c9 a0 __ CMP #$a0
11e3 : 90 03 __ BCC $11e8 ; (show_sram_editor_screen.s42 + 0)
11e5 : 4c 22 11 JMP $1122 ; (show_sram_editor_screen.l7 + 0)
.s42:
11e8 : 69 08 __ ADC #$08
11ea : 4c 24 11 JMP $1124 ; (show_sram_editor_screen.l81 + 0)
.s27:
11ed : a5 54 __ LDA T3 + 0 
11ef : f0 04 __ BEQ $11f5 ; (show_sram_editor_screen.s28 + 0)
.s40:
11f1 : a9 ff __ LDA #$ff
11f3 : d0 0d __ BNE $1202 ; (show_sram_editor_screen.s30 + 0)
.s28:
11f5 : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
11f8 : c9 20 __ CMP #$20
11fa : d0 04 __ BNE $1200 ; (show_sram_editor_screen.s29 + 0)
.s39:
11fc : a9 7f __ LDA #$7f
11fe : d0 02 __ BNE $1202 ; (show_sram_editor_screen.s30 + 0)
.s29:
1200 : a9 1f __ LDA #$1f
.s30:
1202 : 85 43 __ STA T0 + 0 
1204 : 98 __ __ TYA
1205 : c0 87 __ CPY #$87
1207 : f0 1e __ BEQ $1227 ; (show_sram_editor_screen.s36 + 0)
.s31:
1209 : c9 88 __ CMP #$88
120b : d0 8a __ BNE $1197 ; (show_sram_editor_screen.l13 + 0)
.s32:
120d : a5 55 __ LDA T4 + 0 
120f : c5 43 __ CMP T0 + 0 
1211 : 90 0a __ BCC $121d ; (show_sram_editor_screen.s34 + 0)
.s33:
1213 : a9 00 __ LDA #$00
.s82:
1215 : 8d 01 de STA $de01 
1218 : 85 55 __ STA T4 + 0 
121a : 4c 26 11 JMP $1126 ; (show_sram_editor_screen.l8 + 0)
.s34:
121d : e6 55 __ INC T4 + 0 
.s35:
121f : a5 55 __ LDA T4 + 0 
1221 : 8d 01 de STA $de01 
1224 : 4c 26 11 JMP $1126 ; (show_sram_editor_screen.l8 + 0)
.s36:
1227 : a5 55 __ LDA T4 + 0 
1229 : f0 05 __ BEQ $1230 ; (show_sram_editor_screen.s37 + 0)
.s38:
122b : c6 55 __ DEC T4 + 0 
122d : 4c 1f 12 JMP $121f ; (show_sram_editor_screen.s35 + 0)
.s37:
1230 : a5 43 __ LDA T0 + 0 
1232 : 4c 15 12 JMP $1215 ; (show_sram_editor_screen.s82 + 0)
.s43:
1235 : a5 56 __ LDA T5 + 0 
1237 : c9 08 __ CMP #$08
1239 : b0 05 __ BCS $1240 ; (show_sram_editor_screen.s45 + 0)
.s44:
123b : a9 a0 __ LDA #$a0
123d : 4c 24 11 JMP $1124 ; (show_sram_editor_screen.l81 + 0)
.s45:
1240 : e9 08 __ SBC #$08
1242 : 4c 24 11 JMP $1124 ; (show_sram_editor_screen.l81 + 0)
.s46:
1245 : a5 54 __ LDA T3 + 0 
1247 : f0 03 __ BEQ $124c ; (show_sram_editor_screen.s47 + 0)
1249 : 4c fd 12 JMP $12fd ; (show_sram_editor_screen.s56 + 0)
.s47:
124c : 20 88 15 JSR $1588 ; (mdp_sram_is_enabled.s4 + 0)
124f : aa __ __ TAX
1250 : f0 25 __ BEQ $1277 ; (show_sram_editor_screen.s52 + 0)
.s48:
1252 : a9 17 __ LDA #$17
1254 : 85 11 __ STA P4 
1256 : a9 01 __ LDA #$01
1258 : 85 12 __ STA P5 
125a : a9 02 __ LDA #$02
125c : 85 13 __ STA P6 
125e : a5 54 __ LDA T3 + 0 
1260 : d0 07 __ BNE $1269 ; (show_sram_editor_screen.s51 + 0)
.s49:
1262 : a9 18 __ LDA #$18
1264 : a0 e8 __ LDY #$e8
1266 : 4c 6d 12 JMP $126d ; (show_sram_editor_screen.s50 + 0)
.s51:
1269 : a9 18 __ LDA #$18
126b : a0 d3 __ LDY #$d3
.s50:
126d : 84 0f __ STY P2 
126f : 85 10 __ STA P3 
1271 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1274 : 4c 26 11 JMP $1126 ; (show_sram_editor_screen.l8 + 0)
.s52:
1277 : a9 17 __ LDA #$17
1279 : 85 11 __ STA P4 
127b : a9 19 __ LDA #$19
127d : 85 10 __ STA P3 
127f : a9 01 __ LDA #$01
1281 : 85 12 __ STA P5 
1283 : a9 03 __ LDA #$03
1285 : 85 13 __ STA P6 
1287 : a9 00 __ LDA #$00
1289 : 85 0f __ STA P2 
128b : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
128e : a9 17 __ LDA #$17
1290 : 85 14 __ STA P7 
1292 : a9 15 __ LDA #$15
1294 : 85 15 __ STA P8 
1296 : 20 b2 17 JSR $17b2 ; (prompt_hex_byte.s4 + 0)
1299 : a5 1b __ LDA ACCU + 0 
129b : 85 53 __ STA T1 + 0 
129d : a9 17 __ LDA #$17
129f : 85 0d __ STA P0 
12a1 : a9 0b __ LDA #$0b
12a3 : 85 0e __ STA P1 
12a5 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
12a8 : a9 17 __ LDA #$17
12aa : 85 11 __ STA P4 
12ac : a9 19 __ LDA #$19
12ae : 85 10 __ STA P3 
12b0 : a9 01 __ LDA #$01
12b2 : 85 12 __ STA P5 
12b4 : a9 03 __ LDA #$03
12b6 : 85 13 __ STA P6 
12b8 : a9 14 __ LDA #$14
12ba : 85 0f __ STA P2 
12bc : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
12bf : 20 b2 17 JSR $17b2 ; (prompt_hex_byte.s4 + 0)
12c2 : a5 54 __ LDA T3 + 0 
12c4 : d0 12 __ BNE $12d8 ; (show_sram_editor_screen.s55 + 0)
.s53:
12c6 : a5 55 __ LDA T4 + 0 
12c8 : 85 0e __ STA P1 
12ca : a5 53 __ LDA T1 + 0 
12cc : 85 0f __ STA P2 
12ce : a5 1b __ LDA ACCU + 0 
12d0 : 85 10 __ STA P3 
12d2 : 20 bd 0d JSR $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
12d5 : 4c df 12 JMP $12df ; (show_sram_editor_screen.s54 + 0)
.s55:
12d8 : a5 1b __ LDA ACCU + 0 
12da : a6 53 __ LDX T1 + 0 
12dc : 9d 00 df STA $df00,x 
.s54:
12df : a9 17 __ LDA #$17
12e1 : 85 0d __ STA P0 
12e3 : a9 0b __ LDA #$0b
12e5 : 85 0e __ STA P1 
12e7 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
12ea : a9 17 __ LDA #$17
12ec : 85 11 __ STA P4 
12ee : a9 01 __ LDA #$01
12f0 : 85 12 __ STA P5 
12f2 : a9 0d __ LDA #$0d
12f4 : 85 13 __ STA P6 
12f6 : a9 19 __ LDA #$19
12f8 : a0 27 __ LDY #$27
12fa : 4c 6d 12 JMP $126d ; (show_sram_editor_screen.s50 + 0)
.s56:
12fd : 20 88 15 JSR $1588 ; (mdp_sram_is_enabled.s4 + 0)
1300 : aa __ __ TAX
1301 : f0 03 __ BEQ $1306 ; (show_sram_editor_screen.s56 + 9)
1303 : 4c 77 12 JMP $1277 ; (show_sram_editor_screen.s52 + 0)
1306 : 4c 52 12 JMP $1252 ; (show_sram_editor_screen.s48 + 0)
.s57:
1309 : a9 01 __ LDA #$01
130b : 85 12 __ STA P5 
130d : a9 03 __ LDA #$03
130f : 85 13 __ STA P6 
1311 : a5 54 __ LDA T3 + 0 
1313 : f0 07 __ BEQ $131c ; (show_sram_editor_screen.s58 + 0)
.s68:
1315 : a9 17 __ LDA #$17
1317 : a0 7c __ LDY #$7c
1319 : 4c 2e 13 JMP $132e ; (show_sram_editor_screen.s60 + 0)
.s58:
131c : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
131f : c9 20 __ CMP #$20
1321 : f0 07 __ BEQ $132a ; (show_sram_editor_screen.s67 + 0)
.s59:
1323 : a9 17 __ LDA #$17
1325 : a0 a0 __ LDY #$a0
1327 : 4c 2e 13 JMP $132e ; (show_sram_editor_screen.s60 + 0)
.s67:
132a : a9 17 __ LDA #$17
132c : a0 8e __ LDY #$8e
.s60:
132e : 84 0f __ STY P2 
1330 : 85 10 __ STA P3 
1332 : a9 17 __ LDA #$17
1334 : 85 11 __ STA P4 
1336 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1339 : a9 17 __ LDA #$17
133b : 85 14 __ STA P7 
133d : a9 15 __ LDA #$15
133f : 85 15 __ STA P8 
1341 : 20 b2 17 JSR $17b2 ; (prompt_hex_byte.s4 + 0)
1344 : a5 1b __ LDA ACCU + 0 
1346 : 85 55 __ STA T4 + 0 
1348 : a5 54 __ LDA T3 + 0 
134a : f0 04 __ BEQ $1350 ; (show_sram_editor_screen.s61 + 0)
.s66:
134c : a9 ff __ LDA #$ff
134e : d0 0d __ BNE $135d ; (show_sram_editor_screen.s80 + 0)
.s61:
1350 : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
1353 : c9 20 __ CMP #$20
1355 : d0 04 __ BNE $135b ; (show_sram_editor_screen.s62 + 0)
.s65:
1357 : a9 7f __ LDA #$7f
1359 : d0 02 __ BNE $135d ; (show_sram_editor_screen.s80 + 0)
.s62:
135b : a9 1f __ LDA #$1f
.s80:
135d : c5 1b __ CMP ACCU + 0 
135f : b0 04 __ BCS $1365 ; (show_sram_editor_screen.s83 + 0)
.s64:
1361 : 85 55 __ STA T4 + 0 
1363 : 90 02 __ BCC $1367 ; (show_sram_editor_screen.s63 + 0)
.s83:
1365 : a5 1b __ LDA ACCU + 0 
.s63:
1367 : 8d 01 de STA $de01 
136a : 4c 22 11 JMP $1122 ; (show_sram_editor_screen.l7 + 0)
.s69:
136d : a5 54 __ LDA T3 + 0 
136f : d0 03 __ BNE $1374 ; (show_sram_editor_screen.s70 + 0)
1371 : 4c c3 11 JMP $11c3 ; (show_sram_editor_screen.s20 + 0)
.s70:
1374 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
1377 : 4a __ __ LSR
1378 : a9 00 __ LDA #$00
137a : 69 ff __ ADC #$ff
137c : 29 01 __ AND #$01
137e : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
1381 : 4c 26 11 JMP $1126 ; (show_sram_editor_screen.l8 + 0)
.s71:
1384 : 20 88 15 JSR $1588 ; (mdp_sram_is_enabled.s4 + 0)
1387 : aa __ __ TAX
1388 : d0 06 __ BNE $1390 ; (show_sram_editor_screen.s73 + 0)
.s72:
138a : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
138d : 4c 26 11 JMP $1126 ; (show_sram_editor_screen.l8 + 0)
.s73:
1390 : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
1393 : 4c 26 11 JMP $1126 ; (show_sram_editor_screen.l8 + 0)
.s74:
1396 : a5 54 __ LDA T3 + 0 
1398 : d0 06 __ BNE $13a0 ; (show_sram_editor_screen.s76 + 0)
.s75:
139a : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
139d : 4c a3 13 JMP $13a3 ; (show_sram_editor_screen.s3 + 0)
.s76:
13a0 : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
.s3:
13a3 : a2 03 __ LDX #$03
13a5 : bd e8 9f LDA $9fe8,x ; (show_sram_editor_screen@stack + 0)
13a8 : 95 53 __ STA T1 + 0,x 
13aa : ca __ __ DEX
13ab : 10 f8 __ BPL $13a5 ; (show_sram_editor_screen.s3 + 2)
13ad : 60 __ __ RTS
--------------------------------------------------------------------
mdp_sram_enable: ; mdp_sram_enable()->void
;  68, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
13ae : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
13b1 : 09 20 __ ORA #$20
13b3 : 8d 03 de STA $de03 
13b6 : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
.s3:
13b9 : 60 __ __ RTS
--------------------------------------------------------------------
13ba : __ __ __ BYT 53 52 41 4d 20 50 41 47 45 20 45 44 49 54 4f 52 : SRAM PAGE EDITOR
13ca : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
13cb : __ __ __ BYT 45 45 50 52 4f 4d 20 50 41 47 45 20 45 44 49 54 : EEPROM PAGE EDIT
13db : __ __ __ BYT 4f 52 00                                        : OR.
--------------------------------------------------------------------
draw_sram_status_bar: ; draw_sram_status_bar(u8,u8)->void
;1243, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
13de : a9 05 __ LDA #$05
13e0 : 85 0d __ STA P0 
13e2 : a9 0b __ LDA #$0b
13e4 : 85 0e __ STA P1 
13e6 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
13e9 : a9 05 __ LDA #$05
13eb : 85 11 __ STA P4 
13ed : a9 00 __ LDA #$00
13ef : 85 12 __ STA P5 
13f1 : a9 03 __ LDA #$03
13f3 : 85 13 __ STA P6 
13f5 : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
13f8 : f0 03 __ BEQ $13fd ; (draw_sram_status_bar.s5 + 0)
13fa : 4c ac 14 JMP $14ac ; (draw_sram_status_bar.s10 + 0)
.s5:
13fd : a9 ad __ LDA #$ad
13ff : 85 0f __ STA P2 
1401 : a9 15 __ LDA #$15
1403 : 85 10 __ STA P3 
1405 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1408 : a9 08 __ LDA #$08
140a : 85 12 __ STA P5 
140c : 20 88 15 JSR $1588 ; (mdp_sram_is_enabled.s4 + 0)
140f : aa __ __ TAX
1410 : d0 0b __ BNE $141d ; (draw_sram_status_bar.s9 + 0)
.s6:
1412 : a9 0d __ LDA #$0d
1414 : 85 13 __ STA P6 
1416 : a9 0b __ LDA #$0b
1418 : a0 fc __ LDY #$fc
141a : 4c 23 14 JMP $1423 ; (draw_sram_status_bar.s7 + 0)
.s9:
141d : c6 13 __ DEC P6 
141f : a9 0f __ LDA #$0f
1421 : a0 f9 __ LDY #$f9
.s7:
1423 : 84 0f __ STY P2 
1425 : 85 10 __ STA P3 
1427 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
142a : a9 0e __ LDA #$0e
142c : 85 12 __ STA P5 
142e : a9 15 __ LDA #$15
1430 : 85 10 __ STA P3 
1432 : a9 03 __ LDA #$03
1434 : 85 13 __ STA P6 
1436 : a9 98 __ LDA #$98
1438 : 85 0f __ STA P2 
143a : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
143d : a5 14 __ LDA P7 ; (cur_page + 0)
143f : 4a __ __ LSR
1440 : 4a __ __ LSR
1441 : 4a __ __ LSR
1442 : 4a __ __ LSR
1443 : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1446 : 8d f3 9f STA $9ff3 ; (pg[0] + 0)
1449 : a5 14 __ LDA P7 ; (cur_page + 0)
144b : 29 0f __ AND #$0f
144d : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1450 : 8d f4 9f STA $9ff4 ; (pg[0] + 1)
1453 : a9 13 __ LDA #$13
1455 : 85 12 __ STA P5 
1457 : a9 00 __ LDA #$00
1459 : 8d f5 9f STA $9ff5 ; (pg[0] + 2)
145c : a9 01 __ LDA #$01
145e : 85 13 __ STA P6 
1460 : a9 f3 __ LDA #$f3
1462 : 85 0f __ STA P2 
1464 : a9 9f __ LDA #$9f
1466 : 85 10 __ STA P3 
1468 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
146b : a9 17 __ LDA #$17
146d : 85 12 __ STA P5 
146f : a9 15 __ LDA #$15
1471 : 85 10 __ STA P3 
1473 : a9 03 __ LDA #$03
1475 : 85 13 __ STA P6 
1477 : a9 a8 __ LDA #$a8
1479 : 85 0f __ STA P2 
147b : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
147e : a5 15 __ LDA P8 ; (base_offset + 0)
1480 : 4a __ __ LSR
1481 : 4a __ __ LSR
1482 : 4a __ __ LSR
1483 : 4a __ __ LSR
1484 : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1487 : 8d f0 9f STA $9ff0 ; (of[0] + 0)
148a : a5 15 __ LDA P8 ; (base_offset + 0)
148c : 29 0f __ AND #$0f
148e : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1491 : 8d f1 9f STA $9ff1 ; (of[0] + 1)
1494 : a9 1b __ LDA #$1b
1496 : 85 12 __ STA P5 
1498 : a9 00 __ LDA #$00
149a : 8d f2 9f STA $9ff2 ; (of[0] + 2)
149d : a9 9f __ LDA #$9f
149f : a0 f0 __ LDY #$f0
.s8:
14a1 : 84 0f __ STY P2 
14a3 : 85 10 __ STA P3 
14a5 : a9 01 __ LDA #$01
14a7 : 85 13 __ STA P6 
14a9 : 4c 1e 0b JMP $0b1e ; (print_at.s4 + 0)
.s10:
14ac : a9 f9 __ LDA #$f9
14ae : 85 0f __ STA P2 
14b0 : a9 0d __ LDA #$0d
14b2 : 85 10 __ STA P3 
14b4 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
14b7 : 20 88 15 JSR $1588 ; (mdp_sram_is_enabled.s4 + 0)
14ba : aa __ __ TAX
14bb : d0 09 __ BNE $14c6 ; (draw_sram_status_bar.s13 + 0)
.s11:
14bd : c6 13 __ DEC P6 
14bf : a9 0f __ LDA #$0f
14c1 : a0 f9 __ LDY #$f9
14c3 : 4c ce 14 JMP $14ce ; (draw_sram_status_bar.s12 + 0)
.s13:
14c6 : a9 0d __ LDA #$0d
14c8 : 85 13 __ STA P6 
14ca : a9 0b __ LDA #$0b
14cc : a0 fc __ LDY #$fc
.s12:
14ce : 84 0f __ STY P2 
14d0 : 85 10 __ STA P3 
14d2 : a9 05 __ LDA #$05
14d4 : 85 12 __ STA P5 
14d6 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
14d9 : a9 0a __ LDA #$0a
14db : 85 12 __ STA P5 
14dd : a9 15 __ LDA #$15
14df : 85 10 __ STA P3 
14e1 : a9 03 __ LDA #$03
14e3 : 85 13 __ STA P6 
14e5 : a9 92 __ LDA #$92
14e7 : 85 0f __ STA P2 
14e9 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
14ec : a9 10 __ LDA #$10
14ee : 85 12 __ STA P5 
14f0 : a9 01 __ LDA #$01
14f2 : 85 13 __ STA P6 
14f4 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
14f7 : 29 01 __ AND #$01
14f9 : 09 30 __ ORA #$30
14fb : 8d fc 9f STA $9ffc ; (bank_ch[0] + 0)
14fe : a9 00 __ LDA #$00
1500 : 8d fd 9f STA $9ffd ; (bank_ch[0] + 1)
1503 : a9 fc __ LDA #$fc
1505 : 85 0f __ STA P2 
1507 : a9 9f __ LDA #$9f
1509 : 85 10 __ STA P3 
150b : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
150e : a9 13 __ LDA #$13
1510 : 85 12 __ STA P5 
1512 : a9 15 __ LDA #$15
1514 : 85 10 __ STA P3 
1516 : a9 03 __ LDA #$03
1518 : 85 13 __ STA P6 
151a : a9 98 __ LDA #$98
151c : 85 0f __ STA P2 
151e : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1521 : a5 14 __ LDA P7 ; (cur_page + 0)
1523 : 4a __ __ LSR
1524 : 4a __ __ LSR
1525 : 4a __ __ LSR
1526 : 4a __ __ LSR
1527 : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
152a : 8d f9 9f STA $9ff9 ; (pg[0] + 0)
152d : a5 14 __ LDA P7 ; (cur_page + 0)
152f : 29 0f __ AND #$0f
1531 : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1534 : 8d fa 9f STA $9ffa ; (pg[0] + 1)
1537 : a9 17 __ LDA #$17
1539 : 85 12 __ STA P5 
153b : a9 00 __ LDA #$00
153d : 8d fb 9f STA $9ffb ; (pg[0] + 2)
1540 : a9 01 __ LDA #$01
1542 : 85 13 __ STA P6 
1544 : a9 f9 __ LDA #$f9
1546 : 85 0f __ STA P2 
1548 : a9 9f __ LDA #$9f
154a : 85 10 __ STA P3 
154c : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
154f : a9 1b __ LDA #$1b
1551 : 85 12 __ STA P5 
1553 : a9 15 __ LDA #$15
1555 : 85 10 __ STA P3 
1557 : a9 03 __ LDA #$03
1559 : 85 13 __ STA P6 
155b : a9 a8 __ LDA #$a8
155d : 85 0f __ STA P2 
155f : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1562 : a5 15 __ LDA P8 ; (base_offset + 0)
1564 : 4a __ __ LSR
1565 : 4a __ __ LSR
1566 : 4a __ __ LSR
1567 : 4a __ __ LSR
1568 : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
156b : 8d f6 9f STA $9ff6 ; (of[0] + 0)
156e : a5 15 __ LDA P8 ; (base_offset + 0)
1570 : 29 0f __ AND #$0f
1572 : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1575 : 8d f7 9f STA $9ff7 ; (of[0] + 1)
1578 : a9 1f __ LDA #$1f
157a : 85 12 __ STA P5 
157c : a9 00 __ LDA #$00
157e : 8d f8 9f STA $9ff8 ; (of[0] + 2)
1581 : a9 9f __ LDA #$9f
1583 : a0 f6 __ LDY #$f6
1585 : 4c a1 14 JMP $14a1 ; (draw_sram_status_bar.s8 + 0)
--------------------------------------------------------------------
mdp_sram_is_enabled: ; mdp_sram_is_enabled()->bool
;  80, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
1588 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
158b : 29 20 __ AND #$20
158d : f0 02 __ BEQ $1591 ; (mdp_sram_is_enabled.s3 + 0)
.s5:
158f : a9 01 __ LDA #$01
.s3:
1591 : 60 __ __ RTS
--------------------------------------------------------------------
1592 : __ __ __ BYT 42 41 4e 4b 3a 00                               : BANK:.
--------------------------------------------------------------------
1598 : __ __ __ BYT 50 41 47 45 3a 00                               : PAGE:.
--------------------------------------------------------------------
hex_digit: ; hex_digit(u8)->u8
;  97, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
159e : c9 0a __ CMP #$0a
15a0 : b0 03 __ BCS $15a5 ; (hex_digit.s5 + 0)
.s6:
15a2 : 09 30 __ ORA #$30
15a4 : 60 __ __ RTS
.s5:
15a5 : 69 36 __ ADC #$36
.s3:
15a7 : 60 __ __ RTS
--------------------------------------------------------------------
15a8 : __ __ __ BYT 4f 46 46 3a 00                                  : OFF:.
--------------------------------------------------------------------
15ad : __ __ __ BYT 45 45 50 52 4f 4d 3a 00                         : EEPROM:.
--------------------------------------------------------------------
draw_sram_page_view: ; draw_sram_page_view(u8)->void
;1206, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
15b5 : a2 03 __ LDX #$03
15b7 : b5 53 __ LDA T9 + 0,x 
15b9 : 9d ec 9f STA $9fec,x ; (draw_sram_page_view@stack + 0)
15bc : ca __ __ DEX
15bd : 10 f8 __ BPL $15b7 ; (draw_sram_page_view.s1 + 2)
.s4:
15bf : a9 00 __ LDA #$00
15c1 : 85 4b __ STA T2 + 0 
15c3 : 85 4c __ STA T3 + 0 
15c5 : 85 4d __ STA T3 + 1 
15c7 : a2 1d __ LDX #$1d
15c9 : 86 4e __ STX T4 + 0 
15cb : a2 01 __ LDX #$01
15cd : 86 4f __ STX T4 + 1 
15cf : a2 07 __ LDX #$07
15d1 : 86 50 __ STX T5 + 0 
.l5:
15d3 : 0a __ __ ASL
15d4 : 0a __ __ ASL
15d5 : 0a __ __ ASL
15d6 : 18 __ __ CLC
15d7 : 65 14 __ ADC P7 ; (base_offset + 0)
15d9 : 85 51 __ STA T7 + 0 
15db : 4a __ __ LSR
15dc : 4a __ __ LSR
15dd : 4a __ __ LSR
15de : 4a __ __ LSR
15df : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
15e2 : 8d fa 9f STA $9ffa ; (addr_str[0] + 0)
15e5 : a5 51 __ LDA T7 + 0 
15e7 : 29 0f __ AND #$0f
15e9 : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
15ec : 8d fb 9f STA $9ffb ; (addr_str[0] + 1)
15ef : a5 50 __ LDA T5 + 0 
15f1 : 85 11 __ STA P4 
15f3 : a9 fa __ LDA #$fa
15f5 : 85 0f __ STA P2 
15f7 : a9 9f __ LDA #$9f
15f9 : 85 10 __ STA P3 
15fb : a9 01 __ LDA #$01
15fd : 85 12 __ STA P5 
15ff : a9 3a __ LDA #$3a
1601 : 8d fc 9f STA $9ffc ; (addr_str[0] + 2)
1604 : a9 0e __ LDA #$0e
1606 : 85 13 __ STA P6 
1608 : a9 00 __ LDA #$00
160a : 8d fd 9f STA $9ffd ; (addr_str[0] + 3)
160d : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1610 : 18 __ __ CLC
1611 : a5 4c __ LDA T3 + 0 
1613 : 69 1d __ ADC #$1d
1615 : 85 53 __ STA T9 + 0 
1617 : a5 4d __ LDA T3 + 1 
1619 : 69 05 __ ADC #$05
161b : 85 54 __ STA T9 + 1 
161d : a9 08 __ LDA #$08
161f : 85 55 __ STA T10 + 0 
1621 : a6 51 __ LDX T7 + 0 
.l6:
1623 : 86 0d __ STX P0 
1625 : 8a __ __ TXA
1626 : 20 e1 16 JSR $16e1 ; (mdp_read_byte.s4 + 0)
1629 : 85 56 __ STA T11 + 0 
162b : 4a __ __ LSR
162c : 4a __ __ LSR
162d : 4a __ __ LSR
162e : 4a __ __ LSR
162f : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1632 : 20 c1 0b JSR $0bc1 ; (ascii_to_screencode.s4 + 0)
1635 : a0 00 __ LDY #$00
1637 : 91 53 __ STA (T9 + 0),y 
1639 : a5 56 __ LDA T11 + 0 
163b : 29 0f __ AND #$0f
163d : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1640 : 20 c1 0b JSR $0bc1 ; (ascii_to_screencode.s4 + 0)
1643 : a0 01 __ LDY #$01
1645 : 91 53 __ STA (T9 + 0),y 
1647 : a9 20 __ LDA #$20
1649 : c8 __ __ INY
164a : 91 53 __ STA (T9 + 0),y 
164c : a9 00 __ LDA #$00
164e : 85 1f __ STA ADDR + 0 
1650 : 18 __ __ CLC
1651 : a5 54 __ LDA T9 + 1 
1653 : 69 d4 __ ADC #$d4
1655 : 85 20 __ STA ADDR + 1 
1657 : a9 01 __ LDA #$01
1659 : a4 53 __ LDY T9 + 0 
165b : 91 1f __ STA (ADDR + 0),y 
165d : 84 1f __ STY ADDR + 0 
165f : a8 __ __ TAY
1660 : 91 1f __ STA (ADDR + 0),y 
1662 : c8 __ __ INY
1663 : 91 1f __ STA (ADDR + 0),y 
1665 : 18 __ __ CLC
1666 : a5 53 __ LDA T9 + 0 
1668 : 69 03 __ ADC #$03
166a : 85 53 __ STA T9 + 0 
166c : 90 02 __ BCC $1670 ; (draw_sram_page_view.s11 + 0)
.s10:
166e : e6 54 __ INC T9 + 1 
.s11:
1670 : a6 0d __ LDX P0 
1672 : e8 __ __ INX
1673 : c6 55 __ DEC T10 + 0 
1675 : d0 ac __ BNE $1623 ; (draw_sram_page_view.l6 + 0)
.s7:
1677 : 18 __ __ CLC
1678 : a5 4e __ LDA T4 + 0 
167a : 69 19 __ ADC #$19
167c : 85 49 __ STA T0 + 0 
167e : a5 4f __ LDA T4 + 1 
1680 : 69 04 __ ADC #$04
1682 : 85 4a __ STA T0 + 1 
1684 : a9 08 __ LDA #$08
1686 : 85 52 __ STA T8 + 0 
.l8:
1688 : a5 51 __ LDA T7 + 0 
168a : 20 e1 16 JSR $16e1 ; (mdp_read_byte.s4 + 0)
168d : 20 e6 16 JSR $16e6 ; (get_printable_screencode.s4 + 0)
1690 : a0 00 __ LDY #$00
1692 : 84 1f __ STY ADDR + 0 
1694 : 91 49 __ STA (T0 + 0),y 
1696 : 18 __ __ CLC
1697 : a5 4a __ LDA T0 + 1 
1699 : 69 d4 __ ADC #$d4
169b : 85 20 __ STA ADDR + 1 
169d : a9 05 __ LDA #$05
169f : a4 49 __ LDY T0 + 0 
16a1 : 91 1f __ STA (ADDR + 0),y 
16a3 : e6 51 __ INC T7 + 0 
16a5 : 98 __ __ TYA
16a6 : 18 __ __ CLC
16a7 : 69 01 __ ADC #$01
16a9 : 85 49 __ STA T0 + 0 
16ab : 90 02 __ BCC $16af ; (draw_sram_page_view.s13 + 0)
.s12:
16ad : e6 4a __ INC T0 + 1 
.s13:
16af : c6 52 __ DEC T8 + 0 
16b1 : d0 d5 __ BNE $1688 ; (draw_sram_page_view.l8 + 0)
.s9:
16b3 : 18 __ __ CLC
16b4 : a5 4e __ LDA T4 + 0 
16b6 : 69 28 __ ADC #$28
16b8 : 85 4e __ STA T4 + 0 
16ba : 90 03 __ BCC $16bf ; (draw_sram_page_view.s15 + 0)
.s14:
16bc : e6 4f __ INC T4 + 1 
16be : 18 __ __ CLC
.s15:
16bf : a5 4c __ LDA T3 + 0 
16c1 : 69 28 __ ADC #$28
16c3 : 85 4c __ STA T3 + 0 
16c5 : 90 02 __ BCC $16c9 ; (draw_sram_page_view.s17 + 0)
.s16:
16c7 : e6 4d __ INC T3 + 1 
.s17:
16c9 : e6 50 __ INC T5 + 0 
16cb : e6 4b __ INC T2 + 0 
16cd : a5 4b __ LDA T2 + 0 
16cf : c9 0c __ CMP #$0c
16d1 : b0 03 __ BCS $16d6 ; (draw_sram_page_view.s3 + 0)
16d3 : 4c d3 15 JMP $15d3 ; (draw_sram_page_view.l5 + 0)
.s3:
16d6 : a2 03 __ LDX #$03
16d8 : bd ec 9f LDA $9fec,x ; (draw_sram_page_view@stack + 0)
16db : 95 53 __ STA T9 + 0,x 
16dd : ca __ __ DEX
16de : 10 f8 __ BPL $16d8 ; (draw_sram_page_view.s3 + 2)
16e0 : 60 __ __ RTS
--------------------------------------------------------------------
mdp_read_byte: ; mdp_read_byte(u8)->u8
; 104, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
16e1 : aa __ __ TAX
.s3:
16e2 : bd 00 df LDA $df00,x 
16e5 : 60 __ __ RTS
--------------------------------------------------------------------
get_printable_screencode: ; get_printable_screencode(u8)->u8
; 103, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
16e6 : c9 20 __ CMP #$20
16e8 : 90 17 __ BCC $1701 ; (get_printable_screencode.s7 + 0)
.s12:
16ea : c9 40 __ CMP #$40
16ec : 90 0a __ BCC $16f8 ; (get_printable_screencode.s3 + 0)
.s5:
16ee : c9 41 __ CMP #$41
16f0 : 90 0f __ BCC $1701 ; (get_printable_screencode.s7 + 0)
.s10:
16f2 : c9 5b __ CMP #$5b
16f4 : b0 03 __ BCS $16f9 ; (get_printable_screencode.s6 + 0)
.s11:
16f6 : e9 3f __ SBC #$3f
.s3:
16f8 : 60 __ __ RTS
.s6:
16f9 : c9 61 __ CMP #$61
16fb : 90 04 __ BCC $1701 ; (get_printable_screencode.s7 + 0)
.s8:
16fd : c9 7b __ CMP #$7b
16ff : 90 03 __ BCC $1704 ; (get_printable_screencode.s9 + 0)
.s7:
1701 : a9 2e __ LDA #$2e
1703 : 60 __ __ RTS
.s9:
1704 : e9 5f __ SBC #$5f
1706 : 60 __ __ RTS
--------------------------------------------------------------------
1707 : __ __ __ BYT 45 3a 4f 4e 2f 4f 46 46 20 42 3a 42 41 4e 4b 20 : E:ON/OFF B:BANK 
1717 : __ __ __ BYT 50 3a 50 41 47 45 20 57 3a 57 52 49 54 45 00    : P:PAGE W:WRITE.
--------------------------------------------------------------------
1726 : __ __ __ BYT 45 3a 4f 4e 2f 4f 46 46 20 50 3a 50 41 47 45 20 : E:ON/OFF P:PAGE 
1736 : __ __ __ BYT 57 3a 57 52 49 54 45 00                         : W:WRITE.
--------------------------------------------------------------------
173e : __ __ __ BYT 46 31 3a 4f 46 46 2d 20 46 33 3a 4f 46 46 2b 20 : F1:OFF- F3:OFF+ 
174e : __ __ __ BYT 46 35 3a 50 41 47 2d 20 46 37 3a 50 41 47 2b 20 : F5:PAG- F7:PAG+ 
175e : __ __ __ BYT 4d 3a 4d 45 4e 55 00                            : M:MENU.
--------------------------------------------------------------------
mdp_set_bank: ; mdp_set_bank(u8)->void
;  85, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
1765 : aa __ __ TAX
1766 : d0 08 __ BNE $1770 ; (mdp_set_bank.s6 + 0)
.s5:
1768 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
176b : 29 fe __ AND #$fe
176d : 4c 75 17 JMP $1775 ; (mdp_set_bank.s3 + 0)
.s6:
1770 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
1773 : 09 01 __ ORA #$01
.s3:
1775 : 8d 03 de STA $de03 
1778 : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
177b : 60 __ __ RTS
--------------------------------------------------------------------
177c : __ __ __ BYT 50 41 47 45 20 28 48 45 58 20 30 30 2d 46 46 29 : PAGE (HEX 00-FF)
178c : __ __ __ BYT 3a 00                                           : :.
--------------------------------------------------------------------
178e : __ __ __ BYT 50 41 47 45 20 28 48 45 58 20 30 30 2d 37 46 29 : PAGE (HEX 00-7F)
179e : __ __ __ BYT 3a 00                                           : :.
--------------------------------------------------------------------
17a0 : __ __ __ BYT 50 41 47 45 20 28 48 45 58 20 30 30 2d 31 46 29 : PAGE (HEX 00-1F)
17b0 : __ __ __ BYT 3a 00                                           : :.
--------------------------------------------------------------------
prompt_hex_byte: ; prompt_hex_byte(u8,u8)->u8
;1162, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
17b2 : a9 00 __ LDA #$00
17b4 : 85 49 __ STA T3 + 0 
17b6 : 8d fb 9f STA $9ffb ; (buf[0] + 0)
17b9 : 8d fc 9f STA $9ffc ; (buf[0] + 1)
17bc : 8d fd 9f STA $9ffd ; (buf[0] + 2)
17bf : a9 03 __ LDA #$03
17c1 : 85 13 __ STA P6 
17c3 : a5 14 __ LDA P7 ; (row + 0)
17c5 : 85 11 __ STA P4 
17c7 : a9 fd __ LDA #$fd
17c9 : 85 0f __ STA P2 
17cb : a9 0f __ LDA #$0f
17cd : 85 10 __ STA P3 
17cf : a5 15 __ LDA P8 ; (col + 0)
17d1 : 85 12 __ STA P5 
17d3 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
.l5:
17d6 : a9 00 __ LDA #$00
17d8 : c5 49 __ CMP T3 + 0 
17da : a8 __ __ TAY
17db : b0 11 __ BCS $17ee ; (prompt_hex_byte.s7 + 0)
.l28:
17dd : aa __ __ TAX
17de : bd fb 9f LDA $9ffb,x ; (buf[0] + 0)
.l9:
17e1 : 9d f8 9f STA $9ff8,x ; (display[0] + 0)
17e4 : c8 __ __ INY
17e5 : 98 __ __ TYA
17e6 : c0 02 __ CPY #$02
17e8 : b0 12 __ BCS $17fc ; (prompt_hex_byte.s10 + 0)
.s6:
17ea : c5 49 __ CMP T3 + 0 
17ec : 90 ef __ BCC $17dd ; (prompt_hex_byte.l28 + 0)
.s7:
17ee : c5 49 __ CMP T3 + 0 
17f0 : d0 05 __ BNE $17f7 ; (prompt_hex_byte.s8 + 0)
.s27:
17f2 : aa __ __ TAX
17f3 : a9 a4 __ LDA #$a4
17f5 : d0 ea __ BNE $17e1 ; (prompt_hex_byte.l9 + 0)
.s8:
17f7 : aa __ __ TAX
17f8 : a9 20 __ LDA #$20
17fa : d0 e5 __ BNE $17e1 ; (prompt_hex_byte.l9 + 0)
.s10:
17fc : a5 14 __ LDA P7 ; (row + 0)
17fe : 85 11 __ STA P4 
1800 : a5 15 __ LDA P8 ; (col + 0)
1802 : 85 12 __ STA P5 
1804 : a9 03 __ LDA #$03
1806 : 85 13 __ STA P6 
1808 : a9 00 __ LDA #$00
180a : 8d fa 9f STA $9ffa ; (display[0] + 2)
180d : a9 f8 __ LDA #$f8
180f : 85 0f __ STA P2 
1811 : a9 9f __ LDA #$9f
1813 : 85 10 __ STA P3 
1815 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
.l11:
1818 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
181b : 85 43 __ STA T0 + 0 
181d : aa __ __ TAX
181e : f0 f8 __ BEQ $1818 ; (prompt_hex_byte.l11 + 0)
.s12:
1820 : c9 0d __ CMP #$0d
1822 : f0 56 __ BEQ $187a ; (prompt_hex_byte.s26 + 0)
.s13:
1824 : c9 14 __ CMP #$14
1826 : f0 05 __ BEQ $182d ; (prompt_hex_byte.s24 + 0)
.s30:
1828 : a5 49 __ LDA T3 + 0 
182a : 4c 38 18 JMP $1838 ; (prompt_hex_byte.s14 + 0)
.s24:
182d : 85 43 __ STA T0 + 0 
182f : a5 49 __ LDA T3 + 0 
1831 : f0 05 __ BEQ $1838 ; (prompt_hex_byte.s14 + 0)
.s25:
1833 : c6 49 __ DEC T3 + 0 
1835 : 4c d6 17 JMP $17d6 ; (prompt_hex_byte.l5 + 0)
.s14:
1838 : c9 02 __ CMP #$02
183a : b0 9a __ BCS $17d6 ; (prompt_hex_byte.l5 + 0)
.s15:
183c : a5 43 __ LDA T0 + 0 
183e : c9 30 __ CMP #$30
1840 : 90 94 __ BCC $17d6 ; (prompt_hex_byte.l5 + 0)
.s23:
1842 : c9 3a __ CMP #$3a
1844 : 90 16 __ BCC $185c ; (prompt_hex_byte.s29 + 0)
.s16:
1846 : c9 41 __ CMP #$41
1848 : 90 8c __ BCC $17d6 ; (prompt_hex_byte.l5 + 0)
.s22:
184a : c9 47 __ CMP #$47
184c : 90 0e __ BCC $185c ; (prompt_hex_byte.s29 + 0)
.s17:
184e : c9 61 __ CMP #$61
1850 : 90 84 __ BCC $17d6 ; (prompt_hex_byte.l5 + 0)
.s18:
1852 : c9 67 __ CMP #$67
1854 : b0 80 __ BCS $17d6 ; (prompt_hex_byte.l5 + 0)
.s19:
1856 : c9 61 __ CMP #$61
1858 : 90 02 __ BCC $185c ; (prompt_hex_byte.s29 + 0)
.s21:
185a : e9 20 __ SBC #$20
.s29:
185c : a6 49 __ LDX T3 + 0 
185e : e8 __ __ INX
185f : 86 49 __ STX T3 + 0 
1861 : 9d fa 9f STA $9ffa,x ; (display[0] + 2)
1864 : e0 02 __ CPX #$02
1866 : d0 cd __ BNE $1835 ; (prompt_hex_byte.s25 + 2)
.s20:
1868 : 8a __ __ TXA
.s3:
1869 : 85 0f __ STA P2 
186b : a9 00 __ LDA #$00
186d : 85 10 __ STA P3 
186f : a9 9f __ LDA #$9f
1871 : 85 0e __ STA P1 
1873 : a9 fb __ LDA #$fb
1875 : 85 0d __ STA P0 
1877 : 4c 82 18 JMP $1882 ; (parse_hex_address.s4 + 0)
.s26:
187a : 85 43 __ STA T0 + 0 
187c : a5 49 __ LDA T3 + 0 
187e : d0 e9 __ BNE $1869 ; (prompt_hex_byte.s3 + 0)
1880 : f0 b6 __ BEQ $1838 ; (prompt_hex_byte.s14 + 0)
--------------------------------------------------------------------
parse_hex_address: ; parse_hex_address(const u8*,i16)->u16
; 190, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
1882 : a9 00 __ LDA #$00
1884 : 85 43 __ STA T0 + 0 
1886 : 85 1b __ STA ACCU + 0 
1888 : 85 44 __ STA T0 + 1 
188a : 85 1c __ STA ACCU + 1 
188c : a5 10 __ LDA P3 ; (len + 1)
188e : 30 04 __ BMI $1894 ; (parse_hex_address.s3 + 0)
.s9:
1890 : 05 0f __ ORA P2 ; (len + 0)
1892 : d0 01 __ BNE $1895 ; (parse_hex_address.s10 + 0)
.s3:
1894 : 60 __ __ RTS
.s10:
1895 : a6 10 __ LDX P3 ; (len + 1)
.l5:
1897 : a0 00 __ LDY #$00
1899 : b1 0d __ LDA (P0),y ; (buf + 0)
189b : c9 41 __ CMP #$41
189d : 90 05 __ BCC $18a4 ; (parse_hex_address.s6 + 0)
.s8:
189f : 69 c8 __ ADC #$c8
18a1 : 4c a6 18 JMP $18a6 ; (parse_hex_address.s7 + 0)
.s6:
18a4 : e9 2f __ SBC #$2f
.s7:
18a6 : a8 __ __ TAY
18a7 : a5 44 __ LDA T0 + 1 
18a9 : 06 43 __ ASL T0 + 0 
18ab : 2a __ __ ROL
18ac : 06 43 __ ASL T0 + 0 
18ae : 2a __ __ ROL
18af : 06 43 __ ASL T0 + 0 
18b1 : 2a __ __ ROL
18b2 : 06 43 __ ASL T0 + 0 
18b4 : 2a __ __ ROL
18b5 : 85 44 __ STA T0 + 1 
18b7 : 85 1c __ STA ACCU + 1 
18b9 : 98 __ __ TYA
18ba : 05 43 __ ORA T0 + 0 
18bc : 85 43 __ STA T0 + 0 
18be : 85 1b __ STA ACCU + 0 
18c0 : e6 0d __ INC P0 ; (buf + 0)
18c2 : d0 02 __ BNE $18c6 ; (parse_hex_address.s15 + 0)
.s14:
18c4 : e6 0e __ INC P1 ; (buf + 1)
.s15:
18c6 : a5 0f __ LDA P2 ; (len + 0)
18c8 : d0 01 __ BNE $18cb ; (parse_hex_address.s12 + 0)
.s11:
18ca : ca __ __ DEX
.s12:
18cb : c6 0f __ DEC P2 ; (len + 0)
18cd : d0 c8 __ BNE $1897 ; (parse_hex_address.l5 + 0)
.s13:
18cf : 8a __ __ TXA
18d0 : d0 c5 __ BNE $1897 ; (parse_hex_address.l5 + 0)
18d2 : 60 __ __ RTS
--------------------------------------------------------------------
18d3 : __ __ __ BYT 53 52 41 4d 20 4e 4f 54 20 41 43 54 49 56 45 21 : SRAM NOT ACTIVE!
18e3 : __ __ __ BYT 20 20 20 20 00                                  :     .
--------------------------------------------------------------------
18e8 : __ __ __ BYT 45 45 50 52 4f 4d 20 4e 4f 54 20 41 43 54 49 56 : EEPROM NOT ACTIV
18f8 : __ __ __ BYT 45 21 20 20 00                                  : E!  .
--------------------------------------------------------------------
18fd : __ __ __ BYT 24 00                                           : $.
--------------------------------------------------------------------
spentry:
18ff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1900 : __ __ __ BYT 4f 46 46 53 45 54 20 28 48 45 58 20 30 30 2d 46 : OFFSET (HEX 00-F
1910 : __ __ __ BYT 46 29 3a 00                                     : F):.
--------------------------------------------------------------------
1914 : __ __ __ BYT 56 41 4c 55 45 20 28 48 45 58 20 30 30 2d 46 46 : VALUE (HEX 00-FF
1924 : __ __ __ BYT 29 3a 00                                        : ):.
--------------------------------------------------------------------
1927 : __ __ __ BYT 42 59 54 45 20 57 52 49 54 54 45 4e 21 20 20 20 : BYTE WRITTEN!   
1937 : __ __ __ BYT 20 20 20 20 00                                  :     .
--------------------------------------------------------------------
show_sram_diag_screen: ; show_sram_diag_screen()->void
;2170, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
193c : a5 53 __ LDA T0 + 0 
193e : 8d a7 9e STA $9ea7 ; (show_sram_diag_screen@stack + 0)
1941 : a5 54 __ LDA T0 + 1 
1943 : 8d a8 9e STA $9ea8 ; (show_sram_diag_screen@stack + 1)
1946 : a5 55 __ LDA T2 + 0 
1948 : 8d a9 9e STA $9ea9 ; (show_sram_diag_screen@stack + 2)
.l4:
194b : a9 0b __ LDA #$0b
194d : 85 18 __ STA P11 
194f : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
1952 : a9 03 __ LDA #$03
1954 : 85 16 __ STA P9 
1956 : a9 07 __ LDA #$07
1958 : 85 17 __ STA P10 
195a : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
195d : 85 55 __ STA T2 + 0 
195f : d0 40 __ BNE $19a1 ; (show_sram_diag_screen.s21 + 0)
.s5:
1961 : a9 c5 __ LDA #$c5
1963 : 85 14 __ STA P7 
1965 : a9 1a __ LDA #$1a
1967 : 85 15 __ STA P8 
1969 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
196c : a9 09 __ LDA #$09
196e : 85 11 __ STA P4 
1970 : a9 1a __ LDA #$1a
1972 : 85 10 __ STA P3 
1974 : a9 08 __ LDA #$08
1976 : 85 12 __ STA P5 
1978 : a9 01 __ LDA #$01
197a : 85 13 __ STA P6 
197c : a9 73 __ LDA #$73
197e : 85 0f __ STA P2 
1980 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1983 : a9 0b __ LDA #$0b
1985 : 85 11 __ STA P4 
1987 : a9 1a __ LDA #$1a
1989 : 85 10 __ STA P3 
198b : a9 d8 __ LDA #$d8
198d : 85 0f __ STA P2 
198f : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
1992 : a9 00 __ LDA #$00
1994 : 85 0f __ STA P2 
1996 : a9 1b __ LDA #$1b
1998 : 85 10 __ STA P3 
199a : a9 1b __ LDA #$1b
199c : a0 18 __ LDY #$18
199e : 4c de 19 JMP $19de ; (show_sram_diag_screen.s6 + 0)
.s21:
19a1 : a9 62 __ LDA #$62
19a3 : 85 14 __ STA P7 
19a5 : a9 1a __ LDA #$1a
19a7 : 85 15 __ STA P8 
19a9 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
19ac : a9 09 __ LDA #$09
19ae : 85 11 __ STA P4 
19b0 : a9 1a __ LDA #$1a
19b2 : 85 10 __ STA P3 
19b4 : a9 08 __ LDA #$08
19b6 : 85 12 __ STA P5 
19b8 : a9 01 __ LDA #$01
19ba : 85 13 __ STA P6 
19bc : a9 73 __ LDA #$73
19be : 85 0f __ STA P2 
19c0 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
19c3 : a9 0b __ LDA #$0b
19c5 : 85 11 __ STA P4 
19c7 : a9 1a __ LDA #$1a
19c9 : 85 10 __ STA P3 
19cb : a9 8b __ LDA #$8b
19cd : 85 0f __ STA P2 
19cf : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
19d2 : a9 a4 __ LDA #$a4
19d4 : 85 0f __ STA P2 
19d6 : a9 1a __ LDA #$1a
19d8 : 85 10 __ STA P3 
19da : a9 1a __ LDA #$1a
19dc : a0 b5 __ LDY #$b5
.s6:
19de : 84 53 __ STY T0 + 0 
19e0 : 85 54 __ STA T0 + 1 
19e2 : a9 0d __ LDA #$0d
19e4 : 85 11 __ STA P4 
19e6 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
19e9 : a5 53 __ LDA T0 + 0 
19eb : 85 0f __ STA P2 
19ed : a5 54 __ LDA T0 + 1 
19ef : 85 10 __ STA P3 
19f1 : a9 0f __ LDA #$0f
19f3 : 85 11 __ STA P4 
19f5 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
19f8 : a9 17 __ LDA #$17
19fa : 85 16 __ STA P9 
19fc : a9 1b __ LDA #$1b
19fe : 85 15 __ STA P8 
1a00 : a9 0d __ LDA #$0d
1a02 : 85 17 __ STA P10 
1a04 : a9 2a __ LDA #$2a
1a06 : 85 14 __ STA P7 
1a08 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l7:
1a0b : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
1a0e : c9 6d __ CMP #$6d
1a10 : f0 40 __ BEQ $1a52 ; (show_sram_diag_screen.s3 + 0)
.s8:
1a12 : c9 4d __ CMP #$4d
1a14 : f0 3c __ BEQ $1a52 ; (show_sram_diag_screen.s3 + 0)
.s9:
1a16 : c9 85 __ CMP #$85
1a18 : d0 06 __ BNE $1a20 ; (show_sram_diag_screen.s10 + 0)
.s20:
1a1a : 20 3d 1b JSR $1b3d ; (sram_selftest.s1 + 0)
1a1d : 4c 4b 19 JMP $194b ; (show_sram_diag_screen.l4 + 0)
.s10:
1a20 : c9 86 __ CMP #$86
1a22 : f0 1e __ BEQ $1a42 ; (show_sram_diag_screen.s17 + 0)
.s11:
1a24 : c9 87 __ CMP #$87
1a26 : f0 0a __ BEQ $1a32 ; (show_sram_diag_screen.s14 + 0)
.s12:
1a28 : c9 88 __ CMP #$88
1a2a : d0 df __ BNE $1a0b ; (show_sram_diag_screen.l7 + 0)
.s13:
1a2c : 20 23 33 JSR $3323 ; (sram_format.s4 + 0)
1a2f : 4c 4b 19 JMP $194b ; (show_sram_diag_screen.l4 + 0)
.s14:
1a32 : a5 55 __ LDA T2 + 0 
1a34 : d0 06 __ BNE $1a3c ; (show_sram_diag_screen.s16 + 0)
.s15:
1a36 : 20 21 2a JSR $2a21 ; (sram_restore.s4 + 0)
1a39 : 4c 4b 19 JMP $194b ; (show_sram_diag_screen.l4 + 0)
.s16:
1a3c : 20 32 2b JSR $2b32 ; (check_floppy.s1 + 0)
1a3f : 4c 4b 19 JMP $194b ; (show_sram_diag_screen.l4 + 0)
.s17:
1a42 : a5 55 __ LDA T2 + 0 
1a44 : d0 06 __ BNE $1a4c ; (show_sram_diag_screen.s19 + 0)
.s18:
1a46 : 20 23 28 JSR $2823 ; (sram_backup.s4 + 0)
1a49 : 4c 4b 19 JMP $194b ; (show_sram_diag_screen.l4 + 0)
.s19:
1a4c : 20 97 1e JSR $1e97 ; (show_prg_loader_screen.s1 + 0)
1a4f : 4c 4b 19 JMP $194b ; (show_sram_diag_screen.l4 + 0)
.s3:
1a52 : ad a7 9e LDA $9ea7 ; (show_sram_diag_screen@stack + 0)
1a55 : 85 53 __ STA T0 + 0 
1a57 : ad a8 9e LDA $9ea8 ; (show_sram_diag_screen@stack + 1)
1a5a : 85 54 __ STA T0 + 1 
1a5c : ad a9 9e LDA $9ea9 ; (show_sram_diag_screen@stack + 2)
1a5f : 85 55 __ STA T2 + 0 
1a61 : 60 __ __ RTS
--------------------------------------------------------------------
1a62 : __ __ __ BYT 53 52 41 4d 20 44 49 41 47 4e 4f 53 54 49 43 53 : SRAM DIAGNOSTICS
1a72 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1a73 : __ __ __ BYT 46 31 3a 20 49 4e 54 45 47 52 49 54 59 20 53 45 : F1: INTEGRITY SE
1a83 : __ __ __ BYT 4c 46 2d 54 45 53 54 00                         : LF-TEST.
--------------------------------------------------------------------
1a8b : __ __ __ BYT 46 33 3a 20 4c 4f 41 44 20 50 52 47 20 46 52 4f : F3: LOAD PRG FRO
1a9b : __ __ __ BYT 4d 20 46 4c 4f 50 50 59 00                      : M FLOPPY.
--------------------------------------------------------------------
1aa4 : __ __ __ BYT 46 35 3a 20 43 48 45 43 4b 20 46 4c 4f 50 50 59 : F5: CHECK FLOPPY
1ab4 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1ab5 : __ __ __ BYT 46 37 3a 20 46 4f 52 4d 41 54 20 53 52 41 4d 00 : F7: FORMAT SRAM.
--------------------------------------------------------------------
1ac5 : __ __ __ BYT 45 45 50 52 4f 4d 20 44 49 41 47 4e 4f 53 54 49 : EEPROM DIAGNOSTI
1ad5 : __ __ __ BYT 43 53 00                                        : CS.
--------------------------------------------------------------------
1ad8 : __ __ __ BYT 46 33 3a 20 42 41 43 4b 55 50 20 52 41 4d 20 54 : F3: BACKUP RAM T
1ae8 : __ __ __ BYT 4f 20 45 45 50 52 4f 4d 00                      : O EEPROM.
--------------------------------------------------------------------
1af1 : __ __ __ BYT 54 45 53 54 49 4e 47 2e 2e 2e 00                : TESTING....
--------------------------------------------------------------------
krnio_clrchn: ; krnio_clrchn()->void
;  59, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
1afc : 20 cc ff JSR $ffcc 
.s3:
1aff : 60 __ __ RTS
--------------------------------------------------------------------
1b00 : __ __ __ BYT 46 35 3a 20 52 45 53 54 4f 52 45 20 46 52 4f 4d : F5: RESTORE FROM
1b10 : __ __ __ BYT 20 45 45 50 52 4f 4d 00                         :  EEPROM.
--------------------------------------------------------------------
1b18 : __ __ __ BYT 46 37 3a 20 46 4f 52 4d 41 54 20 45 45 50 52 4f : F7: FORMAT EEPRO
1b28 : __ __ __ BYT 4d 00                                           : M.
--------------------------------------------------------------------
1b2a : __ __ __ BYT 50 52 45 53 53 20 28 4d 29 20 46 4f 52 20 4d 45 : PRESS (M) FOR ME
1b3a : __ __ __ BYT 4e 55 00                                        : NU.
--------------------------------------------------------------------
sram_selftest: ; sram_selftest()->void
;1422, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
1b3d : a2 04 __ LDX #$04
1b3f : b5 53 __ LDA T9 + 0,x 
1b41 : 9d aa 9e STA $9eaa,x ; (sram_selftest@stack + 0)
1b44 : ca __ __ DEX
1b45 : 10 f8 __ BPL $1b3f ; (sram_selftest.s1 + 2)
.s4:
1b47 : a9 0b __ LDA #$0b
1b49 : 85 18 __ STA P11 
1b4b : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
1b4e : a9 03 __ LDA #$03
1b50 : 85 16 __ STA P9 
1b52 : a9 07 __ LDA #$07
1b54 : 85 17 __ STA P10 
1b56 : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
1b59 : 85 51 __ STA T7 + 0 
1b5b : f0 03 __ BEQ $1b60 ; (sram_selftest.s5 + 0)
1b5d : 4c e2 1d JMP $1de2 ; (sram_selftest.s56 + 0)
.s5:
1b60 : a9 c5 __ LDA #$c5
1b62 : 85 14 __ STA P7 
1b64 : a9 1a __ LDA #$1a
1b66 : 85 15 __ STA P8 
1b68 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1b6b : ad fe 27 LDA $27fe ; (eeprom_status + 0)
1b6e : d0 38 __ BNE $1ba8 ; (sram_selftest.s7 + 0)
.s6:
1b70 : a9 0b __ LDA #$0b
1b72 : 85 16 __ STA P9 
1b74 : a9 02 __ LDA #$02
1b76 : 85 17 __ STA P10 
1b78 : a9 27 __ LDA #$27
1b7a : 85 14 __ STA P7 
1b7c : a9 1e __ LDA #$1e
.s63:
1b7e : 85 15 __ STA P8 
.s62:
1b80 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1b83 : a9 17 __ LDA #$17
1b85 : 85 16 __ STA P9 
1b87 : a9 0c __ LDA #$0c
1b89 : 85 15 __ STA P8 
1b8b : a9 01 __ LDA #$01
1b8d : 85 17 __ STA P10 
1b8f : a9 cc __ LDA #$cc
1b91 : 85 14 __ STA P7 
1b93 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l35:
1b96 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
1b99 : c9 0d __ CMP #$0d
1b9b : d0 f9 __ BNE $1b96 ; (sram_selftest.l35 + 0)
.s3:
1b9d : a2 04 __ LDX #$04
1b9f : bd aa 9e LDA $9eaa,x ; (sram_selftest@stack + 0)
1ba2 : 95 53 __ STA T9 + 0,x 
1ba4 : ca __ __ DEX
1ba5 : 10 f8 __ BPL $1b9f ; (sram_selftest.s3 + 2)
1ba7 : 60 __ __ RTS
.s7:
1ba8 : a9 0b __ LDA #$0b
1baa : 85 16 __ STA P9 
1bac : a9 1a __ LDA #$1a
1bae : 85 15 __ STA P8 
1bb0 : a9 03 __ LDA #$03
1bb2 : 85 17 __ STA P10 
1bb4 : a9 f1 __ LDA #$f1
1bb6 : 85 14 __ STA P7 
1bb8 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1bbb : a9 00 __ LDA #$00
1bbd : 8d fd 9f STA $9ffd ; (patterns[0] + 2)
1bc0 : 85 52 __ STA T8 + 0 
1bc2 : a9 aa __ LDA #$aa
1bc4 : 8d fb 9f STA $9ffb ; (patterns[0] + 0)
1bc7 : a9 55 __ LDA #$55
1bc9 : 8d fc 9f STA $9ffc ; (patterns[0] + 1)
1bcc : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
1bcf : 85 53 __ STA T9 + 0 
1bd1 : a5 51 __ LDA T7 + 0 
1bd3 : f0 0c __ BEQ $1be1 ; (sram_selftest.s8 + 0)
.s55:
1bd5 : a9 00 __ LDA #$00
1bd7 : 85 4b __ STA T2 + 0 
1bd9 : a9 01 __ LDA #$01
1bdb : 85 4c __ STA T2 + 1 
1bdd : a9 02 __ LDA #$02
1bdf : d0 11 __ BNE $1bf2 ; (sram_selftest.s10 + 0)
.s8:
1be1 : a9 20 __ LDA #$20
1be3 : cd fd 27 CMP $27fd ; (eeprom_size_kb + 0)
1be6 : d0 02 __ BNE $1bea ; (sram_selftest.s9 + 0)
.s54:
1be8 : a9 80 __ LDA #$80
.s9:
1bea : 85 4b __ STA T2 + 0 
1bec : a9 00 __ LDA #$00
1bee : 85 4c __ STA T2 + 1 
1bf0 : a9 01 __ LDA #$01
.s10:
1bf2 : 85 4d __ STA T3 + 0 
1bf4 : a9 00 __ LDA #$00
1bf6 : 85 54 __ STA T10 + 0 
1bf8 : 85 55 __ STA T11 + 0 
1bfa : 85 56 __ STA T12 + 0 
1bfc : a5 51 __ LDA T7 + 0 
1bfe : d0 0f __ BNE $1c0f ; (sram_selftest.l43 + 0)
.s11:
1c00 : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
.l12:
1c03 : a9 00 __ LDA #$00
1c05 : 85 4e __ STA T4 + 0 
1c07 : 85 4f __ STA T4 + 1 
.l52:
1c09 : a9 50 __ LDA #$50
1c0b : a0 00 __ LDY #$00
1c0d : f0 3d __ BEQ $1c4c ; (sram_selftest.l59 + 0)
.l43:
1c0f : a5 52 __ LDA T8 + 0 
1c11 : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
1c14 : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
1c17 : a9 54 __ LDA #$54
1c19 : a0 00 __ LDY #$00
.l58:
1c1b : 99 e7 9f STA $9fe7,y ; (bank_msg[0] + 0)
1c1e : c8 __ __ INY
1c1f : b9 48 1e LDA $1e48,y 
1c22 : d0 f7 __ BNE $1c1b ; (sram_selftest.l58 + 0)
.s44:
1c24 : a9 20 __ LDA #$20
1c26 : 99 e7 9f STA $9fe7,y ; (bank_msg[0] + 0)
1c29 : a9 0d __ LDA #$0d
1c2b : 85 16 __ STA P9 
1c2d : a9 01 __ LDA #$01
1c2f : 85 17 __ STA P10 
1c31 : a9 00 __ LDA #$00
1c33 : 99 e9 9f STA $9fe9,y ; (bank_msg[0] + 2)
1c36 : 18 __ __ CLC
1c37 : a5 52 __ LDA T8 + 0 
1c39 : 69 30 __ ADC #$30
1c3b : 99 e8 9f STA $9fe8,y ; (bank_msg[0] + 1)
1c3e : a9 e7 __ LDA #$e7
1c40 : 85 14 __ STA P7 
1c42 : a9 9f __ LDA #$9f
1c44 : 85 15 __ STA P8 
1c46 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1c49 : 4c 03 1c JMP $1c03 ; (sram_selftest.l12 + 0)
.l59:
1c4c : 99 db 9f STA $9fdb,y ; (pg_str[0] + 0)
1c4f : c8 __ __ INY
1c50 : b9 98 15 LDA $1598,y 
1c53 : d0 f7 __ BNE $1c4c ; (sram_selftest.l59 + 0)
.s53:
1c55 : 84 4a __ STY T1 + 0 
1c57 : a9 20 __ LDA #$20
1c59 : 99 db 9f STA $9fdb,y ; (pg_str[0] + 0)
1c5c : a5 4e __ LDA T4 + 0 
1c5e : 4a __ __ LSR
1c5f : 4a __ __ LSR
1c60 : 4a __ __ LSR
1c61 : 4a __ __ LSR
1c62 : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1c65 : a6 4a __ LDX T1 + 0 
1c67 : 9d dc 9f STA $9fdc,x ; (pg_str[0] + 1)
1c6a : a9 00 __ LDA #$00
1c6c : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1c6f : a6 4a __ LDX T1 + 0 
1c71 : 9d dd 9f STA $9fdd,x ; (pg_str[0] + 2)
1c74 : a9 0f __ LDA #$0f
1c76 : 85 16 __ STA P9 
1c78 : 85 17 __ STA P10 
1c7a : a9 00 __ LDA #$00
1c7c : 9d de 9f STA $9fde,x ; (pg_str[0] + 3)
1c7f : a9 db __ LDA #$db
1c81 : 85 14 __ STA P7 
1c83 : a9 9f __ LDA #$9f
1c85 : 85 15 __ STA P8 
1c87 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l14:
1c8a : a5 4e __ LDA T4 + 0 
1c8c : 8d 01 de STA $de01 
1c8f : a9 00 __ LDA #$00
.l60:
1c91 : 85 0d __ STA P0 
1c93 : 20 e1 16 JSR $16e1 ; (mdp_read_byte.s4 + 0)
1c96 : a6 0d __ LDX P0 
1c98 : 9d db 9e STA $9edb,x ; (saved[0] + 0)
1c9b : e8 __ __ INX
1c9c : 8a __ __ TXA
1c9d : d0 f2 __ BNE $1c91 ; (sram_selftest.l60 + 0)
.s15:
1c9f : 85 49 __ STA T0 + 0 
.l16:
1ca1 : 85 50 __ STA T5 + 0 
.l17:
1ca3 : a6 49 __ LDX T0 + 0 
1ca5 : bd fb 9f LDA $9ffb,x ; (patterns[0] + 0)
1ca8 : 85 57 __ STA T13 + 0 
1caa : a5 51 __ LDA T7 + 0 
1cac : d0 12 __ BNE $1cc0 ; (sram_selftest.s51 + 0)
.s18:
1cae : a5 4e __ LDA T4 + 0 
1cb0 : 85 0e __ STA P1 
1cb2 : a5 50 __ LDA T5 + 0 
1cb4 : 85 0f __ STA P2 
1cb6 : a5 57 __ LDA T13 + 0 
1cb8 : 85 10 __ STA P3 
1cba : 20 bd 0d JSR $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
1cbd : 4c c7 1c JMP $1cc7 ; (sram_selftest.s19 + 0)
.s51:
1cc0 : a5 57 __ LDA T13 + 0 
1cc2 : a6 50 __ LDX T5 + 0 
1cc4 : 9d 00 df STA $df00,x 
.s19:
1cc7 : e6 50 __ INC T5 + 0 
1cc9 : d0 d8 __ BNE $1ca3 ; (sram_selftest.l17 + 0)
.s20:
1ccb : a9 00 __ LDA #$00
1ccd : 85 4a __ STA T1 + 0 
.l21:
1ccf : a5 4a __ LDA T1 + 0 
1cd1 : 20 e1 16 JSR $16e1 ; (mdp_read_byte.s4 + 0)
1cd4 : c5 57 __ CMP T13 + 0 
1cd6 : f0 03 __ BEQ $1cdb ; (sram_selftest.s22 + 0)
1cd8 : 4c d3 1d JMP $1dd3 ; (sram_selftest.s50 + 0)
.s22:
1cdb : e6 4a __ INC T1 + 0 
1cdd : d0 f0 __ BNE $1ccf ; (sram_selftest.l21 + 0)
.s23:
1cdf : e6 49 __ INC T0 + 0 
1ce1 : a5 49 __ LDA T0 + 0 
1ce3 : c9 03 __ CMP #$03
1ce5 : b0 04 __ BCS $1ceb ; (sram_selftest.s24 + 0)
.s49:
1ce7 : a5 54 __ LDA T10 + 0 
1ce9 : f0 b6 __ BEQ $1ca1 ; (sram_selftest.l16 + 0)
.s24:
1ceb : a9 00 __ LDA #$00
1ced : 85 4a __ STA T1 + 0 
.l25:
1cef : a4 4a __ LDY T1 + 0 
1cf1 : a5 51 __ LDA T7 + 0 
1cf3 : d0 11 __ BNE $1d06 ; (sram_selftest.s48 + 0)
.s26:
1cf5 : 84 0f __ STY P2 
1cf7 : a5 4e __ LDA T4 + 0 
1cf9 : 85 0e __ STA P1 
1cfb : b9 db 9e LDA $9edb,y ; (saved[0] + 0)
1cfe : 85 10 __ STA P3 
1d00 : 20 bd 0d JSR $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
1d03 : 4c 0c 1d JMP $1d0c ; (sram_selftest.s27 + 0)
.s48:
1d06 : b9 db 9e LDA $9edb,y ; (saved[0] + 0)
1d09 : 99 00 df STA $df00,y 
.s27:
1d0c : e6 4a __ INC T1 + 0 
1d0e : d0 df __ BNE $1cef ; (sram_selftest.l25 + 0)
.s28:
1d10 : e6 4e __ INC T4 + 0 
1d12 : d0 02 __ BNE $1d16 ; (sram_selftest.s65 + 0)
.s64:
1d14 : e6 4f __ INC T4 + 1 
.s65:
1d16 : a5 4f __ LDA T4 + 1 
1d18 : c5 4c __ CMP T2 + 1 
1d1a : d0 04 __ BNE $1d20 ; (sram_selftest.s47 + 0)
.s46:
1d1c : a5 4e __ LDA T4 + 0 
1d1e : c5 4b __ CMP T2 + 0 
.s47:
1d20 : b0 10 __ BCS $1d32 ; (sram_selftest.s29 + 0)
.s45:
1d22 : a5 54 __ LDA T10 + 0 
1d24 : d0 0c __ BNE $1d32 ; (sram_selftest.s29 + 0)
.s13:
1d26 : a5 4e __ LDA T4 + 0 
1d28 : 29 0f __ AND #$0f
1d2a : f0 03 __ BEQ $1d2f ; (sram_selftest.s13 + 9)
1d2c : 4c 8a 1c JMP $1c8a ; (sram_selftest.l14 + 0)
1d2f : 4c 09 1c JMP $1c09 ; (sram_selftest.l52 + 0)
.s29:
1d32 : e6 52 __ INC T8 + 0 
1d34 : a5 52 __ LDA T8 + 0 
1d36 : c5 4d __ CMP T3 + 0 
1d38 : b0 0e __ BCS $1d48 ; (sram_selftest.s30 + 0)
.s41:
1d3a : a5 54 __ LDA T10 + 0 
1d3c : d0 0a __ BNE $1d48 ; (sram_selftest.s30 + 0)
.s42:
1d3e : a5 51 __ LDA T7 + 0 
1d40 : f0 03 __ BEQ $1d45 ; (sram_selftest.s42 + 7)
1d42 : 4c 0f 1c JMP $1c0f ; (sram_selftest.l43 + 0)
1d45 : 4c 00 1c JMP $1c00 ; (sram_selftest.s11 + 0)
.s30:
1d48 : a5 51 __ LDA T7 + 0 
1d4a : d0 0b __ BNE $1d57 ; (sram_selftest.s40 + 0)
.s31:
1d4c : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
1d4f : 85 11 __ STA P4 
1d51 : 20 20 0e JSR $0e20 ; (mdp_eeprom_write_signature.s4 + 0)
1d54 : 4c 5a 1d JMP $1d5a ; (sram_selftest.s32 + 0)
.s40:
1d57 : 20 90 0c JSR $0c90 ; (mdp_write_signature.s4 + 0)
.s32:
1d5a : a5 53 __ LDA T9 + 0 
1d5c : 8d 03 de STA $de03 
1d5f : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
1d62 : a5 54 __ LDA T10 + 0 
1d64 : d0 13 __ BNE $1d79 ; (sram_selftest.s36 + 0)
.s33:
1d66 : a9 0d __ LDA #$0d
1d68 : 85 17 __ STA P10 
1d6a : a9 1e __ LDA #$1e
1d6c : a0 76 __ LDY #$76
.s34:
1d6e : 84 14 __ STY P7 
1d70 : 85 15 __ STA P8 
1d72 : a9 11 __ LDA #$11
1d74 : 85 16 __ STA P9 
1d76 : 4c 80 1b JMP $1b80 ; (sram_selftest.s62 + 0)
.s36:
1d79 : a9 45 __ LDA #$45
1d7b : a0 00 __ LDY #$00
.l61:
1d7d : 99 b3 9e STA $9eb3,y ; (fail_msg[0] + 0)
1d80 : b9 56 1e LDA $1e56,y 
1d83 : c8 __ __ INY
1d84 : c0 1e __ CPY #$1e
1d86 : d0 f5 __ BNE $1d7d ; (sram_selftest.l61 + 0)
.s37:
1d88 : a5 56 __ LDA T12 + 0 
1d8a : 4a __ __ LSR
1d8b : 4a __ __ LSR
1d8c : 4a __ __ LSR
1d8d : 4a __ __ LSR
1d8e : aa __ __ TAX
1d8f : a5 51 __ LDA T7 + 0 
1d91 : f0 14 __ BEQ $1da7 ; (sram_selftest.s38 + 0)
.s39:
1d93 : a9 42 __ LDA #$42
1d95 : 8d d1 9e STA $9ed1 ; (fail_msg[0] + 30)
1d98 : a9 20 __ LDA #$20
1d9a : 8d d3 9e STA $9ed3 ; (fail_msg[0] + 32)
1d9d : 18 __ __ CLC
1d9e : a5 55 __ LDA T11 + 0 
1da0 : 69 30 __ ADC #$30
1da2 : 8d d2 9e STA $9ed2 ; (fail_msg[0] + 31)
1da5 : a0 21 __ LDY #$21
.s38:
1da7 : 84 49 __ STY T0 + 0 
1da9 : a9 50 __ LDA #$50
1dab : 99 b3 9e STA $9eb3,y ; (fail_msg[0] + 0)
1dae : 8a __ __ TXA
1daf : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1db2 : a6 49 __ LDX T0 + 0 
1db4 : 9d b4 9e STA $9eb4,x ; (fail_msg[0] + 1)
1db7 : a5 56 __ LDA T12 + 0 
1db9 : 29 0f __ AND #$0f
1dbb : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
1dbe : a6 49 __ LDX T0 + 0 
1dc0 : 9d b5 9e STA $9eb5,x ; (fail_msg[0] + 2)
1dc3 : a9 02 __ LDA #$02
1dc5 : 85 17 __ STA P10 
1dc7 : a9 00 __ LDA #$00
1dc9 : 9d b6 9e STA $9eb6,x ; (fail_msg[0] + 3)
1dcc : a9 9e __ LDA #$9e
1dce : a0 b3 __ LDY #$b3
1dd0 : 4c 6e 1d JMP $1d6e ; (sram_selftest.s34 + 0)
.s50:
1dd3 : a5 4e __ LDA T4 + 0 
1dd5 : 85 56 __ STA T12 + 0 
1dd7 : a5 52 __ LDA T8 + 0 
1dd9 : 85 55 __ STA T11 + 0 
1ddb : a9 01 __ LDA #$01
1ddd : 85 54 __ STA T10 + 0 
1ddf : 4c df 1c JMP $1cdf ; (sram_selftest.s23 + 0)
.s56:
1de2 : a9 62 __ LDA #$62
1de4 : 85 14 __ STA P7 
1de6 : a9 1a __ LDA #$1a
1de8 : 85 15 __ STA P8 
1dea : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1ded : ad fc 27 LDA $27fc ; (sram_status + 0)
1df0 : f0 03 __ BEQ $1df5 ; (sram_selftest.s57 + 0)
1df2 : 4c a8 1b JMP $1ba8 ; (sram_selftest.s7 + 0)
.s57:
1df5 : a9 0b __ LDA #$0b
1df7 : 85 16 __ STA P9 
1df9 : a9 02 __ LDA #$02
1dfb : 85 17 __ STA P10 
1dfd : a9 06 __ LDA #$06
1dff : 85 14 __ STA P7 
1e01 : a9 1e __ LDA #$1e
1e03 : 4c 7e 1b JMP $1b7e ; (sram_selftest.s63 + 0)
--------------------------------------------------------------------
1e06 : __ __ __ BYT 45 52 52 4f 52 3a 20 53 52 41 4d 20 4e 4f 54 20 : ERROR: SRAM NOT 
1e16 : __ __ __ BYT 50 52 45 53 45 4e 54 21 20 20 20 20 20 20 20 20 : PRESENT!        
1e26 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1e27 : __ __ __ BYT 45 52 52 4f 52 3a 20 45 45 50 52 4f 4d 20 4e 4f : ERROR: EEPROM NO
1e37 : __ __ __ BYT 54 20 50 52 45 53 45 4e 54 21 20 20 20 20 20 20 : T PRESENT!      
1e47 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1e48 : __ __ __ BYT 54 45 53 54 49 4e 47 20 42 41 4e 4b 00          : TESTING BANK.
--------------------------------------------------------------------
1e55 : __ __ __ BYT 45 52 52 4f 52 21 20 44 45 46 45 43 54 49 56 45 : ERROR! DEFECTIVE
1e65 : __ __ __ BYT 20 50 41 47 45 3a 20 20 20 20 20 20 20 20 20 20 :  PAGE:          
1e75 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
1e76 : __ __ __ BYT 54 45 53 54 20 50 41 53 53 45 44 21 20 53 52 41 : TEST PASSED! SRA
1e86 : __ __ __ BYT 4d 20 49 53 20 49 4e 54 41 43 54 2e 20 20 20 20 : M IS INTACT.    
1e96 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
show_prg_loader_screen: ; show_prg_loader_screen()->void
;2092, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
1e97 : a5 53 __ LDA T2 + 0 
1e99 : 8d b3 9f STA $9fb3 ; (show_prg_loader_screen@stack + 0)
1e9c : a5 54 __ LDA T4 + 0 
1e9e : 8d b4 9f STA $9fb4 ; (show_prg_loader_screen@stack + 1)
1ea1 : a5 55 __ LDA T5 + 0 
1ea3 : 8d b5 9f STA $9fb5 ; (show_prg_loader_screen@stack + 2)
.s4:
1ea6 : a9 0b __ LDA #$0b
1ea8 : 85 18 __ STA P11 
1eaa : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
1ead : a9 03 __ LDA #$03
1eaf : 85 16 __ STA P9 
1eb1 : a9 20 __ LDA #$20
1eb3 : 85 15 __ STA P8 
1eb5 : a9 07 __ LDA #$07
1eb7 : 85 17 __ STA P10 
1eb9 : a9 17 __ LDA #$17
1ebb : 85 14 __ STA P7 
1ebd : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1ec0 : a9 0b __ LDA #$0b
1ec2 : 85 16 __ STA P9 
1ec4 : a9 20 __ LDA #$20
1ec6 : 85 15 __ STA P8 
1ec8 : a9 03 __ LDA #$03
1eca : 85 17 __ STA P10 
1ecc : a9 2c __ LDA #$2c
1ece : 85 14 __ STA P7 
1ed0 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1ed3 : 20 41 20 JSR $2041 ; (read_prg_directory.s4 + 0)
1ed6 : a5 1b __ LDA ACCU + 0 
1ed8 : d0 27 __ BNE $1f01 ; (show_prg_loader_screen.s6 + 0)
.s5:
1eda : a9 0b __ LDA #$0b
1edc : 85 0d __ STA P0 
1ede : 85 0e __ STA P1 
1ee0 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
1ee3 : c6 17 __ DEC P10 
1ee5 : a9 64 __ LDA #$64
1ee7 : 85 14 __ STA P7 
1ee9 : a9 22 __ LDA #$22
1eeb : 85 15 __ STA P8 
1eed : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1ef0 : a9 0d __ LDA #$0d
1ef2 : 85 16 __ STA P9 
1ef4 : a9 07 __ LDA #$07
1ef6 : 85 17 __ STA P10 
1ef8 : a9 7c __ LDA #$7c
1efa : 85 14 __ STA P7 
1efc : a9 22 __ LDA #$22
1efe : 4c 17 1f JMP $1f17 ; (show_prg_loader_screen.s27 + 0)
.s6:
1f01 : ad fc 29 LDA $29fc ; (prg_count + 0)
1f04 : d0 40 __ BNE $1f46 ; (show_prg_loader_screen.s9 + 0)
.s7:
1f06 : a9 0b __ LDA #$0b
1f08 : 85 0d __ STA P0 
1f0a : 85 0e __ STA P1 
1f0c : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
1f0f : c6 17 __ DEC P10 
1f11 : a9 97 __ LDA #$97
1f13 : 85 14 __ STA P7 
1f15 : a9 22 __ LDA #$22
.s27:
1f17 : 85 15 __ STA P8 
1f19 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1f1c : a9 17 __ LDA #$17
1f1e : 85 16 __ STA P9 
1f20 : a9 0c __ LDA #$0c
1f22 : 85 15 __ STA P8 
1f24 : a9 01 __ LDA #$01
1f26 : 85 17 __ STA P10 
1f28 : a9 cc __ LDA #$cc
1f2a : 85 14 __ STA P7 
1f2c : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l8:
1f2f : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
1f32 : c9 0d __ CMP #$0d
1f34 : d0 f9 __ BNE $1f2f ; (show_prg_loader_screen.l8 + 0)
.s3:
1f36 : ad b3 9f LDA $9fb3 ; (show_prg_loader_screen@stack + 0)
1f39 : 85 53 __ STA T2 + 0 
1f3b : ad b4 9f LDA $9fb4 ; (show_prg_loader_screen@stack + 1)
1f3e : 85 54 __ STA T4 + 0 
1f40 : ad b5 9f LDA $9fb5 ; (show_prg_loader_screen@stack + 2)
1f43 : 85 55 __ STA T5 + 0 
1f45 : 60 __ __ RTS
.s9:
1f46 : 85 54 __ STA T4 + 0 
1f48 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
1f4b : a9 03 __ LDA #$03
1f4d : 85 16 __ STA P9 
1f4f : a9 20 __ LDA #$20
1f51 : 85 15 __ STA P8 
1f53 : a9 07 __ LDA #$07
1f55 : 85 17 __ STA P10 
1f57 : a9 17 __ LDA #$17
1f59 : 85 14 __ STA P7 
1f5b : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1f5e : a9 00 __ LDA #$00
1f60 : 8d fe 9f STA $9ffe ; (sstack + 0)
1f63 : 8d ff 9f STA $9fff ; (sstack + 1)
1f66 : 20 ab 22 JSR $22ab ; (draw_file_list.s4 + 0)
1f69 : a9 17 __ LDA #$17
1f6b : 85 16 __ STA P9 
1f6d : a9 25 __ LDA #$25
1f6f : 85 15 __ STA P8 
1f71 : a9 0d __ LDA #$0d
1f73 : 85 17 __ STA P10 
1f75 : a9 00 __ LDA #$00
1f77 : 85 14 __ STA P7 
1f79 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
1f7c : a9 00 __ LDA #$00
1f7e : 85 55 __ STA T5 + 0 
.l26:
1f80 : 85 53 __ STA T2 + 0 
.l10:
1f82 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
1f85 : 85 47 __ STA T3 + 0 
1f87 : aa __ __ TAX
1f88 : f0 f8 __ BEQ $1f82 ; (show_prg_loader_screen.l10 + 0)
.s11:
1f8a : c9 6d __ CMP #$6d
1f8c : f0 a8 __ BEQ $1f36 ; (show_prg_loader_screen.s3 + 0)
.s12:
1f8e : c9 4d __ CMP #$4d
1f90 : f0 a4 __ BEQ $1f36 ; (show_prg_loader_screen.s3 + 0)
.s13:
1f92 : c9 11 __ CMP #$11
1f94 : f0 4f __ BEQ $1fe5 ; (show_prg_loader_screen.s21 + 0)
.s14:
1f96 : c9 91 __ CMP #$91
1f98 : d0 3a __ BNE $1fd4 ; (show_prg_loader_screen.s15 + 0)
.s17:
1f9a : a5 55 __ LDA T5 + 0 
1f9c : f0 e4 __ BEQ $1f82 ; (show_prg_loader_screen.l10 + 0)
.s18:
1f9e : 85 14 __ STA P7 
1fa0 : c6 55 __ DEC T5 + 0 
1fa2 : a5 55 __ LDA T5 + 0 
1fa4 : c5 53 __ CMP T2 + 0 
1fa6 : b0 0e __ BCS $1fb6 ; (show_prg_loader_screen.s19 + 0)
.s20:
1fa8 : 8d fe 9f STA $9ffe ; (sstack + 0)
1fab : 8d ff 9f STA $9fff ; (sstack + 1)
1fae : 20 ab 22 JSR $22ab ; (draw_file_list.s4 + 0)
1fb1 : a5 55 __ LDA T5 + 0 
1fb3 : 4c 80 1f JMP $1f80 ; (show_prg_loader_screen.l26 + 0)
.s19:
1fb6 : a5 53 __ LDA T2 + 0 
1fb8 : 85 15 __ STA P8 
1fba : a9 00 __ LDA #$00
1fbc : 85 16 __ STA P9 
1fbe : 20 f9 22 JSR $22f9 ; (draw_file_item.s4 + 0)
1fc1 : a5 55 __ LDA T5 + 0 
1fc3 : 85 14 __ STA P7 
1fc5 : e6 16 __ INC P9 
1fc7 : 20 f9 22 JSR $22f9 ; (draw_file_item.s4 + 0)
1fca : a5 14 __ LDA P7 
1fcc : 85 18 __ STA P11 
1fce : 20 6c 24 JSR $246c ; (draw_scroll_pos.s4 + 0)
1fd1 : 4c 82 1f JMP $1f82 ; (show_prg_loader_screen.l10 + 0)
.s15:
1fd4 : a5 47 __ LDA T3 + 0 
1fd6 : c9 0d __ CMP #$0d
1fd8 : d0 a8 __ BNE $1f82 ; (show_prg_loader_screen.l10 + 0)
.s16:
1fda : a5 55 __ LDA T5 + 0 
1fdc : 8d fe 9f STA $9ffe ; (sstack + 0)
1fdf : 20 23 25 JSR $2523 ; (load_prg_to_sram.s4 + 0)
1fe2 : 4c 36 1f JMP $1f36 ; (show_prg_loader_screen.s3 + 0)
.s21:
1fe5 : 85 47 __ STA T3 + 0 
1fe7 : a5 54 __ LDA T4 + 0 
1fe9 : e9 01 __ SBC #$01
1feb : 90 e7 __ BCC $1fd4 ; (show_prg_loader_screen.s15 + 0)
.s25:
1fed : 85 45 __ STA T1 + 0 
1fef : a5 55 __ LDA T5 + 0 
1ff1 : c5 45 __ CMP T1 + 0 
1ff3 : b0 df __ BCS $1fd4 ; (show_prg_loader_screen.s15 + 0)
.s22:
1ff5 : 85 14 __ STA P7 
1ff7 : e6 55 __ INC T5 + 0 
1ff9 : a5 53 __ LDA T2 + 0 
1ffb : 69 0d __ ADC #$0d
1ffd : b0 b7 __ BCS $1fb6 ; (show_prg_loader_screen.s19 + 0)
.s24:
1fff : 85 45 __ STA T1 + 0 
2001 : a5 55 __ LDA T5 + 0 
2003 : c5 45 __ CMP T1 + 0 
2005 : 90 af __ BCC $1fb6 ; (show_prg_loader_screen.s19 + 0)
.s23:
2007 : 8d fe 9f STA $9ffe ; (sstack + 0)
200a : 69 f3 __ ADC #$f3
200c : 85 53 __ STA T2 + 0 
200e : 8d ff 9f STA $9fff ; (sstack + 1)
2011 : 20 ab 22 JSR $22ab ; (draw_file_list.s4 + 0)
2014 : 4c 82 1f JMP $1f82 ; (show_prg_loader_screen.l10 + 0)
--------------------------------------------------------------------
2017 : __ __ __ BYT 4c 4f 41 44 20 50 52 47 20 46 52 4f 4d 20 46 4c : LOAD PRG FROM FL
2027 : __ __ __ BYT 4f 50 50 59 00                                  : OPPY.
--------------------------------------------------------------------
202c : __ __ __ BYT 52 45 41 44 49 4e 47 20 44 49 52 45 43 54 4f 52 : READING DIRECTOR
203c : __ __ __ BYT 59 2e 2e 2e 00                                  : Y....
--------------------------------------------------------------------
read_prg_directory: ; read_prg_directory()->bool
;1771, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
2041 : a9 00 __ LDA #$00
2043 : 8d fc 29 STA $29fc ; (prg_count + 0)
2046 : a9 fd __ LDA #$fd
2048 : 85 0d __ STA P0 
204a : a9 18 __ LDA #$18
204c : 85 0e __ STA P1 
204e : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
2051 : a9 02 __ LDA #$02
2053 : 85 0d __ STA P0 
2055 : a9 00 __ LDA #$00
2057 : 85 0f __ STA P2 
2059 : a9 08 __ LDA #$08
205b : 85 0e __ STA P1 
205d : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
2060 : aa __ __ TAX
2061 : d0 03 __ BNE $2066 ; (read_prg_directory.s5 + 0)
2063 : 4c e0 21 JMP $21e0 ; (read_prg_directory.s3 + 0)
.s5:
2066 : a9 02 __ LDA #$02
2068 : 20 33 22 JSR $2233 ; (krnio_chkin.s4 + 0)
206b : aa __ __ TAX
206c : d0 03 __ BNE $2071 ; (read_prg_directory.s6 + 0)
206e : 4c e6 21 JMP $21e6 ; (read_prg_directory.s42 + 0)
.s6:
2071 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2074 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2077 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
207a : 29 82 __ AND #$82
207c : f0 03 __ BEQ $2081 ; (read_prg_directory.s7 + 0)
207e : 4c e3 21 JMP $21e3 ; (read_prg_directory.s41 + 0)
.s7:
2081 : a9 01 __ LDA #$01
.l43:
2083 : 85 4a __ STA T6 + 0 
.l8:
2085 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2088 : aa __ __ TAX
2089 : d0 03 __ BNE $208e ; (read_prg_directory.s10 + 0)
208b : 4c d6 21 JMP $21d6 ; (read_prg_directory.s9 + 0)
.s10:
208e : ad fc 29 LDA $29fc ; (prg_count + 0)
2091 : c9 1e __ CMP #$1e
2093 : b0 f6 __ BCS $208b ; (read_prg_directory.l8 + 6)
.s11:
2095 : 85 4b __ STA T7 + 0 
2097 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
209a : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
209d : 85 48 __ STA T5 + 0 
209f : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
20a2 : 85 49 __ STA T5 + 1 
20a4 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
20a7 : 29 82 __ AND #$82
20a9 : d0 e0 __ BNE $208b ; (read_prg_directory.l8 + 6)
.s12:
20ab : 85 47 __ STA T2 + 0 
.l13:
20ad : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
20b0 : 85 45 __ STA T1 + 0 
20b2 : aa __ __ TAX
20b3 : f0 16 __ BEQ $20cb ; (read_prg_directory.s14 + 0)
.s38:
20b5 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
20b8 : 29 82 __ AND #$82
20ba : d0 0f __ BNE $20cb ; (read_prg_directory.s14 + 0)
.s39:
20bc : a6 47 __ LDX T2 + 0 
20be : e0 27 __ CPX #$27
20c0 : b0 eb __ BCS $20ad ; (read_prg_directory.l13 + 0)
.s40:
20c2 : a5 45 __ LDA T1 + 0 
20c4 : 9d d6 9f STA $9fd6,x ; (buff[0] + 0)
20c7 : e6 47 __ INC T2 + 0 
20c9 : 90 e2 __ BCC $20ad ; (read_prg_directory.l13 + 0)
.s14:
20cb : a9 00 __ LDA #$00
20cd : a6 47 __ LDX T2 + 0 
20cf : 9d d6 9f STA $9fd6,x ; (buff[0] + 0)
20d2 : a5 4a __ LDA T6 + 0 
20d4 : f0 04 __ BEQ $20da ; (read_prg_directory.s15 + 0)
.s37:
20d6 : a9 00 __ LDA #$00
20d8 : f0 a9 __ BEQ $2083 ; (read_prg_directory.l43 + 0)
.s15:
20da : ae d6 9f LDX $9fd6 ; (buff[0] + 0)
20dd : f0 a6 __ BEQ $2085 ; (read_prg_directory.l8 + 0)
.s16:
20df : 85 43 __ STA T0 + 0 
20e1 : e0 22 __ CPX #$22
20e3 : f0 0d __ BEQ $20f2 ; (read_prg_directory.s18 + 0)
.l36:
20e5 : e6 43 __ INC T0 + 0 
20e7 : a4 43 __ LDY T0 + 0 
20e9 : be d6 9f LDX $9fd6,y ; (buff[0] + 0)
20ec : f0 97 __ BEQ $2085 ; (read_prg_directory.l8 + 0)
.s17:
20ee : e0 22 __ CPX #$22
20f0 : d0 f3 __ BNE $20e5 ; (read_prg_directory.l36 + 0)
.s18:
20f2 : a6 43 __ LDX T0 + 0 
20f4 : e8 __ __ INX
20f5 : 86 45 __ STX T1 + 0 
20f7 : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
20fa : f0 89 __ BEQ $2085 ; (read_prg_directory.l8 + 0)
.l19:
20fc : c9 22 __ CMP #$22
20fe : f0 03 __ BEQ $2103 ; (read_prg_directory.s20 + 0)
2100 : 4c cd 21 JMP $21cd ; (read_prg_directory.s35 + 0)
.s20:
2103 : 86 43 __ STX T0 + 0 
2105 : e8 __ __ INX
2106 : 86 47 __ STX T2 + 0 
2108 : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
210b : d0 03 __ BNE $2110 ; (read_prg_directory.l21 + 0)
210d : 4c 85 20 JMP $2085 ; (read_prg_directory.l8 + 0)
.l21:
2110 : c9 50 __ CMP #$50
2112 : d0 10 __ BNE $2124 ; (read_prg_directory.s22 + 0)
.s23:
2114 : a6 47 __ LDX T2 + 0 
2116 : bd d7 9f LDA $9fd7,x ; (buff[0] + 1)
2119 : c9 52 __ CMP #$52
211b : d0 07 __ BNE $2124 ; (read_prg_directory.s22 + 0)
.s24:
211d : bd d8 9f LDA $9fd8,x ; (buff[0] + 2)
2120 : c9 47 __ CMP #$47
2122 : f0 0b __ BEQ $212f ; (read_prg_directory.s25 + 0)
.s22:
2124 : e8 __ __ INX
2125 : 86 47 __ STX T2 + 0 
2127 : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
212a : d0 e4 __ BNE $2110 ; (read_prg_directory.l21 + 0)
212c : 4c 85 20 JMP $2085 ; (read_prg_directory.l8 + 0)
.s25:
212f : a0 00 __ LDY #$00
.l26:
2131 : 84 47 __ STY T2 + 0 
2133 : a5 45 __ LDA T1 + 0 
2135 : c5 43 __ CMP T0 + 0 
2137 : b0 2d __ BCS $2166 ; (read_prg_directory.s27 + 0)
.s33:
2139 : c0 10 __ CPY #$10
213b : b0 29 __ BCS $2166 ; (read_prg_directory.s27 + 0)
.s34:
213d : a5 4b __ LDA T7 + 0 
213f : 85 1b __ STA ACCU + 0 
2141 : a9 00 __ LDA #$00
2143 : 85 1c __ STA ACCU + 1 
2145 : a9 11 __ LDA #$11
2147 : 20 df 47 JSR $47df ; (mul16by8 + 0)
214a : 18 __ __ CLC
214b : a9 b9 __ LDA #$b9
214d : 65 1b __ ADC ACCU + 0 
214f : 85 1b __ STA ACCU + 0 
2151 : a9 49 __ LDA #$49
2153 : 65 1c __ ADC ACCU + 1 
2155 : 85 1c __ STA ACCU + 1 
2157 : a6 45 __ LDX T1 + 0 
2159 : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
215c : a4 47 __ LDY T2 + 0 
215e : 91 1b __ STA (ACCU + 0),y 
2160 : e6 45 __ INC T1 + 0 
2162 : c8 __ __ INY
2163 : 4c 31 21 JMP $2131 ; (read_prg_directory.l26 + 0)
.s27:
2166 : 98 __ __ TYA
2167 : f0 2b __ BEQ $2194 ; (read_prg_directory.s28 + 0)
.s29:
2169 : a5 4b __ LDA T7 + 0 
216b : 85 1b __ STA ACCU + 0 
216d : a9 00 __ LDA #$00
216f : 85 1c __ STA ACCU + 1 
2171 : a9 11 __ LDA #$11
2173 : 20 df 47 JSR $47df ; (mul16by8 + 0)
2176 : 18 __ __ CLC
2177 : a9 b9 __ LDA #$b9
2179 : 65 1b __ ADC ACCU + 0 
217b : 85 43 __ STA T0 + 0 
217d : a9 49 __ LDA #$49
217f : 65 1c __ ADC ACCU + 1 
2181 : 85 44 __ STA T0 + 1 
.l30:
2183 : a4 47 __ LDY T2 + 0 
2185 : 88 __ __ DEY
2186 : b1 43 __ LDA (T0 + 0),y 
2188 : c9 a0 __ CMP #$a0
218a : f0 04 __ BEQ $2190 ; (read_prg_directory.s32 + 0)
.s31:
218c : c9 20 __ CMP #$20
218e : d0 04 __ BNE $2194 ; (read_prg_directory.s28 + 0)
.s32:
2190 : c6 47 __ DEC T2 + 0 
2192 : d0 ef __ BNE $2183 ; (read_prg_directory.l30 + 0)
.s28:
2194 : a5 4b __ LDA T7 + 0 
2196 : 85 43 __ STA T0 + 0 
2198 : 85 1b __ STA ACCU + 0 
219a : a9 00 __ LDA #$00
219c : 85 1c __ STA ACCU + 1 
219e : a9 11 __ LDA #$11
21a0 : 20 df 47 JSR $47df ; (mul16by8 + 0)
21a3 : 18 __ __ CLC
21a4 : a9 b9 __ LDA #$b9
21a6 : 65 1b __ ADC ACCU + 0 
21a8 : 85 45 __ STA T1 + 0 
21aa : a9 49 __ LDA #$49
21ac : 65 1c __ ADC ACCU + 1 
21ae : 85 46 __ STA T1 + 1 
21b0 : a9 00 __ LDA #$00
21b2 : a4 47 __ LDY T2 + 0 
21b4 : 91 45 __ STA (T1 + 0),y 
21b6 : 06 43 __ ASL T0 + 0 
21b8 : a5 48 __ LDA T5 + 0 
21ba : a6 43 __ LDX T0 + 0 
21bc : 9d b7 4b STA $4bb7,x ; (prg_blocks_arr[0] + 0)
21bf : a5 49 __ LDA T5 + 1 
21c1 : 9d b8 4b STA $4bb8,x ; (prg_blocks_arr[0] + 1)
21c4 : a6 4b __ LDX T7 + 0 
21c6 : e8 __ __ INX
21c7 : 8e fc 29 STX $29fc ; (prg_count + 0)
21ca : 4c 85 20 JMP $2085 ; (read_prg_directory.l8 + 0)
.s35:
21cd : e8 __ __ INX
21ce : bd d6 9f LDA $9fd6,x ; (buff[0] + 0)
21d1 : f0 f7 __ BEQ $21ca ; (read_prg_directory.s28 + 54)
21d3 : 4c fc 20 JMP $20fc ; (read_prg_directory.l19 + 0)
.s9:
21d6 : 20 fc 1a JSR $1afc ; (krnio_clrchn.s4 + 0)
21d9 : a9 02 __ LDA #$02
21db : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
21de : a9 01 __ LDA #$01
.s3:
21e0 : 85 1b __ STA ACCU + 0 
21e2 : 60 __ __ RTS
.s41:
21e3 : 20 fc 1a JSR $1afc ; (krnio_clrchn.s4 + 0)
.s42:
21e6 : a9 02 __ LDA #$02
21e8 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
21eb : a9 00 __ LDA #$00
21ed : f0 f1 __ BEQ $21e0 ; (read_prg_directory.s3 + 0)
--------------------------------------------------------------------
krnio_setnam: ; krnio_setnam(const u8*)->void
;  29, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
21ef : a5 0d __ LDA P0 
21f1 : 05 0e __ ORA P1 
21f3 : f0 08 __ BEQ $21fd ; (krnio_setnam.s4 + 14)
21f5 : a0 ff __ LDY #$ff
21f7 : c8 __ __ INY
21f8 : b1 0d __ LDA (P0),y 
21fa : d0 fb __ BNE $21f7 ; (krnio_setnam.s4 + 8)
21fc : 98 __ __ TYA
21fd : a6 0d __ LDX P0 
21ff : a4 0e __ LDY P1 
2201 : 20 bd ff JSR $ffbd 
.s3:
2204 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_open: ; krnio_open(u8,u8,u8)->bool
;  35, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
2205 : a9 00 __ LDA #$00
2207 : a6 0d __ LDX P0 ; (fnum + 0)
2209 : 9d a9 49 STA $49a9,x ; (krnio_pstatus[0] + 0)
220c : a9 00 __ LDA #$00
220e : 85 1b __ STA ACCU + 0 
2210 : 85 1c __ STA ACCU + 1 
2212 : a5 0d __ LDA P0 ; (fnum + 0)
2214 : a6 0e __ LDX P1 
2216 : a4 0f __ LDY P2 
2218 : 20 ba ff JSR $ffba 
221b : 20 c0 ff JSR $ffc0 
221e : 90 08 __ BCC $2228 ; (krnio_open.s4 + 35)
2220 : a5 0d __ LDA P0 ; (fnum + 0)
2222 : 20 c3 ff JSR $ffc3 
2225 : 4c 2c 22 JMP $222c ; (krnio_open.s4 + 39)
2228 : a9 01 __ LDA #$01
222a : 85 1b __ STA ACCU + 0 
222c : a5 1b __ LDA ACCU + 0 
222e : f0 02 __ BEQ $2232 ; (krnio_open.s3 + 0)
.s5:
2230 : a9 01 __ LDA #$01
.s3:
2232 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_chkin: ; krnio_chkin(u8)->bool
;  55, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
2233 : 85 0d __ STA P0 
2235 : a6 0d __ LDX P0 
2237 : 20 c6 ff JSR $ffc6 
223a : a9 00 __ LDA #$00
223c : 2a __ __ ROL
223d : 49 01 __ EOR #$01
223f : 85 1b __ STA ACCU + 0 
2241 : a5 1b __ LDA ACCU + 0 
2243 : f0 02 __ BEQ $2247 ; (krnio_chkin.s3 + 0)
.s5:
2245 : a9 01 __ LDA #$01
.s3:
2247 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_close: ; krnio_close(u8)->void
;  39, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
2248 : 85 0d __ STA P0 
224a : a5 0d __ LDA P0 
224c : 20 c3 ff JSR $ffc3 
.s3:
224f : 60 __ __ RTS
--------------------------------------------------------------------
krnio_chrin: ; krnio_chrin()->u8
;  67, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
2250 : 20 cf ff JSR $ffcf 
2253 : 85 1b __ STA ACCU + 0 
.s3:
2255 : a5 1b __ LDA ACCU + 0 
2257 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_status: ; krnio_status()->enum krnioerr
;  43, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
2258 : 20 b7 ff JSR $ffb7 
225b : 85 1b __ STA ACCU + 0 
225d : a9 00 __ LDA #$00
225f : 85 1c __ STA ACCU + 1 
.s3:
2261 : a5 1b __ LDA ACCU + 0 
2263 : 60 __ __ RTS
--------------------------------------------------------------------
2264 : __ __ __ BYT 45 52 52 4f 52 20 41 43 43 45 53 53 49 4e 47 20 : ERROR ACCESSING 
2274 : __ __ __ BYT 55 4e 49 54 20 38 21 00                         : UNIT 8!.
--------------------------------------------------------------------
227c : __ __ __ BYT 43 48 45 43 4b 20 55 4e 49 54 20 41 4e 44 20 46 : CHECK UNIT AND F
228c : __ __ __ BYT 4c 4f 50 50 59 20 44 49 53 4b 00                : LOPPY DISK.
--------------------------------------------------------------------
2297 : __ __ __ BYT 4e 4f 20 50 52 47 20 46 49 4c 45 53 20 46 4f 55 : NO PRG FILES FOU
22a7 : __ __ __ BYT 4e 44 21 00                                     : ND!.
--------------------------------------------------------------------
draw_file_list: ; draw_file_list(u8,u8)->void
;1925, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
22ab : ad ff 9f LDA $9fff ; (sstack + 1)
22ae : 85 4e __ STA T3 + 0 
22b0 : 85 4c __ STA T1 + 0 
22b2 : ad fc 29 LDA $29fc ; (prg_count + 0)
22b5 : 85 4f __ STA T4 + 0 
22b7 : a9 00 __ LDA #$00
22b9 : 85 4d __ STA T2 + 0 
.l5:
22bb : a5 4c __ LDA T1 + 0 
22bd : c5 4f __ CMP T4 + 0 
22bf : 90 10 __ BCC $22d1 ; (draw_file_list.s6 + 0)
.s12:
22c1 : a9 0b __ LDA #$0b
22c3 : 85 0e __ STA P1 
22c5 : a5 4d __ LDA T2 + 0 
22c7 : 69 06 __ ADC #$06
22c9 : 85 0d __ STA P0 
22cb : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
22ce : 4c e7 22 JMP $22e7 ; (draw_file_list.s10 + 0)
.s6:
22d1 : 85 14 __ STA P7 
22d3 : a6 4e __ LDX T3 + 0 
22d5 : 86 15 __ STX P8 
22d7 : cd fe 9f CMP $9ffe ; (sstack + 0)
22da : d0 04 __ BNE $22e0 ; (draw_file_list.s8 + 0)
.s7:
22dc : a9 01 __ LDA #$01
22de : d0 02 __ BNE $22e2 ; (draw_file_list.s9 + 0)
.s8:
22e0 : a9 00 __ LDA #$00
.s9:
22e2 : 85 16 __ STA P9 
22e4 : 20 f9 22 JSR $22f9 ; (draw_file_item.s4 + 0)
.s10:
22e7 : e6 4c __ INC T1 + 0 
22e9 : e6 4d __ INC T2 + 0 
22eb : a5 4d __ LDA T2 + 0 
22ed : c9 0d __ CMP #$0d
22ef : d0 ca __ BNE $22bb ; (draw_file_list.l5 + 0)
.s11:
22f1 : ad fe 9f LDA $9ffe ; (sstack + 0)
22f4 : 85 18 __ STA P11 
22f6 : 4c 6c 24 JMP $246c ; (draw_scroll_pos.s4 + 0)
--------------------------------------------------------------------
draw_file_item: ; draw_file_item(u8,u8,bool)->void
;1893, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
22f9 : a5 14 __ LDA P7 ; (file_idx + 0)
22fb : c5 15 __ CMP P8 ; (scroll_offset + 0)
22fd : 90 17 __ BCC $2316 ; (draw_file_item.s3 + 0)
.s5:
22ff : a5 15 __ LDA P8 ; (scroll_offset + 0)
2301 : 69 0c __ ADC #$0c
2303 : 90 04 __ BCC $2309 ; (draw_file_item.s16 + 0)
.s17:
2305 : a5 14 __ LDA P7 ; (file_idx + 0)
2307 : b0 08 __ BCS $2311 ; (draw_file_item.s6 + 0)
.s16:
2309 : 85 43 __ STA T1 + 0 
230b : a5 14 __ LDA P7 ; (file_idx + 0)
230d : c5 43 __ CMP T1 + 0 
230f : b0 05 __ BCS $2316 ; (draw_file_item.s3 + 0)
.s6:
2311 : cd fc 29 CMP $29fc ; (prg_count + 0)
2314 : 90 01 __ BCC $2317 ; (draw_file_item.s7 + 0)
.s3:
2316 : 60 __ __ RTS
.s7:
2317 : 38 __ __ SEC
2318 : e5 15 __ SBC P8 ; (scroll_offset + 0)
231a : 18 __ __ CLC
231b : 69 07 __ ADC #$07
231d : 85 0d __ STA P0 
231f : a9 0b __ LDA #$0b
2321 : 85 0e __ STA P1 
2323 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
2326 : a5 0d __ LDA P0 
2328 : 85 11 __ STA P4 
232a : a9 01 __ LDA #$01
232c : 85 12 __ STA P5 
232e : a5 16 __ LDA P9 ; (is_sel + 0)
2330 : f0 12 __ BEQ $2344 ; (draw_file_item.s8 + 0)
.s15:
2332 : a9 07 __ LDA #$07
2334 : 85 13 __ STA P6 
2336 : 85 49 __ STA T0 + 0 
2338 : a9 e6 __ LDA #$e6
233a : 85 0f __ STA P2 
233c : a9 23 __ LDA #$23
233e : 85 10 __ STA P3 
2340 : a9 03 __ LDA #$03
2342 : d0 10 __ BNE $2354 ; (draw_file_item.s9 + 0)
.s8:
2344 : a9 01 __ LDA #$01
2346 : 85 13 __ STA P6 
2348 : 85 49 __ STA T0 + 0 
234a : a9 e8 __ LDA #$e8
234c : 85 0f __ STA P2 
234e : a9 23 __ LDA #$23
2350 : 85 10 __ STA P3 
2352 : a9 0f __ LDA #$0f
.s9:
2354 : 85 4b __ STA T4 + 0 
2356 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
2359 : a5 49 __ LDA T0 + 0 
235b : 85 13 __ STA P6 
235d : a9 03 __ LDA #$03
235f : 85 12 __ STA P5 
2361 : a5 14 __ LDA P7 ; (file_idx + 0)
2363 : 85 1b __ STA ACCU + 0 
2365 : a9 00 __ LDA #$00
2367 : 85 1c __ STA ACCU + 1 
2369 : a9 11 __ LDA #$11
236b : 20 df 47 JSR $47df ; (mul16by8 + 0)
236e : 18 __ __ CLC
236f : a9 b9 __ LDA #$b9
2371 : 65 1b __ ADC ACCU + 0 
2373 : 85 0f __ STA P2 
2375 : a9 49 __ LDA #$49
2377 : 65 1c __ ADC ACCU + 1 
2379 : 85 10 __ STA P3 
237b : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
237e : a5 14 __ LDA P7 ; (file_idx + 0)
2380 : 0a __ __ ASL
2381 : aa __ __ TAX
2382 : bd b7 4b LDA $4bb7,x ; (prg_blocks_arr[0] + 0)
2385 : 85 0d __ STA P0 
2387 : bd b8 4b LDA $4bb8,x ; (prg_blocks_arr[0] + 1)
238a : 85 0e __ STA P1 
238c : a9 ee __ LDA #$ee
238e : 85 0f __ STA P2 
2390 : a9 9f __ LDA #$9f
2392 : 85 10 __ STA P3 
2394 : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
2397 : a9 ee __ LDA #$ee
2399 : 85 0d __ STA P0 
239b : a9 9f __ LDA #$9f
239d : 85 0e __ STA P1 
239f : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
23a2 : a5 1b __ LDA ACCU + 0 
23a4 : 85 49 __ STA T0 + 0 
23a6 : a5 1c __ LDA ACCU + 1 
23a8 : 85 4a __ STA T0 + 1 
23aa : a9 00 __ LDA #$00
23ac : 85 43 __ STA T1 + 0 
23ae : a2 20 __ LDX #$20
.l10:
23b0 : a5 4a __ LDA T0 + 1 
23b2 : 30 08 __ BMI $23bc ; (draw_file_item.s12 + 0)
.s14:
23b4 : d0 1b __ BNE $23d1 ; (draw_file_item.s11 + 0)
.s13:
23b6 : a5 49 __ LDA T0 + 0 
23b8 : c9 09 __ CMP #$09
23ba : b0 15 __ BCS $23d1 ; (draw_file_item.s11 + 0)
.s12:
23bc : 8a __ __ TXA
23bd : a6 49 __ LDX T0 + 0 
23bf : 9d ee 9f STA $9fee,x ; (blk_str[0] + 0)
23c2 : a9 00 __ LDA #$00
23c4 : e6 49 __ INC T0 + 0 
23c6 : 85 4a __ STA T0 + 1 
23c8 : e6 43 __ INC T1 + 0 
23ca : a4 43 __ LDY T1 + 0 
23cc : be 67 24 LDX $2467,y 
23cf : d0 df __ BNE $23b0 ; (draw_file_item.l10 + 0)
.s11:
23d1 : a5 4b __ LDA T4 + 0 
23d3 : 85 13 __ STA P6 
23d5 : a9 00 __ LDA #$00
23d7 : a6 49 __ LDX T0 + 0 
23d9 : 9d ee 9f STA $9fee,x ; (blk_str[0] + 0)
23dc : 38 __ __ SEC
23dd : a9 27 __ LDA #$27
23df : e5 49 __ SBC T0 + 0 
23e1 : 85 12 __ STA P5 
23e3 : 4c 1e 0b JMP $0b1e ; (print_at.s4 + 0)
--------------------------------------------------------------------
23e6 : __ __ __ BYT 3e 00                                           : >.
--------------------------------------------------------------------
23e8 : __ __ __ BYT 20 00                                           :  .
--------------------------------------------------------------------
uint16_to_str: ; uint16_to_str(u16,u8*)->void
; 121, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
23ea : a5 0e __ LDA P1 ; (val + 1)
23ec : 05 0d __ ORA P0 ; (val + 0)
23ee : d0 1a __ BNE $240a ; (uint16_to_str.s5 + 0)
.s11:
23f0 : a9 30 __ LDA #$30
23f2 : a0 00 __ LDY #$00
23f4 : 84 44 __ STY T1 + 1 
23f6 : 91 0f __ STA (P2),y ; (buf + 0)
23f8 : a9 01 __ LDA #$01
.s8:
23fa : 85 0d __ STA P0 ; (val + 0)
23fc : 18 __ __ CLC
23fd : a5 10 __ LDA P3 ; (buf + 1)
23ff : 65 44 __ ADC T1 + 1 
2401 : 85 0e __ STA P1 ; (val + 1)
2403 : a9 00 __ LDA #$00
2405 : a4 0f __ LDY P2 ; (buf + 0)
2407 : 91 0d __ STA (P0),y ; (val + 0)
.s3:
2409 : 60 __ __ RTS
.s5:
240a : a9 00 __ LDA #$00
240c : 85 43 __ STA T1 + 0 
240e : 85 44 __ STA T1 + 1 
2410 : 85 45 __ STA T2 + 0 
2412 : f0 27 __ BEQ $243b ; (uint16_to_str.l6 + 0)
.s10:
2414 : a5 0d __ LDA P0 ; (val + 0)
2416 : 85 1b __ STA ACCU + 0 
2418 : a5 0e __ LDA P1 ; (val + 1)
241a : 85 1c __ STA ACCU + 1 
241c : a9 0a __ LDA #$0a
241e : 85 03 __ STA WORK + 0 
2420 : a9 00 __ LDA #$00
2422 : 85 04 __ STA WORK + 1 
2424 : 20 4d 48 JSR $484d ; (divmod + 0)
2427 : a5 1b __ LDA ACCU + 0 
2429 : 85 0d __ STA P0 ; (val + 0)
242b : a5 1c __ LDA ACCU + 1 
242d : 85 0e __ STA P1 ; (val + 1)
242f : 18 __ __ CLC
2430 : a5 05 __ LDA WORK + 2 
2432 : 69 30 __ ADC #$30
2434 : a6 45 __ LDX T2 + 0 
2436 : 9d f8 9f STA $9ff8,x ; (temp[0] + 0)
2439 : e6 45 __ INC T2 + 0 
.l6:
243b : a5 0d __ LDA P0 ; (val + 0)
243d : 05 0e __ ORA P1 ; (val + 1)
243f : d0 d3 __ BNE $2414 ; (uint16_to_str.s10 + 0)
.s7:
2441 : a6 45 __ LDX T2 + 0 
2443 : f0 1d __ BEQ $2462 ; (uint16_to_str.s17 + 0)
.s9:
2445 : a5 10 __ LDA P3 ; (buf + 1)
2447 : 85 0e __ STA P1 ; (val + 1)
2449 : a9 00 __ LDA #$00
244b : 85 0d __ STA P0 ; (val + 0)
244d : a4 0f __ LDY P2 ; (buf + 0)
.l12:
244f : bd f7 9f LDA $9ff7,x ; (zero_buf[0] + 249)
2452 : 91 0d __ STA (P0),y ; (val + 0)
2454 : e6 43 __ INC T1 + 0 
2456 : d0 02 __ BNE $245a ; (uint16_to_str.s14 + 0)
.s13:
2458 : e6 44 __ INC T1 + 1 
.s14:
245a : c8 __ __ INY
245b : d0 02 __ BNE $245f ; (uint16_to_str.s16 + 0)
.s15:
245d : e6 0e __ INC P1 ; (val + 1)
.s16:
245f : ca __ __ DEX
2460 : d0 ed __ BNE $244f ; (uint16_to_str.l12 + 0)
.s17:
2462 : a5 43 __ LDA T1 + 0 
2464 : 4c fa 23 JMP $23fa ; (uint16_to_str.s8 + 0)
--------------------------------------------------------------------
2467 : __ __ __ BYT 20 42 4c 4b 00                                  :  BLK.
--------------------------------------------------------------------
draw_scroll_pos: ; draw_scroll_pos(u8)->void
;1872, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
246c : a9 15 __ LDA #$15
246e : 85 0d __ STA P0 
2470 : a9 0b __ LDA #$0b
2472 : 85 0e __ STA P1 
2474 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
2477 : ad fc 29 LDA $29fc ; (prg_count + 0)
247a : c9 0e __ CMP #$0e
247c : b0 01 __ BCS $247f ; (draw_scroll_pos.s5 + 0)
.s3:
247e : 60 __ __ RTS
.s5:
247f : 85 4a __ STA T4 + 0 
2481 : a5 18 __ LDA P11 ; (selected + 0)
2483 : 69 00 __ ADC #$00
2485 : 85 0d __ STA P0 
2487 : a9 00 __ LDA #$00
2489 : 2a __ __ ROL
248a : 85 0e __ STA P1 
248c : a9 e8 __ LDA #$e8
248e : 85 0f __ STA P2 
2490 : a9 9f __ LDA #$9f
2492 : 85 10 __ STA P3 
2494 : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
2497 : a9 00 __ LDA #$00
2499 : 85 49 __ STA T3 + 0 
249b : 85 43 __ STA T0 + 0 
249d : f0 09 __ BEQ $24a8 ; (draw_scroll_pos.l6 + 0)
.s10:
249f : a6 49 __ LDX T3 + 0 
24a1 : 9d ee 9f STA $9fee,x ; (pos_str[0] + 0)
24a4 : e6 43 __ INC T0 + 0 
24a6 : e6 49 __ INC T3 + 0 
.l6:
24a8 : a6 43 __ LDX T0 + 0 
24aa : bd e8 9f LDA $9fe8,x ; (num[0] + 0)
24ad : d0 f0 __ BNE $249f ; (draw_scroll_pos.s10 + 0)
.s7:
24af : a9 2f __ LDA #$2f
24b1 : a6 49 __ LDX T3 + 0 
24b3 : 9d ee 9f STA $9fee,x ; (pos_str[0] + 0)
24b6 : a5 4a __ LDA T4 + 0 
24b8 : 85 0d __ STA P0 
24ba : a9 00 __ LDA #$00
24bc : 85 0e __ STA P1 
24be : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
24c1 : a6 49 __ LDX T3 + 0 
24c3 : e8 __ __ INX
24c4 : 86 43 __ STX T0 + 0 
24c6 : ad e8 9f LDA $9fe8 ; (num[0] + 0)
24c9 : f0 14 __ BEQ $24df ; (draw_scroll_pos.s8 + 0)
.s9:
24cb : a2 00 __ LDX #$00
24cd : 86 45 __ STX T1 + 0 
.l11:
24cf : a6 43 __ LDX T0 + 0 
24d1 : 9d ee 9f STA $9fee,x ; (pos_str[0] + 0)
24d4 : e6 43 __ INC T0 + 0 
24d6 : e6 45 __ INC T1 + 0 
24d8 : a6 45 __ LDX T1 + 0 
24da : bd e8 9f LDA $9fe8,x ; (num[0] + 0)
24dd : d0 f0 __ BNE $24cf ; (draw_scroll_pos.l11 + 0)
.s8:
24df : a6 43 __ LDX T0 + 0 
24e1 : 9d ee 9f STA $9fee,x ; (pos_str[0] + 0)
24e4 : a9 15 __ LDA #$15
24e6 : 85 16 __ STA P9 
24e8 : a9 0f __ LDA #$0f
24ea : 85 17 __ STA P10 
24ec : a9 ee __ LDA #$ee
24ee : 85 14 __ STA P7 
24f0 : a9 9f __ LDA #$9f
24f2 : 85 15 __ STA P8 
24f4 : 4c 7e 0a JMP $0a7e ; (print_centered.s4 + 0)
--------------------------------------------------------------------
24f7 : __ __ __ BYT 55 4e 4b 4e 4f 57 4e 00                         : UNKNOWN.
--------------------------------------------------------------------
mdp_ctrl_shadow:
24ff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
2500 : __ __ __ BYT 43 55 52 53 4f 52 3a 4e 41 56 49 47 41 54 45 20 : CURSOR:NAVIGATE 
2510 : __ __ __ BYT 52 45 54 55 52 4e 3a 4c 4f 41 44 20 4d 3a 4d 45 : RETURN:LOAD M:ME
2520 : __ __ __ BYT 4e 55 00                                        : NU.
--------------------------------------------------------------------
load_prg_to_sram: ; load_prg_to_sram(u8)->void
;1941, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
2523 : a9 0b __ LDA #$0b
2525 : 85 18 __ STA P11 
2527 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
252a : a9 03 __ LDA #$03
252c : 85 16 __ STA P9 
252e : a9 20 __ LDA #$20
2530 : 85 15 __ STA P8 
2532 : a9 07 __ LDA #$07
2534 : 85 17 __ STA P10 
2536 : a9 17 __ LDA #$17
2538 : 85 14 __ STA P7 
253a : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
253d : a9 0b __ LDA #$0b
253f : 85 16 __ STA P9 
2541 : ad fc 27 LDA $27fc ; (sram_status + 0)
2544 : d0 2a __ BNE $2570 ; (load_prg_to_sram.s6 + 0)
.s5:
2546 : a9 02 __ LDA #$02
2548 : 85 17 __ STA P10 
254a : a9 06 __ LDA #$06
254c : 85 14 __ STA P7 
254e : a9 1e __ LDA #$1e
.s42:
2550 : 85 15 __ STA P8 
2552 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s41:
2555 : a9 17 __ LDA #$17
2557 : 85 16 __ STA P9 
2559 : a9 0c __ LDA #$0c
255b : 85 15 __ STA P8 
255d : a9 01 __ LDA #$01
255f : 85 17 __ STA P10 
2561 : a9 cc __ LDA #$cc
2563 : 85 14 __ STA P7 
2565 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l24:
2568 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
256b : c9 0d __ CMP #$0d
256d : d0 f9 __ BNE $2568 ; (load_prg_to_sram.l24 + 0)
.s3:
256f : 60 __ __ RTS
.s6:
2570 : a9 03 __ LDA #$03
2572 : 85 17 __ STA P10 
2574 : a9 27 __ LDA #$27
2576 : 85 15 __ STA P8 
2578 : a9 98 __ LDA #$98
257a : 85 14 __ STA P7 
257c : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
257f : ad fe 9f LDA $9ffe ; (sstack + 0)
2582 : 85 1b __ STA ACCU + 0 
2584 : a9 00 __ LDA #$00
2586 : 85 43 __ STA T0 + 0 
2588 : 85 1c __ STA ACCU + 1 
258a : a9 11 __ LDA #$11
258c : 20 df 47 JSR $47df ; (mul16by8 + 0)
258f : 18 __ __ CLC
2590 : a9 b9 __ LDA #$b9
2592 : 65 1b __ ADC ACCU + 0 
2594 : 85 49 __ STA T1 + 0 
2596 : a9 49 __ LDA #$49
2598 : 65 1c __ ADC ACCU + 1 
259a : 85 4a __ STA T1 + 1 
259c : a0 00 __ LDY #$00
259e : b1 49 __ LDA (T1 + 0),y 
25a0 : f0 11 __ BEQ $25b3 ; (load_prg_to_sram.s7 + 0)
.s37:
25a2 : a2 00 __ LDX #$00
.l39:
25a4 : 9d e2 9f STA $9fe2,x ; (open_name[0] + 0)
25a7 : e8 __ __ INX
25a8 : c8 __ __ INY
25a9 : b1 49 __ LDA (T1 + 0),y 
25ab : f0 04 __ BEQ $25b1 ; (load_prg_to_sram.s43 + 0)
.s38:
25ad : e0 10 __ CPX #$10
25af : 90 f3 __ BCC $25a4 ; (load_prg_to_sram.l39 + 0)
.s43:
25b1 : 86 43 __ STX T0 + 0 
.s7:
25b3 : a9 2c __ LDA #$2c
25b5 : a6 43 __ LDX T0 + 0 
25b7 : 9d e2 9f STA $9fe2,x ; (open_name[0] + 0)
25ba : a9 50 __ LDA #$50
25bc : 9d e3 9f STA $9fe3,x ; (open_name[0] + 1)
25bf : a9 2c __ LDA #$2c
25c1 : 9d e4 9f STA $9fe4,x ; (open_name[0] + 2)
25c4 : a9 52 __ LDA #$52
25c6 : 9d e5 9f STA $9fe5,x ; (open_name[0] + 3)
25c9 : a9 00 __ LDA #$00
25cb : 9d e6 9f STA $9fe6,x ; (open_name[0] + 4)
25ce : a9 e2 __ LDA #$e2
25d0 : 85 0d __ STA P0 
25d2 : a9 9f __ LDA #$9f
25d4 : 85 0e __ STA P1 
25d6 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
25d9 : a9 03 __ LDA #$03
25db : 85 0d __ STA P0 
25dd : 85 0f __ STA P2 
25df : a9 08 __ LDA #$08
25e1 : 85 0e __ STA P1 
25e3 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
25e6 : aa __ __ TAX
25e7 : d0 37 __ BNE $2620 ; (load_prg_to_sram.s10 + 0)
.s8:
25e9 : c6 17 __ DEC P10 
25eb : a9 0d __ LDA #$0d
25ed : 85 16 __ STA P9 
25ef : a9 a3 __ LDA #$a3
25f1 : 85 14 __ STA P7 
25f3 : a9 27 __ LDA #$27
25f5 : 85 15 __ STA P8 
25f7 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
25fa : a9 ff __ LDA #$ff
25fc : 85 0d __ STA P0 
25fe : a9 0d __ LDA #$0d
2600 : 85 0e __ STA P1 
2602 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
2605 : a9 0f __ LDA #$0f
2607 : 85 0d __ STA P0 
2609 : 85 0f __ STA P2 
260b : a9 08 __ LDA #$08
260d : 85 0e __ STA P1 
260f : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
2612 : aa __ __ TAX
2613 : d0 03 __ BNE $2618 ; (load_prg_to_sram.s9 + 0)
2615 : 4c 55 25 JMP $2555 ; (load_prg_to_sram.s41 + 0)
.s9:
2618 : a9 0f __ LDA #$0f
261a : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
261d : 4c 55 25 JMP $2555 ; (load_prg_to_sram.s41 + 0)
.s10:
2620 : a9 03 __ LDA #$03
2622 : 20 33 22 JSR $2233 ; (krnio_chkin.s4 + 0)
2625 : aa __ __ TAX
2626 : d0 14 __ BNE $263c ; (load_prg_to_sram.s12 + 0)
.s11:
2628 : a9 03 __ LDA #$03
262a : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
262d : c6 17 __ DEC P10 
262f : a9 0d __ LDA #$0d
2631 : 85 16 __ STA P9 
2633 : a9 bf __ LDA #$bf
2635 : 85 14 __ STA P7 
2637 : a9 27 __ LDA #$27
2639 : 4c 50 25 JMP $2550 ; (load_prg_to_sram.s42 + 0)
.s12:
263c : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
263f : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2642 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
2645 : 85 4d __ STA T5 + 0 
2647 : a9 00 __ LDA #$00
2649 : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
264c : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
264f : a9 00 __ LDA #$00
2651 : 8d 01 de STA $de01 
2654 : 85 4e __ STA T6 + 0 
2656 : 85 4f __ STA T7 + 0 
2658 : 85 50 __ STA T8 + 0 
265a : 85 4b __ STA T2 + 0 
265c : 85 4c __ STA T2 + 1 
265e : a9 01 __ LDA #$01
2660 : 85 51 __ STA T9 + 0 
.l13:
2662 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2665 : 85 49 __ STA T1 + 0 
2667 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
266a : 85 1b __ STA ACCU + 0 
266c : 29 82 __ AND #$82
266e : f0 04 __ BEQ $2674 ; (load_prg_to_sram.s14 + 0)
.s36:
2670 : c6 51 __ DEC T9 + 0 
2672 : f0 38 __ BEQ $26ac ; (load_prg_to_sram.s20 + 0)
.s14:
2674 : a5 49 __ LDA T1 + 0 
2676 : a6 4f __ LDX T7 + 0 
2678 : 9d 00 df STA $df00,x 
267b : a5 1b __ LDA ACCU + 0 
267d : 29 40 __ AND #$40
267f : 85 52 __ STA T10 + 0 
2681 : e6 4f __ INC T7 + 0 
2683 : d0 23 __ BNE $26a8 ; (load_prg_to_sram.s19 + 0)
.s15:
2685 : e6 4b __ INC T2 + 0 
2687 : d0 02 __ BNE $268b ; (load_prg_to_sram.s46 + 0)
.s45:
2689 : e6 4c __ INC T2 + 1 
.s46:
268b : e6 4e __ INC T6 + 0 
268d : d0 0d __ BNE $269c ; (load_prg_to_sram.s18 + 0)
.s16:
268f : e6 50 __ INC T8 + 0 
2691 : a5 50 __ LDA T8 + 0 
2693 : c9 02 __ CMP #$02
2695 : b0 15 __ BCS $26ac ; (load_prg_to_sram.s20 + 0)
.s17:
2697 : a9 01 __ LDA #$01
2699 : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
.s18:
269c : a5 4e __ LDA T6 + 0 
269e : 8d 01 de STA $de01 
26a1 : 29 0f __ AND #$0f
26a3 : d0 03 __ BNE $26a8 ; (load_prg_to_sram.s19 + 0)
26a5 : 4c 46 27 JMP $2746 ; (load_prg_to_sram.s32 + 0)
.s19:
26a8 : a5 52 __ LDA T10 + 0 
26aa : f0 b6 __ BEQ $2662 ; (load_prg_to_sram.l13 + 0)
.s20:
26ac : a5 4f __ LDA T7 + 0 
26ae : f0 06 __ BEQ $26b6 ; (load_prg_to_sram.s21 + 0)
.s31:
26b0 : e6 4b __ INC T2 + 0 
26b2 : d0 02 __ BNE $26b6 ; (load_prg_to_sram.s21 + 0)
.s44:
26b4 : e6 4c __ INC T2 + 1 
.s21:
26b6 : a5 4d __ LDA T5 + 0 
26b8 : 8d 03 de STA $de03 
26bb : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
26be : 20 fc 1a JSR $1afc ; (krnio_clrchn.s4 + 0)
26c1 : a9 03 __ LDA #$03
26c3 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
26c6 : a9 0f __ LDA #$0f
26c8 : 85 16 __ STA P9 
26ca : a5 51 __ LDA T9 + 0 
26cc : d0 0d __ BNE $26db ; (load_prg_to_sram.s25 + 0)
.s22:
26ce : a9 02 __ LDA #$02
26d0 : 85 17 __ STA P10 
26d2 : a9 28 __ LDA #$28
26d4 : a2 0f __ LDX #$0f
.s23:
26d6 : 86 14 __ STX P7 
26d8 : 4c 50 25 JMP $2550 ; (load_prg_to_sram.s42 + 0)
.s25:
26db : a9 0d __ LDA #$0d
26dd : 85 17 __ STA P10 
26df : a9 27 __ LDA #$27
26e1 : 85 15 __ STA P8 
26e3 : a9 d8 __ LDA #$d8
26e5 : 85 14 __ STA P7 
26e7 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
26ea : a5 4b __ LDA T2 + 0 
26ec : 85 0d __ STA P0 
26ee : a5 4c __ LDA T2 + 1 
26f0 : 85 0e __ STA P1 
26f2 : a9 b7 __ LDA #$b7
26f4 : 85 0f __ STA P2 
26f6 : a9 9f __ LDA #$9f
26f8 : 85 10 __ STA P3 
26fa : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
26fd : a2 00 __ LDX #$00
26ff : 86 43 __ STX T0 + 0 
2701 : ad b7 9f LDA $9fb7 ; (num[0] + 0)
2704 : f0 12 __ BEQ $2718 ; (load_prg_to_sram.s26 + 0)
.s30:
2706 : 86 49 __ STX T1 + 0 
.l40:
2708 : a6 43 __ LDX T0 + 0 
270a : 9d bd 9f STA $9fbd,x ; (pg_msg[0] + 0)
270d : e6 43 __ INC T0 + 0 
270f : e6 49 __ INC T1 + 0 
2711 : a6 49 __ LDX T1 + 0 
2713 : bd b7 9f LDA $9fb7,x ; (num[0] + 0)
2716 : d0 f0 __ BNE $2708 ; (load_prg_to_sram.l40 + 0)
.s26:
2718 : 85 49 __ STA T1 + 0 
271a : a9 20 __ LDA #$20
.l27:
271c : a6 43 __ LDX T0 + 0 
271e : e0 18 __ CPX #$18
2720 : b0 10 __ BCS $2732 ; (load_prg_to_sram.s28 + 0)
.s29:
2722 : 9d bd 9f STA $9fbd,x ; (pg_msg[0] + 0)
2725 : e6 43 __ INC T0 + 0 
2727 : e6 49 __ INC T1 + 0 
2729 : a6 49 __ LDX T1 + 0 
272b : bd 00 28 LDA $2800,x 
272e : d0 ec __ BNE $271c ; (load_prg_to_sram.l27 + 0)
.s47:
2730 : a6 43 __ LDX T0 + 0 
.s28:
2732 : a9 00 __ LDA #$00
2734 : 9d bd 9f STA $9fbd,x ; (pg_msg[0] + 0)
2737 : a9 11 __ LDA #$11
2739 : 85 16 __ STA P9 
273b : a9 03 __ LDA #$03
273d : 85 17 __ STA P10 
273f : a9 9f __ LDA #$9f
2741 : a2 bd __ LDX #$bd
2743 : 4c d6 26 JMP $26d6 ; (load_prg_to_sram.s23 + 0)
.s32:
2746 : a9 50 __ LDA #$50
2748 : a2 00 __ LDX #$00
.l35:
274a : e8 __ __ INX
274b : 86 43 __ STX T0 + 0 
274d : 9d d5 9f STA $9fd5,x ; (pg_msg[0] + 24)
2750 : bd 98 15 LDA $1598,x 
2753 : f0 04 __ BEQ $2759 ; (load_prg_to_sram.s34 + 0)
.s33:
2755 : e0 05 __ CPX #$05
2757 : 90 f1 __ BCC $274a ; (load_prg_to_sram.l35 + 0)
.s34:
2759 : a9 20 __ LDA #$20
275b : 9d d6 9f STA $9fd6,x ; (pg_msg[0] + 0)
275e : a5 4e __ LDA T6 + 0 
2760 : 4a __ __ LSR
2761 : 4a __ __ LSR
2762 : 4a __ __ LSR
2763 : 4a __ __ LSR
2764 : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
2767 : a6 43 __ LDX T0 + 0 
2769 : 9d d7 9f STA $9fd7,x ; (pg_msg[0] + 1)
276c : a9 00 __ LDA #$00
276e : 20 9e 15 JSR $159e ; (hex_digit.s4 + 0)
2771 : a6 43 __ LDX T0 + 0 
2773 : 9d d8 9f STA $9fd8,x ; (pg_msg[0] + 2)
2776 : a9 00 __ LDA #$00
2778 : 9d d9 9f STA $9fd9,x ; (pg_msg[0] + 3)
277b : a9 0d __ LDA #$0d
277d : 85 16 __ STA P9 
277f : a9 0f __ LDA #$0f
2781 : 85 17 __ STA P10 
2783 : a9 d6 __ LDA #$d6
2785 : 85 14 __ STA P7 
2787 : a9 9f __ LDA #$9f
2789 : 85 15 __ STA P8 
278b : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
278e : a5 52 __ LDA T10 + 0 
2790 : f0 03 __ BEQ $2795 ; (load_prg_to_sram.s34 + 60)
2792 : 4c ac 26 JMP $26ac ; (load_prg_to_sram.s20 + 0)
2795 : 4c 62 26 JMP $2662 ; (load_prg_to_sram.l13 + 0)
--------------------------------------------------------------------
2798 : __ __ __ BYT 4c 4f 41 44 49 4e 47 2e 2e 2e 00                : LOADING....
--------------------------------------------------------------------
27a3 : __ __ __ BYT 45 52 52 4f 52 20 4f 50 45 4e 49 4e 47 20 49 4e : ERROR OPENING IN
27b3 : __ __ __ BYT 20 52 45 41 44 20 4d 4f 44 45 21 00             :  READ MODE!.
--------------------------------------------------------------------
27bf : __ __ __ BYT 45 52 52 4f 52 20 49 4e 56 4f 4c 56 49 4e 47 20 : ERROR INVOLVING 
27cf : __ __ __ BYT 43 48 41 4e 4e 45 4c 21 00                      : CHANNEL!.
--------------------------------------------------------------------
27d8 : __ __ __ BYT 50 52 47 20 4c 4f 41 44 45 44 20 49 4e 54 4f 20 : PRG LOADED INTO 
27e8 : __ __ __ BYT 53 52 41 4d 21 20 20 20 20 20 20 20 20 20 20 20 : SRAM!           
27f8 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
27f9 : __ __ __ BYT 49 30 00                                        : I0.
--------------------------------------------------------------------
sram_status:
27fc : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
eeprom_size_kb:
27fd : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
eeprom_status:
27fe : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
sram_mode_active:
27ff : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
2800 : __ __ __ BYT 20 50 41 47 45 53 20 57 52 49 54 54 45 4e 00    :  PAGES WRITTEN.
--------------------------------------------------------------------
280f : __ __ __ BYT 44 4f 53 20 45 52 52 4f 52 20 44 45 54 45 43 54 : DOS ERROR DETECT
281f : __ __ __ BYT 45 44 21 00                                     : ED!.
--------------------------------------------------------------------
sram_backup: ; sram_backup()->void
;1580, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
2823 : a9 0b __ LDA #$0b
2825 : 85 18 __ STA P11 
2827 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
282a : a9 03 __ LDA #$03
282c : 85 16 __ STA P9 
282e : a9 07 __ LDA #$07
2830 : 85 17 __ STA P10 
2832 : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
2835 : 85 4f __ STA T4 + 0 
2837 : f0 03 __ BEQ $283c ; (sram_backup.s5 + 0)
2839 : 4c 0a 29 JMP $290a ; (sram_backup.s17 + 0)
.s5:
283c : a9 c5 __ LDA #$c5
283e : 85 14 __ STA P7 
2840 : a9 1a __ LDA #$1a
2842 : 85 15 __ STA P8 
2844 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2847 : ad fe 27 LDA $27fe ; (eeprom_status + 0)
284a : d0 11 __ BNE $285d ; (sram_backup.s7 + 0)
.s6:
284c : a9 0b __ LDA #$0b
284e : 85 16 __ STA P9 
2850 : a9 02 __ LDA #$02
2852 : 85 17 __ STA P10 
2854 : a9 27 __ LDA #$27
2856 : 85 14 __ STA P7 
2858 : a9 1e __ LDA #$1e
285a : 4c ea 28 JMP $28ea ; (sram_backup.s20 + 0)
.s7:
285d : a9 0b __ LDA #$0b
285f : 85 16 __ STA P9 
2861 : a9 29 __ LDA #$29
2863 : 85 15 __ STA P8 
2865 : a9 03 __ LDA #$03
2867 : 85 17 __ STA P10 
2869 : a9 2e __ LDA #$2e
286b : 85 14 __ STA P7 
286d : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2870 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
2873 : 85 50 __ STA T5 + 0 
2875 : a5 4f __ LDA T4 + 0 
2877 : d0 06 __ BNE $287f ; (sram_backup.s16 + 0)
.s8:
2879 : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
287c : 4c 87 28 JMP $2887 ; (sram_backup.s9 + 0)
.s16:
287f : a9 00 __ LDA #$00
2881 : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
2884 : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
.s9:
2887 : a9 00 __ LDA #$00
2889 : 85 51 __ STA T6 + 0 
288b : a9 c0 __ LDA #$c0
288d : 85 4e __ STA T1 + 1 
288f : a5 4f __ LDA T4 + 0 
2891 : d0 22 __ BNE $28b5 ; (sram_backup.l15 + 0)
.s10:
2893 : a5 51 __ LDA T6 + 0 
2895 : 85 11 __ STA P4 
2897 : a5 4e __ LDA T1 + 1 
2899 : 85 13 __ STA P6 
289b : a9 00 __ LDA #$00
289d : 85 12 __ STA P5 
289f : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
28a2 : 85 14 __ STA P7 
28a4 : 20 44 29 JSR $2944 ; (mdp_eeprom_write_cart_page.s4 + 0)
.l11:
28a7 : e6 51 __ INC T6 + 0 
28a9 : a5 51 __ LDA T6 + 0 
28ab : c9 10 __ CMP #$10
28ad : b0 25 __ BCS $28d4 ; (sram_backup.s12 + 0)
.s14:
28af : e6 4e __ INC T1 + 1 
28b1 : a5 4f __ LDA T4 + 0 
28b3 : f0 de __ BEQ $2893 ; (sram_backup.s10 + 0)
.l15:
28b5 : a5 51 __ LDA T6 + 0 
28b7 : 8d 01 de STA $de01 
28ba : a5 4e __ LDA T1 + 1 
28bc : 85 1c __ STA ACCU + 1 
28be : a2 00 __ LDX #$00
28c0 : 86 1b __ STX ACCU + 0 
.l19:
28c2 : a0 00 __ LDY #$00
28c4 : b1 1b __ LDA (ACCU + 0),y 
28c6 : 9d 00 df STA $df00,x 
28c9 : e6 1b __ INC ACCU + 0 
28cb : d0 02 __ BNE $28cf ; (sram_backup.s22 + 0)
.s21:
28cd : e6 1c __ INC ACCU + 1 
.s22:
28cf : e8 __ __ INX
28d0 : d0 f0 __ BNE $28c2 ; (sram_backup.l19 + 0)
28d2 : f0 d3 __ BEQ $28a7 ; (sram_backup.l11 + 0)
.s12:
28d4 : a5 50 __ LDA T5 + 0 
28d6 : 8d 03 de STA $de03 
28d9 : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
28dc : a9 0f __ LDA #$0f
28de : 85 16 __ STA P9 
28e0 : a9 0d __ LDA #$0d
28e2 : 85 17 __ STA P10 
28e4 : a9 00 __ LDA #$00
28e6 : 85 14 __ STA P7 
28e8 : a9 2a __ LDA #$2a
.s20:
28ea : 85 15 __ STA P8 
28ec : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
28ef : a9 17 __ LDA #$17
28f1 : 85 16 __ STA P9 
28f3 : a9 0c __ LDA #$0c
28f5 : 85 15 __ STA P8 
28f7 : a9 01 __ LDA #$01
28f9 : 85 17 __ STA P10 
28fb : a9 cc __ LDA #$cc
28fd : 85 14 __ STA P7 
28ff : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l13:
2902 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
2905 : c9 0d __ CMP #$0d
2907 : d0 f9 __ BNE $2902 ; (sram_backup.l13 + 0)
.s3:
2909 : 60 __ __ RTS
.s17:
290a : a9 62 __ LDA #$62
290c : 85 14 __ STA P7 
290e : a9 1a __ LDA #$1a
2910 : 85 15 __ STA P8 
2912 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2915 : ad fc 27 LDA $27fc ; (sram_status + 0)
2918 : f0 03 __ BEQ $291d ; (sram_backup.s18 + 0)
291a : 4c 5d 28 JMP $285d ; (sram_backup.s7 + 0)
.s18:
291d : a9 0b __ LDA #$0b
291f : 85 16 __ STA P9 
2921 : a9 02 __ LDA #$02
2923 : 85 17 __ STA P10 
2925 : a9 06 __ LDA #$06
2927 : 85 14 __ STA P7 
2929 : a9 1e __ LDA #$1e
292b : 4c ea 28 JMP $28ea ; (sram_backup.s20 + 0)
--------------------------------------------------------------------
292e : __ __ __ BYT 42 41 43 4b 55 50 20 49 4e 20 50 52 4f 47 52 45 : BACKUP IN PROGRE
293e : __ __ __ BYT 53 53 2e 2e 2e 00                               : SS....
--------------------------------------------------------------------
mdp_eeprom_write_cart_page: ; mdp_eeprom_write_cart_page(u8,const u8*,u8)->bool
; 235, "C:/Users/crystal/Documents/Antigravity/MDPManager/magicdeskplus.h"
.s4:
2944 : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
2947 : a5 11 __ LDA P4 ; (page + 0)
2949 : 8d 01 de STA $de01 
294c : a9 00 __ LDA #$00
294e : 85 4b __ STA T4 + 0 
2950 : 85 4c __ STA T4 + 1 
2952 : a5 14 __ LDA P7 ; (eeprom_size_kb + 0)
2954 : c9 20 __ CMP #$20
2956 : f0 2c __ BEQ $2984 ; (mdp_eeprom_write_cart_page.l10 + 0)
.s5:
2958 : a5 12 __ LDA P5 ; (buffer + 0)
295a : 85 47 __ STA T2 + 0 
295c : a9 00 __ LDA #$00
295e : 85 46 __ STA T1 + 0 
2960 : a5 13 __ LDA P6 ; (buffer + 1)
2962 : 85 48 __ STA T2 + 1 
2964 : a5 11 __ LDA P4 ; (page + 0)
2966 : 85 0e __ STA P1 
.l6:
2968 : a4 46 __ LDY T1 + 0 
296a : 84 0f __ STY P2 
296c : b1 47 __ LDA (T2 + 0),y 
296e : 85 10 __ STA P3 
2970 : 20 bd 0d JSR $0dbd ; (mdp_eeprom_write_byte.s4 + 0)
2973 : a5 1b __ LDA ACCU + 0 
2975 : f0 09 __ BEQ $2980 ; (mdp_eeprom_write_cart_page.s7 + 0)
.s8:
2977 : e6 46 __ INC T1 + 0 
2979 : d0 ed __ BNE $2968 ; (mdp_eeprom_write_cart_page.l6 + 0)
.s9:
297b : a9 01 __ LDA #$01
.s3:
297d : 85 1b __ STA ACCU + 0 
297f : 60 __ __ RTS
.s7:
2980 : a9 00 __ LDA #$00
2982 : f0 f9 __ BEQ $297d ; (mdp_eeprom_write_cart_page.s3 + 0)
.l10:
2984 : a5 12 __ LDA P5 ; (buffer + 0)
2986 : 85 49 __ STA T3 + 0 
2988 : a2 00 __ LDX #$00
.l14:
298a : 8a __ __ TXA
298b : 18 __ __ CLC
298c : 65 4b __ ADC T4 + 0 
298e : 85 47 __ STA T2 + 0 
2990 : a9 00 __ LDA #$00
2992 : 2a __ __ ROL
2993 : a8 __ __ TAY
2994 : 65 13 __ ADC P6 ; (buffer + 1)
2996 : 85 4a __ STA T3 + 1 
2998 : 98 __ __ TYA
2999 : 18 __ __ CLC
299a : 69 df __ ADC #$df
299c : 85 48 __ STA T2 + 1 
299e : a4 47 __ LDY T2 + 0 
29a0 : b1 49 __ LDA (T3 + 0),y 
29a2 : a0 00 __ LDY #$00
29a4 : 91 47 __ STA (T2 + 0),y 
29a6 : e8 __ __ INX
29a7 : e0 40 __ CPX #$40
29a9 : d0 df __ BNE $298a ; (mdp_eeprom_write_cart_page.l14 + 0)
.s15:
29ab : 18 __ __ CLC
29ac : a5 4b __ LDA T4 + 0 
29ae : 69 3f __ ADC #$3f
29b0 : 85 47 __ STA T2 + 0 
29b2 : a8 __ __ TAY
29b3 : b1 12 __ LDA (P5),y ; (buffer + 0)
29b5 : 29 80 __ AND #$80
29b7 : 85 46 __ STA T1 + 0 
29b9 : a9 28 __ LDA #$28
29bb : 85 49 __ STA T3 + 0 
.l11:
29bd : a6 47 __ LDX T2 + 0 
29bf : bd 00 df LDA $df00,x 
29c2 : 29 80 __ AND #$80
29c4 : c5 46 __ CMP T1 + 0 
29c6 : d0 12 __ BNE $29da ; (mdp_eeprom_write_cart_page.s12 + 0)
.s13:
29c8 : a5 4b __ LDA T4 + 0 
29ca : 69 3f __ ADC #$3f
29cc : 85 4b __ STA T4 + 0 
29ce : a5 4c __ LDA T4 + 1 
29d0 : 69 00 __ ADC #$00
29d2 : 85 4c __ STA T4 + 1 
29d4 : c9 01 __ CMP #$01
29d6 : 90 ac __ BCC $2984 ; (mdp_eeprom_write_cart_page.l10 + 0)
29d8 : b0 a1 __ BCS $297b ; (mdp_eeprom_write_cart_page.s9 + 0)
.s12:
29da : 20 f1 0d JSR $0df1 ; (delay_0_5ms.s4 + 0)
29dd : c6 49 __ DEC T3 + 0 
29df : d0 dc __ BNE $29bd ; (mdp_eeprom_write_cart_page.l11 + 0)
29e1 : f0 9d __ BEQ $2980 ; (mdp_eeprom_write_cart_page.s7 + 0)
--------------------------------------------------------------------
29e3 : __ __ __ BYT 52 45 53 54 4f 52 49 4e 47 2e 2e 2e 00          : RESTORING....
--------------------------------------------------------------------
29f0 : __ __ __ BYT 44 49 53 4b 3a 20 00                            : DISK: .
--------------------------------------------------------------------
29f7 : __ __ __ BYT 20 4b 42 29 00                                  :  KB).
--------------------------------------------------------------------
prg_count:
29fc : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
lzo_enabled:
29fd : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
last_key:
29fe : __ __ __ BSS	1
--------------------------------------------------------------------
2a00 : __ __ __ BYT 42 41 43 4b 55 50 20 43 4f 4d 50 4c 45 54 45 44 : BACKUP COMPLETED
2a10 : __ __ __ BYT 21 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 : !               
2a20 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
sram_restore: ; sram_restore()->void
;1637, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
2a21 : a9 0b __ LDA #$0b
2a23 : 85 18 __ STA P11 
2a25 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
2a28 : a9 03 __ LDA #$03
2a2a : 85 16 __ STA P9 
2a2c : a9 07 __ LDA #$07
2a2e : 85 17 __ STA P10 
2a30 : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
2a33 : f0 03 __ BEQ $2a38 ; (sram_restore.s5 + 0)
2a35 : 4c ed 2a JMP $2aed ; (sram_restore.s15 + 0)
.s5:
2a38 : a9 c5 __ LDA #$c5
2a3a : 85 14 __ STA P7 
2a3c : a9 1a __ LDA #$1a
2a3e : 85 15 __ STA P8 
2a40 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2a43 : ad fe 27 LDA $27fe ; (eeprom_status + 0)
2a46 : d0 2e __ BNE $2a76 ; (sram_restore.s7 + 0)
.s6:
2a48 : a9 0b __ LDA #$0b
2a4a : 85 16 __ STA P9 
2a4c : a9 02 __ LDA #$02
2a4e : 85 17 __ STA P10 
2a50 : a9 27 __ LDA #$27
2a52 : 85 14 __ STA P7 
2a54 : a9 1e __ LDA #$1e
.s18:
2a56 : 85 15 __ STA P8 
2a58 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2a5b : a9 17 __ LDA #$17
2a5d : 85 16 __ STA P9 
2a5f : a9 0c __ LDA #$0c
2a61 : 85 15 __ STA P8 
2a63 : a9 01 __ LDA #$01
2a65 : 85 17 __ STA P10 
2a67 : a9 cc __ LDA #$cc
2a69 : 85 14 __ STA P7 
2a6b : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l13:
2a6e : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
2a71 : c9 0d __ CMP #$0d
2a73 : d0 f9 __ BNE $2a6e ; (sram_restore.l13 + 0)
.s3:
2a75 : 60 __ __ RTS
.s7:
2a76 : a9 0b __ LDA #$0b
2a78 : 85 16 __ STA P9 
2a7a : a9 29 __ LDA #$29
2a7c : 85 15 __ STA P8 
2a7e : a9 03 __ LDA #$03
2a80 : 85 17 __ STA P10 
2a82 : a9 e3 __ LDA #$e3
2a84 : 85 14 __ STA P7 
2a86 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2a89 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
2a8c : 85 4d __ STA T5 + 0 
2a8e : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
2a91 : d0 06 __ BNE $2a99 ; (sram_restore.s14 + 0)
.s8:
2a93 : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
2a96 : 4c a1 2a JMP $2aa1 ; (sram_restore.s9 + 0)
.s14:
2a99 : a9 00 __ LDA #$00
2a9b : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
2a9e : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
.s9:
2aa1 : a9 c0 __ LDA #$c0
2aa3 : 85 4a __ STA T1 + 1 
2aa5 : a9 00 __ LDA #$00
2aa7 : 85 4e __ STA T6 + 0 
.l10:
2aa9 : 8d 01 de STA $de01 
2aac : a5 4a __ LDA T1 + 1 
2aae : 85 4c __ STA T2 + 1 
2ab0 : a9 00 __ LDA #$00
2ab2 : 85 4b __ STA T2 + 0 
.l17:
2ab4 : 85 0d __ STA P0 
2ab6 : 20 e1 16 JSR $16e1 ; (mdp_read_byte.s4 + 0)
2ab9 : a0 00 __ LDY #$00
2abb : 91 4b __ STA (T2 + 0),y 
2abd : e6 4b __ INC T2 + 0 
2abf : d0 02 __ BNE $2ac3 ; (sram_restore.s20 + 0)
.s19:
2ac1 : e6 4c __ INC T2 + 1 
.s20:
2ac3 : 18 __ __ CLC
2ac4 : a5 0d __ LDA P0 
2ac6 : 69 01 __ ADC #$01
2ac8 : d0 ea __ BNE $2ab4 ; (sram_restore.l17 + 0)
.s11:
2aca : e6 4a __ INC T1 + 1 
2acc : e6 4e __ INC T6 + 0 
2ace : a5 4e __ LDA T6 + 0 
2ad0 : c9 10 __ CMP #$10
2ad2 : 90 d5 __ BCC $2aa9 ; (sram_restore.l10 + 0)
.s12:
2ad4 : a5 4d __ LDA T5 + 0 
2ad6 : 8d 03 de STA $de03 
2ad9 : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
2adc : a9 0f __ LDA #$0f
2ade : 85 16 __ STA P9 
2ae0 : a9 0d __ LDA #$0d
2ae2 : 85 17 __ STA P10 
2ae4 : a9 11 __ LDA #$11
2ae6 : 85 14 __ STA P7 
2ae8 : a9 2b __ LDA #$2b
2aea : 4c 56 2a JMP $2a56 ; (sram_restore.s18 + 0)
.s15:
2aed : a9 62 __ LDA #$62
2aef : 85 14 __ STA P7 
2af1 : a9 1a __ LDA #$1a
2af3 : 85 15 __ STA P8 
2af5 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2af8 : ad fc 27 LDA $27fc ; (sram_status + 0)
2afb : f0 03 __ BEQ $2b00 ; (sram_restore.s16 + 0)
2afd : 4c 76 2a JMP $2a76 ; (sram_restore.s7 + 0)
.s16:
2b00 : a9 0b __ LDA #$0b
2b02 : 85 16 __ STA P9 
2b04 : a9 02 __ LDA #$02
2b06 : 85 17 __ STA P10 
2b08 : a9 06 __ LDA #$06
2b0a : 85 14 __ STA P7 
2b0c : a9 1e __ LDA #$1e
2b0e : 4c 56 2a JMP $2a56 ; (sram_restore.s18 + 0)
--------------------------------------------------------------------
2b11 : __ __ __ BYT 52 45 53 54 4f 52 45 20 43 4f 4d 50 4c 45 54 45 : RESTORE COMPLETE
2b21 : __ __ __ BYT 44 21 20 20 20 20 20 20 20 20 20 20 20 20 20 20 : D!              
2b31 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
check_floppy: ; check_floppy()->void
; 237, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
2b32 : a5 53 __ LDA T7 + 0 
2b34 : 8d 2c 9f STA $9f2c ; (check_floppy@stack + 0)
2b37 : a5 54 __ LDA T8 + 0 
2b39 : 8d 2d 9f STA $9f2d ; (check_floppy@stack + 1)
.s4:
2b3c : a9 55 __ LDA #$55
2b3e : a0 00 __ LDY #$00
.l120:
2b40 : 99 e4 9f STA $9fe4,y ; (disk_name[0] + 0)
2b43 : c8 __ __ INY
2b44 : b9 f7 24 LDA $24f7,y 
2b47 : d0 f7 __ BNE $2b40 ; (check_floppy.l120 + 0)
.s5:
2b49 : 99 e4 9f STA $9fe4,y ; (disk_name[0] + 0)
2b4c : 85 4f __ STA T4 + 0 
2b4e : 85 50 __ STA T4 + 1 
.l6:
2b50 : a9 0b __ LDA #$0b
2b52 : 85 18 __ STA P11 
2b54 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
2b57 : a9 03 __ LDA #$03
2b59 : 85 16 __ STA P9 
2b5b : a9 07 __ LDA #$07
2b5d : 85 17 __ STA P10 
2b5f : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
2b62 : 85 52 __ STA T6 + 0 
2b64 : d0 07 __ BNE $2b6d ; (check_floppy.s119 + 0)
.s7:
2b66 : a9 10 __ LDA #$10
2b68 : a0 bc __ LDY #$bc
2b6a : 4c 71 2b JMP $2b71 ; (check_floppy.s8 + 0)
.s119:
2b6d : a9 30 __ LDA #$30
2b6f : a0 4d __ LDY #$4d
.s8:
2b71 : 84 14 __ STY P7 
2b73 : 85 15 __ STA P8 
2b75 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2b78 : a9 0b __ LDA #$0b
2b7a : 85 16 __ STA P9 
2b7c : a9 30 __ LDA #$30
2b7e : 85 15 __ STA P8 
2b80 : a9 03 __ LDA #$03
2b82 : 85 17 __ STA P10 
2b84 : a9 63 __ LDA #$63
2b86 : 85 14 __ STA P7 
2b88 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2b8b : a9 00 __ LDA #$00
2b8d : 8d bc 9f STA $9fbc ; (dos_status[0] + 0)
2b90 : 20 fc 1a JSR $1afc ; (krnio_clrchn.s4 + 0)
2b93 : a9 f9 __ LDA #$f9
2b95 : 85 0d __ STA P0 
2b97 : a9 27 __ LDA #$27
2b99 : 85 0e __ STA P1 
2b9b : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
2b9e : a9 0f __ LDA #$0f
2ba0 : 85 0d __ STA P0 
2ba2 : 85 0f __ STA P2 
2ba4 : a9 08 __ LDA #$08
2ba6 : 85 0e __ STA P1 
2ba8 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
2bab : aa __ __ TAX
2bac : d0 03 __ BNE $2bb1 ; (check_floppy.s27 + 0)
2bae : 4c 48 30 JMP $3048 ; (check_floppy.s9 + 0)
.s27:
2bb1 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
2bb4 : aa __ __ TAX
2bb5 : 10 08 __ BPL $2bbf ; (check_floppy.s28 + 0)
.s118:
2bb7 : a9 0f __ LDA #$0f
2bb9 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
2bbc : 4c 48 30 JMP $3048 ; (check_floppy.s9 + 0)
.s28:
2bbf : a9 28 __ LDA #$28
2bc1 : 85 10 __ STA P3 
2bc3 : a9 9f __ LDA #$9f
2bc5 : 85 0f __ STA P2 
2bc7 : a9 00 __ LDA #$00
2bc9 : 85 11 __ STA P4 
2bcb : a9 bc __ LDA #$bc
2bcd : 85 0e __ STA P1 
2bcf : 20 7a 30 JSR $307a ; (read_dos_status.s4 + 0)
2bd2 : a9 bc __ LDA #$bc
2bd4 : 85 0d __ STA P0 
2bd6 : a9 9f __ LDA #$9f
2bd8 : 85 0e __ STA P1 
2bda : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
2bdd : a5 1c __ LDA ACCU + 1 
2bdf : 30 08 __ BMI $2be9 ; (check_floppy.s29 + 0)
.s117:
2be1 : d0 0a __ BNE $2bed ; (check_floppy.s109 + 0)
.s116:
2be3 : a5 1b __ LDA ACCU + 0 
2be5 : c9 02 __ CMP #$02
2be7 : b0 04 __ BCS $2bed ; (check_floppy.s109 + 0)
.s29:
2be9 : a9 01 __ LDA #$01
2beb : d0 23 __ BNE $2c10 ; (check_floppy.s30 + 0)
.s109:
2bed : ad bc 9f LDA $9fbc ; (dos_status[0] + 0)
2bf0 : c9 37 __ CMP #$37
2bf2 : d0 03 __ BNE $2bf7 ; (check_floppy.s110 + 0)
2bf4 : 4c 34 30 JMP $3034 ; (check_floppy.s114 + 0)
.s110:
2bf7 : c9 30 __ CMP #$30
2bf9 : d0 07 __ BNE $2c02 ; (check_floppy.s113 + 0)
.s111:
2bfb : ad bd 9f LDA $9fbd ; (dos_status[0] + 1)
2bfe : c9 30 __ CMP #$30
2c00 : f0 0c __ BEQ $2c0e ; (check_floppy.s112 + 0)
.s113:
2c02 : a9 0f __ LDA #$0f
.s123:
2c04 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s32:
2c07 : a9 03 __ LDA #$03
.s124:
2c09 : 85 53 __ STA T7 + 0 
2c0b : 4c 17 2d JMP $2d17 ; (check_floppy.s10 + 0)
.s112:
2c0e : a9 00 __ LDA #$00
.s30:
2c10 : 85 53 __ STA T7 + 0 
2c12 : a9 0f __ LDA #$0f
2c14 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
2c17 : a5 53 __ LDA T7 + 0 
2c19 : d0 f0 __ BNE $2c0b ; (check_floppy.s124 + 2)
.s31:
2c1b : a9 fd __ LDA #$fd
2c1d : 85 0d __ STA P0 
2c1f : a9 18 __ LDA #$18
2c21 : 85 0e __ STA P1 
2c23 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
2c26 : a9 02 __ LDA #$02
2c28 : 85 0d __ STA P0 
2c2a : a9 00 __ LDA #$00
2c2c : 85 0f __ STA P2 
2c2e : a9 08 __ LDA #$08
2c30 : 85 0e __ STA P1 
2c32 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
2c35 : aa __ __ TAX
2c36 : f0 cf __ BEQ $2c07 ; (check_floppy.s32 + 0)
.s33:
2c38 : a9 02 __ LDA #$02
2c3a : 20 33 22 JSR $2233 ; (krnio_chkin.s4 + 0)
2c3d : aa __ __ TAX
2c3e : d0 04 __ BNE $2c44 ; (check_floppy.s35 + 0)
.s34:
2c40 : a9 02 __ LDA #$02
2c42 : d0 c0 __ BNE $2c04 ; (check_floppy.s123 + 0)
.s35:
2c44 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2c47 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2c4a : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
2c4d : 29 82 __ AND #$82
2c4f : f0 0b __ BEQ $2c5c ; (check_floppy.s36 + 0)
.s108:
2c51 : a9 03 __ LDA #$03
2c53 : 85 53 __ STA T7 + 0 
2c55 : a9 00 __ LDA #$00
2c57 : 85 54 __ STA T8 + 0 
2c59 : 4c 08 2d JMP $2d08 ; (check_floppy.s38 + 0)
.s36:
2c5c : a9 01 __ LDA #$01
2c5e : 85 54 __ STA T8 + 0 
.l125:
2c60 : 85 51 __ STA T5 + 0 
2c62 : 4c 6d 2c JMP $2c6d ; (check_floppy.l37 + 0)
.s92:
2c65 : a5 4c __ LDA T2 + 0 
2c67 : 85 4f __ STA T4 + 0 
2c69 : a5 4d __ LDA T2 + 1 
2c6b : 85 50 __ STA T4 + 1 
.l37:
2c6d : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2c70 : aa __ __ TAX
2c71 : f0 e6 __ BEQ $2c59 ; (check_floppy.s108 + 8)
.s88:
2c73 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2c76 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2c79 : 85 4c __ STA T2 + 0 
2c7b : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2c7e : 85 4d __ STA T2 + 1 
2c80 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
2c83 : 29 82 __ AND #$82
2c85 : d0 d2 __ BNE $2c59 ; (check_floppy.s108 + 8)
.s89:
2c87 : 85 4e __ STA T3 + 0 
.l90:
2c89 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
2c8c : 85 4b __ STA T1 + 0 
2c8e : aa __ __ TAX
2c8f : f0 07 __ BEQ $2c98 ; (check_floppy.s91 + 0)
.s105:
2c91 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
2c94 : 29 82 __ AND #$82
2c96 : f0 61 __ BEQ $2cf9 ; (check_floppy.s106 + 0)
.s91:
2c98 : a9 00 __ LDA #$00
2c9a : a6 4e __ LDX T3 + 0 
2c9c : 9d 94 9f STA $9f94,x ; (buff[0] + 0)
2c9f : a5 51 __ LDA T5 + 0 
2ca1 : f0 c2 __ BEQ $2c65 ; (check_floppy.s92 + 0)
.s93:
2ca3 : ad 94 9f LDA $9f94 ; (buff[0] + 0)
2ca6 : f0 b8 __ BEQ $2c60 ; (check_floppy.l125 + 0)
.s94:
2ca8 : a0 00 __ LDY #$00
2caa : 84 49 __ STY T0 + 0 
2cac : c9 22 __ CMP #$22
2cae : f0 0d __ BEQ $2cbd ; (check_floppy.s96 + 0)
.l104:
2cb0 : e6 49 __ INC T0 + 0 
2cb2 : a4 49 __ LDY T0 + 0 
2cb4 : b9 94 9f LDA $9f94,y ; (buff[0] + 0)
2cb7 : f0 a7 __ BEQ $2c60 ; (check_floppy.l125 + 0)
.s95:
2cb9 : c9 22 __ CMP #$22
2cbb : d0 f3 __ BNE $2cb0 ; (check_floppy.l104 + 0)
.s96:
2cbd : c8 __ __ INY
2cbe : 84 49 __ STY T0 + 0 
2cc0 : 84 4b __ STY T1 + 0 
2cc2 : b9 94 9f LDA $9f94,y ; (buff[0] + 0)
2cc5 : f0 0c __ BEQ $2cd3 ; (check_floppy.s97 + 0)
.l102:
2cc7 : c9 22 __ CMP #$22
2cc9 : f0 06 __ BEQ $2cd1 ; (check_floppy.s126 + 0)
.s103:
2ccb : c8 __ __ INY
2ccc : b9 94 9f LDA $9f94,y ; (buff[0] + 0)
2ccf : d0 f6 __ BNE $2cc7 ; (check_floppy.l102 + 0)
.s126:
2cd1 : 84 49 __ STY T0 + 0 
.s97:
2cd3 : a9 00 __ LDA #$00
2cd5 : 85 4c __ STA T2 + 0 
2cd7 : f0 0a __ BEQ $2ce3 ; (check_floppy.l98 + 0)
.s101:
2cd9 : bd 94 9f LDA $9f94,x ; (buff[0] + 0)
2cdc : 99 e4 9f STA $9fe4,y ; (disk_name[0] + 0)
2cdf : e6 4b __ INC T1 + 0 
2ce1 : e6 4c __ INC T2 + 0 
.l98:
2ce3 : a6 4b __ LDX T1 + 0 
2ce5 : e4 49 __ CPX T0 + 0 
2ce7 : b0 06 __ BCS $2cef ; (check_floppy.s99 + 0)
.s100:
2ce9 : a4 4c __ LDY T2 + 0 
2ceb : c0 10 __ CPY #$10
2ced : 90 ea __ BCC $2cd9 ; (check_floppy.s101 + 0)
.s99:
2cef : a9 00 __ LDA #$00
2cf1 : a6 4c __ LDX T2 + 0 
2cf3 : 9d e4 9f STA $9fe4,x ; (disk_name[0] + 0)
2cf6 : 4c 60 2c JMP $2c60 ; (check_floppy.l125 + 0)
.s106:
2cf9 : a4 4e __ LDY T3 + 0 
2cfb : c0 27 __ CPY #$27
2cfd : b0 8a __ BCS $2c89 ; (check_floppy.l90 + 0)
.s107:
2cff : a5 4b __ LDA T1 + 0 
2d01 : 99 94 9f STA $9f94,y ; (buff[0] + 0)
2d04 : e6 4e __ INC T3 + 0 
2d06 : 90 81 __ BCC $2c89 ; (check_floppy.l90 + 0)
.s38:
2d08 : 20 fc 1a JSR $1afc ; (krnio_clrchn.s4 + 0)
2d0b : a9 02 __ LDA #$02
2d0d : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
2d10 : a5 54 __ LDA T8 + 0 
2d12 : f0 03 __ BEQ $2d17 ; (check_floppy.s10 + 0)
2d14 : 4c 11 2e JMP $2e11 ; (check_floppy.s39 + 0)
.s10:
2d17 : a9 0b __ LDA #$0b
2d19 : 85 18 __ STA P11 
2d1b : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
2d1e : a9 03 __ LDA #$03
2d20 : 85 16 __ STA P9 
2d22 : a9 07 __ LDA #$07
2d24 : 85 17 __ STA P10 
2d26 : a5 52 __ LDA T6 + 0 
2d28 : d0 07 __ BNE $2d31 ; (check_floppy.s26 + 0)
.s11:
2d2a : a9 10 __ LDA #$10
2d2c : a0 bc __ LDY #$bc
2d2e : 4c 35 2d JMP $2d35 ; (check_floppy.s12 + 0)
.s26:
2d31 : a9 30 __ LDA #$30
2d33 : a0 4d __ LDY #$4d
.s12:
2d35 : 84 14 __ STY P7 
2d37 : 85 15 __ STA P8 
2d39 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2d3c : a9 02 __ LDA #$02
2d3e : 85 17 __ STA P10 
2d40 : a5 53 __ LDA T7 + 0 
2d42 : c9 01 __ CMP #$01
2d44 : d0 13 __ BNE $2d59 ; (check_floppy.s13 + 0)
.s25:
2d46 : a9 0b __ LDA #$0b
2d48 : 85 16 __ STA P9 
2d4a : a9 2a __ LDA #$2a
2d4c : 85 14 __ STA P7 
2d4e : a9 31 __ LDA #$31
2d50 : 85 15 __ STA P8 
2d52 : a9 31 __ LDA #$31
2d54 : a0 4c __ LDY #$4c
2d56 : 4c b4 2d JMP $2db4 ; (check_floppy.s16 + 0)
.s13:
2d59 : c9 02 __ CMP #$02
2d5b : d0 13 __ BNE $2d70 ; (check_floppy.s14 + 0)
.s24:
2d5d : a9 0b __ LDA #$0b
2d5f : 85 16 __ STA P9 
2d61 : a9 69 __ LDA #$69
2d63 : 85 14 __ STA P7 
2d65 : a9 31 __ LDA #$31
2d67 : 85 15 __ STA P8 
2d69 : a9 31 __ LDA #$31
2d6b : a0 8a __ LDY #$8a
2d6d : 4c b4 2d JMP $2db4 ; (check_floppy.s16 + 0)
.s14:
2d70 : c9 03 __ CMP #$03
2d72 : f0 13 __ BEQ $2d87 ; (check_floppy.s20 + 0)
.s15:
2d74 : a9 0b __ LDA #$0b
2d76 : 85 16 __ STA P9 
2d78 : a9 64 __ LDA #$64
2d7a : 85 14 __ STA P7 
2d7c : a9 22 __ LDA #$22
2d7e : 85 15 __ STA P8 
2d80 : a9 22 __ LDA #$22
2d82 : a0 7c __ LDY #$7c
2d84 : 4c b4 2d JMP $2db4 ; (check_floppy.s16 + 0)
.s20:
2d87 : a9 09 __ LDA #$09
2d89 : 85 16 __ STA P9 
2d8b : a9 28 __ LDA #$28
2d8d : 85 15 __ STA P8 
2d8f : a9 0f __ LDA #$0f
2d91 : 85 14 __ STA P7 
2d93 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2d96 : e6 17 __ INC P10 
2d98 : a9 0b __ LDA #$0b
2d9a : 85 16 __ STA P9 
2d9c : ad bc 9f LDA $9fbc ; (dos_status[0] + 0)
2d9f : d0 07 __ BNE $2da8 ; (check_floppy.s23 + 0)
.s21:
2da1 : a9 31 __ LDA #$31
2da3 : a0 ac __ LDY #$ac
2da5 : 4c ac 2d JMP $2dac ; (check_floppy.s22 + 0)
.s23:
2da8 : a9 9f __ LDA #$9f
2daa : a0 bc __ LDY #$bc
.s22:
2dac : 84 14 __ STY P7 
2dae : 85 15 __ STA P8 
2db0 : a9 31 __ LDA #$31
2db2 : a0 c5 __ LDY #$c5
.s16:
2db4 : 84 49 __ STY T0 + 0 
2db6 : 85 4a __ STA T0 + 1 
2db8 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2dbb : a5 49 __ LDA T0 + 0 
2dbd : 85 14 __ STA P7 
2dbf : a5 4a __ LDA T0 + 1 
2dc1 : 85 15 __ STA P8 
2dc3 : a9 0d __ LDA #$0d
2dc5 : 85 16 __ STA P9 
2dc7 : a9 07 __ LDA #$07
2dc9 : 85 17 __ STA P10 
2dcb : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2dce : a9 11 __ LDA #$11
2dd0 : 85 16 __ STA P9 
2dd2 : a9 31 __ LDA #$31
2dd4 : 85 15 __ STA P8 
2dd6 : a9 01 __ LDA #$01
2dd8 : 85 17 __ STA P10 
2dda : a9 de __ LDA #$de
2ddc : 85 14 __ STA P7 
2dde : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2de1 : a9 13 __ LDA #$13
2de3 : 85 16 __ STA P9 
2de5 : a9 32 __ LDA #$32
2de7 : 85 15 __ STA P8 
2de9 : a9 0d __ LDA #$0d
2deb : 85 17 __ STA P10 
2ded : a9 00 __ LDA #$00
2def : 85 14 __ STA P7 
2df1 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l17:
2df4 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
2df7 : c9 0d __ CMP #$0d
2df9 : d0 03 __ BNE $2dfe ; (check_floppy.s18 + 0)
2dfb : 4c 50 2b JMP $2b50 ; (check_floppy.l6 + 0)
.s18:
2dfe : c9 6d __ CMP #$6d
2e00 : f0 04 __ BEQ $2e06 ; (check_floppy.s3 + 0)
.s19:
2e02 : c9 4d __ CMP #$4d
2e04 : d0 ee __ BNE $2df4 ; (check_floppy.l17 + 0)
.s3:
2e06 : ad 2c 9f LDA $9f2c ; (check_floppy@stack + 0)
2e09 : 85 53 __ STA T7 + 0 
2e0b : ad 2d 9f LDA $9f2d ; (check_floppy@stack + 1)
2e0e : 85 54 __ STA T8 + 0 
2e10 : 60 __ __ RTS
.s39:
2e11 : a9 0b __ LDA #$0b
2e13 : 85 18 __ STA P11 
2e15 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
2e18 : a9 03 __ LDA #$03
2e1a : 85 16 __ STA P9 
2e1c : a9 07 __ LDA #$07
2e1e : 85 17 __ STA P10 
2e20 : a5 52 __ LDA T6 + 0 
2e22 : d0 07 __ BNE $2e2b ; (check_floppy.s87 + 0)
.s40:
2e24 : a9 10 __ LDA #$10
2e26 : a0 bc __ LDY #$bc
2e28 : 4c 2f 2e JMP $2e2f ; (check_floppy.s41 + 0)
.s87:
2e2b : a9 30 __ LDA #$30
2e2d : a0 4d __ LDY #$4d
.s41:
2e2f : 84 14 __ STY P7 
2e31 : 85 15 __ STA P8 
2e33 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2e36 : a9 44 __ LDA #$44
2e38 : a0 00 __ LDY #$00
.l121:
2e3a : 99 6c 9f STA $9f6c,y ; (msg_disk[0] + 0)
2e3d : c8 __ __ INY
2e3e : b9 f0 29 LDA $29f0,y 
2e41 : d0 f7 __ BNE $2e3a ; (check_floppy.l121 + 0)
.s42:
2e43 : 99 6c 9f STA $9f6c,y ; (msg_disk[0] + 0)
2e46 : a9 6c __ LDA #$6c
2e48 : 85 0d __ STA P0 
2e4a : a9 9f __ LDA #$9f
2e4c : 85 0e __ STA P1 
2e4e : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
2e51 : a5 1b __ LDA ACCU + 0 
2e53 : 85 49 __ STA T0 + 0 
2e55 : ad e4 9f LDA $9fe4 ; (disk_name[0] + 0)
2e58 : f0 26 __ BEQ $2e80 ; (check_floppy.s43 + 0)
.s83:
2e5a : 85 4e __ STA T3 + 0 
2e5c : a9 00 __ LDA #$00
2e5e : 85 4b __ STA T1 + 0 
2e60 : a5 1c __ LDA ACCU + 1 
2e62 : 30 08 __ BMI $2e6c ; (check_floppy.s84 + 0)
.s86:
2e64 : d0 1a __ BNE $2e80 ; (check_floppy.s43 + 0)
.l85:
2e66 : a5 49 __ LDA T0 + 0 
2e68 : c9 27 __ CMP #$27
2e6a : b0 14 __ BCS $2e80 ; (check_floppy.s43 + 0)
.s84:
2e6c : a5 4e __ LDA T3 + 0 
2e6e : a6 49 __ LDX T0 + 0 
2e70 : 9d 6c 9f STA $9f6c,x ; (msg_disk[0] + 0)
2e73 : e6 49 __ INC T0 + 0 
2e75 : e6 4b __ INC T1 + 0 
2e77 : a6 4b __ LDX T1 + 0 
2e79 : bd e4 9f LDA $9fe4,x ; (disk_name[0] + 0)
2e7c : 85 4e __ STA T3 + 0 
2e7e : d0 e6 __ BNE $2e66 ; (check_floppy.l85 + 0)
.s43:
2e80 : a9 00 __ LDA #$00
2e82 : a6 49 __ LDX T0 + 0 
2e84 : 9d 6c 9f STA $9f6c,x ; (msg_disk[0] + 0)
2e87 : a9 0b __ LDA #$0b
2e89 : 85 16 __ STA P9 
2e8b : a9 03 __ LDA #$03
2e8d : 85 17 __ STA P10 
2e8f : a9 6c __ LDA #$6c
2e91 : 85 14 __ STA P7 
2e93 : a9 9f __ LDA #$9f
2e95 : 85 15 __ STA P8 
2e97 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2e9a : a9 46 __ LDA #$46
2e9c : a0 00 __ LDY #$00
.l122:
2e9e : 99 44 9f STA $9f44,y ; (msg_blocks[0] + 0)
2ea1 : c8 __ __ INY
2ea2 : b9 1c 32 LDA $321c,y 
2ea5 : d0 f7 __ BNE $2e9e ; (check_floppy.l122 + 0)
.s44:
2ea7 : 99 44 9f STA $9f44,y ; (msg_blocks[0] + 0)
2eaa : a5 4f __ LDA T4 + 0 
2eac : 85 0d __ STA P0 
2eae : a5 50 __ LDA T4 + 1 
2eb0 : 85 0e __ STA P1 
2eb2 : a9 3a __ LDA #$3a
2eb4 : 85 0f __ STA P2 
2eb6 : a9 9f __ LDA #$9f
2eb8 : 85 10 __ STA P3 
2eba : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
2ebd : a9 44 __ LDA #$44
2ebf : 85 0d __ STA P0 
2ec1 : a9 9f __ LDA #$9f
2ec3 : 85 0e __ STA P1 
2ec5 : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
2ec8 : a5 1b __ LDA ACCU + 0 
2eca : 85 4c __ STA T2 + 0 
2ecc : a6 1c __ LDX ACCU + 1 
2ece : ad 3a 9f LDA $9f3a ; (blocks_str[0] + 0)
2ed1 : f0 28 __ BEQ $2efb ; (check_floppy.s45 + 0)
.s79:
2ed3 : 85 4e __ STA T3 + 0 
2ed5 : a9 00 __ LDA #$00
2ed7 : 85 49 __ STA T0 + 0 
2ed9 : 8a __ __ TXA
2eda : 30 08 __ BMI $2ee4 ; (check_floppy.s80 + 0)
.s82:
2edc : d0 1d __ BNE $2efb ; (check_floppy.s45 + 0)
.l81:
2ede : a5 4c __ LDA T2 + 0 
2ee0 : c9 27 __ CMP #$27
2ee2 : b0 17 __ BCS $2efb ; (check_floppy.s45 + 0)
.s80:
2ee4 : a5 4e __ LDA T3 + 0 
2ee6 : a6 4c __ LDX T2 + 0 
2ee8 : 9d 44 9f STA $9f44,x ; (msg_blocks[0] + 0)
2eeb : a9 00 __ LDA #$00
2eed : e6 4c __ INC T2 + 0 
2eef : e6 49 __ INC T0 + 0 
2ef1 : aa __ __ TAX
2ef2 : a4 49 __ LDY T0 + 0 
2ef4 : b9 3a 9f LDA $9f3a,y ; (blocks_str[0] + 0)
2ef7 : 85 4e __ STA T3 + 0 
2ef9 : d0 e3 __ BNE $2ede ; (check_floppy.l81 + 0)
.s45:
2efb : a9 00 __ LDA #$00
2efd : 85 49 __ STA T0 + 0 
2eff : a9 20 __ LDA #$20
.l46:
2f01 : a8 __ __ TAY
2f02 : 8a __ __ TXA
2f03 : 30 08 __ BMI $2f0d ; (check_floppy.s76 + 0)
.s78:
2f05 : d0 1a __ BNE $2f21 ; (check_floppy.s47 + 0)
.s77:
2f07 : a5 4c __ LDA T2 + 0 
2f09 : c9 27 __ CMP #$27
2f0b : b0 14 __ BCS $2f21 ; (check_floppy.s47 + 0)
.s76:
2f0d : 98 __ __ TYA
2f0e : a6 4c __ LDX T2 + 0 
2f10 : 9d 44 9f STA $9f44,x ; (msg_blocks[0] + 0)
2f13 : a9 00 __ LDA #$00
2f15 : e6 4c __ INC T2 + 0 
2f17 : e6 49 __ INC T0 + 0 
2f19 : aa __ __ TAX
2f1a : a4 49 __ LDY T0 + 0 
2f1c : b9 f4 31 LDA $31f4,y 
2f1f : d0 e0 __ BNE $2f01 ; (check_floppy.l46 + 0)
.s47:
2f21 : 86 4d __ STX T2 + 1 
2f23 : a5 50 __ LDA T4 + 1 
2f25 : 4a __ __ LSR
2f26 : 85 0e __ STA P1 
2f28 : a5 4f __ LDA T4 + 0 
2f2a : 6a __ __ ROR
2f2b : 46 0e __ LSR P1 
2f2d : 6a __ __ ROR
2f2e : 85 0d __ STA P0 
2f30 : a9 30 __ LDA #$30
2f32 : 85 0f __ STA P2 
2f34 : a9 9f __ LDA #$9f
2f36 : 85 10 __ STA P3 
2f38 : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
2f3b : ae 30 9f LDX $9f30 ; (kb_str[0] + 0)
2f3e : f0 1d __ BEQ $2f5d ; (check_floppy.s48 + 0)
.s73:
2f40 : a9 00 __ LDA #$00
2f42 : 85 49 __ STA T0 + 0 
2f44 : a5 4d __ LDA T2 + 1 
2f46 : d0 15 __ BNE $2f5d ; (check_floppy.s48 + 0)
.l75:
2f48 : a4 4c __ LDY T2 + 0 
2f4a : c0 27 __ CPY #$27
2f4c : b0 0f __ BCS $2f5d ; (check_floppy.s48 + 0)
.s74:
2f4e : 8a __ __ TXA
2f4f : 99 44 9f STA $9f44,y ; (msg_blocks[0] + 0)
2f52 : e6 4c __ INC T2 + 0 
2f54 : e6 49 __ INC T0 + 0 
2f56 : a4 49 __ LDY T0 + 0 
2f58 : be 30 9f LDX $9f30,y ; (kb_str[0] + 0)
2f5b : d0 eb __ BNE $2f48 ; (check_floppy.l75 + 0)
.s48:
2f5d : a9 00 __ LDA #$00
2f5f : 85 49 __ STA T0 + 0 
2f61 : a9 20 __ LDA #$20
.l49:
2f63 : aa __ __ TAX
2f64 : a5 4d __ LDA T2 + 1 
2f66 : d0 15 __ BNE $2f7d ; (check_floppy.s50 + 0)
.s72:
2f68 : a4 4c __ LDY T2 + 0 
2f6a : c0 27 __ CPY #$27
2f6c : b0 0f __ BCS $2f7d ; (check_floppy.s50 + 0)
.s71:
2f6e : 8a __ __ TXA
2f6f : 99 44 9f STA $9f44,y ; (msg_blocks[0] + 0)
2f72 : e6 4c __ INC T2 + 0 
2f74 : e6 49 __ INC T0 + 0 
2f76 : a6 49 __ LDX T0 + 0 
2f78 : bd f7 29 LDA $29f7,x 
2f7b : d0 e6 __ BNE $2f63 ; (check_floppy.l49 + 0)
.s50:
2f7d : a9 00 __ LDA #$00
2f7f : a6 4c __ LDX T2 + 0 
2f81 : 9d 44 9f STA $9f44,x ; (msg_blocks[0] + 0)
2f84 : a9 0d __ LDA #$0d
2f86 : 85 16 __ STA P9 
2f88 : a9 05 __ LDA #$05
2f8a : 85 17 __ STA P10 
2f8c : a9 44 __ LDA #$44
2f8e : 85 14 __ STA P7 
2f90 : a9 9f __ LDA #$9f
2f92 : 85 15 __ STA P8 
2f94 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2f97 : a5 52 __ LDA T6 + 0 
2f99 : f0 03 __ BEQ $2f9e ; (check_floppy.s51 + 0)
2f9b : 4c 27 30 JMP $3027 ; (check_floppy.s68 + 0)
.s51:
2f9e : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
2fa1 : c9 20 __ CMP #$20
2fa3 : d0 04 __ BNE $2fa9 ; (check_floppy.s52 + 0)
.s67:
2fa5 : a9 83 __ LDA #$83
2fa7 : d0 02 __ BNE $2fab ; (check_floppy.s53 + 0)
.s52:
2fa9 : a9 23 __ LDA #$23
.s53:
2fab : 85 49 __ STA T0 + 0 
2fad : a5 50 __ LDA T4 + 1 
2faf : 38 __ __ SEC
2fb0 : d0 04 __ BNE $2fb6 ; (check_floppy.s70 + 0)
.s66:
2fb2 : a5 4f __ LDA T4 + 0 
2fb4 : c5 49 __ CMP T0 + 0 
.s70:
2fb6 : a9 0f __ LDA #$0f
2fb8 : 85 16 __ STA P9 
2fba : 90 48 __ BCC $3004 ; (check_floppy.s61 + 0)
.s54:
2fbc : a9 0d __ LDA #$0d
2fbe : 85 17 __ STA P10 
2fc0 : a5 52 __ LDA T6 + 0 
2fc2 : f0 21 __ BEQ $2fe5 ; (check_floppy.s55 + 0)
.s60:
2fc4 : a9 32 __ LDA #$32
2fc6 : a0 98 __ LDY #$98
.s57:
2fc8 : 84 14 __ STY P7 
2fca : 85 15 __ STA P8 
2fcc : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2fcf : a9 17 __ LDA #$17
2fd1 : 85 16 __ STA P9 
2fd3 : a9 32 __ LDA #$32
2fd5 : 85 15 __ STA P8 
2fd7 : a9 01 __ LDA #$01
2fd9 : 85 17 __ STA P10 
2fdb : a9 e1 __ LDA #$e1
2fdd : 85 14 __ STA P7 
2fdf : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
2fe2 : 4c fa 2f JMP $2ffa ; (check_floppy.l58 + 0)
.s55:
2fe5 : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
2fe8 : c9 20 __ CMP #$20
2fea : f0 07 __ BEQ $2ff3 ; (check_floppy.s59 + 0)
.s56:
2fec : a9 33 __ LDA #$33
2fee : a0 00 __ LDY #$00
2ff0 : 4c c8 2f JMP $2fc8 ; (check_floppy.s57 + 0)
.s59:
2ff3 : a9 32 __ LDA #$32
2ff5 : a0 bd __ LDY #$bd
2ff7 : 4c c8 2f JMP $2fc8 ; (check_floppy.s57 + 0)
.l58:
2ffa : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
2ffd : c9 0d __ CMP #$0d
2fff : d0 f9 __ BNE $2ffa ; (check_floppy.l58 + 0)
3001 : 4c 06 2e JMP $2e06 ; (check_floppy.s3 + 0)
.s61:
3004 : a9 02 __ LDA #$02
3006 : 85 17 __ STA P10 
3008 : a5 52 __ LDA T6 + 0 
300a : f0 06 __ BEQ $3012 ; (check_floppy.s62 + 0)
.s65:
300c : a9 32 __ LDA #$32
300e : a0 29 __ LDY #$29
3010 : 90 b6 __ BCC $2fc8 ; (check_floppy.s57 + 0)
.s62:
3012 : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
3015 : c9 20 __ CMP #$20
3017 : f0 07 __ BEQ $3020 ; (check_floppy.s64 + 0)
.s63:
3019 : a9 32 __ LDA #$32
301b : a0 74 __ LDY #$74
301d : 4c c8 2f JMP $2fc8 ; (check_floppy.s57 + 0)
.s64:
3020 : a9 32 __ LDA #$32
3022 : a0 4f __ LDY #$4f
3024 : 4c c8 2f JMP $2fc8 ; (check_floppy.s57 + 0)
.s68:
3027 : a5 50 __ LDA T4 + 1 
3029 : c9 02 __ CMP #$02
302b : d0 89 __ BNE $2fb6 ; (check_floppy.s70 + 0)
.s69:
302d : a5 4f __ LDA T4 + 0 
302f : c9 05 __ CMP #$05
3031 : 4c b6 2f JMP $2fb6 ; (check_floppy.s70 + 0)
.s114:
3034 : ad bd 9f LDA $9fbd ; (dos_status[0] + 1)
3037 : c9 34 __ CMP #$34
3039 : f0 03 __ BEQ $303e ; (check_floppy.s115 + 0)
303b : 4c 02 2c JMP $2c02 ; (check_floppy.s113 + 0)
.s115:
303e : a9 0f __ LDA #$0f
3040 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
3043 : a9 02 __ LDA #$02
3045 : 4c 09 2c JMP $2c09 ; (check_floppy.s124 + 0)
.s9:
3048 : a9 01 __ LDA #$01
304a : 4c 09 2c JMP $2c09 ; (check_floppy.s124 + 0)
--------------------------------------------------------------------
304d : __ __ __ BYT 53 52 41 4d 20 42 41 43 4b 55 50 20 54 4f 20 46 : SRAM BACKUP TO F
305d : __ __ __ BYT 4c 4f 50 50 59 00                               : LOPPY.
--------------------------------------------------------------------
3063 : __ __ __ BYT 41 43 43 45 53 53 49 4e 47 20 54 48 45 20 44 52 : ACCESSING THE DR
3073 : __ __ __ BYT 49 56 45 2e 2e 2e 00                            : IVE....
--------------------------------------------------------------------
read_dos_status: ; read_dos_status(u8*,i16)->void
; 203, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
307a : a9 00 __ LDA #$00
307c : 85 43 __ STA T1 + 0 
307e : 85 44 __ STA T1 + 1 
3080 : 85 47 __ STA T5 + 0 
3082 : 85 45 __ STA T2 + 0 
3084 : a5 0e __ LDA P1 ; (buf + 0)
3086 : 85 46 __ STA T3 + 0 
3088 : 05 0f __ ORA P2 ; (buf + 1)
308a : f0 0d __ BEQ $3099 ; (read_dos_status.s5 + 0)
.s23:
308c : a5 11 __ LDA P4 ; (max_len + 1)
308e : 30 09 __ BMI $3099 ; (read_dos_status.s5 + 0)
.s25:
3090 : 05 10 __ ORA P3 ; (max_len + 0)
3092 : f0 05 __ BEQ $3099 ; (read_dos_status.s5 + 0)
.s24:
3094 : a9 00 __ LDA #$00
3096 : a8 __ __ TAY
3097 : 91 0e __ STA (P1),y ; (buf + 0)
.s5:
3099 : a9 0f __ LDA #$0f
309b : 20 33 22 JSR $2233 ; (krnio_chkin.s4 + 0)
309e : aa __ __ TAX
309f : d0 01 __ BNE $30a2 ; (read_dos_status.l6 + 0)
.s3:
30a1 : 60 __ __ RTS
.l6:
30a2 : a5 45 __ LDA T2 + 0 
30a4 : c9 50 __ CMP #$50
30a6 : b0 5c __ BCS $3104 ; (read_dos_status.s7 + 0)
.s10:
30a8 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
30ab : 85 48 __ STA T6 + 0 
30ad : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
30b0 : 85 1b __ STA ACCU + 0 
30b2 : 29 82 __ AND #$82
30b4 : d0 4e __ BNE $3104 ; (read_dos_status.s7 + 0)
.s11:
30b6 : e6 45 __ INC T2 + 0 
30b8 : a5 48 __ LDA T6 + 0 
30ba : c9 0d __ CMP #$0d
30bc : f0 60 __ BEQ $311e ; (read_dos_status.s21 + 0)
.s12:
30be : 06 1b __ ASL ACCU + 0 
30c0 : 30 5c __ BMI $311e ; (read_dos_status.s21 + 0)
.s13:
30c2 : a5 46 __ LDA T3 + 0 
30c4 : 05 0f __ ORA P2 ; (buf + 1)
30c6 : f0 da __ BEQ $30a2 ; (read_dos_status.l6 + 0)
.s14:
30c8 : a5 10 __ LDA P3 ; (max_len + 0)
30ca : 38 __ __ SEC
30cb : e9 01 __ SBC #$01
30cd : 85 1b __ STA ACCU + 0 
30cf : a5 11 __ LDA P4 ; (max_len + 1)
30d1 : e9 00 __ SBC #$00
30d3 : 30 2b __ BMI $3100 ; (read_dos_status.s15 + 0)
.s20:
30d5 : 85 1c __ STA ACCU + 1 
30d7 : a5 44 __ LDA T1 + 1 
30d9 : c5 1c __ CMP ACCU + 1 
30db : d0 04 __ BNE $30e1 ; (read_dos_status.s19 + 0)
.s18:
30dd : a5 43 __ LDA T1 + 0 
30df : c5 1b __ CMP ACCU + 0 
.s19:
30e1 : b0 1d __ BCS $3100 ; (read_dos_status.s15 + 0)
.s16:
30e3 : a5 48 __ LDA T6 + 0 
30e5 : c9 0d __ CMP #$0d
30e7 : f0 17 __ BEQ $3100 ; (read_dos_status.s15 + 0)
.s17:
30e9 : a5 43 __ LDA T1 + 0 
30eb : 85 1b __ STA ACCU + 0 
30ed : 18 __ __ CLC
30ee : a5 0f __ LDA P2 ; (buf + 1)
30f0 : 65 44 __ ADC T1 + 1 
30f2 : 85 1c __ STA ACCU + 1 
30f4 : a5 48 __ LDA T6 + 0 
30f6 : a4 46 __ LDY T3 + 0 
30f8 : 91 1b __ STA (ACCU + 0),y 
30fa : e6 43 __ INC T1 + 0 
30fc : d0 02 __ BNE $3100 ; (read_dos_status.s15 + 0)
.s26:
30fe : e6 44 __ INC T1 + 1 
.s15:
3100 : a5 47 __ LDA T5 + 0 
3102 : f0 9e __ BEQ $30a2 ; (read_dos_status.l6 + 0)
.s7:
3104 : a5 46 __ LDA T3 + 0 
3106 : 05 0f __ ORA P2 ; (buf + 1)
3108 : f0 11 __ BEQ $311b ; (read_dos_status.s8 + 0)
.s9:
310a : a5 43 __ LDA T1 + 0 
310c : 85 1b __ STA ACCU + 0 
310e : 18 __ __ CLC
310f : a5 0f __ LDA P2 ; (buf + 1)
3111 : 65 44 __ ADC T1 + 1 
3113 : 85 1c __ STA ACCU + 1 
3115 : a9 00 __ LDA #$00
3117 : a4 46 __ LDY T3 + 0 
3119 : 91 1b __ STA (ACCU + 0),y 
.s8:
311b : 4c fc 1a JMP $1afc ; (krnio_clrchn.s4 + 0)
.s21:
311e : a5 46 __ LDA T3 + 0 
3120 : 05 0f __ ORA P2 ; (buf + 1)
3122 : f0 f7 __ BEQ $311b ; (read_dos_status.s8 + 0)
.s22:
3124 : a9 01 __ LDA #$01
3126 : 85 47 __ STA T5 + 0 
3128 : d0 9e __ BNE $30c8 ; (read_dos_status.s14 + 0)
--------------------------------------------------------------------
312a : __ __ __ BYT 45 52 52 4f 52 3a 20 31 35 34 31 20 44 52 49 56 : ERROR: 1541 DRIV
313a : __ __ __ BYT 45 20 4e 4f 54 20 52 45 53 50 4f 4e 44 49 4e 47 : E NOT RESPONDING
314a : __ __ __ BYT 21 00                                           : !.
--------------------------------------------------------------------
314c : __ __ __ BYT 43 48 45 43 4b 20 53 45 52 49 41 4c 20 43 41 42 : CHECK SERIAL CAB
315c : __ __ __ BYT 4c 45 20 41 4e 44 20 50 4f 57 45 52 00          : LE AND POWER.
--------------------------------------------------------------------
3169 : __ __ __ BYT 45 52 52 4f 52 3a 20 46 4c 4f 50 50 59 20 44 49 : ERROR: FLOPPY DI
3179 : __ __ __ BYT 53 4b 20 4e 4f 54 20 49 4e 53 45 52 54 45 44 21 : SK NOT INSERTED!
3189 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
318a : __ __ __ BYT 49 4e 53 45 52 54 20 41 20 44 49 53 4b 20 41 4e : INSERT A DISK AN
319a : __ __ __ BYT 44 20 43 4c 4f 53 45 20 54 48 45 20 4c 45 56 45 : D CLOSE THE LEVE
31aa : __ __ __ BYT 52 00                                           : R.
--------------------------------------------------------------------
31ac : __ __ __ BYT 55 4e 41 42 4c 45 20 54 4f 20 52 45 41 44 20 44 : UNABLE TO READ D
31bc : __ __ __ BYT 49 52 45 43 54 4f 52 59 00                      : IRECTORY.
--------------------------------------------------------------------
31c5 : __ __ __ BYT 43 48 45 43 4b 20 44 49 53 4b 20 41 4e 44 20 54 : CHECK DISK AND T
31d5 : __ __ __ BYT 52 59 20 41 47 41 49 4e 00                      : RY AGAIN.
--------------------------------------------------------------------
31de : __ __ __ BYT 50 52 45 53 53 20 52 45 54 55 52 4e 20 54 4f 20 : PRESS RETURN TO 
31ee : __ __ __ BYT 52 45 54 52 59 00                               : RETRY.
--------------------------------------------------------------------
31f4 : __ __ __ BYT 20 42 4c 4f 43 4b 53 20 28 00                   :  BLOCKS (.
--------------------------------------------------------------------
3200 : __ __ __ BYT 50 52 45 53 53 20 28 4d 29 20 54 4f 20 52 45 54 : PRESS (M) TO RET
3210 : __ __ __ BYT 55 52 4e 20 54 4f 20 4d 45 4e 55 00             : URN TO MENU.
--------------------------------------------------------------------
321c : __ __ __ BYT 46 52 45 45 20 53 50 41 43 45 3a 20 00          : FREE SPACE: .
--------------------------------------------------------------------
3229 : __ __ __ BYT 57 41 52 4e 49 4e 47 3a 20 49 4e 53 55 46 46 49 : WARNING: INSUFFI
3239 : __ __ __ BYT 43 49 45 4e 54 20 53 50 41 43 45 21 20 28 3c 31 : CIENT SPACE! (<1
3249 : __ __ __ BYT 32 38 4b 42 29 00                               : 28KB).
--------------------------------------------------------------------
324f : __ __ __ BYT 57 41 52 4e 49 4e 47 3a 20 49 4e 53 55 46 46 49 : WARNING: INSUFFI
325f : __ __ __ BYT 43 49 45 4e 54 20 53 50 41 43 45 21 20 28 3c 33 : CIENT SPACE! (<3
326f : __ __ __ BYT 32 4b 42 29 00                                  : 2KB).
--------------------------------------------------------------------
3274 : __ __ __ BYT 57 41 52 4e 49 4e 47 3a 20 49 4e 53 55 46 46 49 : WARNING: INSUFFI
3284 : __ __ __ BYT 43 49 45 4e 54 20 53 50 41 43 45 21 20 28 3c 38 : CIENT SPACE! (<8
3294 : __ __ __ BYT 4b 42 29 00                                     : KB).
--------------------------------------------------------------------
3298 : __ __ __ BYT 53 55 46 46 49 43 49 45 4e 54 20 53 50 41 43 45 : SUFFICIENT SPACE
32a8 : __ __ __ BYT 20 46 4f 52 20 42 41 43 4b 55 50 20 28 3e 31 32 :  FOR BACKUP (>12
32b8 : __ __ __ BYT 38 4b 42 29 00                                  : 8KB).
--------------------------------------------------------------------
32bd : __ __ __ BYT 53 55 46 46 49 43 49 45 4e 54 20 53 50 41 43 45 : SUFFICIENT SPACE
32cd : __ __ __ BYT 20 46 4f 52 20 42 41 43 4b 55 50 20 28 3e 33 32 :  FOR BACKUP (>32
32dd : __ __ __ BYT 4b 42 29 00                                     : KB).
--------------------------------------------------------------------
32e1 : __ __ __ BYT 50 52 45 53 53 20 52 45 54 55 52 4e 20 54 4f 20 : PRESS RETURN TO 
32f1 : __ __ __ BYT 47 4f 20 42 41 43 4b 00                         : GO BACK.
--------------------------------------------------------------------
32f9 : __ __ __ BYT 31 30 30 25 00                                  : 100%.
--------------------------------------------------------------------
3300 : __ __ __ BYT 53 55 46 46 49 43 49 45 4e 54 20 53 50 41 43 45 : SUFFICIENT SPACE
3310 : __ __ __ BYT 20 46 4f 52 20 42 41 43 4b 55 50 20 28 3e 38 4b :  FOR BACKUP (>8K
3320 : __ __ __ BYT 42 29 00                                        : B).
--------------------------------------------------------------------
sram_format: ; sram_format()->void
;1689, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
3323 : a9 0b __ LDA #$0b
3325 : 85 18 __ STA P11 
3327 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
332a : a9 03 __ LDA #$03
332c : 85 16 __ STA P9 
332e : a9 07 __ LDA #$07
3330 : 85 17 __ STA P10 
3332 : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
3335 : 85 4e __ STA T2 + 0 
3337 : f0 03 __ BEQ $333c ; (sram_format.s5 + 0)
3339 : 4c 4e 34 JMP $344e ; (sram_format.s29 + 0)
.s5:
333c : a9 c5 __ LDA #$c5
333e : 85 14 __ STA P7 
3340 : a9 1a __ LDA #$1a
3342 : 85 15 __ STA P8 
3344 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3347 : a9 0b __ LDA #$0b
3349 : 85 16 __ STA P9 
334b : ad fe 27 LDA $27fe ; (eeprom_status + 0)
334e : d0 0d __ BNE $335d ; (sram_format.s7 + 0)
.s6:
3350 : a9 02 __ LDA #$02
3352 : 85 17 __ STA P10 
3354 : a9 27 __ LDA #$27
3356 : 85 14 __ STA P7 
3358 : a9 1e __ LDA #$1e
335a : 4c fe 33 JMP $33fe ; (sram_format.s34 + 0)
.s7:
335d : a9 34 __ LDA #$34
335f : a0 8d __ LDY #$8d
.s8:
3361 : 84 14 __ STY P7 
3363 : 85 15 __ STA P8 
3365 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l9:
3368 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
336b : c9 6e __ CMP #$6e
336d : f0 04 __ BEQ $3373 ; (sram_format.s27 + 0)
.s10:
336f : c9 4e __ CMP #$4e
3371 : d0 11 __ BNE $3384 ; (sram_format.s11 + 0)
.s27:
3373 : a9 0f __ LDA #$0f
3375 : 85 16 __ STA P9 
3377 : a9 02 __ LDA #$02
3379 : 85 17 __ STA P10 
337b : a9 a6 __ LDA #$a6
337d : 85 14 __ STA P7 
337f : a9 34 __ LDA #$34
3381 : 4c fe 33 JMP $33fe ; (sram_format.s34 + 0)
.s11:
3384 : c9 79 __ CMP #$79
3386 : f0 04 __ BEQ $338c ; (sram_format.s13 + 0)
.s12:
3388 : c9 59 __ CMP #$59
338a : d0 dc __ BNE $3368 ; (sram_format.l9 + 0)
.s13:
338c : a9 0f __ LDA #$0f
338e : 85 16 __ STA P9 
3390 : a9 34 __ LDA #$34
3392 : 85 15 __ STA P8 
3394 : a9 03 __ LDA #$03
3396 : 85 17 __ STA P10 
3398 : a9 c7 __ LDA #$c7
339a : 85 14 __ STA P7 
339c : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
339f : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
33a2 : 85 50 __ STA T4 + 0 
33a4 : a5 4e __ LDA T2 + 0 
33a6 : d0 76 __ BNE $341e ; (sram_format.s21 + 0)
.s14:
33a8 : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
33ab : a9 00 __ LDA #$00
33ad : a8 __ __ TAY
.l33:
33ae : 99 fe 9e STA $9efe,y ; (zero_buf[0] + 0)
33b1 : c8 __ __ INY
33b2 : d0 fa __ BNE $33ae ; (sram_format.l33 + 0)
.s15:
33b4 : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
33b7 : c9 20 __ CMP #$20
33b9 : 85 14 __ STA P7 
33bb : d0 04 __ BNE $33c1 ; (sram_format.s16 + 0)
.s20:
33bd : a9 80 __ LDA #$80
33bf : d0 02 __ BNE $33c3 ; (sram_format.s17 + 0)
.s16:
33c1 : a9 20 __ LDA #$20
.s17:
33c3 : 85 4d __ STA T0 + 0 
33c5 : a9 fe __ LDA #$fe
33c7 : 85 12 __ STA P5 
33c9 : a9 9e __ LDA #$9e
33cb : 85 13 __ STA P6 
33cd : 98 __ __ TYA
.l32:
33ce : 85 11 __ STA P4 
33d0 : 20 44 29 JSR $2944 ; (mdp_eeprom_write_cart_page.s4 + 0)
33d3 : 18 __ __ CLC
33d4 : a5 11 __ LDA P4 
33d6 : 69 01 __ ADC #$01
33d8 : c5 4d __ CMP T0 + 0 
33da : 90 f2 __ BCC $33ce ; (sram_format.l32 + 0)
.s18:
33dc : a5 14 __ LDA P7 
33de : 85 11 __ STA P4 
33e0 : 20 20 0e JSR $0e20 ; (mdp_eeprom_write_signature.s4 + 0)
33e3 : a9 01 __ LDA #$01
33e5 : 8d fe 27 STA $27fe ; (eeprom_status + 0)
.s19:
33e8 : a5 50 __ LDA T4 + 0 
33ea : 8d 03 de STA $de03 
33ed : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
33f0 : a9 11 __ LDA #$11
33f2 : 85 16 __ STA P9 
33f4 : a9 0d __ LDA #$0d
33f6 : 85 17 __ STA P10 
33f8 : a9 d5 __ LDA #$d5
33fa : 85 14 __ STA P7 
33fc : a9 34 __ LDA #$34
.s34:
33fe : 85 15 __ STA P8 
3400 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3403 : a9 17 __ LDA #$17
3405 : 85 16 __ STA P9 
3407 : a9 0c __ LDA #$0c
3409 : 85 15 __ STA P8 
340b : a9 01 __ LDA #$01
340d : 85 17 __ STA P10 
340f : a9 cc __ LDA #$cc
3411 : 85 14 __ STA P7 
3413 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l28:
3416 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
3419 : c9 0d __ CMP #$0d
341b : d0 f9 __ BNE $3416 ; (sram_format.l28 + 0)
.s3:
341d : 60 __ __ RTS
.s21:
341e : a9 00 __ LDA #$00
3420 : 85 4f __ STA T3 + 0 
.l22:
3422 : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
3425 : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
3428 : a9 00 __ LDA #$00
342a : 85 4d __ STA T0 + 0 
.l23:
342c : a6 4d __ LDX T0 + 0 
342e : 8e 01 de STX $de01 
3431 : aa __ __ TAX
.l35:
3432 : 9d 00 df STA $df00,x 
3435 : e8 __ __ INX
3436 : d0 fa __ BNE $3432 ; (sram_format.l35 + 0)
.s24:
3438 : e6 4d __ INC T0 + 0 
343a : d0 f0 __ BNE $342c ; (sram_format.l23 + 0)
.s25:
343c : e6 4f __ INC T3 + 0 
343e : a5 4f __ LDA T3 + 0 
3440 : c9 02 __ CMP #$02
3442 : 90 de __ BCC $3422 ; (sram_format.l22 + 0)
.s26:
3444 : 20 90 0c JSR $0c90 ; (mdp_write_signature.s4 + 0)
3447 : a9 01 __ LDA #$01
3449 : 8d fc 27 STA $27fc ; (sram_status + 0)
344c : d0 9a __ BNE $33e8 ; (sram_format.s19 + 0)
.s29:
344e : a9 62 __ LDA #$62
3450 : 85 14 __ STA P7 
3452 : a9 1a __ LDA #$1a
3454 : 85 15 __ STA P8 
3456 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3459 : a9 0b __ LDA #$0b
345b : 85 16 __ STA P9 
345d : ad fc 27 LDA $27fc ; (sram_status + 0)
3460 : f0 07 __ BEQ $3469 ; (sram_format.s30 + 0)
.s31:
3462 : a9 34 __ LDA #$34
3464 : a0 76 __ LDY #$76
3466 : 4c 61 33 JMP $3361 ; (sram_format.s8 + 0)
.s30:
3469 : a9 02 __ LDA #$02
346b : 85 17 __ STA P10 
346d : a9 06 __ LDA #$06
346f : 85 14 __ STA P7 
3471 : a9 1e __ LDA #$1e
3473 : 4c fe 33 JMP $33fe ; (sram_format.s34 + 0)
--------------------------------------------------------------------
3476 : __ __ __ BYT 46 4f 52 4d 41 54 20 41 4c 4c 20 53 52 41 4d 3f : FORMAT ALL SRAM?
3486 : __ __ __ BYT 20 28 59 2f 4e 29 00                            :  (Y/N).
--------------------------------------------------------------------
348d : __ __ __ BYT 46 4f 52 4d 41 54 20 41 4c 4c 20 45 45 50 52 4f : FORMAT ALL EEPRO
349d : __ __ __ BYT 4d 3f 20 28 59 2f 4e 29 00                      : M? (Y/N).
--------------------------------------------------------------------
34a6 : __ __ __ BYT 4f 50 45 52 41 54 49 4f 4e 20 43 41 4e 43 45 4c : OPERATION CANCEL
34b6 : __ __ __ BYT 45 44 2e 20 20 20 20 20 20 20 20 20 20 20 20 20 : ED.             
34c6 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
34c7 : __ __ __ BYT 46 4f 52 4d 41 54 54 49 4e 47 2e 2e 2e 00       : FORMATTING....
--------------------------------------------------------------------
34d5 : __ __ __ BYT 46 4f 52 4d 41 54 20 43 4f 4d 50 4c 45 54 45 44 : FORMAT COMPLETED
34e5 : __ __ __ BYT 21 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 : !               
34f5 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
show_dump_screen: ; show_dump_screen()->void
; 761, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
34f6 : a2 0d __ LDX #$0d
34f8 : b5 53 __ LDA T0 + 0,x 
34fa : 9d 51 9b STA $9b51,x ; (show_dump_screen@stack + 0)
34fd : ca __ __ DEX
34fe : 10 f8 __ BPL $34f8 ; (show_dump_screen.s1 + 2)
.s4:
3500 : a9 0b __ LDA #$0b
3502 : 85 18 __ STA P11 
3504 : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
3507 : a9 03 __ LDA #$03
3509 : 85 16 __ STA P9 
350b : a9 07 __ LDA #$07
350d : 85 17 __ STA P10 
350f : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
3512 : 85 5c __ STA T5 + 0 
3514 : d0 07 __ BNE $351d ; (show_dump_screen.l149 + 0)
.s18:
3516 : a9 10 __ LDA #$10
3518 : a0 bc __ LDY #$bc
351a : 4c 21 35 JMP $3521 ; (show_dump_screen.l5 + 0)
.l149:
351d : a9 30 __ LDA #$30
351f : a0 4d __ LDY #$4d
.l5:
3521 : 84 14 __ STY P7 
3523 : 85 15 __ STA P8 
3525 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3528 : a9 09 __ LDA #$09
352a : 85 11 __ STA P4 
352c : a9 3e __ LDA #$3e
352e : 85 10 __ STA P3 
3530 : a9 0a __ LDA #$0a
3532 : 85 12 __ STA P5 
3534 : a9 01 __ LDA #$01
3536 : 85 13 __ STA P6 
3538 : a9 34 __ LDA #$34
353a : 85 0f __ STA P2 
353c : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
353f : a9 0b __ LDA #$0b
3541 : 85 11 __ STA P4 
3543 : a9 3e __ LDA #$3e
3545 : 85 10 __ STA P3 
3547 : a9 43 __ LDA #$43
3549 : 85 0f __ STA P2 
354b : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
354e : a9 0d __ LDA #$0d
3550 : 85 11 __ STA P4 
3552 : a9 3e __ LDA #$3e
3554 : 85 10 __ STA P3 
3556 : a9 56 __ LDA #$56
3558 : 85 0f __ STA P2 
355a : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
355d : a9 0f __ LDA #$0f
355f : 85 11 __ STA P4 
3561 : ad fd 29 LDA $29fd ; (lzo_enabled + 0)
3564 : d0 07 __ BNE $356d ; (show_dump_screen.s154 + 0)
.s156:
3566 : a9 3e __ LDA #$3e
3568 : a0 81 __ LDY #$81
356a : 4c 71 35 JMP $3571 ; (show_dump_screen.s6 + 0)
.s154:
356d : a9 3e __ LDA #$3e
356f : a0 68 __ LDY #$68
.s6:
3571 : 84 0f __ STY P2 
3573 : 85 10 __ STA P3 
3575 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
3578 : a9 2a __ LDA #$2a
357a : 85 14 __ STA P7 
357c : a9 0d __ LDA #$0d
357e : 85 17 __ STA P10 
3580 : a9 1b __ LDA #$1b
3582 : 85 15 __ STA P8 
3584 : a9 17 __ LDA #$17
3586 : 85 16 __ STA P9 
3588 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l7:
358b : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
358e : c9 6d __ CMP #$6d
3590 : d0 03 __ BNE $3595 ; (show_dump_screen.s8 + 0)
3592 : 4c 29 3e JMP $3e29 ; (show_dump_screen.s3 + 0)
.s8:
3595 : c9 4d __ CMP #$4d
3597 : f0 f9 __ BEQ $3592 ; (show_dump_screen.l7 + 7)
.s9:
3599 : c9 85 __ CMP #$85
359b : d0 03 __ BNE $35a0 ; (show_dump_screen.s10 + 0)
359d : 4c a0 3a JMP $3aa0 ; (show_dump_screen.s85 + 0)
.s10:
35a0 : c9 86 __ CMP #$86
35a2 : f0 5e __ BEQ $3602 ; (show_dump_screen.s19 + 0)
.s11:
35a4 : c9 87 __ CMP #$87
35a6 : d0 1c __ BNE $35c4 ; (show_dump_screen.s12 + 0)
.s17:
35a8 : 20 d1 42 JSR $42d1 ; (verify_backup.s1 + 0)
35ab : a9 0b __ LDA #$0b
35ad : 85 18 __ STA P11 
35af : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
35b2 : a9 03 __ LDA #$03
35b4 : 85 16 __ STA P9 
35b6 : a9 07 __ LDA #$07
35b8 : 85 17 __ STA P10 
35ba : a5 5c __ LDA T5 + 0 
35bc : f0 03 __ BEQ $35c1 ; (show_dump_screen.s17 + 25)
35be : 4c 1d 35 JMP $351d ; (show_dump_screen.l149 + 0)
35c1 : 4c 16 35 JMP $3516 ; (show_dump_screen.s18 + 0)
.s12:
35c4 : c9 88 __ CMP #$88
35c6 : d0 c3 __ BNE $358b ; (show_dump_screen.l7 + 0)
.s13:
35c8 : a9 00 __ LDA #$00
35ca : cd fd 29 CMP $29fd ; (lzo_enabled + 0)
35cd : 2a __ __ ROL
35ce : 8d fd 29 STA $29fd ; (lzo_enabled + 0)
35d1 : a9 0f __ LDA #$0f
35d3 : 85 0d __ STA P0 
35d5 : a9 0b __ LDA #$0b
35d7 : 85 0e __ STA P1 
35d9 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
35dc : a9 0f __ LDA #$0f
35de : 85 11 __ STA P4 
35e0 : a9 0a __ LDA #$0a
35e2 : 85 12 __ STA P5 
35e4 : a9 01 __ LDA #$01
35e6 : 85 13 __ STA P6 
35e8 : ad fd 29 LDA $29fd ; (lzo_enabled + 0)
35eb : d0 07 __ BNE $35f4 ; (show_dump_screen.s16 + 0)
.s14:
35ed : a9 3e __ LDA #$3e
35ef : a0 81 __ LDY #$81
35f1 : 4c f8 35 JMP $35f8 ; (show_dump_screen.s15 + 0)
.s16:
35f4 : a9 3e __ LDA #$3e
35f6 : a0 68 __ LDY #$68
.s15:
35f8 : 84 0f __ STY P2 
35fa : 85 10 __ STA P3 
35fc : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
35ff : 4c 8b 35 JMP $358b ; (show_dump_screen.l7 + 0)
.s19:
3602 : a9 17 __ LDA #$17
3604 : 85 0d __ STA P0 
3606 : a9 0b __ LDA #$0b
3608 : 85 0e __ STA P1 
360a : a9 86 __ LDA #$86
360c : 85 5d __ STA T6 + 0 
360e : a5 5c __ LDA T5 + 0 
3610 : f0 03 __ BEQ $3615 ; (show_dump_screen.s20 + 0)
3612 : 4c 95 3a JMP $3a95 ; (show_dump_screen.s84 + 0)
.s20:
3615 : ad fe 27 LDA $27fe ; (eeprom_status + 0)
3618 : f0 03 __ BEQ $361d ; (show_dump_screen.s21 + 0)
361a : 4c e5 36 JMP $36e5 ; (show_dump_screen.s23 + 0)
.s21:
361d : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
3620 : a9 0f __ LDA #$0f
3622 : 85 16 __ STA P9 
3624 : a9 02 __ LDA #$02
3626 : 85 17 __ STA P10 
3628 : a5 5c __ LDA T5 + 0 
362a : d0 07 __ BNE $3633 ; (show_dump_screen.s160 + 0)
.s87:
362c : a9 1e __ LDA #$1e
362e : a0 27 __ LDY #$27
3630 : 4c 37 36 JMP $3637 ; (show_dump_screen.s88 + 0)
.s160:
3633 : a9 1e __ LDA #$1e
3635 : a0 06 __ LDY #$06
.s88:
3637 : 84 14 __ STY P7 
3639 : 85 15 __ STA P8 
363b : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s158:
363e : a9 17 __ LDA #$17
3640 : 85 16 __ STA P9 
3642 : a9 0c __ LDA #$0c
3644 : 85 15 __ STA P8 
3646 : a9 01 __ LDA #$01
3648 : 85 17 __ STA P10 
364a : a9 cc __ LDA #$cc
364c : 85 14 __ STA P7 
364e : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l89:
3651 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
3654 : c9 0d __ CMP #$0d
3656 : d0 f9 __ BNE $3651 ; (show_dump_screen.l89 + 0)
.s90:
3658 : a9 0b __ LDA #$0b
365a : 85 18 __ STA P11 
365c : 20 32 0a JSR $0a32 ; (clear_screen.s4 + 0)
365f : a9 03 __ LDA #$03
3661 : 85 16 __ STA P9 
3663 : a9 07 __ LDA #$07
3665 : 85 17 __ STA P10 
3667 : a5 5c __ LDA T5 + 0 
3669 : d0 07 __ BNE $3672 ; (show_dump_screen.s93 + 0)
.s91:
366b : a9 10 __ LDA #$10
366d : a0 bc __ LDY #$bc
366f : 4c 76 36 JMP $3676 ; (show_dump_screen.s92 + 0)
.s93:
3672 : a9 30 __ LDA #$30
3674 : a0 4d __ LDY #$4d
.s92:
3676 : 84 14 __ STY P7 
3678 : 85 15 __ STA P8 
367a : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
367d : a9 09 __ LDA #$09
367f : 85 11 __ STA P4 
3681 : a9 3e __ LDA #$3e
3683 : 85 10 __ STA P3 
3685 : a9 0a __ LDA #$0a
3687 : 85 12 __ STA P5 
3689 : a9 01 __ LDA #$01
368b : 85 13 __ STA P6 
368d : a9 34 __ LDA #$34
368f : 85 0f __ STA P2 
3691 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
3694 : a9 0b __ LDA #$0b
3696 : 85 11 __ STA P4 
3698 : a9 3e __ LDA #$3e
369a : 85 10 __ STA P3 
369c : a9 43 __ LDA #$43
369e : 85 0f __ STA P2 
36a0 : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
36a3 : a9 0d __ LDA #$0d
36a5 : 85 11 __ STA P4 
36a7 : a9 3e __ LDA #$3e
36a9 : 85 10 __ STA P3 
36ab : a9 56 __ LDA #$56
36ad : 85 0f __ STA P2 
36af : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
36b2 : a9 0f __ LDA #$0f
36b4 : 85 11 __ STA P4 
36b6 : ad fd 29 LDA $29fd ; (lzo_enabled + 0)
36b9 : d0 07 __ BNE $36c2 ; (show_dump_screen.s155 + 0)
.s157:
36bb : a9 3e __ LDA #$3e
36bd : a0 81 __ LDY #$81
36bf : 4c c6 36 JMP $36c6 ; (show_dump_screen.s22 + 0)
.s155:
36c2 : a9 3e __ LDA #$3e
36c4 : a0 68 __ LDY #$68
.s22:
36c6 : 84 0f __ STY P2 
36c8 : 85 10 __ STA P3 
36ca : 20 1e 0b JSR $0b1e ; (print_at.s4 + 0)
36cd : a9 2a __ LDA #$2a
36cf : 85 14 __ STA P7 
36d1 : a9 0d __ LDA #$0d
36d3 : 85 17 __ STA P10 
36d5 : a9 1b __ LDA #$1b
36d7 : 85 15 __ STA P8 
36d9 : a9 17 __ LDA #$17
36db : 85 16 __ STA P9 
36dd : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
36e0 : a5 5d __ LDA T6 + 0 
36e2 : 4c c4 35 JMP $35c4 ; (show_dump_screen.s12 + 0)
.s23:
36e5 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
36e8 : a9 0f __ LDA #$0f
36ea : 85 16 __ STA P9 
36ec : a9 3e __ LDA #$3e
36ee : 85 15 __ STA P8 
36f0 : a9 03 __ LDA #$03
36f2 : 85 17 __ STA P10 
36f4 : a9 9b __ LDA #$9b
36f6 : 85 14 __ STA P7 
36f8 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
36fb : a5 5c __ LDA T5 + 0 
36fd : d0 0f __ BNE $370e ; (show_dump_screen.s83 + 0)
.s24:
36ff : a9 3e __ LDA #$3e
3701 : 85 54 __ STA T0 + 1 
3703 : 85 56 __ STA T1 + 1 
3705 : a9 3e __ LDA #$3e
3707 : a0 ee __ LDY #$ee
3709 : a2 da __ LDX #$da
370b : 4c 1a 37 JMP $371a ; (show_dump_screen.s25 + 0)
.s83:
370e : a9 3e __ LDA #$3e
3710 : 85 54 __ STA T0 + 1 
3712 : 85 56 __ STA T1 + 1 
3714 : a9 3e __ LDA #$3e
3716 : a0 cb __ LDY #$cb
3718 : a2 b9 __ LDX #$b9
.s25:
371a : 84 57 __ STY T2 + 0 
371c : 86 55 __ STX T1 + 0 
371e : 86 0d __ STX P0 
3720 : 85 58 __ STA T2 + 1 
3722 : a5 54 __ LDA T0 + 1 
3724 : 85 0e __ STA P1 
3726 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3729 : a9 03 __ LDA #$03
372b : 85 0d __ STA P0 
372d : 85 0f __ STA P2 
372f : a9 08 __ LDA #$08
3731 : 85 0e __ STA P1 
3733 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3736 : 85 53 __ STA T0 + 0 
3738 : a9 00 __ LDA #$00
373a : 85 59 __ STA T3 + 0 
373c : 85 5b __ STA T4 + 0 
373e : a9 ff __ LDA #$ff
3740 : 85 0d __ STA P0 
3742 : a9 0d __ LDA #$0d
3744 : 85 0e __ STA P1 
3746 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3749 : a9 0f __ LDA #$0f
374b : 85 0d __ STA P0 
374d : 85 0f __ STA P2 
374f : a9 08 __ LDA #$08
3751 : 85 0e __ STA P1 
3753 : a5 53 __ LDA T0 + 0 
3755 : f0 03 __ BEQ $375a ; (show_dump_screen.s26 + 0)
3757 : 4c 55 3a JMP $3a55 ; (show_dump_screen.s77 + 0)
.s26:
375a : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
375d : aa __ __ TAX
375e : f0 05 __ BEQ $3765 ; (show_dump_screen.s27 + 0)
.s76:
3760 : a9 0f __ LDA #$0f
.s153:
3762 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s27:
3765 : a5 57 __ LDA T2 + 0 
3767 : 85 0d __ STA P0 
3769 : a5 58 __ LDA T2 + 1 
376b : 85 0e __ STA P1 
376d : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3770 : a9 03 __ LDA #$03
3772 : 85 0d __ STA P0 
3774 : 85 0f __ STA P2 
3776 : a9 08 __ LDA #$08
3778 : 85 0e __ STA P1 
377a : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
377d : aa __ __ TAX
377e : f0 03 __ BEQ $3783 ; (show_dump_screen.s28 + 0)
3780 : 4c 00 3a JMP $3a00 ; (show_dump_screen.s70 + 0)
.s28:
3783 : a9 ff __ LDA #$ff
3785 : 85 0d __ STA P0 
3787 : a9 0d __ LDA #$0d
3789 : 85 0e __ STA P1 
378b : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
378e : a9 0f __ LDA #$0f
3790 : 85 0d __ STA P0 
3792 : 85 0f __ STA P2 
3794 : a9 08 __ LDA #$08
3796 : 85 0e __ STA P1 
3798 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
379b : aa __ __ TAX
379c : f0 05 __ BEQ $37a3 ; (show_dump_screen.s29 + 0)
.s69:
379e : a9 0f __ LDA #$0f
.s152:
37a0 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s29:
37a3 : a9 0f __ LDA #$0f
37a5 : 85 0d __ STA P0 
37a7 : a9 0b __ LDA #$0b
37a9 : 85 0e __ STA P1 
37ab : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
37ae : ad fd 29 LDA $29fd ; (lzo_enabled + 0)
37b1 : f0 03 __ BEQ $37b6 ; (show_dump_screen.s30 + 0)
37b3 : 4c ef 39 JMP $39ef ; (show_dump_screen.s67 + 0)
.s30:
37b6 : a5 5b __ LDA T4 + 0 
37b8 : f0 04 __ BEQ $37be ; (show_dump_screen.s31 + 0)
.s66:
37ba : a9 00 __ LDA #$00
37bc : f0 11 __ BEQ $37cf ; (show_dump_screen.s33 + 0)
.s31:
37be : a5 59 __ LDA T3 + 0 
37c0 : d0 0d __ BNE $37cf ; (show_dump_screen.s33 + 0)
.s32:
37c2 : c6 17 __ DEC P10 
37c4 : a9 13 __ LDA #$13
37c6 : 85 16 __ STA P9 
37c8 : a9 41 __ LDA #$41
37ca : a0 c2 __ LDY #$c2
37cc : 4c 37 36 JMP $3637 ; (show_dump_screen.s88 + 0)
.s33:
37cf : 85 5b __ STA T4 + 0 
37d1 : a9 13 __ LDA #$13
37d3 : 85 16 __ STA P9 
37d5 : a9 41 __ LDA #$41
37d7 : 85 15 __ STA P8 
37d9 : a9 e0 __ LDA #$e0
37db : 85 14 __ STA P7 
37dd : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
37e0 : a5 5b __ LDA T4 + 0 
37e2 : d0 08 __ BNE $37ec ; (show_dump_screen.s35 + 0)
.s34:
37e4 : a5 57 __ LDA T2 + 0 
37e6 : 85 55 __ STA T1 + 0 
37e8 : a5 58 __ LDA T2 + 1 
37ea : 85 56 __ STA T1 + 1 
.s35:
37ec : a5 55 __ LDA T1 + 0 
37ee : 85 0d __ STA P0 
37f0 : a5 56 __ LDA T1 + 1 
37f2 : 85 0e __ STA P1 
37f4 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
37f7 : a9 03 __ LDA #$03
37f9 : 85 0d __ STA P0 
37fb : 85 0f __ STA P2 
37fd : a9 08 __ LDA #$08
37ff : 85 0e __ STA P1 
3801 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3804 : aa __ __ TAX
3805 : d0 09 __ BNE $3810 ; (show_dump_screen.s37 + 0)
.s36:
3807 : c6 17 __ DEC P10 
3809 : a9 27 __ LDA #$27
380b : a0 a3 __ LDY #$a3
380d : 4c 37 36 JMP $3637 ; (show_dump_screen.s88 + 0)
.s37:
3810 : a9 03 __ LDA #$03
3812 : 20 33 22 JSR $2233 ; (krnio_chkin.s4 + 0)
3815 : aa __ __ TAX
3816 : d0 15 __ BNE $382d ; (show_dump_screen.s38 + 0)
.s161:
3818 : c6 17 __ DEC P10 
381a : a9 27 __ LDA #$27
381c : a0 bf __ LDY #$bf
.s159:
381e : 84 14 __ STY P7 
3820 : 85 15 __ STA P8 
3822 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s103:
3825 : a9 03 __ LDA #$03
3827 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
382a : 4c 3e 36 JMP $363e ; (show_dump_screen.s158 + 0)
.s38:
382d : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
3830 : 85 5e __ STA T7 + 0 
3832 : a5 5c __ LDA T5 + 0 
3834 : f0 17 __ BEQ $384d ; (show_dump_screen.s39 + 0)
.s65:
3836 : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
3839 : a9 00 __ LDA #$00
383b : 85 57 __ STA T2 + 0 
383d : a9 02 __ LDA #$02
383f : 85 58 __ STA T2 + 1 
.s41:
3841 : a9 00 __ LDA #$00
3843 : 85 59 __ STA T3 + 0 
3845 : 85 5a __ STA T3 + 1 
3847 : a9 01 __ LDA #$01
3849 : 85 5f __ STA T8 + 0 
384b : d0 15 __ BNE $3862 ; (show_dump_screen.l42 + 0)
.s39:
384d : a9 20 __ LDA #$20
384f : cd fd 27 CMP $27fd ; (eeprom_size_kb + 0)
3852 : d0 02 __ BNE $3856 ; (show_dump_screen.s40 + 0)
.s64:
3854 : a9 80 __ LDA #$80
.s40:
3856 : 85 57 __ STA T2 + 0 
3858 : a9 00 __ LDA #$00
385a : 85 58 __ STA T2 + 1 
385c : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
385f : 4c 41 38 JMP $3841 ; (show_dump_screen.s41 + 0)
.l42:
3862 : a5 59 __ LDA T3 + 0 
3864 : 85 1b __ STA ACCU + 0 
3866 : a5 5a __ LDA T3 + 1 
3868 : 85 1c __ STA ACCU + 1 
386a : a9 00 __ LDA #$00
386c : 85 1d __ STA ACCU + 2 
386e : 85 1e __ STA ACCU + 3 
3870 : a9 64 __ LDA #$64
3872 : 20 17 48 JSR $4817 ; (mul32by8 + 0)
3875 : a5 07 __ LDA WORK + 4 
3877 : 85 1b __ STA ACCU + 0 
3879 : a5 08 __ LDA WORK + 5 
387b : 85 1c __ STA ACCU + 1 
387d : a5 09 __ LDA WORK + 6 
387f : 85 1d __ STA ACCU + 2 
3881 : a5 0a __ LDA WORK + 7 
3883 : 85 1e __ STA ACCU + 3 
3885 : a5 57 __ LDA T2 + 0 
3887 : 85 03 __ STA WORK + 0 
3889 : a5 58 __ LDA T2 + 1 
388b : 85 04 __ STA WORK + 1 
388d : a9 00 __ LDA #$00
388f : 85 0e __ STA P1 
3891 : 85 05 __ STA WORK + 2 
3893 : 85 06 __ STA WORK + 3 
3895 : 20 d2 48 JSR $48d2 ; (divmod32 + 0)
3898 : a5 1b __ LDA ACCU + 0 
389a : 85 0d __ STA P0 
389c : a9 8b __ LDA #$8b
389e : 85 0f __ STA P2 
38a0 : a9 9c __ LDA #$9c
38a2 : 85 10 __ STA P3 
38a4 : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
38a7 : a9 8b __ LDA #$8b
38a9 : 85 0d __ STA P0 
38ab : a9 9c __ LDA #$9c
38ad : 85 0e __ STA P1 
38af : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
38b2 : a9 25 __ LDA #$25
38b4 : a6 1b __ LDX ACCU + 0 
38b6 : 9d 8b 9c STA $9c8b,x ; (pct_str[0] + 0)
38b9 : a9 8b __ LDA #$8b
38bb : 85 14 __ STA P7 
38bd : a9 9c __ LDA #$9c
38bf : 85 15 __ STA P8 
38c1 : a9 13 __ LDA #$13
38c3 : 85 16 __ STA P9 
38c5 : a9 07 __ LDA #$07
38c7 : 85 17 __ STA P10 
38c9 : a9 00 __ LDA #$00
38cb : 9d 8c 9c STA $9c8c,x ; (pct_str[0] + 1)
38ce : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
38d1 : a5 5c __ LDA T5 + 0 
38d3 : f0 05 __ BEQ $38da ; (show_dump_screen.s43 + 0)
.s63:
38d5 : a5 5a __ LDA T3 + 1 
38d7 : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
.s43:
38da : a5 59 __ LDA T3 + 0 
38dc : 8d 01 de STA $de01 
38df : a5 5b __ LDA T4 + 0 
38e1 : f0 03 __ BEQ $38e6 ; (show_dump_screen.s44 + 0)
38e3 : 4c d1 39 JMP $39d1 ; (show_dump_screen.s61 + 0)
.s44:
38e6 : 85 55 __ STA T1 + 0 
.l45:
38e8 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
38eb : 85 60 __ STA T9 + 0 
38ed : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
38f0 : aa __ __ TAX
38f1 : f0 04 __ BEQ $38f7 ; (show_dump_screen.s46 + 0)
.s60:
38f3 : c9 40 __ CMP #$40
38f5 : d0 2a __ BNE $3921 ; (show_dump_screen.s49 + 0)
.s46:
38f7 : a5 60 __ LDA T9 + 0 
38f9 : a6 55 __ LDX T1 + 0 
38fb : 9d 8b 9b STA $9b8b,x ; (page_buf[0] + 0)
38fe : e6 55 __ INC T1 + 0 
3900 : d0 e6 __ BNE $38e8 ; (show_dump_screen.l45 + 0)
.s47:
3902 : a5 5c __ LDA T5 + 0 
3904 : f0 03 __ BEQ $3909 ; (show_dump_screen.s48 + 0)
3906 : 4c c3 39 JMP $39c3 ; (show_dump_screen.s58 + 0)
.s48:
3909 : a5 59 __ LDA T3 + 0 
390b : 85 11 __ STA P4 
390d : ad fd 27 LDA $27fd ; (eeprom_size_kb + 0)
3910 : 85 14 __ STA P7 
3912 : a9 8b __ LDA #$8b
3914 : 85 12 __ STA P5 
3916 : a9 9b __ LDA #$9b
3918 : 85 13 __ STA P6 
391a : 20 44 29 JSR $2944 ; (mdp_eeprom_write_cart_page.s4 + 0)
391d : a5 1b __ LDA ACCU + 0 
391f : d0 04 __ BNE $3925 ; (show_dump_screen.s56 + 0)
.s49:
3921 : c6 5f __ DEC T8 + 0 
3923 : f0 17 __ BEQ $393c ; (show_dump_screen.s50 + 0)
.s56:
3925 : e6 59 __ INC T3 + 0 
3927 : d0 02 __ BNE $392b ; (show_dump_screen.s166 + 0)
.s165:
3929 : e6 5a __ INC T3 + 1 
.s166:
392b : a5 5a __ LDA T3 + 1 
392d : c5 58 __ CMP T2 + 1 
392f : b0 03 __ BCS $3934 ; (show_dump_screen.s168 + 0)
3931 : 4c 62 38 JMP $3862 ; (show_dump_screen.l42 + 0)
.s168:
3934 : d0 06 __ BNE $393c ; (show_dump_screen.s50 + 0)
.s57:
3936 : a5 59 __ LDA T3 + 0 
3938 : c5 57 __ CMP T2 + 0 
393a : 90 f5 __ BCC $3931 ; (show_dump_screen.s166 + 6)
.s50:
393c : a5 5e __ LDA T7 + 0 
393e : 8d 03 de STA $de03 
3941 : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
3944 : 20 fc 1a JSR $1afc ; (krnio_clrchn.s4 + 0)
3947 : a5 5f __ LDA T8 + 0 
3949 : f0 1e __ BEQ $3969 ; (show_dump_screen.s51 + 0)
.s55:
394b : a9 13 __ LDA #$13
394d : 85 16 __ STA P9 
394f : a9 32 __ LDA #$32
3951 : 85 15 __ STA P8 
3953 : a9 07 __ LDA #$07
3955 : 85 17 __ STA P10 
3957 : a9 f9 __ LDA #$f9
3959 : 85 14 __ STA P7 
395b : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
395e : a9 05 __ LDA #$05
3960 : 85 17 __ STA P10 
3962 : a9 42 __ LDA #$42
3964 : a0 b2 __ LDY #$b2
3966 : 4c 1e 38 JMP $381e ; (show_dump_screen.s159 + 0)
.s51:
3969 : 8d 63 9b STA $9b63 ; (dos_err[0] + 0)
396c : a9 ff __ LDA #$ff
396e : 85 0d __ STA P0 
3970 : a9 0d __ LDA #$0d
3972 : 85 0e __ STA P1 
3974 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3977 : a9 0f __ LDA #$0f
3979 : 85 0d __ STA P0 
397b : 85 0f __ STA P2 
397d : a9 08 __ LDA #$08
397f : 85 0e __ STA P1 
3981 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3984 : aa __ __ TAX
3985 : f0 18 __ BEQ $399f ; (show_dump_screen.s52 + 0)
.s54:
3987 : a9 63 __ LDA #$63
3989 : 85 0e __ STA P1 
398b : a9 00 __ LDA #$00
398d : 85 11 __ STA P4 
398f : a9 9b __ LDA #$9b
3991 : 85 0f __ STA P2 
3993 : a9 28 __ LDA #$28
3995 : 85 10 __ STA P3 
3997 : 20 7a 30 JSR $307a ; (read_dos_status.s4 + 0)
399a : a9 0f __ LDA #$0f
399c : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s52:
399f : a9 13 __ LDA #$13
39a1 : 85 16 __ STA P9 
39a3 : a9 28 __ LDA #$28
39a5 : 85 15 __ STA P8 
39a7 : a9 02 __ LDA #$02
39a9 : 85 17 __ STA P10 
39ab : a9 0f __ LDA #$0f
39ad : 85 14 __ STA P7 
39af : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
39b2 : ad 63 9b LDA $9b63 ; (dos_err[0] + 0)
39b5 : d0 03 __ BNE $39ba ; (show_dump_screen.s53 + 0)
39b7 : 4c 25 38 JMP $3825 ; (show_dump_screen.s103 + 0)
.s53:
39ba : a9 9b __ LDA #$9b
39bc : a0 63 __ LDY #$63
.s162:
39be : e6 17 __ INC P10 
39c0 : 4c 1e 38 JMP $381e ; (show_dump_screen.s159 + 0)
.s58:
39c3 : a2 00 __ LDX #$00
.l59:
39c5 : bd 8b 9b LDA $9b8b,x ; (page_buf[0] + 0)
39c8 : 9d 00 df STA $df00,x 
39cb : e8 __ __ INX
39cc : d0 f7 __ BNE $39c5 ; (show_dump_screen.l59 + 0)
39ce : 4c 25 39 JMP $3925 ; (show_dump_screen.s56 + 0)
.s61:
39d1 : a9 03 __ LDA #$03
39d3 : 85 0e __ STA P1 
39d5 : a9 9b __ LDA #$9b
39d7 : 85 10 __ STA P3 
39d9 : a9 8b __ LDA #$8b
39db : 85 0f __ STA P2 
39dd : 20 fc 41 JSR $41fc ; (krnio_read_lzo.s4 + 0)
39e0 : a6 1c __ LDX ACCU + 1 
39e2 : ca __ __ DEX
39e3 : f0 03 __ BEQ $39e8 ; (show_dump_screen.s62 + 0)
39e5 : 4c 21 39 JMP $3921 ; (show_dump_screen.s49 + 0)
.s62:
39e8 : a5 1b __ LDA ACCU + 0 
39ea : d0 f9 __ BNE $39e5 ; (show_dump_screen.s61 + 20)
39ec : 4c 02 39 JMP $3902 ; (show_dump_screen.s47 + 0)
.s67:
39ef : a5 59 __ LDA T3 + 0 
39f1 : f0 03 __ BEQ $39f6 ; (show_dump_screen.s68 + 0)
39f3 : 4c cf 37 JMP $37cf ; (show_dump_screen.s33 + 0)
.s68:
39f6 : a5 5b __ LDA T4 + 0 
39f8 : d0 03 __ BNE $39fd ; (show_dump_screen.s68 + 7)
39fa : 4c c2 37 JMP $37c2 ; (show_dump_screen.s32 + 0)
39fd : 4c ba 37 JMP $37ba ; (show_dump_screen.s66 + 0)
.s70:
3a00 : a9 ff __ LDA #$ff
3a02 : 85 0d __ STA P0 
3a04 : a9 0d __ LDA #$0d
3a06 : 85 0e __ STA P1 
3a08 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3a0b : a9 0f __ LDA #$0f
3a0d : 85 0d __ STA P0 
3a0f : 85 0f __ STA P2 
3a11 : a9 08 __ LDA #$08
3a13 : 85 0e __ STA P1 
3a15 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3a18 : aa __ __ TAX
3a19 : f0 35 __ BEQ $3a50 ; (show_dump_screen.s71 + 0)
.s72:
3a1b : a9 28 __ LDA #$28
3a1d : 85 10 __ STA P3 
3a1f : a9 9c __ LDA #$9c
3a21 : 85 0f __ STA P2 
3a23 : a9 00 __ LDA #$00
3a25 : 85 11 __ STA P4 
3a27 : a9 93 __ LDA #$93
3a29 : 85 0e __ STA P1 
3a2b : 20 7a 30 JSR $307a ; (read_dos_status.s4 + 0)
3a2e : ad 93 9c LDA $9c93 ; (temp_status[0] + 0)
3a31 : c9 30 __ CMP #$30
3a33 : d0 16 __ BNE $3a4b ; (show_dump_screen.s73 + 0)
.s74:
3a35 : ad 94 9c LDA $9c94 ; (temp_status[0] + 1)
3a38 : c9 30 __ CMP #$30
3a3a : d0 0f __ BNE $3a4b ; (show_dump_screen.s73 + 0)
.s75:
3a3c : a9 0f __ LDA #$0f
3a3e : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
3a41 : a9 03 __ LDA #$03
3a43 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
3a46 : e6 5b __ INC T4 + 0 
3a48 : 4c a3 37 JMP $37a3 ; (show_dump_screen.s29 + 0)
.s73:
3a4b : a9 0f __ LDA #$0f
3a4d : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s71:
3a50 : a9 03 __ LDA #$03
3a52 : 4c a0 37 JMP $37a0 ; (show_dump_screen.s152 + 0)
.s77:
3a55 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3a58 : aa __ __ TAX
3a59 : f0 35 __ BEQ $3a90 ; (show_dump_screen.s78 + 0)
.s79:
3a5b : a9 28 __ LDA #$28
3a5d : 85 10 __ STA P3 
3a5f : a9 9c __ LDA #$9c
3a61 : 85 0f __ STA P2 
3a63 : a9 00 __ LDA #$00
3a65 : 85 11 __ STA P4 
3a67 : a9 bb __ LDA #$bb
3a69 : 85 0e __ STA P1 
3a6b : 20 7a 30 JSR $307a ; (read_dos_status.s4 + 0)
3a6e : ad bb 9c LDA $9cbb ; (temp_status[0] + 0)
3a71 : c9 30 __ CMP #$30
3a73 : d0 16 __ BNE $3a8b ; (show_dump_screen.s80 + 0)
.s81:
3a75 : ad bc 9c LDA $9cbc ; (temp_status[0] + 1)
3a78 : c9 30 __ CMP #$30
3a7a : d0 0f __ BNE $3a8b ; (show_dump_screen.s80 + 0)
.s82:
3a7c : a9 0f __ LDA #$0f
3a7e : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
3a81 : a9 03 __ LDA #$03
3a83 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
3a86 : e6 59 __ INC T3 + 0 
3a88 : 4c 65 37 JMP $3765 ; (show_dump_screen.s27 + 0)
.s80:
3a8b : a9 0f __ LDA #$0f
3a8d : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s78:
3a90 : a9 03 __ LDA #$03
3a92 : 4c 62 37 JMP $3762 ; (show_dump_screen.s153 + 0)
.s84:
3a95 : ad fc 27 LDA $27fc ; (sram_status + 0)
3a98 : f0 03 __ BEQ $3a9d ; (show_dump_screen.s84 + 8)
3a9a : 4c e5 36 JMP $36e5 ; (show_dump_screen.s23 + 0)
3a9d : 4c 1d 36 JMP $361d ; (show_dump_screen.s21 + 0)
.s85:
3aa0 : a9 17 __ LDA #$17
3aa2 : 85 0d __ STA P0 
3aa4 : a9 0b __ LDA #$0b
3aa6 : 85 0e __ STA P1 
3aa8 : a9 85 __ LDA #$85
3aaa : 85 5d __ STA T6 + 0 
3aac : a5 5c __ LDA T5 + 0 
3aae : d0 03 __ BNE $3ab3 ; (show_dump_screen.s148 + 0)
3ab0 : 4c 1e 3e JMP $3e1e ; (show_dump_screen.s86 + 0)
.s148:
3ab3 : ad fc 27 LDA $27fc ; (sram_status + 0)
3ab6 : f0 e5 __ BEQ $3a9d ; (show_dump_screen.s84 + 8)
.s94:
3ab8 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
3abb : a9 0f __ LDA #$0f
3abd : 85 16 __ STA P9 
3abf : a9 3e __ LDA #$3e
3ac1 : 85 15 __ STA P8 
3ac3 : a9 03 __ LDA #$03
3ac5 : 85 17 __ STA P10 
3ac7 : a9 9b __ LDA #$9b
3ac9 : 85 14 __ STA P7 
3acb : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3ace : ad fd 29 LDA $29fd ; (lzo_enabled + 0)
3ad1 : 85 5e __ STA T7 + 0 
3ad3 : a9 00 __ LDA #$00
3ad5 : 85 59 __ STA T3 + 0 
3ad7 : a5 5c __ LDA T5 + 0 
3ad9 : f0 03 __ BEQ $3ade ; (show_dump_screen.s95 + 0)
3adb : 4c f0 3d JMP $3df0 ; (show_dump_screen.s145 + 0)
.s95:
3ade : a5 5e __ LDA T7 + 0 
3ae0 : d0 15 __ BNE $3af7 ; (show_dump_screen.s144 + 0)
.s96:
3ae2 : a9 3e __ LDA #$3e
3ae4 : 85 54 __ STA T0 + 1 
3ae6 : a9 35 __ LDA #$35
3ae8 : 85 55 __ STA T1 + 0 
3aea : a9 3f __ LDA #$3f
3aec : 85 56 __ STA T1 + 1 
3aee : a9 3f __ LDA #$3f
3af0 : a0 78 __ LDY #$78
3af2 : a2 ee __ LDX #$ee
3af4 : 4c 09 3b JMP $3b09 ; (show_dump_screen.s97 + 0)
.s144:
3af7 : a9 3e __ LDA #$3e
3af9 : 85 54 __ STA T0 + 1 
3afb : a9 21 __ LDA #$21
3afd : 85 55 __ STA T1 + 0 
3aff : a9 3f __ LDA #$3f
3b01 : 85 56 __ STA T1 + 1 
3b03 : a9 3f __ LDA #$3f
3b05 : a0 65 __ LDY #$65
3b07 : a2 da __ LDX #$da
.s97:
3b09 : 86 0d __ STX P0 
3b0b : 84 57 __ STY T2 + 0 
3b0d : 85 58 __ STA T2 + 1 
3b0f : a5 54 __ LDA T0 + 1 
3b11 : 85 0e __ STA P1 
3b13 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3b16 : a9 03 __ LDA #$03
3b18 : 85 0d __ STA P0 
3b1a : 85 0f __ STA P2 
3b1c : a9 08 __ LDA #$08
3b1e : 85 0e __ STA P1 
3b20 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3b23 : aa __ __ TAX
3b24 : f0 03 __ BEQ $3b29 ; (show_dump_screen.s98 + 0)
3b26 : 4c 9b 3d JMP $3d9b ; (show_dump_screen.s138 + 0)
.s98:
3b29 : a9 ff __ LDA #$ff
3b2b : 85 0d __ STA P0 
3b2d : a9 0d __ LDA #$0d
3b2f : 85 0e __ STA P1 
3b31 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3b34 : a9 0f __ LDA #$0f
3b36 : 85 0d __ STA P0 
3b38 : 85 0f __ STA P2 
3b3a : a9 08 __ LDA #$08
3b3c : 85 0e __ STA P1 
3b3e : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3b41 : aa __ __ TAX
3b42 : f0 05 __ BEQ $3b49 ; (show_dump_screen.s99 + 0)
.s137:
3b44 : a9 0f __ LDA #$0f
.s151:
3b46 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s99:
3b49 : a9 0f __ LDA #$0f
3b4b : 85 0d __ STA P0 
3b4d : a9 0b __ LDA #$0b
3b4f : 85 0e __ STA P1 
3b51 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
3b54 : a5 59 __ LDA T3 + 0 
3b56 : f0 6b __ BEQ $3bc3 ; (show_dump_screen.s100 + 0)
.s128:
3b58 : a9 11 __ LDA #$11
3b5a : 85 16 __ STA P9 
3b5c : a9 3f __ LDA #$3f
3b5e : 85 15 __ STA P8 
3b60 : a9 07 __ LDA #$07
3b62 : 85 17 __ STA P10 
3b64 : a9 88 __ LDA #$88
3b66 : 85 14 __ STA P7 
3b68 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l129:
3b6b : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
3b6e : aa __ __ TAX
3b6f : f0 fa __ BEQ $3b6b ; (show_dump_screen.l129 + 0)
.s130:
3b71 : c9 79 __ CMP #$79
3b73 : f0 1b __ BEQ $3b90 ; (show_dump_screen.s135 + 0)
.s131:
3b75 : c9 59 __ CMP #$59
3b77 : f0 17 __ BEQ $3b90 ; (show_dump_screen.s135 + 0)
.s132:
3b79 : c9 6e __ CMP #$6e
3b7b : f0 04 __ BEQ $3b81 ; (show_dump_screen.s134 + 0)
.s133:
3b7d : c9 4e __ CMP #$4e
3b7f : d0 ea __ BNE $3b6b ; (show_dump_screen.l129 + 0)
.s134:
3b81 : a9 13 __ LDA #$13
3b83 : 85 16 __ STA P9 
3b85 : a9 02 __ LDA #$02
3b87 : 85 17 __ STA P10 
3b89 : a9 34 __ LDA #$34
3b8b : a0 a6 __ LDY #$a6
3b8d : 4c 37 36 JMP $3637 ; (show_dump_screen.s88 + 0)
.s135:
3b90 : a9 13 __ LDA #$13
3b92 : 85 16 __ STA P9 
3b94 : a9 3f __ LDA #$3f
3b96 : 85 15 __ STA P8 
3b98 : a9 03 __ LDA #$03
3b9a : 85 17 __ STA P10 
3b9c : a9 a5 __ LDA #$a5
3b9e : 85 14 __ STA P7 
3ba0 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3ba3 : a5 57 __ LDA T2 + 0 
3ba5 : 85 0d __ STA P0 
3ba7 : a5 58 __ LDA T2 + 1 
3ba9 : 85 0e __ STA P1 
3bab : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3bae : a9 0f __ LDA #$0f
3bb0 : 85 0d __ STA P0 
3bb2 : 85 0f __ STA P2 
3bb4 : a9 08 __ LDA #$08
3bb6 : 85 0e __ STA P1 
3bb8 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3bbb : aa __ __ TAX
3bbc : f0 05 __ BEQ $3bc3 ; (show_dump_screen.s100 + 0)
.s136:
3bbe : a9 0f __ LDA #$0f
3bc0 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s100:
3bc3 : a9 13 __ LDA #$13
3bc5 : 85 16 __ STA P9 
3bc7 : a9 3f __ LDA #$3f
3bc9 : 85 15 __ STA P8 
3bcb : a9 bf __ LDA #$bf
3bcd : 85 14 __ STA P7 
3bcf : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3bd2 : a5 55 __ LDA T1 + 0 
3bd4 : 85 0d __ STA P0 
3bd6 : a5 56 __ LDA T1 + 1 
3bd8 : 85 0e __ STA P1 
3bda : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3bdd : a9 03 __ LDA #$03
3bdf : 85 0d __ STA P0 
3be1 : 85 0f __ STA P2 
3be3 : a9 08 __ LDA #$08
3be5 : 85 0e __ STA P1 
3be7 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3bea : aa __ __ TAX
3beb : d0 03 __ BNE $3bf0 ; (show_dump_screen.s102 + 0)
3bed : 4c 92 3d JMP $3d92 ; (show_dump_screen.s101 + 0)
.s102:
3bf0 : a9 03 __ LDA #$03
3bf2 : 20 db 3f JSR $3fdb ; (krnio_chkout.s4 + 0)
3bf5 : aa __ __ TAX
3bf6 : d0 03 __ BNE $3bfb ; (show_dump_screen.s104 + 0)
3bf8 : 4c 18 38 JMP $3818 ; (show_dump_screen.s161 + 0)
.s104:
3bfb : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
3bfe : 85 5f __ STA T8 + 0 
3c00 : a5 5c __ LDA T5 + 0 
3c02 : f0 17 __ BEQ $3c1b ; (show_dump_screen.s105 + 0)
.s127:
3c04 : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
3c07 : a9 00 __ LDA #$00
3c09 : 85 57 __ STA T2 + 0 
3c0b : a9 02 __ LDA #$02
3c0d : 85 58 __ STA T2 + 1 
.s107:
3c0f : a9 00 __ LDA #$00
3c11 : 85 59 __ STA T3 + 0 
3c13 : 85 5a __ STA T3 + 1 
3c15 : a9 01 __ LDA #$01
3c17 : 85 60 __ STA T9 + 0 
3c19 : d0 15 __ BNE $3c30 ; (show_dump_screen.l108 + 0)
.s105:
3c1b : a9 20 __ LDA #$20
3c1d : cd fd 27 CMP $27fd ; (eeprom_size_kb + 0)
3c20 : d0 02 __ BNE $3c24 ; (show_dump_screen.s106 + 0)
.s126:
3c22 : a9 80 __ LDA #$80
.s106:
3c24 : 85 57 __ STA T2 + 0 
3c26 : a9 00 __ LDA #$00
3c28 : 85 58 __ STA T2 + 1 
3c2a : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
3c2d : 4c 0f 3c JMP $3c0f ; (show_dump_screen.s107 + 0)
.l108:
3c30 : a5 59 __ LDA T3 + 0 
3c32 : 85 1b __ STA ACCU + 0 
3c34 : a5 5a __ LDA T3 + 1 
3c36 : 85 1c __ STA ACCU + 1 
3c38 : a9 00 __ LDA #$00
3c3a : 85 1d __ STA ACCU + 2 
3c3c : 85 1e __ STA ACCU + 3 
3c3e : a9 64 __ LDA #$64
3c40 : 20 17 48 JSR $4817 ; (mul32by8 + 0)
3c43 : a5 07 __ LDA WORK + 4 
3c45 : 85 1b __ STA ACCU + 0 
3c47 : a5 08 __ LDA WORK + 5 
3c49 : 85 1c __ STA ACCU + 1 
3c4b : a5 09 __ LDA WORK + 6 
3c4d : 85 1d __ STA ACCU + 2 
3c4f : a5 0a __ LDA WORK + 7 
3c51 : 85 1e __ STA ACCU + 3 
3c53 : a5 57 __ LDA T2 + 0 
3c55 : 85 03 __ STA WORK + 0 
3c57 : a5 58 __ LDA T2 + 1 
3c59 : 85 04 __ STA WORK + 1 
3c5b : a9 00 __ LDA #$00
3c5d : 85 0e __ STA P1 
3c5f : 85 05 __ STA WORK + 2 
3c61 : 85 06 __ STA WORK + 3 
3c63 : 20 d2 48 JSR $48d2 ; (divmod32 + 0)
3c66 : a5 1b __ LDA ACCU + 0 
3c68 : 85 0d __ STA P0 
3c6a : a9 0b __ LDA #$0b
3c6c : 85 0f __ STA P2 
3c6e : a9 9e __ LDA #$9e
3c70 : 85 10 __ STA P3 
3c72 : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
3c75 : a9 0b __ LDA #$0b
3c77 : 85 0d __ STA P0 
3c79 : a9 9e __ LDA #$9e
3c7b : 85 0e __ STA P1 
3c7d : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
3c80 : a9 25 __ LDA #$25
3c82 : a6 1b __ LDX ACCU + 0 
3c84 : 9d 0b 9e STA $9e0b,x ; (pct_str[0] + 0)
3c87 : a9 0b __ LDA #$0b
3c89 : 85 14 __ STA P7 
3c8b : a9 9e __ LDA #$9e
3c8d : 85 15 __ STA P8 
3c8f : a9 13 __ LDA #$13
3c91 : 85 16 __ STA P9 
3c93 : a9 07 __ LDA #$07
3c95 : 85 17 __ STA P10 
3c97 : a9 00 __ LDA #$00
3c99 : 9d 0c 9e STA $9e0c,x ; (pct_str[0] + 1)
3c9c : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3c9f : a5 5c __ LDA T5 + 0 
3ca1 : f0 05 __ BEQ $3ca8 ; (show_dump_screen.s109 + 0)
.s125:
3ca3 : a5 5a __ LDA T3 + 1 
3ca5 : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
.s109:
3ca8 : a5 59 __ LDA T3 + 0 
3caa : 8d 01 de STA $de01 
3cad : a5 5e __ LDA T7 + 0 
3caf : f0 03 __ BEQ $3cb4 ; (show_dump_screen.s110 + 0)
3cb1 : 4c 6e 3d JMP $3d6e ; (show_dump_screen.s122 + 0)
.s110:
3cb4 : 85 53 __ STA T0 + 0 
.l111:
3cb6 : a5 53 __ LDA T0 + 0 
3cb8 : 20 e1 16 JSR $16e1 ; (mdp_read_byte.s4 + 0)
3cbb : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
3cbe : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
3cc1 : aa __ __ TAX
3cc2 : f0 03 __ BEQ $3cc7 ; (show_dump_screen.s112 + 0)
3cc4 : 4c 67 3d JMP $3d67 ; (show_dump_screen.s121 + 0)
.s112:
3cc7 : e6 53 __ INC T0 + 0 
3cc9 : d0 eb __ BNE $3cb6 ; (show_dump_screen.l111 + 0)
.s113:
3ccb : e6 59 __ INC T3 + 0 
3ccd : d0 02 __ BNE $3cd1 ; (show_dump_screen.s164 + 0)
.s163:
3ccf : e6 5a __ INC T3 + 1 
.s164:
3cd1 : a5 5a __ LDA T3 + 1 
3cd3 : c5 58 __ CMP T2 + 1 
3cd5 : b0 03 __ BCS $3cda ; (show_dump_screen.s167 + 0)
3cd7 : 4c 30 3c JMP $3c30 ; (show_dump_screen.l108 + 0)
.s167:
3cda : d0 06 __ BNE $3ce2 ; (show_dump_screen.s114 + 0)
.s120:
3cdc : a5 59 __ LDA T3 + 0 
3cde : c5 57 __ CMP T2 + 0 
3ce0 : 90 f5 __ BCC $3cd7 ; (show_dump_screen.s164 + 6)
.s114:
3ce2 : a5 5f __ LDA T8 + 0 
3ce4 : 8d 03 de STA $de03 
3ce7 : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
3cea : 20 fc 1a JSR $1afc ; (krnio_clrchn.s4 + 0)
3ced : a5 60 __ LDA T9 + 0 
3cef : f0 1e __ BEQ $3d0f ; (show_dump_screen.s115 + 0)
.s119:
3cf1 : a9 13 __ LDA #$13
3cf3 : 85 16 __ STA P9 
3cf5 : a9 32 __ LDA #$32
3cf7 : 85 15 __ STA P8 
3cf9 : a9 07 __ LDA #$07
3cfb : 85 17 __ STA P10 
3cfd : a9 f9 __ LDA #$f9
3cff : 85 14 __ STA P7 
3d01 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3d04 : a9 05 __ LDA #$05
3d06 : 85 17 __ STA P10 
3d08 : a9 41 __ LDA #$41
3d0a : a0 84 __ LDY #$84
3d0c : 4c 1e 38 JMP $381e ; (show_dump_screen.s159 + 0)
.s115:
3d0f : 8d e3 9c STA $9ce3 ; (dos_err[0] + 0)
3d12 : a9 ff __ LDA #$ff
3d14 : 85 0d __ STA P0 
3d16 : a9 0d __ LDA #$0d
3d18 : 85 0e __ STA P1 
3d1a : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3d1d : a9 0f __ LDA #$0f
3d1f : 85 0d __ STA P0 
3d21 : 85 0f __ STA P2 
3d23 : a9 08 __ LDA #$08
3d25 : 85 0e __ STA P1 
3d27 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3d2a : aa __ __ TAX
3d2b : f0 18 __ BEQ $3d45 ; (show_dump_screen.s116 + 0)
.s118:
3d2d : a9 e3 __ LDA #$e3
3d2f : 85 0e __ STA P1 
3d31 : a9 00 __ LDA #$00
3d33 : 85 11 __ STA P4 
3d35 : a9 9c __ LDA #$9c
3d37 : 85 0f __ STA P2 
3d39 : a9 28 __ LDA #$28
3d3b : 85 10 __ STA P3 
3d3d : 20 7a 30 JSR $307a ; (read_dos_status.s4 + 0)
3d40 : a9 0f __ LDA #$0f
3d42 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s116:
3d45 : a9 13 __ LDA #$13
3d47 : 85 16 __ STA P9 
3d49 : a9 28 __ LDA #$28
3d4b : 85 15 __ STA P8 
3d4d : a9 02 __ LDA #$02
3d4f : 85 17 __ STA P10 
3d51 : a9 0f __ LDA #$0f
3d53 : 85 14 __ STA P7 
3d55 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
3d58 : ad e3 9c LDA $9ce3 ; (dos_err[0] + 0)
3d5b : d0 03 __ BNE $3d60 ; (show_dump_screen.s117 + 0)
3d5d : 4c 25 38 JMP $3825 ; (show_dump_screen.s103 + 0)
.s117:
3d60 : a9 9c __ LDA #$9c
3d62 : a0 e3 __ LDY #$e3
3d64 : 4c be 39 JMP $39be ; (show_dump_screen.s162 + 0)
.s121:
3d67 : a9 00 __ LDA #$00
3d69 : 85 60 __ STA T9 + 0 
3d6b : 4c cb 3c JMP $3ccb ; (show_dump_screen.s113 + 0)
.s122:
3d6e : a9 00 __ LDA #$00
.l150:
3d70 : 85 0d __ STA P0 
3d72 : 20 e1 16 JSR $16e1 ; (mdp_read_byte.s4 + 0)
3d75 : a6 0d __ LDX P0 
3d77 : 9d 0b 9d STA $9d0b,x ; (page_buf[0] + 0)
3d7a : e8 __ __ INX
3d7b : 8a __ __ TXA
3d7c : d0 f2 __ BNE $3d70 ; (show_dump_screen.l150 + 0)
.s123:
3d7e : a9 0b __ LDA #$0b
3d80 : 85 0e __ STA P1 
3d82 : a9 9d __ LDA #$9d
3d84 : 85 0f __ STA P2 
3d86 : 20 f0 3f JSR $3ff0 ; (compress_and_write_page.s4 + 0)
3d89 : a5 1b __ LDA ACCU + 0 
3d8b : d0 de __ BNE $3d6b ; (show_dump_screen.s121 + 4)
.s124:
3d8d : 85 60 __ STA T9 + 0 
3d8f : 4c e2 3c JMP $3ce2 ; (show_dump_screen.s114 + 0)
.s101:
3d92 : c6 17 __ DEC P10 
3d94 : a9 41 __ LDA #$41
3d96 : a0 a5 __ LDY #$a5
3d98 : 4c 37 36 JMP $3637 ; (show_dump_screen.s88 + 0)
.s138:
3d9b : a9 ff __ LDA #$ff
3d9d : 85 0d __ STA P0 
3d9f : a9 0d __ LDA #$0d
3da1 : 85 0e __ STA P1 
3da3 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
3da6 : a9 0f __ LDA #$0f
3da8 : 85 0d __ STA P0 
3daa : 85 0f __ STA P2 
3dac : a9 08 __ LDA #$08
3dae : 85 0e __ STA P1 
3db0 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
3db3 : aa __ __ TAX
3db4 : f0 35 __ BEQ $3deb ; (show_dump_screen.s139 + 0)
.s140:
3db6 : a9 28 __ LDA #$28
3db8 : 85 10 __ STA P3 
3dba : a9 9e __ LDA #$9e
3dbc : 85 0f __ STA P2 
3dbe : a9 00 __ LDA #$00
3dc0 : 85 11 __ STA P4 
3dc2 : a9 13 __ LDA #$13
3dc4 : 85 0e __ STA P1 
3dc6 : 20 7a 30 JSR $307a ; (read_dos_status.s4 + 0)
3dc9 : ad 13 9e LDA $9e13 ; (temp_status[0] + 0)
3dcc : c9 30 __ CMP #$30
3dce : d0 16 __ BNE $3de6 ; (show_dump_screen.s141 + 0)
.s142:
3dd0 : ad 14 9e LDA $9e14 ; (temp_status[0] + 1)
3dd3 : c9 30 __ CMP #$30
3dd5 : d0 0f __ BNE $3de6 ; (show_dump_screen.s141 + 0)
.s143:
3dd7 : a9 0f __ LDA #$0f
3dd9 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
3ddc : a9 03 __ LDA #$03
3dde : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
3de1 : e6 59 __ INC T3 + 0 
3de3 : 4c 49 3b JMP $3b49 ; (show_dump_screen.s99 + 0)
.s141:
3de6 : a9 0f __ LDA #$0f
3de8 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s139:
3deb : a9 03 __ LDA #$03
3ded : 4c 46 3b JMP $3b46 ; (show_dump_screen.s151 + 0)
.s145:
3df0 : a5 5e __ LDA T7 + 0 
3df2 : d0 15 __ BNE $3e09 ; (show_dump_screen.s147 + 0)
.s146:
3df4 : a9 3e __ LDA #$3e
3df6 : 85 54 __ STA T0 + 1 
3df8 : a9 12 __ LDA #$12
3dfa : 85 55 __ STA T1 + 0 
3dfc : a9 3f __ LDA #$3f
3dfe : 85 56 __ STA T1 + 1 
3e00 : a9 3f __ LDA #$3f
3e02 : a0 57 __ LDY #$57
3e04 : a2 cb __ LDX #$cb
3e06 : 4c 09 3b JMP $3b09 ; (show_dump_screen.s97 + 0)
.s147:
3e09 : a9 3e __ LDA #$3e
3e0b : 85 54 __ STA T0 + 1 
3e0d : a9 00 __ LDA #$00
3e0f : 85 55 __ STA T1 + 0 
3e11 : a9 3f __ LDA #$3f
3e13 : 85 56 __ STA T1 + 1 
3e15 : a9 3f __ LDA #$3f
3e17 : a0 46 __ LDY #$46
3e19 : a2 b9 __ LDX #$b9
3e1b : 4c 09 3b JMP $3b09 ; (show_dump_screen.s97 + 0)
.s86:
3e1e : ad fe 27 LDA $27fe ; (eeprom_status + 0)
3e21 : f0 03 __ BEQ $3e26 ; (show_dump_screen.s86 + 8)
3e23 : 4c b8 3a JMP $3ab8 ; (show_dump_screen.s94 + 0)
3e26 : 4c 1d 36 JMP $361d ; (show_dump_screen.s21 + 0)
.s3:
3e29 : a2 0d __ LDX #$0d
3e2b : bd 51 9b LDA $9b51,x ; (show_dump_screen@stack + 0)
3e2e : 95 53 __ STA T0 + 0,x 
3e30 : ca __ __ DEX
3e31 : 10 f8 __ BPL $3e2b ; (show_dump_screen.s3 + 2)
3e33 : 60 __ __ RTS
--------------------------------------------------------------------
3e34 : __ __ __ BYT 46 31 3a 20 52 55 4e 20 42 41 43 4b 55 50 00    : F1: RUN BACKUP.
--------------------------------------------------------------------
3e43 : __ __ __ BYT 46 33 3a 20 52 45 53 54 4f 52 45 20 42 41 43 4b : F3: RESTORE BACK
3e53 : __ __ __ BYT 55 50 00                                        : UP.
--------------------------------------------------------------------
3e56 : __ __ __ BYT 46 35 3a 20 56 45 52 49 46 59 20 42 41 43 4b 55 : F5: VERIFY BACKU
3e66 : __ __ __ BYT 50 00                                           : P.
--------------------------------------------------------------------
3e68 : __ __ __ BYT 46 37 3a 20 4c 5a 4f 20 43 4f 4d 50 52 45 53 53 : F7: LZO COMPRESS
3e78 : __ __ __ BYT 49 4f 4e 20 28 4f 4e 29 00                      : ION (ON).
--------------------------------------------------------------------
3e81 : __ __ __ BYT 46 37 3a 20 4c 5a 4f 20 43 4f 4d 50 52 45 53 53 : F7: LZO COMPRESS
3e91 : __ __ __ BYT 49 4f 4e 20 28 4f 46 46 29 00                   : ION (OFF).
--------------------------------------------------------------------
3e9b : __ __ __ BYT 43 48 45 43 4b 49 4e 47 20 46 4f 52 20 45 58 49 : CHECKING FOR EXI
3eab : __ __ __ BYT 53 54 49 4e 47 20 46 49 4c 45 2e 2e 2e 00       : STING FILE....
--------------------------------------------------------------------
3eb9 : __ __ __ BYT 53 52 41 4d 42 41 43 4b 55 50 4c 5a 4f 2c 53 2c : SRAMBACKUPLZO,S,
3ec9 : __ __ __ BYT 52 00                                           : R.
--------------------------------------------------------------------
3ecb : __ __ __ BYT 53 52 41 4d 42 41 43 4b 55 50 2c 53 2c 52 00    : SRAMBACKUP,S,R.
--------------------------------------------------------------------
3eda : __ __ __ BYT 45 45 50 52 4f 4d 42 41 43 4b 55 50 4c 5a 4f 2c : EEPROMBACKUPLZO,
3eea : __ __ __ BYT 53 2c 52 00                                     : S,R.
--------------------------------------------------------------------
3eee : __ __ __ BYT 45 45 50 52 4f 4d 42 41 43 4b 55 50 2c 53 2c 52 : EEPROMBACKUP,S,R
3efe : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3f00 : __ __ __ BYT 53 52 41 4d 42 41 43 4b 55 50 4c 5a 4f 2c 53 2c : SRAMBACKUPLZO,S,
3f10 : __ __ __ BYT 57 00                                           : W.
--------------------------------------------------------------------
3f12 : __ __ __ BYT 53 52 41 4d 42 41 43 4b 55 50 2c 53 2c 57 00    : SRAMBACKUP,S,W.
--------------------------------------------------------------------
3f21 : __ __ __ BYT 45 45 50 52 4f 4d 42 41 43 4b 55 50 4c 5a 4f 2c : EEPROMBACKUPLZO,
3f31 : __ __ __ BYT 53 2c 57 00                                     : S,W.
--------------------------------------------------------------------
3f35 : __ __ __ BYT 45 45 50 52 4f 4d 42 41 43 4b 55 50 2c 53 2c 57 : EEPROMBACKUP,S,W
3f45 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3f46 : __ __ __ BYT 53 30 3a 53 52 41 4d 42 41 43 4b 55 50 4c 5a 4f : S0:SRAMBACKUPLZO
3f56 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
3f57 : __ __ __ BYT 53 30 3a 53 52 41 4d 42 41 43 4b 55 50 00       : S0:SRAMBACKUP.
--------------------------------------------------------------------
3f65 : __ __ __ BYT 53 30 3a 45 45 50 52 4f 4d 42 41 43 4b 55 50 4c : S0:EEPROMBACKUPL
3f75 : __ __ __ BYT 5a 4f 00                                        : ZO.
--------------------------------------------------------------------
3f78 : __ __ __ BYT 53 30 3a 45 45 50 52 4f 4d 42 41 43 4b 55 50 00 : S0:EEPROMBACKUP.
--------------------------------------------------------------------
3f88 : __ __ __ BYT 46 49 4c 45 20 46 4f 55 4e 44 21 20 4f 56 45 52 : FILE FOUND! OVER
3f98 : __ __ __ BYT 57 52 49 54 45 3f 20 28 59 2f 4e 29 00          : WRITE? (Y/N).
--------------------------------------------------------------------
3fa5 : __ __ __ BYT 44 45 4c 45 54 49 4e 47 20 50 52 45 56 49 4f 55 : DELETING PREVIOU
3fb5 : __ __ __ BYT 53 20 46 49 4c 45 2e 2e 2e 00                   : S FILE....
--------------------------------------------------------------------
3fbf : __ __ __ BYT 57 52 49 54 49 4e 47 20 46 49 4c 45 20 49 4e 20 : WRITING FILE IN 
3fcf : __ __ __ BYT 50 52 4f 47 52 45 53 53 2e 2e 2e 00             : PROGRESS....
--------------------------------------------------------------------
krnio_chkout: ; krnio_chkout(u8)->bool
;  51, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
3fdb : 85 0d __ STA P0 
3fdd : a6 0d __ LDX P0 
3fdf : 20 c9 ff JSR $ffc9 
3fe2 : a9 00 __ LDA #$00
3fe4 : 2a __ __ ROL
3fe5 : 49 01 __ EOR #$01
3fe7 : 85 1b __ STA ACCU + 0 
3fe9 : a5 1b __ LDA ACCU + 0 
3feb : f0 02 __ BEQ $3fef ; (krnio_chkout.s3 + 0)
.s5:
3fed : a9 01 __ LDA #$01
.s3:
3fef : 60 __ __ RTS
--------------------------------------------------------------------
compress_and_write_page: ; compress_and_write_page(const u8*)->bool
; 487, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s4:
3ff0 : a9 00 __ LDA #$00
3ff2 : 85 49 __ STA T6 + 0 
3ff4 : 85 4a __ STA T6 + 1 
.l5:
3ff6 : 85 4b __ STA T7 + 0 
3ff8 : a5 4a __ LDA T6 + 1 
.l6:
3ffa : aa __ __ TAX
3ffb : 30 3d __ BMI $403a ; (compress_and_write_page.s14 + 0)
.s52:
3ffd : c9 01 __ CMP #$01
3fff : 90 39 __ BCC $403a ; (compress_and_write_page.s14 + 0)
.s7:
4001 : a5 4b __ LDA T7 + 0 
4003 : f0 20 __ BEQ $4025 ; (compress_and_write_page.s8 + 0)
.s9:
4005 : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
4008 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
400b : aa __ __ TAX
400c : d0 28 __ BNE $4036 ; (compress_and_write_page.s13 + 0)
.s10:
400e : 85 43 __ STA T1 + 0 
4010 : aa __ __ TAX
.l11:
4011 : bd 7f 9f LDA $9f7f,x ; (lit_buf[0] + 0)
4014 : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
4017 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
401a : aa __ __ TAX
401b : d0 19 __ BNE $4036 ; (compress_and_write_page.s13 + 0)
.s12:
401d : e6 43 __ INC T1 + 0 
401f : a6 43 __ LDX T1 + 0 
4021 : e4 4b __ CPX T7 + 0 
4023 : 90 ec __ BCC $4011 ; (compress_and_write_page.l11 + 0)
.s8:
4025 : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
4028 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
402b : c9 01 __ CMP #$01
402d : a9 00 __ LDA #$00
402f : 69 ff __ ADC #$ff
4031 : 29 01 __ AND #$01
.s3:
4033 : 85 1b __ STA ACCU + 0 
4035 : 60 __ __ RTS
.s13:
4036 : a9 00 __ LDA #$00
4038 : f0 f9 __ BEQ $4033 ; (compress_and_write_page.s3 + 0)
.s14:
403a : a5 4a __ LDA T6 + 1 
403c : 30 10 __ BMI $404e ; (compress_and_write_page.s44 + 0)
.s46:
403e : d0 06 __ BNE $4046 ; (compress_and_write_page.s15 + 0)
.s45:
4040 : a5 49 __ LDA T6 + 0 
4042 : c9 ff __ CMP #$ff
4044 : 90 06 __ BCC $404c ; (compress_and_write_page.s54 + 0)
.s15:
4046 : a9 00 __ LDA #$00
4048 : a2 ff __ LDX #$ff
404a : d0 04 __ BNE $4050 ; (compress_and_write_page.s16 + 0)
.s54:
404c : a5 4a __ LDA T6 + 1 
.s44:
404e : a6 49 __ LDX T6 + 0 
.s16:
4050 : 85 1c __ STA ACCU + 1 
4052 : a9 00 __ LDA #$00
4054 : 85 4c __ STA T8 + 0 
4056 : 85 4d __ STA T9 + 0 
4058 : a5 1c __ LDA ACCU + 1 
405a : 30 7b __ BMI $40d7 ; (compress_and_write_page.s17 + 0)
.s43:
405c : 86 1b __ STX ACCU + 0 
405e : d0 03 __ BNE $4063 ; (compress_and_write_page.s32 + 0)
.s42:
4060 : 8a __ __ TXA
4061 : f0 74 __ BEQ $40d7 ; (compress_and_write_page.s17 + 0)
.s32:
4063 : a9 01 __ LDA #$01
4065 : 85 43 __ STA T1 + 0 
4067 : a9 00 __ LDA #$00
4069 : 85 44 __ STA T1 + 1 
406b : a6 0e __ LDX P1 ; (src + 0)
.l33:
406d : 8a __ __ TXA
406e : 18 __ __ CLC
406f : 65 49 __ ADC T6 + 0 
4071 : 85 47 __ STA T3 + 0 
4073 : a5 0f __ LDA P2 ; (src + 1)
4075 : 65 4a __ ADC T6 + 1 
4077 : 85 48 __ STA T3 + 1 
4079 : 38 __ __ SEC
407a : a5 49 __ LDA T6 + 0 
407c : e5 43 __ SBC T1 + 0 
407e : 85 1d __ STA ACCU + 2 
4080 : a5 4a __ LDA T6 + 1 
4082 : e5 44 __ SBC T1 + 1 
4084 : a8 __ __ TAY
4085 : 8a __ __ TXA
4086 : 18 __ __ CLC
4087 : 65 1d __ ADC ACCU + 2 
4089 : 85 45 __ STA T2 + 0 
408b : 98 __ __ TYA
408c : 65 0f __ ADC P2 ; (src + 1)
408e : 85 46 __ STA T2 + 1 
4090 : a4 4c __ LDY T8 + 0 
4092 : b1 45 __ LDA (T2 + 0),y 
4094 : d1 47 __ CMP (T3 + 0),y 
4096 : d0 2d __ BNE $40c5 ; (compress_and_write_page.s36 + 0)
.s34:
4098 : a0 00 __ LDY #$00
.l40:
409a : b1 45 __ LDA (T2 + 0),y 
409c : d1 47 __ CMP (T3 + 0),y 
409e : d0 13 __ BNE $40b3 ; (compress_and_write_page.s47 + 0)
.s41:
40a0 : c8 __ __ INY
40a1 : 98 __ __ TYA
40a2 : 18 __ __ CLC
40a3 : 65 49 __ ADC T6 + 0 
40a5 : a5 4a __ LDA T6 + 1 
40a7 : 69 00 __ ADC #$00
40a9 : 30 04 __ BMI $40af ; (compress_and_write_page.s35 + 0)
.s53:
40ab : c9 01 __ CMP #$01
40ad : b0 04 __ BCS $40b3 ; (compress_and_write_page.s47 + 0)
.s35:
40af : c0 7f __ CPY #$7f
40b1 : 90 e7 __ BCC $409a ; (compress_and_write_page.l40 + 0)
.s47:
40b3 : 84 1d __ STY ACCU + 2 
40b5 : a5 4c __ LDA T8 + 0 
40b7 : c5 1d __ CMP ACCU + 2 
40b9 : b0 0a __ BCS $40c5 ; (compress_and_write_page.s36 + 0)
.s39:
40bb : 84 4c __ STY T8 + 0 
40bd : a5 43 __ LDA T1 + 0 
40bf : 85 4d __ STA T9 + 0 
40c1 : c0 7f __ CPY #$7f
40c3 : f0 12 __ BEQ $40d7 ; (compress_and_write_page.s17 + 0)
.s36:
40c5 : e6 43 __ INC T1 + 0 
40c7 : d0 02 __ BNE $40cb ; (compress_and_write_page.s51 + 0)
.s50:
40c9 : e6 44 __ INC T1 + 1 
.s51:
40cb : a5 1c __ LDA ACCU + 1 
40cd : c5 44 __ CMP T1 + 1 
40cf : d0 04 __ BNE $40d5 ; (compress_and_write_page.s38 + 0)
.s37:
40d1 : a5 1b __ LDA ACCU + 0 
40d3 : c5 43 __ CMP T1 + 0 
.s38:
40d5 : b0 96 __ BCS $406d ; (compress_and_write_page.l33 + 0)
.s17:
40d7 : a5 4c __ LDA T8 + 0 
40d9 : c9 03 __ CMP #$03
40db : 90 51 __ BCC $412e ; (compress_and_write_page.s18 + 0)
.s31:
40dd : a5 4b __ LDA T7 + 0 
40df : f0 25 __ BEQ $4106 ; (compress_and_write_page.s23 + 0)
.s26:
40e1 : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
40e4 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
40e7 : aa __ __ TAX
40e8 : f0 03 __ BEQ $40ed ; (compress_and_write_page.s27 + 0)
40ea : 4c 36 40 JMP $4036 ; (compress_and_write_page.s13 + 0)
.s27:
40ed : 85 43 __ STA T1 + 0 
40ef : aa __ __ TAX
.l28:
40f0 : bd 7f 9f LDA $9f7f,x ; (lit_buf[0] + 0)
40f3 : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
40f6 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
40f9 : aa __ __ TAX
40fa : d0 ee __ BNE $40ea ; (compress_and_write_page.s26 + 9)
.s29:
40fc : e6 43 __ INC T1 + 0 
40fe : a6 43 __ LDX T1 + 0 
4100 : e4 4b __ CPX T7 + 0 
4102 : 90 ec __ BCC $40f0 ; (compress_and_write_page.l28 + 0)
.s30:
4104 : 85 4b __ STA T7 + 0 
.s23:
4106 : a5 4c __ LDA T8 + 0 
4108 : 09 80 __ ORA #$80
410a : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
410d : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
4110 : aa __ __ TAX
4111 : d0 d7 __ BNE $40ea ; (compress_and_write_page.s26 + 9)
.s24:
4113 : a5 4d __ LDA T9 + 0 
4115 : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
4118 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
411b : aa __ __ TAX
411c : d0 cc __ BNE $40ea ; (compress_and_write_page.s26 + 9)
.s25:
411e : 18 __ __ CLC
411f : a5 49 __ LDA T6 + 0 
4121 : 65 4c __ ADC T8 + 0 
4123 : 85 49 __ STA T6 + 0 
4125 : a5 4a __ LDA T6 + 1 
4127 : 69 00 __ ADC #$00
4129 : 85 4a __ STA T6 + 1 
412b : 4c fa 3f JMP $3ffa ; (compress_and_write_page.l6 + 0)
.s18:
412e : a5 49 __ LDA T6 + 0 
4130 : 85 1b __ STA ACCU + 0 
4132 : a5 0f __ LDA P2 ; (src + 1)
4134 : 65 4a __ ADC T6 + 1 
4136 : 85 1c __ STA ACCU + 1 
4138 : a4 0e __ LDY P1 ; (src + 0)
413a : b1 1b __ LDA (ACCU + 0),y 
413c : a6 4b __ LDX T7 + 0 
413e : e8 __ __ INX
413f : 86 4b __ STX T7 + 0 
4141 : 9d 7e 9f STA $9f7e,x ; (page_buf[0] + 222)
4144 : e6 49 __ INC T6 + 0 
4146 : d0 02 __ BNE $414a ; (compress_and_write_page.s49 + 0)
.s48:
4148 : e6 4a __ INC T6 + 1 
.s49:
414a : a5 4a __ LDA T6 + 1 
414c : e0 7f __ CPX #$7f
414e : d0 db __ BNE $412b ; (compress_and_write_page.s25 + 13)
.s19:
4150 : 8a __ __ TXA
4151 : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
4154 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
4157 : aa __ __ TAX
4158 : d0 90 __ BNE $40ea ; (compress_and_write_page.s26 + 9)
.s20:
415a : 85 43 __ STA T1 + 0 
415c : aa __ __ TAX
.l21:
415d : bd 7f 9f LDA $9f7f,x ; (lit_buf[0] + 0)
4160 : 20 74 41 JSR $4174 ; (krnio_chrout.s4 + 0)
4163 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
4166 : aa __ __ TAX
4167 : d0 81 __ BNE $40ea ; (compress_and_write_page.s26 + 9)
.s22:
4169 : e6 43 __ INC T1 + 0 
416b : a6 43 __ LDX T1 + 0 
416d : e0 7f __ CPX #$7f
416f : 90 ec __ BCC $415d ; (compress_and_write_page.l21 + 0)
4171 : 4c f6 3f JMP $3ff6 ; (compress_and_write_page.l5 + 0)
--------------------------------------------------------------------
krnio_chrout: ; krnio_chrout(u8)->bool
;  63, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
4174 : 85 0d __ STA P0 
4176 : a5 0d __ LDA P0 
4178 : 20 d2 ff JSR $ffd2 
417b : 85 1b __ STA ACCU + 0 
417d : a5 1b __ LDA ACCU + 0 
417f : f0 02 __ BEQ $4183 ; (krnio_chrout.s3 + 0)
.s5:
4181 : a9 01 __ LDA #$01
.s3:
4183 : 60 __ __ RTS
--------------------------------------------------------------------
4184 : __ __ __ BYT 42 41 43 4b 55 50 20 43 4f 4d 50 4c 45 54 45 44 : BACKUP COMPLETED
4194 : __ __ __ BYT 20 53 55 43 43 45 53 53 46 55 4c 4c 59 21 20 20 :  SUCCESSFULLY!  
41a4 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
41a5 : __ __ __ BYT 45 52 52 4f 52 20 4f 50 45 4e 49 4e 47 20 49 4e : ERROR OPENING IN
41b5 : __ __ __ BYT 20 57 52 49 54 45 20 4d 4f 44 45 21 00          :  WRITE MODE!.
--------------------------------------------------------------------
41c2 : __ __ __ BYT 45 52 52 4f 52 3a 20 42 41 43 4b 55 50 20 46 49 : ERROR: BACKUP FI
41d2 : __ __ __ BYT 4c 45 20 4e 4f 54 20 46 4f 55 4e 44 21 00       : LE NOT FOUND!.
--------------------------------------------------------------------
41e0 : __ __ __ BYT 52 45 41 44 49 4e 47 20 46 49 4c 45 20 49 4e 20 : READING FILE IN 
41f0 : __ __ __ BYT 50 52 4f 47 52 45 53 53 2e 2e 2e 00             : PROGRESS....
--------------------------------------------------------------------
krnio_read_lzo: ; krnio_read_lzo(u8,u8*)->i16
;  93, "C:/Program Files/oscar64/include/c64/kernalio.h"
.s4:
41fc : a6 0e __ LDX P1 ; (fnum + 0)
41fe : bd a9 49 LDA $49a9,x ; (krnio_pstatus[0] + 0)
4201 : c9 40 __ CMP #$40
4203 : d0 07 __ BNE $420c ; (krnio_read_lzo.s5 + 0)
.s18:
4205 : a9 00 __ LDA #$00
.s21:
4207 : 85 1b __ STA ACCU + 0 
.s3:
4209 : 85 1c __ STA ACCU + 1 
420b : 60 __ __ RTS
.s5:
420c : 86 46 __ STX T4 + 0 
420e : 8a __ __ TXA
420f : 20 33 22 JSR $2233 ; (krnio_chkin.s4 + 0)
4212 : aa __ __ TAX
4213 : d0 04 __ BNE $4219 ; (krnio_read_lzo.s7 + 0)
.s6:
4215 : a9 ff __ LDA #$ff
4217 : d0 ee __ BNE $4207 ; (krnio_read_lzo.s21 + 0)
.s7:
4219 : a9 00 __ LDA #$00
421b : 85 47 __ STA T5 + 0 
421d : 85 48 __ STA T5 + 1 
.l8:
421f : 85 45 __ STA T2 + 0 
.l9:
4221 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
4224 : 85 43 __ STA T1 + 0 
4226 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
4229 : 85 1d __ STA ACCU + 2 
422b : aa __ __ TAX
422c : f0 04 __ BEQ $4232 ; (krnio_read_lzo.s10 + 0)
.s17:
422e : c9 40 __ CMP #$40
4230 : d0 21 __ BNE $4253 ; (krnio_read_lzo.s26 + 0)
.s10:
4232 : a5 45 __ LDA T2 + 0 
4234 : 30 41 __ BMI $4277 ; (krnio_read_lzo.s16 + 0)
.s11:
4236 : d0 20 __ BNE $4258 ; (krnio_read_lzo.s15 + 0)
.s12:
4238 : a5 43 __ LDA T1 + 0 
423a : f0 17 __ BEQ $4253 ; (krnio_read_lzo.s26 + 0)
.s14:
423c : 85 45 __ STA T2 + 0 
423e : a5 1d __ LDA ACCU + 2 
4240 : f0 df __ BEQ $4221 ; (krnio_read_lzo.l9 + 0)
.s13:
4242 : a6 46 __ LDX T4 + 0 
4244 : 9d a9 49 STA $49a9,x ; (krnio_pstatus[0] + 0)
4247 : 20 fc 1a JSR $1afc ; (krnio_clrchn.s4 + 0)
424a : a5 47 __ LDA T5 + 0 
424c : 85 1b __ STA ACCU + 0 
424e : a5 48 __ LDA T5 + 1 
4250 : 4c 09 42 JMP $4209 ; (krnio_read_lzo.s3 + 0)
.s26:
4253 : a5 1d __ LDA ACCU + 2 
4255 : 4c 42 42 JMP $4242 ; (krnio_read_lzo.s13 + 0)
.s15:
4258 : a5 47 __ LDA T5 + 0 
425a : 85 1b __ STA ACCU + 0 
425c : 18 __ __ CLC
425d : a5 10 __ LDA P3 ; (data + 1)
425f : 65 48 __ ADC T5 + 1 
4261 : 85 1c __ STA ACCU + 1 
4263 : a5 43 __ LDA T1 + 0 
4265 : a4 0f __ LDY P2 ; (data + 0)
4267 : 91 1b __ STA (ACCU + 0),y 
4269 : c6 45 __ DEC T2 + 0 
426b : e6 47 __ INC T5 + 0 
426d : d0 02 __ BNE $4271 ; (krnio_read_lzo.s25 + 0)
.s24:
426f : e6 48 __ INC T5 + 1 
.s25:
4271 : a5 1d __ LDA ACCU + 2 
4273 : d0 cd __ BNE $4242 ; (krnio_read_lzo.s13 + 0)
4275 : f0 aa __ BEQ $4221 ; (krnio_read_lzo.l9 + 0)
.s16:
4277 : 18 __ __ CLC
4278 : a5 0f __ LDA P2 ; (data + 0)
427a : 65 47 __ ADC T5 + 0 
427c : 85 1b __ STA ACCU + 0 
427e : a5 10 __ LDA P3 ; (data + 1)
4280 : 65 48 __ ADC T5 + 1 
4282 : 85 1c __ STA ACCU + 1 
4284 : 38 __ __ SEC
4285 : a5 1b __ LDA ACCU + 0 
4287 : e5 43 __ SBC T1 + 0 
4289 : 85 43 __ STA T1 + 0 
428b : a5 1c __ LDA ACCU + 1 
428d : e9 00 __ SBC #$00
428f : 85 44 __ STA T1 + 1 
4291 : a5 45 __ LDA T2 + 0 
4293 : 29 7f __ AND #$7f
4295 : 85 1e __ STA ACCU + 3 
4297 : 18 __ __ CLC
4298 : 65 47 __ ADC T5 + 0 
429a : 85 47 __ STA T5 + 0 
429c : 90 02 __ BCC $42a0 ; (krnio_read_lzo.s23 + 0)
.s22:
429e : e6 48 __ INC T5 + 1 
.s23:
42a0 : a0 00 __ LDY #$00
.l19:
42a2 : b1 43 __ LDA (T1 + 0),y 
42a4 : 91 1b __ STA (ACCU + 0),y 
42a6 : c8 __ __ INY
42a7 : c4 1e __ CPY ACCU + 3 
42a9 : d0 f7 __ BNE $42a2 ; (krnio_read_lzo.l19 + 0)
.s20:
42ab : a5 1d __ LDA ACCU + 2 
42ad : d0 93 __ BNE $4242 ; (krnio_read_lzo.s13 + 0)
42af : 4c 1f 42 JMP $421f ; (krnio_read_lzo.l8 + 0)
--------------------------------------------------------------------
42b2 : __ __ __ BYT 52 45 53 54 4f 52 45 20 46 52 4f 4d 20 46 4c 4f : RESTORE FROM FLO
42c2 : __ __ __ BYT 50 50 59 20 43 4f 4d 50 4c 45 54 45 44 21 00    : PPY COMPLETED!.
--------------------------------------------------------------------
verify_backup: ; verify_backup()->void
; 561, "C:/Users/crystal/Documents/Antigravity/MDPManager/main.c"
.s1:
42d1 : a2 06 __ LDX #$06
42d3 : b5 53 __ LDA T4 + 0,x 
42d5 : 9d 3b 9e STA $9e3b,x ; (verify_backup@stack + 0)
42d8 : ca __ __ DEX
42d9 : 10 f8 __ BPL $42d3 ; (verify_backup.s1 + 2)
.s4:
42db : a9 17 __ LDA #$17
42dd : 85 0d __ STA P0 
42df : a9 0b __ LDA #$0b
42e1 : 85 0e __ STA P1 
42e3 : ad ff 27 LDA $27ff ; (sram_mode_active + 0)
42e6 : 85 56 __ STA T6 + 0 
42e8 : f0 03 __ BEQ $42ed ; (verify_backup.s5 + 0)
42ea : 4c 79 47 JMP $4779 ; (verify_backup.s95 + 0)
.s5:
42ed : ad fe 27 LDA $27fe ; (eeprom_status + 0)
42f0 : d0 46 __ BNE $4338 ; (verify_backup.s12 + 0)
.s6:
42f2 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
42f5 : a9 0f __ LDA #$0f
42f7 : 85 16 __ STA P9 
42f9 : a9 02 __ LDA #$02
42fb : 85 17 __ STA P10 
42fd : a5 56 __ LDA T6 + 0 
42ff : d0 07 __ BNE $4308 ; (verify_backup.s11 + 0)
.s7:
4301 : a9 1e __ LDA #$1e
4303 : a2 27 __ LDX #$27
4305 : 4c 0c 43 JMP $430c ; (verify_backup.s8 + 0)
.s11:
4308 : a9 1e __ LDA #$1e
430a : a2 06 __ LDX #$06
.s8:
430c : 86 14 __ STX P7 
430e : 85 15 __ STA P8 
4310 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s9:
4313 : a9 17 __ LDA #$17
4315 : 85 16 __ STA P9 
4317 : a9 0c __ LDA #$0c
4319 : 85 15 __ STA P8 
431b : a9 01 __ LDA #$01
431d : 85 17 __ STA P10 
431f : a9 cc __ LDA #$cc
4321 : 85 14 __ STA P7 
4323 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.l10:
4326 : 20 7e 0c JSR $0c7e ; (get_key.s4 + 0)
4329 : c9 0d __ CMP #$0d
432b : d0 f9 __ BNE $4326 ; (verify_backup.l10 + 0)
.s3:
432d : a2 06 __ LDX #$06
432f : bd 3b 9e LDA $9e3b,x ; (verify_backup@stack + 0)
4332 : 95 53 __ STA T4 + 0,x 
4334 : ca __ __ DEX
4335 : 10 f8 __ BPL $432f ; (verify_backup.s3 + 2)
4337 : 60 __ __ RTS
.s12:
4338 : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
433b : a9 0f __ LDA #$0f
433d : 85 16 __ STA P9 
433f : a9 3e __ LDA #$3e
4341 : 85 15 __ STA P8 
4343 : a9 03 __ LDA #$03
4345 : 85 17 __ STA P10 
4347 : a9 9b __ LDA #$9b
4349 : 85 14 __ STA P7 
434b : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
434e : a5 56 __ LDA T6 + 0 
4350 : d0 0f __ BNE $4361 ; (verify_backup.s94 + 0)
.s13:
4352 : a9 3e __ LDA #$3e
4354 : 85 4a __ STA T0 + 1 
4356 : 85 4c __ STA T1 + 1 
4358 : a9 3e __ LDA #$3e
435a : a2 ee __ LDX #$ee
435c : a0 da __ LDY #$da
435e : 4c 6d 43 JMP $436d ; (verify_backup.s14 + 0)
.s94:
4361 : a9 3e __ LDA #$3e
4363 : 85 4a __ STA T0 + 1 
4365 : 85 4c __ STA T1 + 1 
4367 : a9 3e __ LDA #$3e
4369 : a2 cb __ LDX #$cb
436b : a0 b9 __ LDY #$b9
.s14:
436d : 86 4d __ STX T2 + 0 
436f : 84 4b __ STY T1 + 0 
4371 : 84 0d __ STY P0 
4373 : 85 4e __ STA T2 + 1 
4375 : a5 4a __ LDA T0 + 1 
4377 : 85 0e __ STA P1 
4379 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
437c : a9 03 __ LDA #$03
437e : 85 0d __ STA P0 
4380 : 85 0f __ STA P2 
4382 : a9 08 __ LDA #$08
4384 : 85 0e __ STA P1 
4386 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
4389 : 85 49 __ STA T0 + 0 
438b : a9 00 __ LDA #$00
438d : 85 51 __ STA T3 + 0 
438f : 85 53 __ STA T4 + 0 
4391 : a9 ff __ LDA #$ff
4393 : 85 0d __ STA P0 
4395 : a9 0d __ LDA #$0d
4397 : 85 0e __ STA P1 
4399 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
439c : a9 0f __ LDA #$0f
439e : 85 0d __ STA P0 
43a0 : 85 0f __ STA P2 
43a2 : a9 08 __ LDA #$08
43a4 : 85 0e __ STA P1 
43a6 : a5 49 __ LDA T0 + 0 
43a8 : f0 03 __ BEQ $43ad ; (verify_backup.s15 + 0)
43aa : 4c 39 47 JMP $4739 ; (verify_backup.s88 + 0)
.s15:
43ad : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
43b0 : aa __ __ TAX
43b1 : f0 05 __ BEQ $43b8 ; (verify_backup.s16 + 0)
.s87:
43b3 : a9 0f __ LDA #$0f
.s98:
43b5 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s16:
43b8 : a5 4d __ LDA T2 + 0 
43ba : 85 0d __ STA P0 
43bc : a5 4e __ LDA T2 + 1 
43be : 85 0e __ STA P1 
43c0 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
43c3 : a9 03 __ LDA #$03
43c5 : 85 0d __ STA P0 
43c7 : 85 0f __ STA P2 
43c9 : a9 08 __ LDA #$08
43cb : 85 0e __ STA P1 
43cd : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
43d0 : aa __ __ TAX
43d1 : f0 03 __ BEQ $43d6 ; (verify_backup.s17 + 0)
43d3 : 4c e4 46 JMP $46e4 ; (verify_backup.s81 + 0)
.s17:
43d6 : a9 ff __ LDA #$ff
43d8 : 85 0d __ STA P0 
43da : a9 0d __ LDA #$0d
43dc : 85 0e __ STA P1 
43de : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
43e1 : a9 0f __ LDA #$0f
43e3 : 85 0d __ STA P0 
43e5 : 85 0f __ STA P2 
43e7 : a9 08 __ LDA #$08
43e9 : 85 0e __ STA P1 
43eb : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
43ee : aa __ __ TAX
43ef : f0 05 __ BEQ $43f6 ; (verify_backup.s18 + 0)
.s80:
43f1 : a9 0f __ LDA #$0f
.s97:
43f3 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s18:
43f6 : a9 0f __ LDA #$0f
43f8 : 85 0d __ STA P0 
43fa : a9 0b __ LDA #$0b
43fc : 85 0e __ STA P1 
43fe : 20 be 0a JSR $0abe ; (clear_row.s4 + 0)
4401 : ad fd 29 LDA $29fd ; (lzo_enabled + 0)
4404 : f0 03 __ BEQ $4409 ; (verify_backup.s19 + 0)
4406 : 4c d3 46 JMP $46d3 ; (verify_backup.s78 + 0)
.s19:
4409 : a5 53 __ LDA T4 + 0 
440b : f0 04 __ BEQ $4411 ; (verify_backup.s20 + 0)
.s77:
440d : a9 00 __ LDA #$00
440f : f0 11 __ BEQ $4422 ; (verify_backup.s22 + 0)
.s20:
4411 : a5 51 __ LDA T3 + 0 
4413 : d0 0d __ BNE $4422 ; (verify_backup.s22 + 0)
.s21:
4415 : c6 17 __ DEC P10 
4417 : a9 13 __ LDA #$13
4419 : 85 16 __ STA P9 
441b : a9 41 __ LDA #$41
441d : a2 c2 __ LDX #$c2
441f : 4c 0c 43 JMP $430c ; (verify_backup.s8 + 0)
.s22:
4422 : 85 57 __ STA T7 + 0 
4424 : a9 13 __ LDA #$13
4426 : 85 16 __ STA P9 
4428 : a9 47 __ LDA #$47
442a : 85 15 __ STA P8 
442c : a9 84 __ LDA #$84
442e : 85 14 __ STA P7 
4430 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
4433 : a5 57 __ LDA T7 + 0 
4435 : d0 08 __ BNE $443f ; (verify_backup.s24 + 0)
.s23:
4437 : a5 4d __ LDA T2 + 0 
4439 : 85 4b __ STA T1 + 0 
443b : a5 4e __ LDA T2 + 1 
443d : 85 4c __ STA T1 + 1 
.s24:
443f : a5 4b __ LDA T1 + 0 
4441 : 85 0d __ STA P0 
4443 : a5 4c __ LDA T1 + 1 
4445 : 85 0e __ STA P1 
4447 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
444a : a9 03 __ LDA #$03
444c : 85 0d __ STA P0 
444e : 85 0f __ STA P2 
4450 : a9 08 __ LDA #$08
4452 : 85 0e __ STA P1 
4454 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
4457 : aa __ __ TAX
4458 : d0 09 __ BNE $4463 ; (verify_backup.s26 + 0)
.s25:
445a : c6 17 __ DEC P10 
445c : a9 27 __ LDA #$27
445e : a2 a3 __ LDX #$a3
4460 : 4c 0c 43 JMP $430c ; (verify_backup.s8 + 0)
.s26:
4463 : a9 03 __ LDA #$03
4465 : 20 33 22 JSR $2233 ; (krnio_chkin.s4 + 0)
4468 : aa __ __ TAX
4469 : d0 15 __ BNE $4480 ; (verify_backup.s31 + 0)
.s27:
446b : c6 17 __ DEC P10 
446d : a9 27 __ LDA #$27
446f : a2 bf __ LDX #$bf
.s28:
4471 : 86 14 __ STX P7 
.s29:
4473 : 85 15 __ STA P8 
4475 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
.s30:
4478 : a9 03 __ LDA #$03
447a : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
447d : 4c 13 43 JMP $4313 ; (verify_backup.s9 + 0)
.s31:
4480 : ad ff 24 LDA $24ff ; (mdp_ctrl_shadow + 0)
4483 : 85 58 __ STA T8 + 0 
4485 : a5 56 __ LDA T6 + 0 
4487 : f0 1f __ BEQ $44a8 ; (verify_backup.s32 + 0)
.s76:
4489 : 20 ae 13 JSR $13ae ; (mdp_sram_enable.s4 + 0)
448c : a9 00 __ LDA #$00
448e : 85 51 __ STA T3 + 0 
4490 : a9 02 __ LDA #$02
4492 : 85 52 __ STA T3 + 1 
.s34:
4494 : a9 00 __ LDA #$00
4496 : 85 53 __ STA T4 + 0 
4498 : 85 54 __ STA T4 + 1 
449a : 85 4d __ STA T2 + 0 
449c : 85 4e __ STA T2 + 1 
449e : 85 4f __ STA T2 + 2 
44a0 : 85 50 __ STA T2 + 3 
44a2 : a9 01 __ LDA #$01
44a4 : 85 59 __ STA T9 + 0 
44a6 : d0 15 __ BNE $44bd ; (verify_backup.l35 + 0)
.s32:
44a8 : a9 20 __ LDA #$20
44aa : cd fd 27 CMP $27fd ; (eeprom_size_kb + 0)
44ad : d0 02 __ BNE $44b1 ; (verify_backup.s33 + 0)
.s75:
44af : a9 80 __ LDA #$80
.s33:
44b1 : 85 51 __ STA T3 + 0 
44b3 : a9 00 __ LDA #$00
44b5 : 85 52 __ STA T3 + 1 
44b7 : 20 f4 0c JSR $0cf4 ; (mdp_eeprom_enable.s4 + 0)
44ba : 4c 94 44 JMP $4494 ; (verify_backup.s34 + 0)
.l35:
44bd : a5 53 __ LDA T4 + 0 
44bf : 85 1b __ STA ACCU + 0 
44c1 : a5 54 __ LDA T4 + 1 
44c3 : 85 1c __ STA ACCU + 1 
44c5 : a9 00 __ LDA #$00
44c7 : 85 1d __ STA ACCU + 2 
44c9 : 85 1e __ STA ACCU + 3 
44cb : a9 64 __ LDA #$64
44cd : 20 17 48 JSR $4817 ; (mul32by8 + 0)
44d0 : a5 07 __ LDA WORK + 4 
44d2 : 85 1b __ STA ACCU + 0 
44d4 : a5 08 __ LDA WORK + 5 
44d6 : 85 1c __ STA ACCU + 1 
44d8 : a5 09 __ LDA WORK + 6 
44da : 85 1d __ STA ACCU + 2 
44dc : a5 0a __ LDA WORK + 7 
44de : 85 1e __ STA ACCU + 3 
44e0 : a5 51 __ LDA T3 + 0 
44e2 : 85 03 __ STA WORK + 0 
44e4 : a5 52 __ LDA T3 + 1 
44e6 : 85 04 __ STA WORK + 1 
44e8 : a9 00 __ LDA #$00
44ea : 85 0e __ STA P1 
44ec : 85 05 __ STA WORK + 2 
44ee : 85 06 __ STA WORK + 3 
44f0 : 20 d2 48 JSR $48d2 ; (divmod32 + 0)
44f3 : a5 1b __ LDA ACCU + 0 
44f5 : 85 0d __ STA P0 
44f7 : a9 a0 __ LDA #$a0
44f9 : 85 0f __ STA P2 
44fb : a9 9f __ LDA #$9f
44fd : 85 10 __ STA P3 
44ff : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
4502 : a9 a0 __ LDA #$a0
4504 : 85 0d __ STA P0 
4506 : a9 9f __ LDA #$9f
4508 : 85 0e __ STA P1 
450a : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
450d : a9 25 __ LDA #$25
450f : a6 1b __ LDX ACCU + 0 
4511 : 9d a0 9f STA $9fa0,x ; (pct_str[0] + 0)
4514 : a9 a0 __ LDA #$a0
4516 : 85 14 __ STA P7 
4518 : a9 9f __ LDA #$9f
451a : 85 15 __ STA P8 
451c : a9 13 __ LDA #$13
451e : 85 16 __ STA P9 
4520 : a9 07 __ LDA #$07
4522 : 85 17 __ STA P10 
4524 : a9 00 __ LDA #$00
4526 : 9d a1 9f STA $9fa1,x ; (pct_str[0] + 1)
4529 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
452c : a5 56 __ LDA T6 + 0 
452e : f0 05 __ BEQ $4535 ; (verify_backup.s36 + 0)
.s74:
4530 : a5 54 __ LDA T4 + 1 
4532 : 20 65 17 JSR $1765 ; (mdp_set_bank.s4 + 0)
.s36:
4535 : a5 53 __ LDA T4 + 0 
4537 : 8d 01 de STA $de01 
453a : a5 57 __ LDA T7 + 0 
453c : f0 03 __ BEQ $4541 ; (verify_backup.s37 + 0)
453e : 4c 97 46 JMP $4697 ; (verify_backup.s69 + 0)
.s37:
4541 : 85 49 __ STA T0 + 0 
.l38:
4543 : 20 50 22 JSR $2250 ; (krnio_chrin.s4 + 0)
4546 : 85 55 __ STA T5 + 0 
4548 : 20 58 22 JSR $2258 ; (krnio_status.s4 + 0)
454b : aa __ __ TAX
454c : f0 08 __ BEQ $4556 ; (verify_backup.s39 + 0)
.s67:
454e : c9 40 __ CMP #$40
4550 : f0 04 __ BEQ $4556 ; (verify_backup.s39 + 0)
.s68:
4552 : c6 59 __ DEC T9 + 0 
4554 : f0 32 __ BEQ $4588 ; (verify_backup.s42 + 0)
.s39:
4556 : a5 49 __ LDA T0 + 0 
4558 : 20 e1 16 JSR $16e1 ; (mdp_read_byte.s4 + 0)
455b : c5 55 __ CMP T5 + 0 
455d : f0 0e __ BEQ $456d ; (verify_backup.s40 + 0)
.s66:
455f : e6 4d __ INC T2 + 0 
4561 : d0 0a __ BNE $456d ; (verify_backup.s40 + 0)
.s106:
4563 : e6 4e __ INC T2 + 1 
4565 : d0 06 __ BNE $456d ; (verify_backup.s40 + 0)
.s104:
4567 : e6 4f __ INC T2 + 2 
4569 : d0 02 __ BNE $456d ; (verify_backup.s40 + 0)
.s103:
456b : e6 50 __ INC T2 + 3 
.s40:
456d : e6 49 __ INC T0 + 0 
456f : d0 d2 __ BNE $4543 ; (verify_backup.l38 + 0)
.s41:
4571 : e6 53 __ INC T4 + 0 
4573 : d0 02 __ BNE $4577 ; (verify_backup.s100 + 0)
.s99:
4575 : e6 54 __ INC T4 + 1 
.s100:
4577 : a5 54 __ LDA T4 + 1 
4579 : c5 52 __ CMP T3 + 1 
457b : b0 03 __ BCS $4580 ; (verify_backup.s107 + 0)
457d : 4c bd 44 JMP $44bd ; (verify_backup.l35 + 0)
.s107:
4580 : d0 06 __ BNE $4588 ; (verify_backup.s42 + 0)
.s65:
4582 : a5 53 __ LDA T4 + 0 
4584 : c5 51 __ CMP T3 + 0 
4586 : 90 f5 __ BCC $457d ; (verify_backup.s100 + 6)
.s42:
4588 : a5 58 __ LDA T8 + 0 
458a : 8d 03 de STA $de03 
458d : 8d ff 24 STA $24ff ; (mdp_ctrl_shadow + 0)
4590 : 20 fc 1a JSR $1afc ; (krnio_clrchn.s4 + 0)
4593 : a5 59 __ LDA T9 + 0 
4595 : d0 5c __ BNE $45f3 ; (verify_backup.s47 + 0)
.s43:
4597 : 8d 46 9e STA $9e46 ; (dos_err[0] + 0)
459a : a9 ff __ LDA #$ff
459c : 85 0d __ STA P0 
459e : a9 0d __ LDA #$0d
45a0 : 85 0e __ STA P1 
45a2 : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
45a5 : a9 0f __ LDA #$0f
45a7 : 85 0d __ STA P0 
45a9 : 85 0f __ STA P2 
45ab : a9 08 __ LDA #$08
45ad : 85 0e __ STA P1 
45af : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
45b2 : aa __ __ TAX
45b3 : f0 18 __ BEQ $45cd ; (verify_backup.s44 + 0)
.s46:
45b5 : a9 46 __ LDA #$46
45b7 : 85 0e __ STA P1 
45b9 : a9 00 __ LDA #$00
45bb : 85 11 __ STA P4 
45bd : a9 9e __ LDA #$9e
45bf : 85 0f __ STA P2 
45c1 : a9 28 __ LDA #$28
45c3 : 85 10 __ STA P3 
45c5 : 20 7a 30 JSR $307a ; (read_dos_status.s4 + 0)
45c8 : a9 0f __ LDA #$0f
45ca : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s44:
45cd : a9 13 __ LDA #$13
45cf : 85 16 __ STA P9 
45d1 : a9 28 __ LDA #$28
45d3 : 85 15 __ STA P8 
45d5 : a9 02 __ LDA #$02
45d7 : 85 17 __ STA P10 
45d9 : a9 0f __ LDA #$0f
45db : 85 14 __ STA P7 
45dd : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
45e0 : ad 46 9e LDA $9e46 ; (dos_err[0] + 0)
45e3 : d0 03 __ BNE $45e8 ; (verify_backup.s45 + 0)
45e5 : 4c 78 44 JMP $4478 ; (verify_backup.s30 + 0)
.s45:
45e8 : a9 46 __ LDA #$46
45ea : 85 14 __ STA P7 
45ec : a9 9e __ LDA #$9e
45ee : e6 17 __ INC P10 
45f0 : 4c 73 44 JMP $4473 ; (verify_backup.s29 + 0)
.s47:
45f3 : a9 13 __ LDA #$13
45f5 : 85 16 __ STA P9 
45f7 : a9 32 __ LDA #$32
45f9 : 85 15 __ STA P8 
45fb : a9 07 __ LDA #$07
45fd : 85 17 __ STA P10 
45ff : a9 f9 __ LDA #$f9
4601 : 85 14 __ STA P7 
4603 : 20 7e 0a JSR $0a7e ; (print_centered.s4 + 0)
4606 : a5 50 __ LDA T2 + 3 
4608 : d0 17 __ BNE $4621 ; (verify_backup.s48 + 0)
.s62:
460a : a5 4f __ LDA T2 + 2 
460c : d0 13 __ BNE $4621 ; (verify_backup.s48 + 0)
.s63:
460e : a5 4e __ LDA T2 + 1 
4610 : d0 0f __ BNE $4621 ; (verify_backup.s48 + 0)
.s64:
4612 : a5 4d __ LDA T2 + 0 
4614 : d0 0b __ BNE $4621 ; (verify_backup.s48 + 0)
.s61:
4616 : a9 05 __ LDA #$05
4618 : 85 17 __ STA P10 
461a : a9 47 __ LDA #$47
461c : a2 91 __ LDX #$91
461e : 4c 71 44 JMP $4471 ; (verify_backup.s28 + 0)
.s48:
4621 : a9 56 __ LDA #$56
4623 : a2 00 __ LDX #$00
.l96:
4625 : 9d 78 9e STA $9e78,x ; (err_msg[0] + 0)
4628 : e8 __ __ INX
4629 : bd b2 47 LDA $47b2,x 
462c : d0 f7 __ BNE $4625 ; (verify_backup.l96 + 0)
.s49:
462e : 86 51 __ STX T3 + 0 
4630 : a5 50 __ LDA T2 + 3 
4632 : d0 04 __ BNE $4638 ; (verify_backup.s108 + 0)
.s57:
4634 : a5 4f __ LDA T2 + 2 
4636 : f0 07 __ BEQ $463f ; (verify_backup.s58 + 0)
.s108:
4638 : a9 ff __ LDA #$ff
.s56:
463a : 85 0d __ STA P0 
463c : 4c 4f 46 JMP $464f ; (verify_backup.s51 + 0)
.s58:
463f : a9 ff __ LDA #$ff
4641 : c5 4e __ CMP T2 + 1 
4643 : d0 02 __ BNE $4647 ; (verify_backup.s60 + 0)
.s59:
4645 : c5 4d __ CMP T2 + 0 
.s60:
4647 : 90 f1 __ BCC $463a ; (verify_backup.s56 + 0)
.s50:
4649 : a5 4d __ LDA T2 + 0 
464b : 85 0d __ STA P0 
464d : a5 4e __ LDA T2 + 1 
.s51:
464f : 85 0e __ STA P1 
4651 : a9 6e __ LDA #$6e
4653 : 85 0f __ STA P2 
4655 : a9 9e __ LDA #$9e
4657 : 85 10 __ STA P3 
4659 : 20 ea 23 JSR $23ea ; (uint16_to_str.s4 + 0)
465c : a9 6e __ LDA #$6e
465e : 85 0d __ STA P0 
4660 : a9 9e __ LDA #$9e
4662 : 85 0e __ STA P1 
4664 : 20 02 0b JSR $0b02 ; (mystrlen.s4 + 0)
4667 : ac 6e 9e LDY $9e6e ; (num_str[0] + 0)
466a : f0 19 __ BEQ $4685 ; (verify_backup.s109 + 0)
.s53:
466c : a9 00 __ LDA #$00
466e : 85 49 __ STA T0 + 0 
.l54:
4670 : a6 51 __ LDX T3 + 0 
4672 : e0 27 __ CPX #$27
4674 : b0 11 __ BCS $4687 ; (verify_backup.s52 + 0)
.s55:
4676 : 98 __ __ TYA
4677 : 9d 78 9e STA $9e78,x ; (err_msg[0] + 0)
467a : e6 51 __ INC T3 + 0 
467c : e6 49 __ INC T0 + 0 
467e : a6 49 __ LDX T0 + 0 
4680 : bc 6e 9e LDY $9e6e,x ; (num_str[0] + 0)
4683 : d0 eb __ BNE $4670 ; (verify_backup.l54 + 0)
.s109:
4685 : a6 51 __ LDX T3 + 0 
.s52:
4687 : a9 00 __ LDA #$00
4689 : 9d 78 9e STA $9e78,x ; (err_msg[0] + 0)
468c : a9 02 __ LDA #$02
468e : 85 17 __ STA P10 
4690 : a9 9e __ LDA #$9e
4692 : a2 78 __ LDX #$78
4694 : 4c 71 44 JMP $4471 ; (verify_backup.s28 + 0)
.s69:
4697 : a9 03 __ LDA #$03
4699 : 85 0e __ STA P1 
469b : a9 9e __ LDA #$9e
469d : 85 10 __ STA P3 
469f : a9 a0 __ LDA #$a0
46a1 : 85 0f __ STA P2 
46a3 : 20 fc 41 JSR $41fc ; (krnio_read_lzo.s4 + 0)
46a6 : a6 1c __ LDX ACCU + 1 
46a8 : ca __ __ DEX
46a9 : f0 03 __ BEQ $46ae ; (verify_backup.s73 + 0)
46ab : 4c 52 45 JMP $4552 ; (verify_backup.s68 + 0)
.s73:
46ae : a5 1b __ LDA ACCU + 0 
46b0 : d0 f9 __ BNE $46ab ; (verify_backup.s69 + 20)
.l70:
46b2 : 85 0d __ STA P0 
46b4 : 20 e1 16 JSR $16e1 ; (mdp_read_byte.s4 + 0)
46b7 : a6 0d __ LDX P0 
46b9 : dd a0 9e CMP $9ea0,x ; (page_buf[0] + 0)
46bc : f0 0e __ BEQ $46cc ; (verify_backup.s71 + 0)
.s72:
46be : e6 4d __ INC T2 + 0 
46c0 : d0 0a __ BNE $46cc ; (verify_backup.s71 + 0)
.s105:
46c2 : e6 4e __ INC T2 + 1 
46c4 : d0 06 __ BNE $46cc ; (verify_backup.s71 + 0)
.s102:
46c6 : e6 4f __ INC T2 + 2 
46c8 : d0 02 __ BNE $46cc ; (verify_backup.s71 + 0)
.s101:
46ca : e6 50 __ INC T2 + 3 
.s71:
46cc : e8 __ __ INX
46cd : 8a __ __ TXA
46ce : d0 e2 __ BNE $46b2 ; (verify_backup.l70 + 0)
46d0 : 4c 71 45 JMP $4571 ; (verify_backup.s41 + 0)
.s78:
46d3 : a5 51 __ LDA T3 + 0 
46d5 : f0 03 __ BEQ $46da ; (verify_backup.s79 + 0)
46d7 : 4c 22 44 JMP $4422 ; (verify_backup.s22 + 0)
.s79:
46da : a5 53 __ LDA T4 + 0 
46dc : d0 03 __ BNE $46e1 ; (verify_backup.s79 + 7)
46de : 4c 15 44 JMP $4415 ; (verify_backup.s21 + 0)
46e1 : 4c 0d 44 JMP $440d ; (verify_backup.s77 + 0)
.s81:
46e4 : a9 ff __ LDA #$ff
46e6 : 85 0d __ STA P0 
46e8 : a9 0d __ LDA #$0d
46ea : 85 0e __ STA P1 
46ec : 20 ef 21 JSR $21ef ; (krnio_setnam.s4 + 0)
46ef : a9 0f __ LDA #$0f
46f1 : 85 0d __ STA P0 
46f3 : 85 0f __ STA P2 
46f5 : a9 08 __ LDA #$08
46f7 : 85 0e __ STA P1 
46f9 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
46fc : aa __ __ TAX
46fd : f0 35 __ BEQ $4734 ; (verify_backup.s82 + 0)
.s83:
46ff : a9 28 __ LDA #$28
4701 : 85 10 __ STA P3 
4703 : a9 9f __ LDA #$9f
4705 : 85 0f __ STA P2 
4707 : a9 00 __ LDA #$00
4709 : 85 11 __ STA P4 
470b : a9 a8 __ LDA #$a8
470d : 85 0e __ STA P1 
470f : 20 7a 30 JSR $307a ; (read_dos_status.s4 + 0)
4712 : ad a8 9f LDA $9fa8 ; (temp_status[0] + 0)
4715 : c9 30 __ CMP #$30
4717 : d0 16 __ BNE $472f ; (verify_backup.s84 + 0)
.s85:
4719 : ad a9 9f LDA $9fa9 ; (temp_status[0] + 1)
471c : c9 30 __ CMP #$30
471e : d0 0f __ BNE $472f ; (verify_backup.s84 + 0)
.s86:
4720 : a9 0f __ LDA #$0f
4722 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
4725 : a9 03 __ LDA #$03
4727 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
472a : e6 53 __ INC T4 + 0 
472c : 4c f6 43 JMP $43f6 ; (verify_backup.s18 + 0)
.s84:
472f : a9 0f __ LDA #$0f
4731 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s82:
4734 : a9 03 __ LDA #$03
4736 : 4c f3 43 JMP $43f3 ; (verify_backup.s97 + 0)
.s88:
4739 : 20 05 22 JSR $2205 ; (krnio_open.s4 + 0)
473c : aa __ __ TAX
473d : f0 35 __ BEQ $4774 ; (verify_backup.s89 + 0)
.s90:
473f : a9 28 __ LDA #$28
4741 : 85 10 __ STA P3 
4743 : a9 9f __ LDA #$9f
4745 : 85 0f __ STA P2 
4747 : a9 00 __ LDA #$00
4749 : 85 11 __ STA P4 
474b : a9 d0 __ LDA #$d0
474d : 85 0e __ STA P1 
474f : 20 7a 30 JSR $307a ; (read_dos_status.s4 + 0)
4752 : ad d0 9f LDA $9fd0 ; (temp_status[0] + 0)
4755 : c9 30 __ CMP #$30
4757 : d0 16 __ BNE $476f ; (verify_backup.s91 + 0)
.s92:
4759 : ad d1 9f LDA $9fd1 ; (temp_status[0] + 1)
475c : c9 30 __ CMP #$30
475e : d0 0f __ BNE $476f ; (verify_backup.s91 + 0)
.s93:
4760 : a9 0f __ LDA #$0f
4762 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
4765 : a9 03 __ LDA #$03
4767 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
476a : e6 51 __ INC T3 + 0 
476c : 4c b8 43 JMP $43b8 ; (verify_backup.s16 + 0)
.s91:
476f : a9 0f __ LDA #$0f
4771 : 20 48 22 JSR $2248 ; (krnio_close.s4 + 0)
.s89:
4774 : a9 03 __ LDA #$03
4776 : 4c b5 43 JMP $43b5 ; (verify_backup.s98 + 0)
.s95:
4779 : ad fc 27 LDA $27fc ; (sram_status + 0)
477c : f0 03 __ BEQ $4781 ; (verify_backup.s95 + 8)
477e : 4c 38 43 JMP $4338 ; (verify_backup.s12 + 0)
4781 : 4c f2 42 JMP $42f2 ; (verify_backup.s6 + 0)
--------------------------------------------------------------------
4784 : __ __ __ BYT 56 45 52 49 46 59 49 4e 47 2e 2e 2e 00          : VERIFYING....
--------------------------------------------------------------------
4791 : __ __ __ BYT 42 41 43 4b 55 50 20 56 45 52 49 46 49 45 44 3a : BACKUP VERIFIED:
47a1 : __ __ __ BYT 20 4f 4b 21 20 20 20 20 20 20 20 20 20 20 20 20 :  OK!            
47b1 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
47b2 : __ __ __ BYT 56 45 52 49 46 59 20 46 41 49 4c 45 44 21 20 45 : VERIFY FAILED! E
47c2 : __ __ __ BYT 52 52 4f 52 53 3a 20 00                         : RRORS: .
--------------------------------------------------------------------
47ca : __ __ __ BYT 53 45 45 20 59 4f 55 20 53 50 41 43 45 20 43 4f : SEE YOU SPACE CO
47da : __ __ __ BYT 57 42 4f 59 00                                  : WBOY.
--------------------------------------------------------------------
mul16by8: ; mul16by8
47df : 4a __ __ LSR
47e0 : f0 2e __ BEQ $4810 ; (mul16by8 + 49)
47e2 : a2 00 __ LDX #$00
47e4 : a0 00 __ LDY #$00
47e6 : 90 13 __ BCC $47fb ; (mul16by8 + 28)
47e8 : a4 1b __ LDY ACCU + 0 
47ea : a6 1c __ LDX ACCU + 1 
47ec : b0 0d __ BCS $47fb ; (mul16by8 + 28)
47ee : 85 02 __ STA $02 
47f0 : 18 __ __ CLC
47f1 : 98 __ __ TYA
47f2 : 65 1b __ ADC ACCU + 0 
47f4 : a8 __ __ TAY
47f5 : 8a __ __ TXA
47f6 : 65 1c __ ADC ACCU + 1 
47f8 : aa __ __ TAX
47f9 : a5 02 __ LDA $02 
47fb : 06 1b __ ASL ACCU + 0 
47fd : 26 1c __ ROL ACCU + 1 
47ff : 4a __ __ LSR
4800 : 90 f9 __ BCC $47fb ; (mul16by8 + 28)
4802 : d0 ea __ BNE $47ee ; (mul16by8 + 15)
4804 : 18 __ __ CLC
4805 : 98 __ __ TYA
4806 : 65 1b __ ADC ACCU + 0 
4808 : 85 1b __ STA ACCU + 0 
480a : 8a __ __ TXA
480b : 65 1c __ ADC ACCU + 1 
480d : 85 1c __ STA ACCU + 1 
480f : 60 __ __ RTS
4810 : b0 04 __ BCS $4816 ; (mul16by8 + 55)
4812 : 85 1b __ STA ACCU + 0 
4814 : 85 1c __ STA ACCU + 1 
4816 : 60 __ __ RTS
--------------------------------------------------------------------
mul32by8: ; mul32by8
4817 : a0 00 __ LDY #$00
4819 : 84 07 __ STY WORK + 4 
481b : 84 08 __ STY WORK + 5 
481d : 84 09 __ STY WORK + 6 
481f : 4a __ __ LSR
4820 : b0 0d __ BCS $482f ; (mul32by8 + 24)
4822 : f0 26 __ BEQ $484a ; (mul32by8 + 51)
4824 : 06 1b __ ASL ACCU + 0 
4826 : 26 1c __ ROL ACCU + 1 
4828 : 26 1d __ ROL ACCU + 2 
482a : 26 1e __ ROL ACCU + 3 
482c : 4a __ __ LSR
482d : 90 f5 __ BCC $4824 ; (mul32by8 + 13)
482f : aa __ __ TAX
4830 : 18 __ __ CLC
4831 : a5 07 __ LDA WORK + 4 
4833 : 65 1b __ ADC ACCU + 0 
4835 : 85 07 __ STA WORK + 4 
4837 : a5 08 __ LDA WORK + 5 
4839 : 65 1c __ ADC ACCU + 1 
483b : 85 08 __ STA WORK + 5 
483d : a5 09 __ LDA WORK + 6 
483f : 65 1d __ ADC ACCU + 2 
4841 : 85 09 __ STA WORK + 6 
4843 : 98 __ __ TYA
4844 : 65 1e __ ADC ACCU + 3 
4846 : a8 __ __ TAY
4847 : 8a __ __ TXA
4848 : d0 da __ BNE $4824 ; (mul32by8 + 13)
484a : 84 0a __ STY WORK + 7 
484c : 60 __ __ RTS
--------------------------------------------------------------------
divmod: ; divmod
484d : a5 1c __ LDA ACCU + 1 
484f : d0 31 __ BNE $4882 ; (divmod + 53)
4851 : a5 04 __ LDA WORK + 1 
4853 : d0 1e __ BNE $4873 ; (divmod + 38)
4855 : 85 06 __ STA WORK + 3 
4857 : a2 04 __ LDX #$04
4859 : 06 1b __ ASL ACCU + 0 
485b : 2a __ __ ROL
485c : c5 03 __ CMP WORK + 0 
485e : 90 02 __ BCC $4862 ; (divmod + 21)
4860 : e5 03 __ SBC WORK + 0 
4862 : 26 1b __ ROL ACCU + 0 
4864 : 2a __ __ ROL
4865 : c5 03 __ CMP WORK + 0 
4867 : 90 02 __ BCC $486b ; (divmod + 30)
4869 : e5 03 __ SBC WORK + 0 
486b : 26 1b __ ROL ACCU + 0 
486d : ca __ __ DEX
486e : d0 eb __ BNE $485b ; (divmod + 14)
4870 : 85 05 __ STA WORK + 2 
4872 : 60 __ __ RTS
4873 : a5 1b __ LDA ACCU + 0 
4875 : 85 05 __ STA WORK + 2 
4877 : a5 1c __ LDA ACCU + 1 
4879 : 85 06 __ STA WORK + 3 
487b : a9 00 __ LDA #$00
487d : 85 1b __ STA ACCU + 0 
487f : 85 1c __ STA ACCU + 1 
4881 : 60 __ __ RTS
4882 : a5 04 __ LDA WORK + 1 
4884 : d0 1f __ BNE $48a5 ; (divmod + 88)
4886 : a5 03 __ LDA WORK + 0 
4888 : 30 1b __ BMI $48a5 ; (divmod + 88)
488a : a9 00 __ LDA #$00
488c : 85 06 __ STA WORK + 3 
488e : a2 10 __ LDX #$10
4890 : 06 1b __ ASL ACCU + 0 
4892 : 26 1c __ ROL ACCU + 1 
4894 : 2a __ __ ROL
4895 : c5 03 __ CMP WORK + 0 
4897 : 90 02 __ BCC $489b ; (divmod + 78)
4899 : e5 03 __ SBC WORK + 0 
489b : 26 1b __ ROL ACCU + 0 
489d : 26 1c __ ROL ACCU + 1 
489f : ca __ __ DEX
48a0 : d0 f2 __ BNE $4894 ; (divmod + 71)
48a2 : 85 05 __ STA WORK + 2 
48a4 : 60 __ __ RTS
48a5 : a9 00 __ LDA #$00
48a7 : 85 05 __ STA WORK + 2 
48a9 : 85 06 __ STA WORK + 3 
48ab : 84 02 __ STY $02 
48ad : a0 10 __ LDY #$10
48af : 18 __ __ CLC
48b0 : 26 1b __ ROL ACCU + 0 
48b2 : 26 1c __ ROL ACCU + 1 
48b4 : 26 05 __ ROL WORK + 2 
48b6 : 26 06 __ ROL WORK + 3 
48b8 : 38 __ __ SEC
48b9 : a5 05 __ LDA WORK + 2 
48bb : e5 03 __ SBC WORK + 0 
48bd : aa __ __ TAX
48be : a5 06 __ LDA WORK + 3 
48c0 : e5 04 __ SBC WORK + 1 
48c2 : 90 04 __ BCC $48c8 ; (divmod + 123)
48c4 : 86 05 __ STX WORK + 2 
48c6 : 85 06 __ STA WORK + 3 
48c8 : 88 __ __ DEY
48c9 : d0 e5 __ BNE $48b0 ; (divmod + 99)
48cb : 26 1b __ ROL ACCU + 0 
48cd : 26 1c __ ROL ACCU + 1 
48cf : a4 02 __ LDY $02 
48d1 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32: ; divmod32
48d2 : 84 02 __ STY $02 
48d4 : a0 20 __ LDY #$20
48d6 : a9 00 __ LDA #$00
48d8 : 85 07 __ STA WORK + 4 
48da : 85 08 __ STA WORK + 5 
48dc : 85 09 __ STA WORK + 6 
48de : 85 0a __ STA WORK + 7 
48e0 : a5 05 __ LDA WORK + 2 
48e2 : 05 06 __ ORA WORK + 3 
48e4 : d0 78 __ BNE $495e ; (divmod32 + 140)
48e6 : a5 04 __ LDA WORK + 1 
48e8 : d0 27 __ BNE $4911 ; (divmod32 + 63)
48ea : 18 __ __ CLC
48eb : 26 1b __ ROL ACCU + 0 
48ed : 26 1c __ ROL ACCU + 1 
48ef : 26 1d __ ROL ACCU + 2 
48f1 : 26 1e __ ROL ACCU + 3 
48f3 : 2a __ __ ROL
48f4 : 90 05 __ BCC $48fb ; (divmod32 + 41)
48f6 : e5 03 __ SBC WORK + 0 
48f8 : 38 __ __ SEC
48f9 : b0 06 __ BCS $4901 ; (divmod32 + 47)
48fb : c5 03 __ CMP WORK + 0 
48fd : 90 02 __ BCC $4901 ; (divmod32 + 47)
48ff : e5 03 __ SBC WORK + 0 
4901 : 88 __ __ DEY
4902 : d0 e7 __ BNE $48eb ; (divmod32 + 25)
4904 : 85 07 __ STA WORK + 4 
4906 : 26 1b __ ROL ACCU + 0 
4908 : 26 1c __ ROL ACCU + 1 
490a : 26 1d __ ROL ACCU + 2 
490c : 26 1e __ ROL ACCU + 3 
490e : a4 02 __ LDY $02 
4910 : 60 __ __ RTS
4911 : a5 1e __ LDA ACCU + 3 
4913 : d0 10 __ BNE $4925 ; (divmod32 + 83)
4915 : a6 1d __ LDX ACCU + 2 
4917 : 86 1e __ STX ACCU + 3 
4919 : a6 1c __ LDX ACCU + 1 
491b : 86 1d __ STX ACCU + 2 
491d : a6 1b __ LDX ACCU + 0 
491f : 86 1c __ STX ACCU + 1 
4921 : 85 1b __ STA ACCU + 0 
4923 : a0 18 __ LDY #$18
4925 : 18 __ __ CLC
4926 : 26 1b __ ROL ACCU + 0 
4928 : 26 1c __ ROL ACCU + 1 
492a : 26 1d __ ROL ACCU + 2 
492c : 26 1e __ ROL ACCU + 3 
492e : 26 07 __ ROL WORK + 4 
4930 : 26 08 __ ROL WORK + 5 
4932 : 90 0c __ BCC $4940 ; (divmod32 + 110)
4934 : a5 07 __ LDA WORK + 4 
4936 : e5 03 __ SBC WORK + 0 
4938 : aa __ __ TAX
4939 : a5 08 __ LDA WORK + 5 
493b : e5 04 __ SBC WORK + 1 
493d : 38 __ __ SEC
493e : b0 0c __ BCS $494c ; (divmod32 + 122)
4940 : 38 __ __ SEC
4941 : a5 07 __ LDA WORK + 4 
4943 : e5 03 __ SBC WORK + 0 
4945 : aa __ __ TAX
4946 : a5 08 __ LDA WORK + 5 
4948 : e5 04 __ SBC WORK + 1 
494a : 90 04 __ BCC $4950 ; (divmod32 + 126)
494c : 86 07 __ STX WORK + 4 
494e : 85 08 __ STA WORK + 5 
4950 : 88 __ __ DEY
4951 : d0 d3 __ BNE $4926 ; (divmod32 + 84)
4953 : 26 1b __ ROL ACCU + 0 
4955 : 26 1c __ ROL ACCU + 1 
4957 : 26 1d __ ROL ACCU + 2 
4959 : 26 1e __ ROL ACCU + 3 
495b : a4 02 __ LDY $02 
495d : 60 __ __ RTS
495e : a0 10 __ LDY #$10
4960 : a5 1e __ LDA ACCU + 3 
4962 : 85 08 __ STA WORK + 5 
4964 : a5 1d __ LDA ACCU + 2 
4966 : 85 07 __ STA WORK + 4 
4968 : a9 00 __ LDA #$00
496a : 85 1d __ STA ACCU + 2 
496c : 85 1e __ STA ACCU + 3 
496e : 18 __ __ CLC
496f : 26 1b __ ROL ACCU + 0 
4971 : 26 1c __ ROL ACCU + 1 
4973 : 26 07 __ ROL WORK + 4 
4975 : 26 08 __ ROL WORK + 5 
4977 : 26 09 __ ROL WORK + 6 
4979 : 26 0a __ ROL WORK + 7 
497b : a5 07 __ LDA WORK + 4 
497d : c5 03 __ CMP WORK + 0 
497f : a5 08 __ LDA WORK + 5 
4981 : e5 04 __ SBC WORK + 1 
4983 : a5 09 __ LDA WORK + 6 
4985 : e5 05 __ SBC WORK + 2 
4987 : aa __ __ TAX
4988 : a5 0a __ LDA WORK + 7 
498a : e5 06 __ SBC WORK + 3 
498c : 90 11 __ BCC $499f ; (divmod32 + 205)
498e : 86 09 __ STX WORK + 6 
4990 : 85 0a __ STA WORK + 7 
4992 : a5 07 __ LDA WORK + 4 
4994 : e5 03 __ SBC WORK + 0 
4996 : 85 07 __ STA WORK + 4 
4998 : a5 08 __ LDA WORK + 5 
499a : e5 04 __ SBC WORK + 1 
499c : 85 08 __ STA WORK + 5 
499e : 38 __ __ SEC
499f : 88 __ __ DEY
49a0 : d0 cd __ BNE $496f ; (divmod32 + 157)
49a2 : 26 1b __ ROL ACCU + 0 
49a4 : 26 1c __ ROL ACCU + 1 
49a6 : a4 02 __ LDY $02 
49a8 : 60 __ __ RTS
--------------------------------------------------------------------
krnio_pstatus:
49a9 : __ __ __ BSS	16
--------------------------------------------------------------------
prg_names:
49b9 : __ __ __ BSS	510
--------------------------------------------------------------------
prg_blocks_arr:
4bb7 : __ __ __ BSS	60
