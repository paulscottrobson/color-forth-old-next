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

; =========== * word ix ===========

forth__cforth_2a:
	pop ix
  pop  hl
  call  MULTMultiply16        ; HL := HL * DE
  ex   de,hl
	jp (ix)

; *********************************************************************************

; =========== / word ix ===========

forth__cforth_2f:
	pop ix
  pop  hl
  call  DIVDivideMod16       ; DE := DE/HL HL = DE%HL
	jp (ix)

; *********************************************************************************

; =========== mod word ix ===========

forth__cforth_6d_6f_64:
	pop ix
  pop  hl
  call  DIVDivideMod16       ; DE := DE/HL HL = DE%HL
  ex   de,hl
	jp (ix)

; *********************************************************************************

; =========== /mod word ix ===========

forth__cforth_2f_6d_6f_64:
	pop ix
  pop  hl
  call  DIVDivideMod16       ; DE := DE/HL HL = DE%HL
  push  hl
	jp (ix)

; *********************************************************************************

; =========== + generator ix ===========

forth__cforth_2b:
	pop ix
g__cforth_2b:
  pop  hl
  add  hl,de
  ex   de,hl
e__cforth_2b:
	jp (ix)

macro__cforth_2b:
	ld b,e__cforth_2b-g__cforth_2b
	ld hl,g__cforth_2b
	jp MacroExpand

; *********************************************************************************

; =========== and word hl ===========

forth__cforth_61_6e_64:
	pop hl
  pop  bc
  ld   a,e
  and  c
  ld   e,a
  ld   a,d
  and  b
  ld   d,a
	jp (hl)

; *********************************************************************************

; =========== or word hl ===========

forth__cforth_6f_72:
	pop hl
  pop  bc
  ld   a,e
  xor  c
  ld   e,a
  ld   a,d
  xor  b
  ld   d,a
	jp (hl)

; *********************************************************************************

; =========== +or word hl ===========

forth__cforth_2b_6f_72:
	pop hl
  pop  bc
  ld   a,e
  or   c
  ld   e,a
  ld   a,d
  or   b
  ld   d,a
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

; =========== = word ix ===========

forth__cforth_3d:
	pop ix
  ex   de,hl
  pop  bc
  ld   de,$0000
  ld   a,h
  cp   b
  jr   nz,__equalFail
  ld   a,l
  cp   c
  jr   nz,__equalFail
  dec  de
__equalFail:
	jp (ix)

; *********************************************************************************

; =========== <> word ix ===========

forth__cforth_3c_3e:
	pop ix
  ex   de,hl
  pop  bc
  ld   de,$FFFF
  ld   a,h
  cp   b
  jr   nz,__notEqualExit
  ld   a,l
  cp   c
  jr   nz,__notEqualExit
  inc  de
__notEqualExit:
	jp (ix)
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

; *********************************************************************************

; =========== mode.48 word ret ===========

forth__cforth_6d_6f_64_65_2e_34_38:
  push  de
  call  GFXInitialise48k
  call  GFXConfigure
  pop  de
	ret

; *********************************************************************************

; =========== mode.lowres word ret ===========

forth__cforth_6d_6f_64_65_2e_6c_6f_77_72_65_73:
  push  de
  call  GFXInitialiseLowRes
  call  GFXConfigure
  pop  de
	ret

; *********************************************************************************

; =========== mode.layer2 word ret ===========

forth__cforth_6d_6f_64_65_2e_6c_61_79_65_72_32:
  push  de
  call  GFXInitialiseLayer2
  call  GFXConfigure
  pop  de
	ret

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

; =========== @ generator ix ===========

forth__cforth_40:
	pop ix
g__cforth_40:
  ex   de,hl
  ld   e,(hl)
  inc  hl
  ld   d,(hl)
e__cforth_40:
	jp (ix)

macro__cforth_40:
	ld b,e__cforth_40-g__cforth_40
	ld hl,g__cforth_40
	jp MacroExpand

; *********************************************************************************

; =========== c@ generator hl ===========

forth__cforth_63_40:
	pop hl
g__cforth_63_40:
  ld   a,(de)
  ld   e,a
  ld   d,0
e__cforth_63_40:
	jp (hl)

macro__cforth_63_40:
	ld b,e__cforth_63_40-g__cforth_63_40
	ld hl,g__cforth_63_40
	jp MacroExpand

; *********************************************************************************

; =========== c! generator ix ===========

forth__cforth_63_21:
	pop ix
g__cforth_63_21:
  pop  hl
  ld   a,l
  ld   (de),a
  pop  de
e__cforth_63_21:
	jp (ix)

macro__cforth_63_21:
	ld b,e__cforth_63_21-g__cforth_63_21
	ld hl,g__cforth_63_21
	jp MacroExpand

; *********************************************************************************

; =========== ! generator ix ===========

forth__cforth_21:
	pop ix
g__cforth_21:
  pop  hl
  ld   (hl),e
  inc  hl
  ld   (hl),d
  pop  de
e__cforth_21:
	jp (ix)

macro__cforth_21:
	ld b,e__cforth_21-g__cforth_21
	ld hl,g__cforth_21
	jp MacroExpand

; *********************************************************************************

; =========== +! word ix ===========

forth__cforth_2b_21:
	pop ix
  pop  hl
  ld   a,(hl)
  add  a,e
  ld   (hl),a
  inc  hl
  ld   a,(hl)
  adc  a,d
  ld   (hl),a
  pop  de
	jp (ix)

; *********************************************************************************

; =========== or! word ix ===========

forth__cforth_6f_72_21:
	pop ix
  pop  hl
  ld   a,(hl)
  or   e
  ld   (hl),a
  inc  hl
  ld   a,(hl)
  or   d
  ld   (hl),a
  pop  de
	jp (ix)

; *********************************************************************************

; =========== fill word ix ===========

forth__cforth_66_69_6c_6c:
	pop ix

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
	jp (ix)

; *********************************************************************************

; =========== move word ix ===========

forth__cforth_6d_6f_76_65:
	pop ix
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
	jp (ix)

; *********************************************************************************

; =========== p@ generator hl ===========

forth__cforth_70_40:
	pop hl
g__cforth_70_40:
  ld   b,d
  ld   c,e
  in   e,(c)
  ld   d,0
e__cforth_70_40:
	jp (hl)

macro__cforth_70_40:
	ld b,e__cforth_70_40-g__cforth_70_40
	ld hl,g__cforth_70_40
	jp MacroExpand

; *********************************************************************************

; =========== p! generator hl ===========

forth__cforth_70_21:
	pop hl
g__cforth_70_21:
  ld   b,d
  ld   c,e
  pop  de
  out  (c),e
  pop  de
e__cforth_70_21:
	jp (hl)

macro__cforth_70_21:
	ld b,e__cforth_70_21-g__cforth_70_21
	ld hl,g__cforth_70_21
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

; =========== drop generator hl ===========

forth__cforth_64_72_6f_70:
	pop hl
g__cforth_64_72_6f_70:
  pop  de
e__cforth_64_72_6f_70:
	jp (hl)

macro__cforth_64_72_6f_70:
	ld b,e__cforth_64_72_6f_70-g__cforth_64_72_6f_70
	ld hl,g__cforth_64_72_6f_70
	jp MacroExpand

; *********************************************************************************

; =========== dup generator hl ===========

forth__cforth_64_75_70:
	pop hl
g__cforth_64_75_70:
  push  de
e__cforth_64_75_70:
	jp (hl)

macro__cforth_64_75_70:
	ld b,e__cforth_64_75_70-g__cforth_64_75_70
	ld hl,g__cforth_64_75_70
	jp MacroExpand

; *********************************************************************************

; =========== nip generator ix ===========

forth__cforth_6e_69_70:
	pop ix
g__cforth_6e_69_70:
  pop  hl
  push  de
  ex   de,hl
e__cforth_6e_69_70:
	jp (ix)

macro__cforth_6e_69_70:
	ld b,e__cforth_6e_69_70-g__cforth_6e_69_70
	ld hl,g__cforth_6e_69_70
	jp MacroExpand

; *********************************************************************************

; =========== over generator ix ===========

forth__cforth_6f_76_65_72:
	pop ix
g__cforth_6f_76_65_72:
  pop  hl
  push  de
  ex   de,hl
e__cforth_6f_76_65_72:
	jp (ix)

macro__cforth_6f_76_65_72:
	ld b,e__cforth_6f_76_65_72-g__cforth_6f_76_65_72
	ld hl,g__cforth_6f_76_65_72
	jp MacroExpand

; *********************************************************************************

; =========== swap generator ix ===========

forth__cforth_73_77_61_70:
	pop ix
g__cforth_73_77_61_70:
  pop  hl
  ex   de,hl
  push  hl
e__cforth_73_77_61_70:
	jp (ix)

macro__cforth_73_77_61_70:
	ld b,e__cforth_73_77_61_70-g__cforth_73_77_61_70
	ld hl,g__cforth_73_77_61_70
	jp MacroExpand

; *********************************************************************************
; ***************************************************************************************
; ***************************************************************************************
;
;  Name :   unary.words
;  Author : Paul Robson (paul@robsons.org.uk)
;  Date :   16th November 2018
;  Purpose : Unary operators
;
; ***************************************************************************************
; ***************************************************************************************

; =========== bswap generator ret ===========

forth__cforth_62_73_77_61_70:
g__cforth_62_73_77_61_70:
  ld   a,d
  ld   d,e
  ld   e,a
e__cforth_62_73_77_61_70:
	ret

macro__cforth_62_73_77_61_70:
	ld b,e__cforth_62_73_77_61_70-g__cforth_62_73_77_61_70
	ld hl,g__cforth_62_73_77_61_70
	jp MacroExpand

; *********************************************************************************

; =========== 2* generator ret ===========

forth__cforth_32_2a:
g__cforth_32_2a:
  ex   de,hl
  add  hl,hl
  ex   de,hl
e__cforth_32_2a:
	ret

macro__cforth_32_2a:
	ld b,e__cforth_32_2a-g__cforth_32_2a
	ld hl,g__cforth_32_2a
	jp MacroExpand

; *********************************************************************************

; =========== 2/ generator ret ===========

forth__cforth_32_2f:
g__cforth_32_2f:
  srl  d
  rr   e
e__cforth_32_2f:
	ret

macro__cforth_32_2f:
	ld b,e__cforth_32_2f-g__cforth_32_2f
	ld hl,g__cforth_32_2f
	jp MacroExpand

; *********************************************************************************

; =========== 1+ generator ret ===========

forth__cforth_31_2b:
g__cforth_31_2b:
  inc  de
e__cforth_31_2b:
	ret

macro__cforth_31_2b:
	ld b,e__cforth_31_2b-g__cforth_31_2b
	ld hl,g__cforth_31_2b
	jp MacroExpand

; *********************************************************************************

; =========== 2+ generator ret ===========

forth__cforth_32_2b:
g__cforth_32_2b:
  inc  de
  inc  de
e__cforth_32_2b:
	ret

macro__cforth_32_2b:
	ld b,e__cforth_32_2b-g__cforth_32_2b
	ld hl,g__cforth_32_2b
	jp MacroExpand

; *********************************************************************************

; =========== 1- generator ret ===========

forth__cforth_31_2d:
g__cforth_31_2d:
  dec  de
e__cforth_31_2d:
	ret

macro__cforth_31_2d:
	ld b,e__cforth_31_2d-g__cforth_31_2d
	ld hl,g__cforth_31_2d
	jp MacroExpand

; *********************************************************************************

; =========== 2- generator ret ===========

forth__cforth_32_2d:
g__cforth_32_2d:
  dec  de
  dec  de
e__cforth_32_2d:
	ret

macro__cforth_32_2d:
	ld b,e__cforth_32_2d-g__cforth_32_2d
	ld hl,g__cforth_32_2d
	jp MacroExpand

; *********************************************************************************

; =========== - word ret ===========

forth__cforth_2d:
  ld   a,d
  cpl
  ld   d,a
  ld   a,e
  cpl
  ld   e,a
	ret

; *********************************************************************************

; =========== negate word ret ===========

forth__cforth_6e_65_67_61_74_65:
  ld   a,d
  cpl
  ld   d,a
  ld   a,e
  cpl
  ld   e,a
  inc  de
	ret

; *********************************************************************************

; =========== abs word ret ===========

forth__cforth_61_62_73:
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
	ret

; *********************************************************************************

; =========== 0= word ret ===========

forth__cforth_30_3d:
  ld   a,d
  or   e
  ld   de,$0000
  jr   nz,__IsNonZero
  dec  de
__IsNonZero:
	ret

; *********************************************************************************

; =========== 0< word ret ===========

forth__cforth_30_3c:
  bit  7,d
  ld   de,$0000
  jr   z,__IsPositive2
  dec  de
__IsPositive2:
	ret
; ***************************************************************************************
; ***************************************************************************************
;
;  Name :   utility.words
;  Author : Paul Robson (paul@robsons.org.uk)
;  Date :   16th November 2018
;  Purpose : Miscellaneous words.
;
; ***************************************************************************************
; ***************************************************************************************

; =========== inkey word hl ===========

forth__cforth_69_6e_6b_65_79:
	pop hl
  push  de
  call  IOScanKeyboard
  ld   e,a
  ld   d,0
	jp (hl)

; ***************************************************************************************

; =========== halt word ret ===========

forth__cforth_68_61_6c_74:

__haltLoop:
  di
  halt
  jr   __haltLoop

	ret

