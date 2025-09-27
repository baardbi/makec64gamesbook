drawText:
	lda charColor
	sta $0286

	clc
	ldy charCol
	ldx charRow
	jsr $fff0

	ldy #0
	textLoop:
		lda (ZP_TEXT_LO),y
		cmp #35 // Stop char:  #
		beq doneWriteText
		cmp #62 // New line:  >
		bne writeText
			sty tempY // Backup char counter
			clc
			ldy charCol
			inx
			jsr PLOT
			ldy tempY // Restore char counter
			iny
			jmp textLoop
		writeText:
			jsr $ffd2
			iny
			jmp textLoop

	doneWriteText:
		rts
