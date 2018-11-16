; *********************************************************************************
; *********************************************************************************
;
;		File:		graphics.asm
;		Purpose:	General screen I/O routines
;		Date : 		15th November 2018
;		Author:		paul@robsons.org.uk
;
; *********************************************************************************
; *********************************************************************************

GFXConfigure:
		ld 		a,l 								; save screen size
		ld 		(SIScreenWidth),a
		ld 		a,h
		ld 		(SIScreenHeight),a
		ex 		de,hl 								; save driver
		ld 		(SIScreenDriver),hl
		ld		l,d 								; calculate and save full screen size
		ld 		h,0
		ld 		d,0
		call	MULTMultiply16
		ld 		(SIScreenSize),hl
		ret

GFXWriteCharacter:
		push 	af
		push 	bc
		push 	de
		push 	hl
		ld 		bc,__GFXWCExit
		push 	bc
		ld 		bc,(SIScreenDriver)
		push 	bc
		ret
__GFXWCExit:
		pop 	hl
		pop 	de
		pop 	bc
		pop 	af
		ret
