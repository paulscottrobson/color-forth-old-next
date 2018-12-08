; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		com_compile.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		8th December 2018
;		Purpose :	Executes a green/cyan word.
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;										Green word.
;
; ***************************************************************************************

COMCCompileGreenWord:
	ld 		a,$80 									; firstly check if in Macro
	call 	DICTFindWord 
	jr 		nc,__COMCGreenMacro 					; if so execute that word
	ld 		a,$00									; then check if in Forth
	call 	DICTFindWord 
	jr 		nc,__COMCGreenForth
	call 	CONSTConvert 							; number ?
	jr 		nc,__COMCGreenNumber
	jp 		COMError 								; failed, error.
;
;		Green word, in macro, execute it.
;
__COMCGreenMacro:
	call 	COMXExecuteEHL
	ret
;
;		Green word, in Forth, compile it.
;
__COMCGreenForth:
	call 	COMCCompileCallEHL
	ret
;
;		Green number, compile code to load it.
;
__COMCGreenNumber:
	call 	COMUCompileConstant
	ret

; ***************************************************************************************
;
;							Compile code to do a call to E:HL
;
; ***************************************************************************************

COMCCompileCallEHL:
	;
	;		TODO: Cross page if target >= $C000 and not current page.
	;
	ld 		a,$CD 									; Z80 call
	call 	FARCompileByte
	call 	FARCompileWord
	ret

; ***************************************************************************************
;
;						Cyan word - compile if in MACRO
;
; ***************************************************************************************
	
COMCCompileCyanWord:
	ld 		a,$80 									; firstly check if in Macro
	call 	DICTFindWord 
	jp 		c,COMError 								; not found, error
	call 	COMCCompileCallEHL 						; compile the call.
	ret

	