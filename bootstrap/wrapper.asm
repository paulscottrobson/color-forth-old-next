; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		wrapper.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		3rd December 2018
;		Purpose :	Wrapper for assembling bootstrap words
;
; ***************************************************************************************
; ***************************************************************************************

		opt 	zxnextreg
		org 	0

		include "sources/binary.asm"

MULTMultiply16 = $8010 								; HL := HL * DE
		