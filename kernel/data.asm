; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		data.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		7th December 2018
;		Purpose :	Data area
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;								System Information
;
; ***************************************************************************************

SystemInformation:

Here:												; +0 	Here 
		dw 		FreeMemory
HerePage: 											; +2	Here.Page
		db 		FirstCodePage,0
NextFreePage: 										; +4 	Next available code page.
		db 		FirstCodePage+1,0,0,0
DisplayInfo: 										; +8 	Display information
		dw 		DisplayInformation,0		

; ***************************************************************************************
;
;							 Display system information
;
; ***************************************************************************************

DisplayInformation:

__DIScreenWidth: 									; +0 	screen width
		db 		0,0,0,0
__DIScreenHeight:									; +4 	screen height
		db 		0,0,0,0
__DIScreenSize:										; +8 	char size of screen
		dw 		0,0		
__DIScreenMode:										; +12 	current mode
		db 		0,0,0,0
__DIFontBase:										; font in use
		dw 		AlternateFont
__DIScreenDriver:									; Screen Driver
		dw 		0	

; ***************************************************************************************
;
;								 Other data and buffers
;
; ***************************************************************************************

__PAGEStackPointer: 								; stack used for switching pages
		dw 		0
__PAGEStackBase:
		ds 		16

__SPAREStackPointer: 								; working stack so we sort of do push and pop.
		dw 		__SPAREStack 						; (no return stack !)
__SPAREStack:
		ds 		32

__BUFFPage:											; current buffer page being scanned.
		db 		0
		
__COMPStackPointer: 								; when advanced, will be next stack entry.
		dw 		CompilerStack-CompilerStackSize

__COMPCurrentDef: 									; points to head (e.g. POP HL) of current definition	
		dw 		0  									; set to zero when definition has been closed by ;s

__COMPCurrentExit:									; points to tail (e.g. JP $0000) of current definition
		dw 		0 									; set to zero by red word ; if 0 when ;s is called creates
													; postfix else jump to that postfix.

__CLICurrentKey: 									; current inkey state on CLI
		db 		0

		db 		$86 								; buffer for executing, tags it yellow effectively.
__CLIBuffer:
		ds 		20

__DICTSelector: 									; updating FORTH ($00) MACRO ($80)
		db 		0

		org 	$A000
FreeMemory:		
		org 	$C000
		db 		0 									; start of dictionary, which is empty.
