; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		system.asm
;		Author :	paul@robsons.org.uk
;		Date : 		3rd December 2018
;		Purpose :	System function.
;
; ***************************************************************************************
; ***************************************************************************************

; ***************************************************************************************
;
;							Execute system function A
;
; ***************************************************************************************

SystemHandler:
		ld 			a,h 							; check A in range
		or 			a
		ret 		nz
		ld 			a,l 							
		cp 			3
		ret 		nc

		push 		hl 								; save HL then DE
		push 		de 					
		ld 			d,h 							; multiply HL by 3
		ld 			e,l
		add 		hl,de
		add 		hl,de
		ld 			de, SYSVectorTable 				; add to vector table.
		add 		hl,de

		pop 		de 								; restore DE
		ex 			(sp),hl 						; restore HL, putting address on stack
		ret 										; go there.

SYSVectorTable:
		jp 			GFXModeE 						; +0 	set mode to B (e.g. E)
		jp 			GFXClearScreen 					; +1 	clear screen
		jp 			SYSGetExtent 					; +2 	extent (width in HL, height in DE)

SYSGetExtent:
		ld 			a,(__DIScreenWidth)
		ld 			l,a
		ld 			a,(__DIScreenHeight)
		ld 			e,a
		ld 			h,0
		ld 			d,0
		ret

