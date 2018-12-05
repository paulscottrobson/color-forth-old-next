; *********************************************************************************
; *********************************************************************************
;
;		File:		debug.asm
;		Purpose:	Show stack.
;		Date : 		4th December 2018
;		Author:		paul@robsons.org.uk
;
; *********************************************************************************
; *********************************************************************************

DEBUGShowStack:
		pop 	ix 									; IX contains return address
		push 	de 									; stack is now non-cached.
		push	ix 

		ld 		hl,(__DIScreenSize) 				; calculate 32 off bottom of screen
		ld 		de,-32
		add 	hl,de
		ex 		de,hl
		push 	de 									; save it
		ld 		hl,3 								; set screen position
		call 	SystemHandler
		ld 		b,32 								; count
__DEBUGSSClear:
		ld 		hl,4
		ld 		de,$0400
		call 	SystemHandler
		djnz 	__DEBUGSSClear

		pop 	de 									; restore the bottom of screen
		ld 		hl,3 								; set screen position
		call 	SystemHandler

		ld 		hl,StackTop 						; start of stack.
__DEBUGSSLoop:
		ld 		ix,2 								; reached the top of the stack ?
		add 	ix,sp				
		ld 		a,ixl
		cp 		l
		jr 		z,__DEBUGSSExit

		dec 	hl 									; get number.
		ld 		d,(hl)
		dec 	hl
		ld 		e,(hl)

		call 	__DEBUGPrintNumber

		ld 		de,$0600
		call 	__DEBUGPrintCharacter

		jr 		__DEBUGSSLoop

__DEBUGSSExit:
		pop 	ix
		pop 	de 									; restore stack to cached state
		jp 		(ix) 								; and exit.


__DEBUGPrintCharacter:
		push 	hl 									; seperating space.
		push 	de
		ld 		hl,4
		call 	SystemHandler
		pop 	de
		pop 	hl
		ret
;
;		Print integer DE
;
__DEBUGPrintNumber:
		push 	bc
		push 	de
		push 	hl

		push 	de
		bit 	7,d
		jr 		z,__DSSDDNotNegative
		ld 		a,d
		cpl 
		ld 		d,a
		ld 		a,e
		cpl 
		ld 		e,a
		inc 	de
__DSSDDNotNegative:
		call 	__DSSDisplayRecursive
		pop 	bc
		ld 		de,$0600+'-'
		bit 	7,b
		jr 		z,__DSDDNoMinus
		call 	__DEBUGPrintCharacter
__DSDDNoMinus:
		pop 	hl
		pop 	de
		pop 	bc
		ret

__DSSDisplayRecursive:
		ld 		hl,10
		call 	DIVDivideMod16
		push 	hl
		ld 		a,d
		or 		e
		call 	nz,__DSSDisplayRecursive
		pop 	de
		ld 		a,e
		add 	a,48
		ld 		e,a
		ld 		d,6
		call 	__DEBUGPrintCharacter
		ret
