; ***************************************************************************************
; ***************************************************************************************
;
;		Name : 		dictionary.asm
;		Author :	Paul Robson (paul@robsons.org.uk)
;		Date : 		7th December 2018
;		Purpose :	Dictionary handler.
;
; ***************************************************************************************
; ***************************************************************************************

; ***********************************************************************************************
;
;		Add Dictionary Word. Name is a tagged string at BC ends in $80-$FF, uses the current 
;		page/pointer values. A indicates whether it goes in FORTH ($00) or MACRO ($80)
;
; ***********************************************************************************************

DICTAddWord:
		push 	af 									; registers to stack.
		push 	bc
		push 	de
		push	hl
		push 	ix

		push 	bc 									; put word address in HL
		pop 	hl 

		and 	$80 								; mask off forth/macro bit put in C
		ld 		c,a

		ld 		b,-1 								; work out length in B
		push 	hl
__DICTGetLength:
		inc 	b
		inc 	hl
		bit 	7,(hl)
		jr 		z,__DICTGetLength
		pop 	hl 									; HL = Tag.
		inc 	hl 									; HL = first character

		ld 		a,DictionaryPage					; switch to dictionary page
		call 	PAGESwitch

		ld 		ix,$C000							; IX = Start of dictionary

__DICTFindEndDictionary:
		ld 		a,(ix+0) 							; follow down chain to the end
		or 		a
		jr 		z,__DICTCreateEntry
		ld 		e,a
		ld 		d,0
		add 	ix,de
		jr 		__DICTFindEndDictionary

__DICTCreateEntry:
		ld 		a,b
		add 	a,5
		ld 		(ix+0),a 							; offset is length + 5

		ld 		a,(HerePage)						; code page
		ld 		(ix+1),a

		ld 		de,(Here) 							; code address
		ld 		(ix+2),e
		ld 		(ix+3),d 

		ld 		a,b 								; OR length with FORTH/MACRO bit.
		or 		c
		ld 		(ix+4),a 							; put length in.

		ex 		de,hl 								; put name in DE
__DICTAddCopy:
		ld 		a,(de) 								; copy byte over as 7 bit ASCII.
		ld 		(ix+5),a
		inc 	ix 									
		inc 	de
		djnz	__DICTAddCopy 						; until string is copied over.

		ld 		(ix+5),0 							; write end of dictionary zero.

		call 	PAGERestore
		pop 	ix 									; restore and exit
		pop 	hl
 		pop 	de
		pop 	bc
		pop 	af
		ret

; ***********************************************************************************************
;
;			Find word in dictionary. BC points to tagged string which is the name.
;	 		A is the search type ($00 = FORTH,$80 = MACRO)
; 
;			On exit, HL is the address and E the page number with CC if found, 
;			CS set and HL=DE=0 if not found.
;
; ***********************************************************************************************

DICTFindWord:
		push 	bc 								; save registers - return in EHL Carry
		push 	ix

		ld 		h,b 							; put address of name in HL. 
		ld 		l,c
		ld 		c,a 							; puth the FORTH/MACRO mask in C

		ld 		a,DictionaryPage 				; switch to dictionary page
		call 	PAGESwitch

		ld 		ix,$C000 						; dictionary start			
__DICTFindMainLoop:
		ld 		a,(ix+0)						; examine offset, exit if zero.
		or 		a
		jr 		z,__DICTFindFail

		ld 		a,(ix+4) 						; get this entries forth/macro byte
		xor 	c 								; compare against one passed in
		and 	$80 							; only interested in bit 7.
		jr 		nz,__DICTFindNext 				; if different go to next

		push 	ix 								; save pointers on stack.
		push 	hl 

		ld 		a,(hl)							; get tag length
		and 	$1F
		ld 		b,a 							; into B
		inc 	hl 								; skip over tag byte
__DICTCheckName:
		ld 		a,(ix+5) 						; compare dictionary vs character.
		cp 		(hl) 							; compare vs the matching character.
		jr 		nz,__DICTFindNoMatch 			; no, not the same word.
		inc 	hl 								; HL point to next character
		inc 	ix
		djnz 	__DICTCheckName

		bit 	7,(hl) 							; is the next character in HL a tag/$80
		jr 		z,__DICTFindNoMatch 			; otherwise you have failed to match.

		pop 	hl 								; Found a match. restore HL and IX
		pop 	ix
	
		ld 		d,0 							; D = 0 for neatness.
		ld 		e,(ix+1)						; E = page
		ld 		l,(ix+2)						; HL = address
		ld 		h,(ix+3)		
		xor 	a 								; clear the carry flag.
		jr 		__DICTFindExit

__DICTFindNoMatch:								; this one doesn't match.
		pop 	hl 								; restore HL and IX
		pop 	ix
__DICTFindNext:
		ld 		e,(ix+0)						; DE = offset
		ld 		d,$00
		add 	ix,de 							; next word.
		jr 		__DICTFindMainLoop				; and try the next one.

__DICTFindFail:
		ld 		de,$0000 						; return all zeros.
		ld 		hl,$0000
		scf 									; set carry flag
__DICTFindExit:
		push 	af
		call 	PAGERestore
		pop 	af
		pop 	ix 								; pop registers and return.
		pop 	bc
		ret
