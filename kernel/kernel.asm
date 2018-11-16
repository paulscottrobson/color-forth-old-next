; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		kernel.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		16th November 2018
;		Purpose :	ColorForth Kernel
;
; ***************************************************************************************
; ***************************************************************************************

StackTop   = 	$7EF0 								; Top of stack

DictionaryPage = $20 								; dictionary page
FirstCodePage = $22

			org 	$8000
			jr 		Boot
			org 	$8004							; pointer to SysInfo at $8004
			dw 		SystemInformationTable
			
Boot:		ld 		sp,(SIStack)					; reset Z80 Stack
			di										; disable interrupts

			db 		$ED,$91,7,2						; set turbo port (7) to 2 (14Mhz speed)

			call 	GFXInitialise48k 				; initialise and clear screen.
			call 	GFXConfigure

			db 		$DD,$01
			ld 		a,(SIBootCodePage) 				; get the page to start
			call 	PAGEInitialise

			ld 		hl,(SIBootCodeAddress)
			jp 		(hl)

HaltZ80:	di
			halt
			jr 		HaltZ80

			include "support/macro.asm" 			; macro expander
			include "support/debug.asm"				; debug helper
			include "support/paging.asm" 			; page switcher (not while executing)
			include "support/farmemory.asm" 		; far memory routines
			include "support/divide.asm" 			; division
			include "support/multiply.asm" 			; multiplication
			include "support/graphics.asm" 			; common graphics
			include "support/keyboard.asm"
			include "support/screen48k.asm"			; screen "drivers"
			include "support/screen_layer2.asm"
			include "support/screen_lores.asm"
			include "temp/__words.asm"				; built file of words.

AlternateFont:										; nicer font
			include "font.inc" 						; can be $3D00 here to save memory

			include "data.asm"		

			org 	$C000
			db 		0 								; start of dictionary, which is empty.
