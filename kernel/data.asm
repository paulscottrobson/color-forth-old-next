; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		data.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		15th November 2018
;		Purpose :	Data area
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;									System Information
;
; ***************************************************************************************

SystemInformationTable:

SINextFreeCode: 									; +0 	Next Free Code Byte
		dw 		FreeMemory,0
SINextFreeCodePage: 								; +4 	Next Free Code Byte Page
		dw 		FirstCodePage,0
SIBootCodeAddress:									; +8	Run from here
		dw 		HaltZ80,0
SIBootCodePage: 									; +12   Run page.
		db		FirstCodePage,0,0,0
SIPageUsage:										; +16 	Page Usage Table
		dw 		PageUsage,0 			
SIStack:											; +20 	Initial Z80 stack value
		dw 		StackTop,0							
SIScreenWidth:										; +24 	Screen Width
		dw 		0,0
SIScreenHeight:										; +28 	Screen Height
		dw 		0,0
SIScreenDriver:										; +32 	Screen Driver
		dw 		0,0 								
SIScreenSize: 										; +36  	Screen Size
		dw 		0,0 
SIFontBase:											; +40 	768 byte font, begins with space
		dw 		AlternateFont,0 							

; ***************************************************************************************
;
;								 Other data and buffers
;
; ***************************************************************************************

PAGEStackPointer: 									; stack used for switching pages
		dw 		0
PAGEStackBase:
		ds 		16

PageUsage:
		db 		1									; $20 (dictionary) [1 = system]
		db 		2 									; $24 (first code) [2 = code]
		db 		0,0,0,0,0,0 						; $24-$2E 		   [0 = unused]
		db 		0,0,0,0,0,0,0,0 					; $30-$3E
		db 		0,0,0,0,0,0,0,0 					; $40-$4E
		db 		0,0,0,0,0,0,0,0 					; $50-$5E
		db 		$FF 								; end of page.

		org 	$A000
FreeMemory:		
