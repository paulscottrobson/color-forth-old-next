; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		buffer.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		4th December 2018
;		Purpose :	Scan pages for buffers.
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;								Scan and compile buffers.
;
; ***************************************************************************************

BUFFScan:
		ld 		a,FirstSourcePage
__BUFFScanLoop:
		call 	BUFFCompile 						; compile buffer
		inc 	a 									; bump page
		inc 	a
		cp 		FirstSourcePage+SourcePageCount
		jr 		nz,__BUFFScanLoop
		ret

; ***************************************************************************************
;
;							Compile Buffer A. ABC in BCDEHL
;
; ***************************************************************************************

BUFFCompile:
		push 	af
		push 	ix
		call 	PAGESwitch							; switch to that page.

		ld 		ix,$C000 							; first block of 32 in each page.
__BUFFCompileLoop:
		ld 		a,(ix+0)							; look at the entry
		cp 		$80 								; is the first byte $80 ?
		jr 		z,__BUFFNext 						; if so, the buffer is empty

		push 	ix 									; copy IX to HL
		pop 	hl

		ld 		de,EditBuffer 						; copy that 512 byte block into edit buffer
		ld 		bc,EditPageSize
		ldir
		call 	BUFFCompileEditBuffer 				; compile the buffer

__BUFFNext:
		ld 		bc,EditPageSize
		add 	ix,bc
		jr 		nc,__BUFFCompileLoop 				; ends on carry e.g. gone to $0000

		call 	PAGERestore 						; switch page back
		pop 	ix									; restore registers
		pop 	af
		ret

; ***************************************************************************************
;
;			   	   			Compile contents of the buffer.
;
; ***************************************************************************************

BUFFCompileEditBuffer:
		push 	af									; save registers. 
		push 	bc 									; if this is called re-entrantly we aren't interested
		push 	de 									; in the stack values.
		push 	hl
		push 	ix

		ld 		de,EditBuffer 						; DE points to edit buffer.
__BUFFCEBLoop:
		ld 		a,(de)								; read tag
		cp 		$80 								; is it the end of buffer tag
		jr 		z,__BUFFCEBExit

		ld 		a,(de) 								
		cp 		$82
;		call 	z,COMGCompileGreen
		ld 		a,(de) 								
		cp 		$83
;		call 	z,COMDCompileMagenta
		ld 		a,(de) 								
		cp 		$84
;		call 	z,COMDCompileRed
		ld 		a,(de) 								
		cp 		$85
;		call 	z,COMGCompileCyan
		ld 		a,(de) 								
		cp 		$85
;		call 	z,COMYExecuteYellow

__BUFFCEBNext:
		inc 	de 									; advance to next tag skipping over text and length.
		ld 		a,(de)
		bit 	7,a
		jr 		z,__BUFFCEBNext
		jr 		__BUFFCEBLoop

__BUFFCEBExit:
		pop 	ix
		pop 	hl
		pop 	de
		pop 	bc 									; pop and exit
		pop 	af
		ret

