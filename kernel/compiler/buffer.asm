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
		ld 		de,$0000 							; decached stack.
		push 	de

		ld 		a,FirstSourcePage 					; set the first source page.
		ld 		(__BUFFPage),a
;
;		Loop here to scan the next source page.
;
__BUFFScanSourcePage:
		ld 		a,(__BUFFPage) 						; switch to that source page.
		call 	PAGESwitch
		ld 		hl,$C000 							; next page to scan.
;
;		Come here to scan the buffer at E:HL
;
__BUFFScanNextPageInBuffer:
		ld 		a,(hl) 								; is the buffer empty ?
		cp 		$80
		jr 		z,__BUFFNextPage

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
		
__BUFFNextPage:		
		ld 		bc,EditPageSize 					; go to next buffer
		add 	hl,bc
		jr 		nc,__BUFFScanNextPageInBuffer

		call 	PAGERestore 						; back to original page

		ld 		a,(__BUFFPage)						; go to next page
		add 	a,2
		ld 		(__BUFFPage),a	
		cp 		FirstSourcePage+SourcePageCount 	; have we finished ?
		jr 		nz,__BUFFScanSourcePage

													; finished, the stack is not cached in DE at this point.
															
		pop 	de 									; now the stack is cached
		jp 		CommandLineStart 					; so run the command line with this status.														
