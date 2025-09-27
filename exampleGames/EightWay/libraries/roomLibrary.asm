
// -------------------------------- ROOM LIBRARY --------------------------------

ROOM:
{
	// ******************* Load room *******************
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

		// ******************* Visit room *******************
		jsr HUD.visitRoom

		// ******************* Create room sprites *******************
		ldx roomNr

		lda Room_Sprite_1_X,x
		beq dontCreateRoomSprite1
			sta spriteXpos
			lda Room_Sprite_1_Y,x
			sta spriteYpos
			lda Room_Sprite_1_Type,x
			sta spriteType

			jsr SPRITE.createSprite
		dontCreateRoomSprite1:

		lda Room_Sprite_2_X,x
		beq dontCreateRoomSprite2
			sta spriteXpos
			lda Room_Sprite_2_Y,x
			sta spriteYpos
			lda Room_Sprite_2_Type,x
			sta spriteType

			jsr SPRITE.createSprite
		dontCreateRoomSprite2:

		lda Room_Sprite_3_X,x
		beq dontCreateRoomSprite3
			sta spriteXpos
			lda Room_Sprite_3_Y,x
			sta spriteYpos
			lda Room_Sprite_3_Type,x
			sta spriteType

			jsr SPRITE.createSprite
		dontCreateRoomSprite3:

		pla
		tay
		pla
		tax

		rts

	// ******************* Load charmap *******************
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


	triggerRoom:
		ldy roomNr
		lda Room_Flags,y
		ora #ROOM_FLAG_0_TRIGGERED
		sta Room_Flags,y

		rts


	checkRoomTrigger:
		ldy roomNr
		lda Room_Flags,y
		and #ROOM_FLAG_0_TRIGGERED // If triggered A will contain 1, else 0

		rts
}
