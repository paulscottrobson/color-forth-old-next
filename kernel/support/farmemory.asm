; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		farmemory.asm
;		Author :	paul@robsons.org.uk
;		Date : 		15th November 2018
;		Purpose :	Kernel - Far memory routines.
;
; ***************************************************************************************
; ***************************************************************************************

; ***********************************************************************************************
;
;								Byte compile far memory A
;
; ***********************************************************************************************
	
FARCompileByte:
		push 	af 									; save byte and HL
		push 	hl
		push 	af 									; save byte
		ld		a,(SINextFreeCodePage) 				; switch to page
		call 	PAGESwitch
		ld 		hl,(SINextFreeCode) 				; write to memory location
		pop 	af
		ld 		(hl),a
		inc 	hl 									; bump memory location
		ld 		(SINextFreeCode),hl 				; write back
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
		ld		a,(SINextFreeCodePage) 				; switch to page
		call 	PAGESwitch
		ld 		hl,(SINextFreeCode) 				; write to memory location
		ld 		(hl),e
		inc 	hl 	
		ld 		(hl),d
		inc 	hl
		ld 		(SINextFreeCode),hl 				; write back
		call 	PAGERestore
		pop 	hl
		pop 	de 									; restore and exit
		pop 	af
		ret
											
; ***********************************************************************************************
;
;									Far Read Byte at (SIWord):A
;
; ***********************************************************************************************

FARRead:
		ld 		a,(SIWord)
		call 	PAGESwitch
		ld 		l,(hl)
		ld 		h,0
		call 	PAGERestore
		ret

; ***********************************************************************************************
;
;									Far Write Byte B.0 at (SIWord):A
;
; ***********************************************************************************************

FARWrite:
		ld 		a,(SIWord)
		call 	PAGESwitch
		ld 		(hl),e
		call 	PAGERestore
		ret
