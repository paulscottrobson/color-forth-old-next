; =========== ! both ===========

start_21_2e_6d:
 ld a,end_21_2e_6d-start_21_2e_6d-5
 call COMUCopyCode
  pop  hl
  ex   de,hl
  ld   (hl),e
  inc  hl
  ld   (hl),d
  pop  de
end_21_2e_6d:

start_21_2e_66:
 pop ix
  pop  hl
  ex   de,hl
  ld   (hl),e
  inc  hl
  ld   (hl),d
  pop  de
 jp (ix)

; =========== * word.ix ===========

start_2a_2e_66:
 pop ix
  pop  hl
  call  MULTMultiply16
  ex   de,hl
 jp (ix)

; =========== + both ===========

start_2b_2e_6d:
 ld a,end_2b_2e_6d-start_2b_2e_6d-5
 call COMUCopyCode
  pop  hl
  add  hl,de
  ex   de,hl
end_2b_2e_6d:

start_2b_2e_66:
 pop ix
  pop  hl
  add  hl,de
  ex   de,hl
 jp (ix)

; =========== +! word.ix ===========

start_2b_21_2e_66:
 pop ix
  pop  hl
  ex   de,hl
  ld   a,(hl)
  add  a,e
  ld   (hl),a
  inc  hl
  ld   a,(hl)
  adc  a,d
  ld   (hl),a
  pop  de
 jp (ix)

; =========== +or word.hl ===========

start_2b_6f_72_2e_66:
 pop hl
  pop  bc
  ld   a,b
  or   d
  ld   d,a
  ld   a,c
  or   e
  ld   e,a
 jp (hl)

; =========== , word.ix ===========

start_2c_2e_66:
 pop ix
  ex   de,hl
  call FARCompileWord
  pop  de
 jp (ix)

; =========== - both ===========

start_2d_2e_6d:
 ld a,end_2d_2e_6d-start_2d_2e_6d-5
 call COMUCopyCode
  ld   a,d
  cpl
  ld   d,a
  ld   a,e
  cpl
  ld   e,a
end_2d_2e_6d:

start_2d_2e_66:
 pop ix
  ld   a,d
  cpl
  ld   d,a
  ld   a,e
  cpl
  ld   e,a
 jp (ix)

; =========== / word.ix ===========

start_2f_2e_66:
 pop ix
  pop  hl
  call  DIVDivideMod16
 jp (ix)

; =========== /mod word.ix ===========

start_2f_6d_6f_64_2e_66:
 pop ix
  pop  hl
  call  DIVDivideMod16
  push  hl
 jp (ix)

; =========== 1, word.hl ===========

start_31_2c_2e_66:
 pop hl
  ld   a,e
  call  FARCompileByte
  pop  de
 jp (hl)

; =========== 2* both ===========

start_32_2a_2e_6d:
 ld a,end_32_2a_2e_6d-start_32_2a_2e_6d-5
 call COMUCopyCode
  ex   de,hl
  add  hl,hl
  ex   de,hl
end_32_2a_2e_6d:

start_32_2a_2e_66:
 pop ix
  ex   de,hl
  add  hl,hl
  ex   de,hl
 jp (ix)

; =========== 2/ both ===========

start_32_2f_2e_6d:
 ld a,end_32_2f_2e_6d-start_32_2f_2e_6d-5
 call COMUCopyCode
  sra  d
  rr   e
end_32_2f_2e_6d:

start_32_2f_2e_66:
 pop ix
  sra  d
  rr   e
 jp (ix)

; =========== ;s execute ===========

start_3b_73_2e_6d:
  jp   COMDExitRoutine
; =========== @ both ===========

start_40_2e_6d:
 ld a,end_40_2e_6d-start_40_2e_6d-5
 call COMUCopyCode
  ex   de,hl
  ld   e,(hl)
  inc  hl
  ld   d,(hl)
end_40_2e_6d:

start_40_2e_66:
 pop ix
  ex   de,hl
  ld   e,(hl)
  inc  hl
  ld   d,(hl)
 jp (ix)

; =========== abs word.hl ===========

start_61_62_73_2e_66:
 pop hl
  bit  7,d
  jp   nz,__Negate
 jp (hl)

; =========== and word.hl ===========

start_61_6e_64_2e_66:
 pop hl
  pop  bc
  ld   a,b
  and  d
  ld   d,a
  ld   a,c
  and  e
  ld   e,a
 jp (hl)

; =========== b! both ===========

start_62_21_2e_6d:
 ld a,end_62_21_2e_6d-start_62_21_2e_6d-5
 call COMUCopyCode
  pop  hl
  ld   a,l
  ld   (de),a
  pop  de
end_62_21_2e_6d:

start_62_21_2e_66:
 pop ix
  pop  hl
  ld   a,l
  ld   (de),a
  pop  de
 jp (ix)

; =========== b@ both ===========

start_62_40_2e_6d:
 ld a,end_62_40_2e_6d-start_62_40_2e_6d-5
 call COMUCopyCode
  ld   a,(de)
  ld   e,a
  ld   d,$00
end_62_40_2e_6d:

start_62_40_2e_66:
 pop ix
  ld   a,(de)
  ld   e,a
  ld   d,$00
 jp (ix)

; =========== break macro ===========

start_62_72_65_61_6b_2e_6d:
 ld a,end_62_72_65_61_6b_2e_6d-start_62_72_65_61_6b_2e_6d-5
 call COMUCopyCode
  db   $DD,$01
end_62_72_65_61_6b_2e_6d:

; =========== bswap both ===========

start_62_73_77_61_70_2e_6d:
 ld a,end_62_73_77_61_70_2e_6d-start_62_73_77_61_70_2e_6d-5
 call COMUCopyCode
  ld   a,h
  ld   h,l
  ld   l,a
end_62_73_77_61_70_2e_6d:

start_62_73_77_61_70_2e_66:
 pop ix
  ld   a,h
  ld   h,l
  ld   l,a
 jp (ix)

; =========== debug word.ix ===========

start_64_65_62_75_67_2e_66:
 pop ix
  call  DEBUGShow
 jp (ix)

; =========== drop both ===========

start_64_72_6f_70_2e_6d:
 ld a,end_64_72_6f_70_2e_6d-start_64_72_6f_70_2e_6d-5
 call COMUCopyCode
  pop  de          ; pop the top off stack into cache
end_64_72_6f_70_2e_6d:

start_64_72_6f_70_2e_66:
 pop ix
  pop  de          ; pop the top off stack into cache
 jp (ix)

; =========== dup both ===========

start_64_75_70_2e_6d:
 ld a,end_64_75_70_2e_6d-start_64_75_70_2e_6d-5
 call COMUCopyCode
  push  de          ; push stack onto cache
end_64_75_70_2e_6d:

start_64_75_70_2e_66:
 pop ix
  push  de          ; push stack onto cache
 jp (ix)

; =========== fill word.ix ===========

start_66_69_6c_6c_2e_66:
 pop ix
  pop  hl         ; (number address count)
  pop  bc          ; DE = count, HL = address, BC = number
  ld   a,b
  or   c
  jr   z,__fillExit       ; if count zero exit.
__fillLoop:
  ld   (hl),c
  inc  hl
  dec  de
  ld   a,d
  or   e
  jr   nz,__fillLoop
__fillExit:
  pop  de
 jp (ix)

; =========== forth word.ret ===========

start_66_6f_72_74_68_2e_66:
  xor  a          ; set dictionary flag to $00
  ld   (__DICTSelector),a
 ret
; =========== h word.hl ===========

start_68_2e_66:
 pop hl
  push  de          ; address of here
  ld   de,Here
 jp (hl)

; =========== halt word.ix ===========

start_68_61_6c_74_2e_66:
 pop ix
__haltz80:
  di
  halt
  jr   __haltz80
 jp (ix)

; =========== here word.hl ===========

start_68_65_72_65_2e_66:
 pop hl
  push  de          ; contents of here
  ld   de,(Here)
 jp (hl)

; =========== hex! word.ix ===========

start_68_65_78_21_2e_66:
 pop ix
  pop  hl          ; HL = word, DE = pos
  ex   de,hl         ; right way round (!)
  call  GFXWriteHexWord      ; write out the word
  pop  de          ; fix up stack.
 jp (ix)

; =========== macro word.ret ===========

start_6d_61_63_72_6f_2e_66:
  ld  a,$80         ; set dictionary flag to $80
  ld   (__DICTSelector),a
 ret
; =========== mod word.ix ===========

start_6d_6f_64_2e_66:
 pop ix
  pop  hl
  call  DIVDivideMod16
  ex   de,hl
 jp (ix)

; =========== move word.ix ===========

start_6d_6f_76_65_2e_66:
 pop ix
  ld   b,d          ; (source target count)
  ld   c,e         ; put count in BC
  pop  de          ; target in DE
  pop  hl          ; source in HL
  ld   a,b         ; zero check
  or   c
  jr   z,__moveExit
  ldir           ; do the move.
__moveExit:
  pop  de
 jp (ix)

; =========== negate word.hl ===========

start_6e_65_67_61_74_65_2e_66:
 pop hl
__Negate:
  ld   a,d
  cpl
  ld   d,a
  ld   a,e
  cpl
  ld   e,a
  inc  de
 jp (hl)

; =========== nip both ===========

start_6e_69_70_2e_6d:
 ld a,end_6e_69_70_2e_6d-start_6e_69_70_2e_6d-5
 call COMUCopyCode
  pop  hl          ; remove 2nd on the stack.
end_6e_69_70_2e_6d:

start_6e_69_70_2e_66:
 pop ix
  pop  hl          ; remove 2nd on the stack.
 jp (ix)

; =========== or word.hl ===========

start_6f_72_2e_66:
 pop hl
  pop  bc
  ld   a,b
  xor  d
  ld   d,a
  ld   a,c
  xor  e
  ld   e,a
 jp (hl)

; =========== or! word.ix ===========

start_6f_72_21_2e_66:
 pop ix
  pop  hl
  ex   de,hl
  ld   a,(hl)
  or   e
  ld   (hl),a
  inc  hl
  ld   a,(hl)
  or   d
  ld   (hl),a
  pop  de
 jp (ix)

; =========== over both ===========

start_6f_76_65_72_2e_6d:
 ld a,end_6f_76_65_72_2e_6d-start_6f_76_65_72_2e_6d-5
 call COMUCopyCode
  pop  hl          ; get 2nd on stack
  push  hl          ; put it back.
  push    de          ; push tos to 2nd
  ex   de,hl         ; make the old second value the new top.
end_6f_76_65_72_2e_6d:

start_6f_76_65_72_2e_66:
 pop ix
  pop  hl          ; get 2nd on stack
  push  hl          ; put it back.
  push    de          ; push tos to 2nd
  ex   de,hl         ; make the old second value the new top.
 jp (ix)

; =========== p! word.hl ===========

start_70_21_2e_66:
 pop hl
  ld   c,e
  ld   b,d
  pop  de
  out  (c),e
  pop  de
 jp (hl)

; =========== p@ word.hl ===========

start_70_40_2e_66:
 pop hl
  ld   c,e
  ld   b,d
  in   e,(c)
  ld   d,0
 jp (hl)

; =========== pop word.ix ===========

start_70_6f_70_2e_66:
 pop ix
  push  de
  ld   hl,(__SpareStackPointer)
  dec  hl
  ld   d,(hl)
  dec  hl
  ld   e,(hl)
  ld   (__SpareStackPointer),hl
 jp (ix)

; =========== push word.ix ===========

start_70_75_73_68_2e_66:
 pop ix
  ld   hl,(__SpareStackPointer)
  ld   (hl),e
  inc  hl
  ld   (hl),d
  inc  hl
  ld   (__SpareStackPointer),hl
  pop  de
 jp (ix)

; =========== swap both ===========

start_73_77_61_70_2e_6d:
 ld a,end_73_77_61_70_2e_6d-start_73_77_61_70_2e_6d-5
 call COMUCopyCode
  pop  hl          ; get 2nd
  push  de          ; put TOS second
  ex   de,hl         ; 2nd now TOS
end_73_77_61_70_2e_6d:

start_73_77_61_70_2e_66:
 pop ix
  pop  hl          ; get 2nd
  push  de          ; put TOS second
  ex   de,hl         ; 2nd now TOS
 jp (ix)

