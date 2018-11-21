;
; Generated.
;
; ***************************************************************************************
; ***************************************************************************************
;
;  Name :   binary.words
;  Author : Paul Robson (paul@robsons.org.uk)
;  Date :   15th November 2018
;  Purpose : Binary operators
;
; ***************************************************************************************
; ***************************************************************************************


; @forth[ix]   *

cforth_2a_forth:
    pop ix
cforth_2a_code:
  pop  hl
  call  MULTMultiply16        ; HL := HL * DE
  ex   de,hl

; @end

cforth_2a_end:
    jp (ix)

; *********************************************************************************


; @forth[ix]   /

cforth_2f_forth:
    pop ix
cforth_2f_code:
  pop  hl
  call  DIVDivideMod16       ; DE := DE/HL HL = DE%HL

; @end

cforth_2f_end:
    jp (ix)

; *********************************************************************************


; @forth[ix]   mod

cforth_6d_6f_64_forth:
    pop ix
cforth_6d_6f_64_code:
  pop  hl
  call  DIVDivideMod16       ; DE := DE/HL HL = DE%HL
  ex   de,hl

; @end

cforth_6d_6f_64_end:
    jp (ix)

; *********************************************************************************


; @forth[ix]   /mod

cforth_2f_6d_6f_64_forth:
    pop ix
cforth_2f_6d_6f_64_code:
  pop  hl
  call  DIVDivideMod16       ; DE := DE/HL HL = DE%HL
  push  hl

; @end

cforth_2f_6d_6f_64_end:
    jp (ix)

; *********************************************************************************


; @macro[ix] +

cforth_2b_forth:
    pop ix
cforth_2b_code:
  pop  hl
  add  hl,de
  ex   de,hl

; @end

cforth_2b_end:
    jp (ix)
cforth_2b_macro:
    ld b,cforth_2b_end-cforth_2b_start
    ld hl,cforth_2b_start
    jp MacroExpand

; *********************************************************************************


; @forth[hl]  and

cforth_61_6e_64_forth:
    pop hl
cforth_61_6e_64_code:
  pop  bc
  ld   a,e
  and  c
  ld   e,a
  ld   a,d
  and  b
  ld   d,a

; @end

cforth_61_6e_64_end:
    jp (hl)

; *********************************************************************************


; @forth[hl]  or

cforth_6f_72_forth:
    pop hl
cforth_6f_72_code:
  pop  bc
  ld   a,e
  xor  c
  ld   e,a
  ld   a,d
  xor  b
  ld   d,a

; @end

cforth_6f_72_end:
    jp (hl)

; *********************************************************************************


; @forth[hl]  +or

cforth_2b_6f_72_forth:
    pop hl
cforth_2b_6f_72_code:
  pop  bc
  ld   a,e
  or   c
  ld   e,a
  ld   a,d
  or   b
  ld   d,a

; @end

cforth_2b_6f_72_end:
    jp (hl)

; ***************************************************************************************
; ***************************************************************************************
;
;  Name :   compare.words
;  Author : Paul Robson (paul@robsons.org.uk)
;  Date :   16th November 2018
;  Purpose : Comparison words, min and max.
;
; ***************************************************************************************
; ***************************************************************************************

; *********************************************************************************


; @forth[hl]   =

cforth_3d_forth:
    pop hl
cforth_3d_code:
  pop  bc
  ld   a,b    ; B = B ^ D
  xor  d
  ld   b,a
  ld   a,c    ; A = (B ^ D) | (C ^ E) if BC=DE then Z
  xor  e
  or   b
  ld   de,$0000
  jr   nz,__equal1
  dec  de
__equal1:

; @end

cforth_3d_end:
    jp (hl)

; ***************************************************************************************
; ***************************************************************************************
;
;  Name :   graphic.words
;  Author : Paul Robson (paul@robsons.org.uk)
;  Date :   15th November 2018
;  Purpose : Graphic System words
;
; ***************************************************************************************
; ***************************************************************************************


; @word[hl] screenmode

cforth_73_63_72_65_65_6e_6d_6f_64_65_forth:
    pop hl
cforth_73_63_72_65_65_6e_6d_6f_64_65_code:
  ld   a,e
  call GFXMode
  pop  de

; @end

cforth_73_63_72_65_65_6e_6d_6f_64_65_end:
    jp (hl)

; ***************************************************************************************


; @word[ix] screen!

cforth_73_63_72_65_65_6e_21_forth:
    pop ix
cforth_73_63_72_65_65_6e_21_code:
  ex   de,hl        ; TOS (address) in HL
  pop  de         ; data in DE
  call  GFXWriteCharacter     ; display it
  pop  de         ; fix up stack

; @end

cforth_73_63_72_65_65_6e_21_end:
    jp (ix)

; ***************************************************************************************
; ***************************************************************************************
;
;  Name :   memory.words
;  Author : Paul Robson (paul@robsons.org.uk)
;  Date :   15th November 2018
;  Purpose : Memory and Hardware access
;
; ***************************************************************************************
; ***************************************************************************************


; @macro[ix] @

cforth_40_forth:
    pop ix
cforth_40_code:
  ex   de,hl
  ld   e,(hl)
  inc  hl
  ld   d,(hl)

; @end

cforth_40_end:
    jp (ix)
cforth_40_macro:
    ld b,cforth_40_end-cforth_40_start
    ld hl,cforth_40_start
    jp MacroExpand

; *********************************************************************************


; @macro[hl] c@

cforth_63_40_forth:
    pop hl
cforth_63_40_code:
  ld   a,(de)
  ld   e,a
  ld   d,0

; @end

cforth_63_40_end:
    jp (hl)
cforth_63_40_macro:
    ld b,cforth_63_40_end-cforth_63_40_start
    ld hl,cforth_63_40_start
    jp MacroExpand

; *********************************************************************************


; @macro[ix] c!

cforth_63_21_forth:
    pop ix
cforth_63_21_code:
  pop  hl
  ld   a,l
  ld   (de),a
  pop  de

; @end

cforth_63_21_end:
    jp (ix)
cforth_63_21_macro:
    ld b,cforth_63_21_end-cforth_63_21_start
    ld hl,cforth_63_21_start
    jp MacroExpand

; *********************************************************************************


; @macro[ix] !

cforth_21_forth:
    pop ix
cforth_21_code:
  pop  hl
  ld   (hl),e
  inc  hl
  ld   (hl),d
  pop  de

; @end

cforth_21_end:
    jp (ix)
cforth_21_macro:
    ld b,cforth_21_end-cforth_21_start
    ld hl,cforth_21_start
    jp MacroExpand

; *********************************************************************************


; @forth[ix] +!

cforth_2b_21_forth:
    pop ix
cforth_2b_21_code:
  pop  hl      ; address in DE, get data in HL
  ex   de,hl     ; address in HL, data in E
  ld   a,(hl)
  add  a,e
  ld   (hl),a
  inc  hl
  ld   a,(hl)
  adc  a,d
  ld   (hl),a
  pop  de

; @end

cforth_2b_21_end:
    jp (ix)

; *********************************************************************************


; @forth[ix] or!

cforth_6f_72_21_forth:
    pop ix
cforth_6f_72_21_code:
  pop  hl
  ld   a,(hl)
  or   e
  ld   (hl),a
  inc  hl
  ld   a,(hl)
  or   d
  ld   (hl),a
  pop  de

; @end

cforth_6f_72_21_end:
    jp (ix)

; *********************************************************************************


; @forth[ix] fill

cforth_66_69_6c_6c_forth:
    pop ix
cforth_66_69_6c_6c_code:

  pop  hl       ; top is count (DE) 2nd address (HL) 3rd value (BC)
  pop  bc
  ld   a,d
  or   e
  jr   z,__fill2

__fill1:ld   (hl),c
  inc  hl
  dec  bc
  ld   a,d
  or   e
  jr   nz,__fill1
__fill2:
  pop  de

; @end

cforth_66_69_6c_6c_end:
    jp (ix)

; *********************************************************************************


; @forth[ix] move

cforth_6d_6f_76_65_forth:
    pop ix
cforth_6d_6f_76_65_code:
  ld   b,d         ; top is count (BC)
  ld   c,e
  pop  hl          ; 2nd is target (HL)
  pop  de          ; 3rd is source (DE)

  ld   a,b
  or   c
  jr   z,__move2

  xor  a          ; find direction.
  sbc  hl,de
  ld   a,h
  add  hl,de
  bit  7,a         ; if +ve use LDDR
  jr   z,__move3

  ex   de,hl         ; LDIR etc do (DE) <- (HL)
  ldir
  jr   __move2

__move3:
  add  hl,bc         ; add length to HL,DE, swap as LDDR does (DE) <- (HL)
  ex   de,hl
  add  hl,bc
  dec  de          ; -1 to point to last byte
  dec  hl
  lddr

__move2:
  pop  de

; @end

cforth_6d_6f_76_65_end:
    jp (ix)

; *********************************************************************************


; @macro[hl] p@

cforth_70_40_forth:
    pop hl
cforth_70_40_code:
  ld   b,d
  ld   c,e
  in   e,(c)
  ld   d,0

; @end

cforth_70_40_end:
    jp (hl)
cforth_70_40_macro:
    ld b,cforth_70_40_end-cforth_70_40_start
    ld hl,cforth_70_40_start
    jp MacroExpand

; *********************************************************************************


; @macro[hl] p!

cforth_70_21_forth:
    pop hl
cforth_70_21_code:
  ld   b,d
  ld   c,e
  pop  de
  out  (c),e
  pop  de

; @end

cforth_70_21_end:
    jp (hl)
cforth_70_21_macro:
    ld b,cforth_70_21_end-cforth_70_21_start
    ld hl,cforth_70_21_start
    jp MacroExpand
; ***************************************************************************************
; ***************************************************************************************
;
;  Name :   stack.words
;  Author : Paul Robson (paul@robsons.org.uk)
;  Date :   16th November 2018
;  Purpose : Stack operators
;
; ***************************************************************************************
; ***************************************************************************************


; @macro[hl] drop

cforth_64_72_6f_70_forth:
    pop hl
cforth_64_72_6f_70_code:
  pop  de

; @end

cforth_64_72_6f_70_end:
    jp (hl)
cforth_64_72_6f_70_macro:
    ld b,cforth_64_72_6f_70_end-cforth_64_72_6f_70_start
    ld hl,cforth_64_72_6f_70_start
    jp MacroExpand

; *********************************************************************************


; @macro[hl] dup

cforth_64_75_70_forth:
    pop hl
cforth_64_75_70_code:
  push  de

; @end

cforth_64_75_70_end:
    jp (hl)
cforth_64_75_70_macro:
    ld b,cforth_64_75_70_end-cforth_64_75_70_start
    ld hl,cforth_64_75_70_start
    jp MacroExpand

; *********************************************************************************


; @macro[ix] nip

cforth_6e_69_70_forth:
    pop ix
cforth_6e_69_70_code:
  pop  hl

; @end

cforth_6e_69_70_end:
    jp (ix)
cforth_6e_69_70_macro:
    ld b,cforth_6e_69_70_end-cforth_6e_69_70_start
    ld hl,cforth_6e_69_70_start
    jp MacroExpand

; *********************************************************************************


; @macro[ix] over

cforth_6f_76_65_72_forth:
    pop ix
cforth_6f_76_65_72_code:
  pop  hl
  push  de
  ex   de,hl

; @end

cforth_6f_76_65_72_end:
    jp (ix)
cforth_6f_76_65_72_macro:
    ld b,cforth_6f_76_65_72_end-cforth_6f_76_65_72_start
    ld hl,cforth_6f_76_65_72_start
    jp MacroExpand

; *********************************************************************************


; @macro[ix] swap

cforth_73_77_61_70_forth:
    pop ix
cforth_73_77_61_70_code:
  pop  hl
  ex   de,hl
  push  hl

; @end

cforth_73_77_61_70_end:
    jp (ix)
cforth_73_77_61_70_macro:
    ld b,cforth_73_77_61_70_end-cforth_73_77_61_70_start
    ld hl,cforth_73_77_61_70_start
    jp MacroExpand

; ***************************************************************************************
; ***************************************************************************************
;
;  Name :   unary.words
;  Author : Paul Robson (paul@robsons.org.uk)
;  Date :   22nd November 2018
;  Purpose : Unary operators
;
; ***************************************************************************************
; ***************************************************************************************


; @macro[ret] bswap

cforth_62_73_77_61_70_forth:
cforth_62_73_77_61_70_code:
  ld   a,d
  ld   d,e
  ld   e,a

; @end

cforth_62_73_77_61_70_end:
    ret
cforth_62_73_77_61_70_macro:
    ld b,cforth_62_73_77_61_70_end-cforth_62_73_77_61_70_start
    ld hl,cforth_62_73_77_61_70_start
    jp MacroExpand

; *********************************************************************************


; @macro[ret] 2*

cforth_32_2a_forth:
cforth_32_2a_code:
  ex   de,hl
  add  hl,hl
  ex   de,hl

; @end

cforth_32_2a_end:
    ret
cforth_32_2a_macro:
    ld b,cforth_32_2a_end-cforth_32_2a_start
    ld hl,cforth_32_2a_start
    jp MacroExpand

; *********************************************************************************


; @macro[ret] 2/

cforth_32_2f_forth:
cforth_32_2f_code:
  srl  d
  rr   e

; @end

cforth_32_2f_end:
    ret
cforth_32_2f_macro:
    ld b,cforth_32_2f_end-cforth_32_2f_start
    ld hl,cforth_32_2f_start
    jp MacroExpand

; *********************************************************************************


; @macro[ret] 1+

cforth_31_2b_forth:
cforth_31_2b_code:
  inc  de

; @end

cforth_31_2b_end:
    ret
cforth_31_2b_macro:
    ld b,cforth_31_2b_end-cforth_31_2b_start
    ld hl,cforth_31_2b_start
    jp MacroExpand

; *********************************************************************************


; @macro[ret] 2+

cforth_32_2b_forth:
cforth_32_2b_code:
  inc  de
  inc  de

; @end

cforth_32_2b_end:
    ret
cforth_32_2b_macro:
    ld b,cforth_32_2b_end-cforth_32_2b_start
    ld hl,cforth_32_2b_start
    jp MacroExpand

; *********************************************************************************


; @macro[ret] 1-

cforth_31_2d_forth:
cforth_31_2d_code:
  dec  de

; @end

cforth_31_2d_end:
    ret
cforth_31_2d_macro:
    ld b,cforth_31_2d_end-cforth_31_2d_start
    ld hl,cforth_31_2d_start
    jp MacroExpand

; *********************************************************************************


; @macro[ret] 2-

cforth_32_2d_forth:
cforth_32_2d_code:
  dec  de
  dec  de

; @end

cforth_32_2d_end:
    ret
cforth_32_2d_macro:
    ld b,cforth_32_2d_end-cforth_32_2d_start
    ld hl,cforth_32_2d_start
    jp MacroExpand

; *********************************************************************************


; @forth[ret] -

cforth_2d_forth:
cforth_2d_code:
  ld   a,d
  cpl
  ld   d,a
  ld   a,e
  cpl
  ld   e,a

; @end

cforth_2d_end:
    ret

; *********************************************************************************


; @forth[ret]  negate

cforth_6e_65_67_61_74_65_forth:
cforth_6e_65_67_61_74_65_code:
  ld   a,d
  cpl
  ld   d,a
  ld   a,e
  cpl
  ld   e,a
  inc  de

; @end

cforth_6e_65_67_61_74_65_end:
    ret

; *********************************************************************************


; @forth[ret]  abs

cforth_61_62_73_forth:
cforth_61_62_73_code:
  bit  7,d
  jr   z,__IsPositive
  ld   a,d
  cpl
  ld   d,a
  ld   a,e
  cpl
  ld   e,a
  inc  de
__IsPositive:

; @end

cforth_61_62_73_end:
    ret

; *********************************************************************************


; @forth[ret]  0=

cforth_30_3d_forth:
cforth_30_3d_code:
  ld   a,d
  or   e
  ld   de,$0000
  jr   nz,__IsNonZero
  dec  de
__IsNonZero:

; @end

cforth_30_3d_end:
    ret

; *********************************************************************************


; @forth[ret]  0<

cforth_30_3c_forth:
cforth_30_3c_code:
  bit  7,d
  ld   de,$0000
  jr   z,__IsPositive2
  dec  de
__IsPositive2:

; @end

cforth_30_3c_end:
    ret
; ***************************************************************************************
; ***************************************************************************************
;
;  Name :   utility.words
;  Author : Paul Robson (paul@robsons.org.uk)
;  Date :   21st November 2018
;  Purpose : Miscellaneous words.
;
; ***************************************************************************************
; ***************************************************************************************


; @forth[hl] inkey

cforth_69_6e_6b_65_79_forth:
    pop hl
cforth_69_6e_6b_65_79_code:
  push  de
  call  IOScanKeyboard
  ld   e,a
  ld   d,0

; @end

cforth_69_6e_6b_65_79_end:
    jp (hl)

; ***************************************************************************************


; @forth[ret] halt

cforth_68_61_6c_74_forth:
cforth_68_61_6c_74_code:

__haltLoop:
  di
  halt
  jr   __haltLoop


; @end

cforth_68_61_6c_74_end:
    ret

; ***************************************************************************************


; @macro[ret] break

cforth_62_72_65_61_6b_forth:
cforth_62_72_65_61_6b_code:
  db   $DD,$01

; @endm

cforth_62_72_65_61_6b_end:
    ret
cforth_62_72_65_61_6b_macro:
    ld b,cforth_62_72_65_61_6b_end-cforth_62_72_65_61_6b_start
    ld hl,cforth_62_72_65_61_6b_start
    jp MacroExpand

; ***************************************************************************************


; @word[hl] c,

cforth_63_2c_forth:
    pop hl
cforth_63_2c_code:
  ld   a,e
  call  FARCompileByte
  pop  de

; @endm

cforth_63_2c_end:
    jp (hl)

; ***************************************************************************************


; @word[hl] ,

cforth_2c_forth:
    pop hl
cforth_2c_code:
  ex   de,hl
  call  FARCompileByte
  pop  de

; @endm

cforth_2c_end:
    jp (hl)
