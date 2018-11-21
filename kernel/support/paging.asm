; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		paging.asm
;		Author :	paul@robsons.org.uk
;		Date : 		15th November 2018
;		Purpose :	Paging Manager
;
; ***************************************************************************************
; ***************************************************************************************

; ********************************************************************************************************
;
; 									Initialise Paging, set current to A
;
; ********************************************************************************************************

PAGEInitialise:
		db 		$ED,$92,$56							; switch to page A
		inc 	a
		db 		$ED,$92,$57
		dec 	a
		ex 		af,af' 								; put page in A'
		ld 		hl,PAGEStackBase 					; reset the page stack
		ld 		(PAGEStackPointer),hl
		ret

; ********************************************************************************************************
;
;										Switch to a new page A
;
; ********************************************************************************************************

PAGESwitch:
		push 	af
		push 	hl

		push 	af 									; save A on stack
		ld 		hl,(PAGEStackPointer) 				; put A' on the stack, the current page
		ex 		af,af'
		ld 		(hl),a
		inc 	hl
		ld 		(PAGEStackPointer),hl

		pop 	af 									; restore new A
		db 		$ED,$92,$56							; switch to page A
		inc 	a
		db 		$ED,$92,$57
		dec 	a
		ex 		af,af' 								; put page in A'

		pop 	hl
		pop 	af
		ret

; ********************************************************************************************************
;
;										Return to the previous page
;
; ********************************************************************************************************

PAGERestore:
		push 	af
		push 	hl
		ld 		hl,(PAGEStackPointer) 				; pop the old page off
		dec 	hl
		ld 		a,(hl)
		ld 		(PAGEStackPointer),hl
		db 		$ED,$92,$56							; switch to page A
		inc 	a
		db 		$ED,$92,$57
		dec 	a
		pop 	hl
		pop 	af
		ret
		
		