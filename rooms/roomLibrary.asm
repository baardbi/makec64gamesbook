ROOM:
{
	load:
		txa
		pha
		tya
		pha

		lda #0
		sta tileCounter

		ldx roomNr

		lda Room_LO,x
		sta ZP_ROOM_LO
		lda Room_HI,x
		sta ZP_ROOM_HI

		ldx #0
		loadRoomRow:
			stx tileRow
			
			ldy #0
			loadRoomCol:
				sty tileCol
				ldy tileCounter
				lda (ZP_ROOM_LO),y
				sta tileNr
				ldy tileCol

				jsr TILE.drawTile
				inc tileCounter

				iny
				cpy #ROOM_WIDTH
				bne loadRoomCol

			inx
			cpx #ROOM_HEIGHT
			bne loadRoomRow

		pla
		tay
		pla
		tax

		rts
}
