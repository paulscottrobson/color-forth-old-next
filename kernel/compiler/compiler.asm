; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		compiler.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		7th December 2018
;		Purpose :	Compiles a list of word split by tags.
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;		Compile word list at BC. Stack is normal (DE = cache, SP below return)
;
; ***************************************************************************************

COMCompileWordList:
		pop 	ix 									; IX is now the return address.
		push 	de 									; decache the stack, DE is no longer cached.

		push 	af 									; push the other registers on the stack. The data stack
		push 	bc 									; is 8 up after this.
		push 	hl
		push 	ix 									; put the return address in DE

		ld 		ix,(__COMPStackPointer) 			; advance the stack frame forward.
		ld 		de,CompilerStackSize
		add 	ix,de
		ld 		(__COMPStackPointer),ix 			; set it back.

		ld 		hl,$0000 							; retrieve the stack pointer.
		add 	hl,sp
		ld 		(ix+0),l 							; save in offset 0/1.
		ld 		(ix+1),h

		push 	ix 									; calculate temporary stack position.
		pop 	hl
		ld 		de,CompilerStackSize-2 				; which is at the end of this frame.
		add 	hl,de
		ld 		sp,hl 								; and put in SP.
		ld 		(ix+2),l 							; save this so you can reload it if required
		ld 		(ix+3),h

__COMWLoop:
		db 		$DD,$01
		ld 		a,(bc) 								; reached the end ?
		cp 		$80
		jr 		z,__COMWExit
		ld 		a,(bc) 								; central dispatcher.
		cp 		$82
		call 	z,COMCCompileGreenWord
		ld 		a,(bc)
		cp 		$83
		call 	z,COMDCompileMagentaWord
		ld 		a,(bc)
		cp 		$84
		call 	z,COMDCompileRedWord
		ld 		a,(bc)
		cp 		$85
		call 	z,COMCCompileCyanWord
		ld 		a,(bc)
		cp 		$86
		call 	z,COMXExecuteYellowWord

__COMWNext: 										; advance to next tag.
		inc 	bc 
		ld 		a,(bc)
		bit 	7,a
		jr 		z,__COMWNext
		jr 		__COMWLoop 							; go do that.

__COMWExit:
		ld 		ix,(__COMPStackPointer)				; retrieve the old SP value
		ld 		l,(ix+0)
		ld 		h,(ix+1)
		ld 		sp,hl 								; put in stack pointer

		ld 		de,-CompilerStackSize 				; put the stack frame backword
		add 	ix,de
		ld 		(__COMPStackPointer),ix

		pop 	ix 									; restore registers, return is now in IX
		pop 	hl
		pop 	bc
		pop 	af
		pop 	de 									; the stack is now cached again
		jp 		(ix) 								; and return via IX.

		ret
