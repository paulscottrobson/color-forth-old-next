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
	ld 		hl,(__COMPCurrentDef)					; check if it's been closed
	ld 		a,h
	or 		l
	jr 		z,__COMRedClosed
	ld 		hl,__COMRedNotClosedMsg 				; not closed.
	jp 		ErrorHandler
__COMRedNotClosedMsg:
	db 		"not closed",$00
;
;		Adding red word okay.
;
__COMRedClosed:
	xor 	a 										; add to FORTH 
	call 	DICTAddWord
	ld 		hl,(Here)								; copy HERE to CurrentDef
	ld 		(__COMPCurrentDef),hl
	ld 		hl,$0000 								; zero current exit as one not done yet.
	ld 		(__COMPCurrentExit),hl		
	ld 		a,$E1 									; pop HL
	call 	FARCompileByte
	ld 		a,$22 									; ld (xxxx),hl
	call 	FARCompileByte
	ld 		hl,$0000 								; zero address
	call 	FARCompileWord
	ret

; ***************************************************************************************
;
;			  Code for compiling ;s - this is ; without the THEN closure
;
; ***************************************************************************************

COMDExitRoutine:
	ld 		hl,(__COMPCurrentExit) 					; current exit already done.
	ld 		a,h
	or 		l
	jr 		z,__COMDExitCreate
	ld 		a,$C3 									; JP to that exit
	call 	FARCompileByte
	call 	FARCompileWord
	ret

__COMDExitCreate:
	ld 		hl,(Here) 								; get and save Here.
	ld 		(__COMPCurrentExit),hl 					; save as current exit

	ld 		a,$C3 									; compile JP $0000
	call 	FARCompileByte
	ld 		hl,$0000
	call 	FARCompileWord

	ld 		bc,(Here) 								; put current here in BC
	ld 		hl,(__COMPCurrentDef)					; get current definition
	inc 	hl 										; point to address part of prefix.
	inc 	hl
	ld 		(Here),hl
	ld 		h,b 									; overwrite with BC + 1
	ld 		l,c
	dec 	hl
	dec 	hl
	call 	FARCompileWord
	ld 		(Here),bc 								; restore HERE.
	ld 		hl,$0000
	ld 		(__COMPCurrentDef),hl 					; zero current definition as old one closed.
	ret

	ret

