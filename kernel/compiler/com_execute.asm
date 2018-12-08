; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		com_execute.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		8th December 2018
;		Purpose :	Executes a yellow word.
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;						Execute the Yellow tagged word at BC
;
; ***************************************************************************************

COMXExecuteYellowWord:
	ld 		a,$00 									; search in dictionary
	call 	DICTFindWord 
	jr 		nc,__COMXExecute
	call 	CONSTConvert 							; try to convert it as a constant
	jp 		c,COMError 					
;
;		HL is a constant to push on the stack, which is kept in IX+0,IX+1
;
__COMXConstant:
	ex 		de,hl 									; constant in DE
	ld 		l,(ix+4) 								; stack pointer value in HL
	ld 		h,(ix+5)
	dec 	hl 										; now do "Push DE"
	ld 		(hl),d
	dec 	hl
	ld 		(hl),e
	ld 		(ix+4),l 								; and put the stack pointer back
	ld 		(ix+5),h
	ret
;
;		Execute the word at E:HL
;
__COMXExecute:
	call 	COMXExecuteEHL
	ret

; ***************************************************************************************
;
;			Execute the word at E:HL using the decached stack store at (IX+4/5)
;
; ***************************************************************************************

COMXExecuteEHL:
	push 	bc 										; save BC
	ld 		a,e 									; switch to the page this is on.
	call 	PAGESwitch
	ex 		de,hl 									; put the routine address in DE.

	ld 		hl,$0000
	add 	hl,sp
	ld 		(ix+8),l 								; put the current pointer in IX+8/9
	ld 		(ix+9),h

	ld 		l,(ix+4)								; get the stack pointer into HL
	ld 		h,(ix+5)
	ld 		sp,hl 									

	pop 	hl 										; cache the stack except TOS in HL
	ex 		de,hl 									; now TOS in DE, address in HL
	call 	__COMXCallHL 							; call the Call (HL) routine
	push 	de 										; decache the stack.

	ld 		ix,(__COMPStackPointer) 				; reget the stack value. If this recurses back this should be right.

	ld 		hl,$0000 								; get the SP value
	add 	hl,sp
	ld 		(ix+4),l 								; update in IX structure
	ld 		(ix+5),h

	ld 		l,(ix+8) 								; retrieve SP value
	ld 		h,(ix+9) 			
	ld 		sp,hl 									; put in SP 
	pop 	bc 										; restore BC
	ret 											; and return.

__COMXCallHL:
	jp 		(hl)

