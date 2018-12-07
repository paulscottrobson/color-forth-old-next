; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		buffer.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		7th December 2018
;		Purpose :	Scan pages for buffers.
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;						Scan and compile all pages with buffers
;
; ***************************************************************************************

BUFFScan:
		ld 		sp,StackTop 						; reset the stack top.
		ld 		de,$0000 							; push a zero on it. The stack is now DeCached.
		push 	de
		ld 		e,FirstSourcePage 					; C is the first source page.
;
;		Loop here to scan the next source page.
;
__BUFFScanSourcePage:
		ld 		a,e 								; switch to that source page.
		call 	PAGESwitch
		ld 		hl,$C000 							; next page to scan.
;
;		Come here to scan the buffer at E:HL
;
__BUFFScanNextPageInBuffer:
		push 	hl 									; copy that code into the edit buffer.
		push 	de
		ld 		de,EditBuffer
		ld 		bc,EditPageSize
		ldir 
		pop 	de
		pop 	hl

		pop 	de 									; make stack cached
		ld 		bc,EditBuffer 						; BC is the code to compile.
		call 	COMCompileWordList 					; compile that word list.
		push 	de 									; re-cache stack.
		
		ld 		bc,EditPageSize 					; go to next buffer
		add 	hl,bc
		jr 		nc,__BUFFScanNextPageInBuffer

		call 	PAGERestore 						; back to original page
		inc 	e 									; go to next page (x 2 because 16k pages)
		inc 	e
		ld 		a,e 	
		cp 		FirstSourcePage+SourcePageCount 	; have we finished ?
		jr 		nz,__BUFFScanSourcePage

w1: 	jr 		w1

