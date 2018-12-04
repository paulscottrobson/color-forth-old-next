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
;							Execute system function A param in B
;
; ***************************************************************************************

SystemHandler:
		ld 			a,h 							; check A in range
		or 			a
		ret 		nz
		ld 			a,l 							
		cp 			5
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
		jp 			SYSSetPosition					; +3 	set writing position to B
		jp 			SYSWriteCharacter 				; +4 	write character and advance.

SYSSetPosition:
		ld 			(__DIScreenAddress),de
		ret

SYSWriteCharacter:
		push 		hl
		ld 			hl,(__DIScreenAddress)
		call 		GFXWriteCharacter
		inc 		hl
		ld 			(__DIScreenAddress),hl
		pop 		hl
		ret

SYSGetExtent:
		ld 			a,(__DIScreenWidth)
		ld 			l,a
		ld 			a,(__DIScreenHeight)
		ld 			e,a
		ld 			h,0
		ld 			d,0
		ret

