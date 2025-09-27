
// ----------------------------------- ROOM LIBRARY -----------------------------------

ROOM:
{
	load:
		SetRoomStatus(ROOM_LOADING)
		txa
		pha

		ldx roomNr
		lda Room_LO,x
		sta ZP_ROOM_LO
		lda Room_HI,x
		sta ZP_ROOM_HI
		lda Room_Info_LO,x
		sta ZP_ROOM_INFO_LO
		lda Room_Info_HI,x
		sta ZP_ROOM_INFO_HI

		lda #0
		sta tileCounter
		sta tileRow
		tax

		loadRoomRow:
			ldy #0
			sty tileCol

			loadRoomCol:
				sty tempY
				ldy tileCounter
				lda (ZP_ROOM_LO),y
				sta tileNr
				ldy tempY

				jsr TILE.drawTile
				inc tileCounter
				
				iny
				sty tileCol
				cpy #ROOM_WIDTH
				bne loadRoomCol

			inx
			stx tileRow
			cpx #ROOM_HEIGHT
			bne loadRoomRow

		lda #%00000001 // Disable all sprites except player
		sta SPRITE_ENABLE

		// This loop clears the sprite table values defined inside the loop.
		ldx #1 // Skip sprite 0 (Player sprite)
		clearSpriteLoop:
			lda #10 // Set inactive sprites slightly away from the edges
			sta Sprite_X_Pos,x
			sta Sprite_Y_Pos,x

			lda #BLANK_SPRITE // Make sprite invisible
			sta Sprite_Anim_Graphic,x

			lda SPRITE_X_EXTENDED
			ora Sprite_Binary,x
			sta SPRITE_X_EXTENDED
			
			inx
			cpx #MAX_NUMBER_OF_SPRITES
			bne clearSpriteLoop

		// Load room info
		ldy #0
		lda (ZP_ROOM_INFO_LO),y
		sta roomFlags
		iny
		lda (ZP_ROOM_INFO_LO),y
		sta warpOutRoom
		iny
		lda (ZP_ROOM_INFO_LO),y
		sta warpInX
		iny
		lda (ZP_ROOM_INFO_LO),y
		sta warpInY
		iny
		
		roomSprite1:
		// Sprite 1
		lda (ZP_ROOM_INFO_LO),y
		bne roomSprite1not0 // If sprite type is 0 then skip this sprite
			iny
			iny
			iny
			jmp roomSprite2
		roomSprite1not0:

		lda (ZP_ROOM_INFO_LO),y
		sta spriteType
		iny
		lda (ZP_ROOM_INFO_LO),y
		sta spriteX
		iny
		lda (ZP_ROOM_INFO_LO),y
		sta spriteY

		jsr SPRITE.createSprite

		iny
		
		roomSprite2:
		// Sprite 2
		lda (ZP_ROOM_INFO_LO),y
		bne roomSprite2not0 // If sprite type is 0 then skip this sprite
			iny
			iny
			iny
			jmp roomSprite3
		roomSprite2not0:

		lda (ZP_ROOM_INFO_LO),y
		sta spriteType
		iny
		lda (ZP_ROOM_INFO_LO),y
		sta spriteX
		iny
		lda (ZP_ROOM_INFO_LO),y
		sta spriteY

		jsr SPRITE.createSprite

		iny
		
		roomSprite3: // Coin sprite
		// Sprite 3
		lda (ZP_ROOM_INFO_LO),y
		bne roomSprite3not0 // If sprite type is 0 then skip this sprite
			iny
			iny
			iny
			jmp doneCreateRoomSprites
		roomSprite3not0:

		// If coin is marked as collected then don't load coin sprite
		lda roomFlags
		and #ROOM_COIN_COLLECTED
		beq !coinNotCollected+
			iny
			iny
			iny
			jmp doneCreateRoomSprites
		!coinNotCollected:

		lda (ZP_ROOM_INFO_LO),y
		sta spriteType
		iny
		lda (ZP_ROOM_INFO_LO),y
		sta spriteX
		iny
		lda (ZP_ROOM_INFO_LO),y
		sta spriteY

		jsr SPRITE.createSprite

		doneCreateRoomSprites:
		
		pla
		tax
		SetRoomStatus(ROOM_NO_STATUS)
		rts


	loadCharMap:
		SetRoomStatus(ROOM_LOADING)
		txa
		pha
		tya
		pha

		lda #0
		sta tileCounter

		lda charMapWidth
		clc
		adc charMapStartX
		sta charMapWidth

		lda charMapHeight
		clc
		adc charMapStartY
		sta charMapHeight

		ldx charMapStartY
		stx tileRow

		loadCharMapRow:

			ldy charMapStartX
			sty tileCol
			
			loadCharMapCol:
				tya
				pha

				ldy tileCounter
				lda (ZP_ROOM_LO),y
				sta tileNr
				tay
				lda CHARSET_ATTRIB_ADDRESS,y
				sta tileColor
				
				pla
				tay

				jsr TILE.drawChar
				inc tileCounter

				iny
				sty tileCol
				cpy charMapWidth
				bne loadCharMapCol

			inx
			stx tileRow
			cpx charMapHeight
			bne loadCharMapRow

		pla
		tay
		pla
		tax
		SetRoomStatus(ROOM_NO_STATUS)
		rts


	resetRoomCoins:
		lda #0
		sta collectedCoins

		txa
		pha

		ldy #0 // Room flags is the first room info value in the room info table

		ldx #0

		resetRoomCoinsLoop:
			lda Room_Info_LO,x
			sta ZP_ROOM_INFO_LO
			lda Room_Info_HI,x
			sta ZP_ROOM_INFO_HI

			lda (ZP_ROOM_INFO_LO),y
			and #ROOM_COIN_COLLECTED_0 // Reset coin to not collected
			sta (ZP_ROOM_INFO_LO),y

			inx
			cpx #TOTAL_NUMBER_OF_ROOMS
			bne resetRoomCoinsLoop
		pla
		tax
		rts
}
