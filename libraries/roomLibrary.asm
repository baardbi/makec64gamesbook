ROOM:
{
	load:
		txa
		pha
		tya
		pha
		
		lda #0
		sta tileCounter
		
		ldx roomNr // The room (level) we want to draw
		lda Room_LO,x 	// Get the correct address from rooms.bin
		sta ZP_ROOM_LO	// We do this by combining the low byte
		lda Room_HI,x 	// and high byte from the room tables.
		sta ZP_ROOM_HI
		
		ldx #0
		loadRoomRow:
			stx tileRow	// Set the tile row according to the loop
			
			ldy #0
			loadRoomCol:
				sty tileCol // Set the tile column according to the loop
							// and backup the value in Y register because
							// we need to load a tile number into the Y register next.
				
				ldy tileCounter	// Set the tile number to draw
				lda (ZP_ROOM_LO),y // Fetch tile number from the current room to draw
				sta tileNr
				ldy tileCol	// Restore the value in Y register

				jsr TILE.drawTile
				inc tileCounter // Next tile number
				
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
