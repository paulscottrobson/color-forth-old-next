; =========== ! copies ===========

start_21_3a_3a_63_3a_3a:
  pop  hl
  ex   de,hl
  ld   (hl),e
  inc  hl
  ld   (hl),d
  pop  de
end_21_3a_3a_63_3a_3a:

; =========== * word ===========

start_2a_3a_3a_77_3a_3a_69_78:
  pop  hl
  call MULTMultiply16
  ex   de,hl
end_2a_3a_3a_77_3a_3a_69_78:

; =========== + copies ===========

start_2b_3a_3a_63_3a_3a:
  pop  hl
  add  hl,de
  ex   de,hl
end_2b_3a_3a_63_3a_3a:

; =========== +! word ===========

start_2b_21_3a_3a_77_3a_3a_69_78:
  pop  hl
  ld   a,(de)
  add  a,l
  ld   (de),a
  inc  de
  ld   a,(de)
  adc  a,h
  ld   (de),a
end_2b_21_3a_3a_77_3a_3a_69_78:

; =========== ++ copies ===========

start_2b_2b_3a_3a_63_3a_3a:
  inc  de
end_2b_2b_3a_3a_63_3a_3a:

; =========== +++ copies ===========

start_2b_2b_2b_3a_3a_63_3a_3a:
  inc  de
  inc  de
end_2b_2b_2b_3a_3a_63_3a_3a:

; =========== +or word ===========

start_2b_6f_72_3a_3a_77_3a_3a_68_6c:
  pop  bc
  ld   a,d
  or   b
  ld   d,a
  ld   a,e
  or    c
  ld   e,a
end_2b_6f_72_3a_3a_77_3a_3a_68_6c:

; =========== - word ===========

start_2d_3a_3a_77_3a_3a_72_65_74:
  ld   a,d
  cpl
  ld   d,a
  ld  a,e
  cpl
  ld   e,a
end_2d_3a_3a_77_3a_3a_72_65_74:

; =========== -- copies ===========

start_2d_2d_3a_3a_63_3a_3a:
  dec  de
end_2d_2d_3a_3a_63_3a_3a:

; =========== --- copies ===========

start_2d_2d_2d_3a_3a_63_3a_3a:
  dec  de
  dec  de
end_2d_2d_2d_3a_3a_63_3a_3a:

; =========== / word ===========

start_2f_3a_3a_77_3a_3a_69_78:
  pop  hl
  ex   de,hl
  call DIVDivideMod16
end_2f_3a_3a_77_3a_3a_69_78:

; =========== /mod word ===========

start_2f_6d_6f_64_3a_3a_77_3a_3a_69_78:
  pop  hl
  ex   de,hl
  call DIVDivideMod16
  push  hl
end_2f_6d_6f_64_3a_3a_77_3a_3a_69_78:

; =========== 16* copies ===========

start_31_36_2a_3a_3a_63_3a_3a:
  ex   de,hl
  add  hl,hl
  add  hl,hl
  add  hl,hl
  add  hl,hl
  ex   de,hl
end_31_36_2a_3a_3a_63_3a_3a:

; =========== 2* copies ===========

start_32_2a_3a_3a_63_3a_3a:
  ex   de,hl
  add  hl,hl
  ex   de,hl
end_32_2a_3a_3a_63_3a_3a:

; =========== 2/ copies ===========

start_32_2f_3a_3a_63_3a_3a:
  sra  d
  rr   e
end_32_2f_3a_3a_63_3a_3a:

; =========== 4* copies ===========

start_34_2a_3a_3a_63_3a_3a:
  ex   de,hl
  add  hl,hl
  add  hl,hl
  ex   de,hl
end_34_2a_3a_3a_63_3a_3a:

; =========== @ copies ===========

start_40_3a_3a_63_3a_3a:
  ex   de,hl
  ld   e,(hl)
  inc  hl
  ld   d,(hl)
end_40_3a_3a_63_3a_3a:

; =========== abs word ===========

start_61_62_73_3a_3a_77_3a_3a_72_65_74:
  bit  7,d
  jr   z,__absPositive
  ld   a,d
  cpl
  ld   d,a
  ld   a,e
  cpl
  ld   e,a
  inc  de
__absPositive:
end_61_62_73_3a_3a_77_3a_3a_72_65_74:

; =========== and word ===========

start_61_6e_64_3a_3a_77_3a_3a_68_6c:
  pop  bc
  ld   a,d
  and  b
  ld   d,a
  ld   a,e
  and  c
  ld   e,a
end_61_6e_64_3a_3a_77_3a_3a_68_6c:

; =========== b! copies ===========

start_62_21_3a_3a_63_3a_3a:
  pop  bc
  ld   a,c
  ld   (de),a
  pop  de
end_62_21_3a_3a_63_3a_3a:

; =========== b@ copies ===========

start_62_40_3a_3a_63_3a_3a:
  ld  a,(de)
  ld   e,a
  ld   d,0
end_62_40_3a_3a_63_3a_3a:

; =========== bswap copies ===========

start_62_73_77_61_70_3a_3a_63_3a_3a:
  ld   a,d
  ld   d,e
  ld   e,a
end_62_73_77_61_70_3a_3a_63_3a_3a:

; =========== drop copies ===========

start_64_72_6f_70_3a_3a_63_3a_3a:
  pop  de
end_64_72_6f_70_3a_3a_63_3a_3a:

; =========== dup copies ===========

start_64_75_70_3a_3a_63_3a_3a:
  push  de
end_64_75_70_3a_3a_63_3a_3a:

; =========== h copies ===========

start_68_3a_3a_63_3a_3a:
  push  de
  ld   de,(HereAddr)
end_68_3a_3a_63_3a_3a:

; =========== here word ===========

start_68_65_72_65_3a_3a_77_3a_3a_69_78:
  push  de
  ld   hl,(HereAddr)
  ld   e,(hl)
  inc  hl
  ld   d,(hl)
end_68_65_72_65_3a_3a_77_3a_3a_69_78:

; =========== less word ===========

start_6c_65_73_73_3a_3a_77_3a_3a_69_78:
  pop  hl
  ld   a,d
  xor  h
  add  a,a
  jr   c,__LessSignDifferent
  sbc  hl,de
  ld   hl,$0000
  jr   c,__LessExit
  dec  hl
  jr   __LessExit
__LessSignDifferent
  bit  7,d
  ld   hl,$0000
  jr   nz,__LessExit
  dec  hl
__LessExit:
end_6c_65_73_73_3a_3a_77_3a_3a_69_78:

; =========== mod word ===========

start_6d_6f_64_3a_3a_77_3a_3a_69_78:
  pop  hl
  ex   de,hl
  call DIVDivideMod16
  ex   de,hl
end_6d_6f_64_3a_3a_77_3a_3a_69_78:

; =========== negate word ===========

start_6e_65_67_61_74_65_3a_3a_77_3a_3a_72_65_74:
  ld   a,d
  cpl
  ld   d,a
  ld  a,e
  cpl
  ld   e,a
  inc  de
end_6e_65_67_61_74_65_3a_3a_77_3a_3a_72_65_74:

; =========== nip copies ===========

start_6e_69_70_3a_3a_63_3a_3a:
  pop  bc
end_6e_69_70_3a_3a_63_3a_3a:

; =========== or word ===========

start_6f_72_3a_3a_77_3a_3a_68_6c:
  pop  bc
  ld   a,d
  xor  b
  ld   d,a
  ld   a,e
  xor  c
  ld   e,a
end_6f_72_3a_3a_77_3a_3a_68_6c:

; =========== or! word ===========

start_6f_72_21_3a_3a_77_3a_3a_69_78:
  pop  hl
  ld   a,(de)
  or   l
  ld   (de),a
  inc  de
  ld   a,(de)
  or   h
  ld   (de),a
end_6f_72_21_3a_3a_77_3a_3a_69_78:

; =========== over copies ===========

start_6f_76_65_72_3a_3a_63_3a_3a:
  pop  hl
  push  de
  ex   de,hl
end_6f_76_65_72_3a_3a_63_3a_3a:

; =========== p! copies ===========

start_70_21_3a_3a_63_3a_3a:
  pop  hl
  ld   b,d
  ld   c,e
  out  (c),l
  pop  de
end_70_21_3a_3a_63_3a_3a:

; =========== p@ copies ===========

start_70_40_3a_3a_63_3a_3a:
  ld   b,d
  ld   c,e
  in   e,(c)
  ld   d,0
end_70_40_3a_3a_63_3a_3a:

; =========== swap copies ===========

start_73_77_61_70_3a_3a_63_3a_3a:
  pop  hl
  push  de
  ex   de,hl
w
end_73_77_61_70_3a_3a_63_3a_3a:

; =========== u+ word ===========

start_75_2b_3a_3a_77_3a_3a_69_78:
  pop  bc
  pop  hl
  add  hl,de
  push  bc
  ex   de,hl
end_75_2b_3a_3a_77_3a_3a_69_78:

