; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		kernel.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		3rd December 2018
;		Purpose :	ColorForth Kernel
;
; ***************************************************************************************
; ***************************************************************************************


;
;		Page allocation. These need to match up with those given in the page table
;		in data.asm
;													
DictionaryPage = $20 								; dictionary page
FirstCodePage = $22 								; first code page.
								
;
;		Memory allocated from the Unused space in $4000-$7FFF
;
EditBuffer = $7B08 									; $7B00-$7D1F 512 byte edit buffer
StackTop = $7EFC 									;      -$7EFC Top of stack
EditPageSize = 512 									; bytes per edit page.

		opt 	zxnextreg
		org 	$8000 								; $8000 boot.
		jr 		Boot
		org 	$8004 								; $8004 address of sysinfo
		dw 		SystemInformation 
		org		$8008								; $8008 system commands.
		jp	 	SystemHandler
		org 	$8010
		jp 		MULTMultiply16						; $8010 Multiply
		jp 		DIVDivideMod16 						; $8013 Divide

		org 	$8020
Boot:	ld 		sp,StackTop							; reset Z80 Stack
		di											; disable interrupts
	
		db 		$ED,$91,7,2							; set turbo port (7) to 2 (14Mhz speed)
		ld 		a,FirstCodePage 					; get the page to start
		call 	PAGEInitialise

		ld 		hl,0								; A = 0
		ld 		de,0 								; B = Mode
		call 	SystemHandler 						; Switch to that mode.

		ld 		de,32100
		push 	de
		ld 		de,2702
		push 	de
		ld 		de,-2
		call 	DEBUGShowStack

w1:		jp 		w1

		include "support/multiply.asm"				; 16 bit multiply
		include "support/divide.asm"				; 16 bit divide
		include "support/debug.asm"					; stack display.
		include "support/farmemory.asm" 			; far memory routines
		include "support/graphics.asm" 				; common graphics
		include "support/keyboard.asm"				; keyboard handler
		include "support/paging.asm" 				; page switcher (not while executing)
		include "support/screen48k.asm"				; screen "drivers"
		include "support/screen_layer2.asm"
		include "support/screen_lores.asm"
		include "support/system.asm"				; system handler

AlternateFont:										; nicer font
		include "font.inc" 							; can be $3D00 here to save memory
		include "data.asm"		

