TILE:
{
	drawChar:
		txa
		pha
		tya
		pha

		ldx tileRow

		lda Row_LO,x
		sta ZP_ROW_LO
		sta ZP_ROW_COLOR_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy tileCol

		lda tileNr
		sta (ZP_ROW_LO),y

		lda tileColor
		sta (ZP_ROW_COLOR_LO),y

		pla
		tay
		pla
		tax

		rts


	
	drawTile:
		txa
		pha
		tya
		pha

		lda tileRow
		asl
		tax

		lda Row_LO,x
		sta ZP_ROW_LO
		sta ZP_ROW_COLOR_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		lda tileCol
		asl
		tay

		lda tileNr
		asl
		asl
		tax

		stx tempX
		lda TILESET_ADDRESS,x
		sta (ZP_ROW_LO),y
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		sta (ZP_ROW_COLOR_LO),y
		ldx tempX

		inx
		iny
		stx tempX
		lda TILESET_ADDRESS,x
		sta (ZP_ROW_LO),y
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		sta (ZP_ROW_COLOR_LO),y
		ldx tempX

		inx
		tya
		clc
		adc #SCREEN_WIDTH - 1
		tay

		stx tempX
		lda TILESET_ADDRESS,x
		sta (ZP_ROW_LO),y
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		sta (ZP_ROW_COLOR_LO),y
		ldx tempX

		inx
		iny

		lda TILESET_ADDRESS,x
		sta (ZP_ROW_LO),y
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		sta (ZP_ROW_COLOR_LO),y

		pla
		tay
		pla
		tax

		rts
}
