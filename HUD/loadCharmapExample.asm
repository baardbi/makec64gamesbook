loadCharmap:
	txa
	pha
	tya
	pha

	lda #0
	sta tileCounter

	ldx charmapStartRow
	loadCharMapRow:
		stx tileRow

		ldy charmapStartCol
		loadCharMapCol:
			sty tileCol
			ldy tileCounter
			lda (ZP_ROOM_LO),y
			sta tileNr
			tay
			lda CHARSET_ATTRIB_ADDRESS,y
			sta tileColor
			ldy tileCol

			jsr TILE.drawChar

			inc tileCounter
			lda tileCounter
			bne dontIncRoomHi
				inc ZP_ROOM_HI
			dontIncRoomHi:

			iny
			cpy charmapEndCol
			bne loadCharMapCol


		inx
		cpx charmapEndRow
		bne loadCharMapRow
	pla
	tay
	pla
	tax

	rts
