; *********************************************************************************
; *********************************************************************************
;
;		File:		debug.asm
;		Purpose:	Show stack on the screen.
;		Date : 		8th December 2018
;		Author:		paul@robsons.org.uk
;
; *********************************************************************************
; *********************************************************************************

DEBUGShow:
		pop 	bc 									; return address
		push 	de 									; stack is now decached
		push 	bc 									; the stack is now [data stack] [return address]
		push	ix 									; now [data stack] [return address] [ix]

		ld 		hl,$0000 							; get SP value
		add 	hl,sp
		ld 		de,StackTop 	
		ex 		de,hl 								; calculate Stack Top - SP
		xor 	a
		sbc 	hl,de
		rr 		l 									; divide by 2 as 2 bytes per stack element.
		dec 	l 									; subtract two for the return address and IX
		dec 	l
		dec 	l 									; one for the initial PUSH DE ; means ld sp,top == empty

		ld 		b,l 								; put count in B
		ld 		ix,StackTop-2  						; TOS in IX

		push 	bc 									; clear the bottom 32 characters
		ld 		hl,(__DIScreenSize) 				
		ld 		de,-32
		add 	hl,de
		push 	hl
		ld 		b,32
__DEBUGShowClear:
		ld 		de,$0620
		call 	GFXWriteCharacter
		inc 	hl
		djnz 	__DEBUGShowClear
		pop 	hl 									; HL points to bottom line
		pop 	bc 									; B is the count to print
		ld 		c,32 								; C is the ramining characters
													; IX points to the bottom stack element.

		ld 		a,b 								; exit on underflow or empty
		or 		a
		jr 		z,__DEBUGShowExit															
		jp 		m,__DEBUGShowExit

__DEBUGShowLoop:
		dec 	ix 									; read next value
		dec 	ix
		ld 		e,(ix+0)
		ld 		d,(ix+1)

		call 	__DEBUGPrintDecimalInteger 			; print DE at position HL, C Chars remaining.

		inc 	hl 									; space right
		dec 	c 									; one fewer character
		bit 	7,c 								; if -ve exit anyway
		jr 		nz,__DEBUGShowExit
		djnz 	__DEBUGShowLoop 					; do however many.


__DEBUGShowExit:
		pop 	ix 									; restore IX
		pop 	hl 									; pop return address
		pop 	de 									; decache stack
		jp 		(hl) 								; and exit.

__DEBUGPrintDecimalInteger:
		push 	de
		bit 	7,d 								; is it negative.
		jr 		z,__DEBUGPrintDecNotNegative
		ld 		a,d 								; if so, negate the value.
		cpl
		ld 		d,a
		ld 		a,e
		cpl
		ld 		e,a
		inc 	de
__DEBUGPrintDecNotNegative:
		call 	__DEBUGPrintDERecursively

		pop 	de
		bit 	7,d 								; was it -VE
		ret 	z
		ld 		de,$0600+'-'						; print a -ve sign
		call 	GFXWriteCharacter
		inc 	hl
		dec 	c
		ret

__DEBUGPrintDERecursively:
		push 	hl 									; save screen position
		ld 		hl,10 								; divide by 10, DE is division, HL is remainder.
		call 	DIVDivideMod16
		ex 		(sp),hl 							; remainder on TOS, HL contains screen position
		ld 		a,d 								; if DE is non zero call Recursively
		or 		e
		call 	nz,__DEBUGPrintDERecursively
		pop 	de 									; DE = remainder
		ld 		a,e 								; convert E to a character
		or 		'0'
		ld 		e,a
		ld 		d,6 								; yellow
		call 	GFXWriteCharacter 					; write digit.
		inc 	hl 	
		dec 	c
		ret

		ret