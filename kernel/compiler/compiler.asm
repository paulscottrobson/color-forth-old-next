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

		push 	ix 									; save the return address temporarily
		ld 		ix,(__COMPStackPointer) 			; advance the stack frame forward.
		ld 		de,CompilerStackSize
		add 	ix,de
		ld 		(__COMPStackPointer),ix 			; set it back.
		pop 	de 									; return address in DE.

		ld 		(ix+0),e 							; save return address in +0,+1
		ld 		(ix+1),d 
		ld 		(ix+2),l 							; save HL in IX+2,IX+3
		ld 		(ix+3),h

		ld 		hl,$0000 							; retrieve the stack pointer.
		add 	hl,sp
		ld 		(ix+4),l 							; save in offset 4/5
		ld 		(ix+5),h

		push 	ix 									; calculate temporary stack position.
		pop 	hl
		ld 		de,CompilerStackSize-2 				; which is at the end of this frame.
		add 	hl,de
		ld 		sp,hl 								; and put in SP.
		ld 		(ix+6),l 							; save this so you can reload it if required
		ld 		(ix+7),h

__COMWLoop:
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
		ld 		ix,(__COMPStackPointer)				; unwind the return stack.
		ld 		de,-CompilerStackSize 				; put the stack frame backword
		add 	ix,de 								; hence all the (+stacksize below ....)
		ld 		(__COMPStackPointer),ix

		ld 		l,(ix+4+CompilerStackSize) 			; original stack in SP
		ld 		h,(ix+5+CompilerStackSize)
		ld 		sp,hl 								; put that in SP.

		ld 		l,(ix+2+CompilerStackSize) 			; reload HL from IX
		ld 		h,(ix+3+CompilerStackSize)

		ld 		e,(ix+0+CompilerStackSize)			; return address in DE
		ld 		d,(ix+1+CompilerStackSize)

		ld 		ix,$0000 							; put the return address in IX
		add 	ix,de

		pop 	de 									; the stack is now cached again
		jp 		(ix) 								; and return via IX.
;
;		Jump here on error.
;
COMError:
		push 	bc
		pop 	hl
		inc 	hl
		jp 		ErrorHandler

