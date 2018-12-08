; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		com_define.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		8th December 2018
;		Purpose :	Executes a red or magenta word.
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;					Compile the magenta word (variable definition)
;
; ***************************************************************************************

COMDCompileMagentaWord:
	db 		$DD,$01
	ld 		a,$80 									; add it to the MACRO dictionary.
	call 	DICTAddWord

	ld 		a,$CD 									; add a caller to the standard variable handler
	call 	FARCompileByte
	ld 		hl,COMDVariableHandler
	call 	FARCompileWord
	ld 		hl,$0000 								; and space for the variable.
	call 	FARCompileWord
	ret
;
;		Magenta word call this routine - their code (compiled above) is 
;		CALL COMDVariableHandler ; dw 0
;
COMDVariableHandler:
	pop 	hl 										; address of the data
	call 	COMUCompileConstant 					; compile the code to load the constant.
	ret

; ***************************************************************************************
;
;	 Compiles a red word. If the previous word is open (e.g. CurrentDef is non-zero)
;	 throw an error as previous not closed. Store current def and compile prefix, set
;	 CurrentExit to zero so ;s can compile the postfix.
;
; ***************************************************************************************

COMDCompileRedWord:
	ret

