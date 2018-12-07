; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		farmemory.asm
;		Author :	paul@robsons.org.uk
;		Date : 		7th December 2018
;		Purpose :	Kernel - Far memory routines.
;
; ***************************************************************************************
; ***************************************************************************************
	
; ***********************************************************************************************
;
;								Byte compile far memory A/L
;
; ***********************************************************************************************

FARCompileByte:
		push 	af 									; save byte and HL
		push 	hl
		push 	af 									; save byte
		ld		a,(HerePage) 						; switch to page
		call 	PAGESwitch
		ld 		hl,(Here) 							; write to memory location
		pop 	af
		ld 		(hl),a
		inc 	hl 									; bump memory location
		ld 		(Here),hl 							; write back
		call 	PAGERestore
		pop 	hl 									; restore and exit
		pop 	af
		ret

; ***********************************************************************************************
;
;								Word compile far memory A/HL
;
; ***********************************************************************************************

FARCompileWord:
		push 	af 									; save byte and HL
		push 	de
		push 	hl
		ex 		de,hl 								; word into DE
		ld		a,(HerePage) 						; switch to page
		call 	PAGESwitch
		ld 		hl,(Here) 							; write to memory location
		ld 		(hl),e
		inc 	hl 	
		ld 		(hl),d
		inc 	hl
		ld 		(Here),hl 							; write back
		call 	PAGERestore
		pop 	hl
		pop 	de 									; restore and exit
		pop 	af
		ret
