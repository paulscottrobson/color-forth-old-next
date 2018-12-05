// ***************************************************************************************
// ***************************************************************************************
//
//		Name : 		wrapper.asm
//		Author :	Paul Robson (paul@robsons.org.uk)
//		Date : 		3rd December 2018
//		Purpose :	Wrapper for assembling bootstrap words
//
// ***************************************************************************************
// ***************************************************************************************

MULTMultiply16 = $8010 								// HL := HL * DE
DIVDivideMod16 = $8014 								// DE := DE / HL // HL := DE mod HL
HereAddr = $8004 									// contains address of HERE

		opt 	zxnextreg
		org 	0
		include "_source.asm"

