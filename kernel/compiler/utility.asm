; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		utility.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		7th December 2018
;		Purpose :	Compile Utilities
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;							Compile code to load constant
;
; ***************************************************************************************

COMUCompileConstant:
		ld 		a,$EB 								; EX DE,HL
		call 	FARCompileByte
		ld 		a,$21								; LD HL,xxxx
		call 	FARCompileByte
		call 	FARCompileWord						; compile constant
		ret

; ***************************************************************************************
;
;			Compile code to copy A bytes from code following caller (for MACRO)
;
; ***************************************************************************************

COMUCopyCode:
		pop 	bc 									; BC = code to copy
		ld 		l,a 								; L = count
		or 		a
		ret 	z
__COMUCopyLoop:
		ld 		a,(bc) 								; read a byte
		call 	FARCompileByte 						; compile it
		inc 	bc 									; next byte
		dec 	l 									; do E bytes
		jr 		nz,__COMUCopyLoop
		ret
