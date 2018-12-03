; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		data.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		3rd December 2018
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

; ***************************************************************************************
;
;							 Display system information
;
; ***************************************************************************************

__DIScreenMode:										; current mode
		db 		0
__DIScreenWidth: 									; screen extent
		db 		0
__DIScreenHeight:
		db 		0
__DIFontBase:										; font in use
		dw 		AlternateFont
__DIScreenDriver:									; Screen Driver
		dw 		0	
__DIScreenAddress:									; position on screen
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



		org 	$A000
FreeMemory:		
		org 	$C000
		db 		0 									; start of dictionary, which is empty.
