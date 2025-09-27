
// -------------------------------- HUD LIBRARY --------------------------------

HUD:
{
	initialize:
		DrawCharmap(HUD_CHARMAP_ADDRESS,HUD_START_ROW,HUD_END_ROW,HUD_START_COL,HUD_END_COL)
		jsr clearRoomVisited
		jsr clearItems
		jsr hideMapLabel
		jsr updateHealth

		rts


	visitRoom:
		lda playerItems
		and #%00000001 // Map
		bne gotMapSoUpdate
			rts
		gotMapSoUpdate:

		lda mapX
		sta mapXprev

		lda mapY
		sta mapYprev

		ldx roomNr

		lda Map_Y,x
		sta mapY

		lda Map_X,x
		sta mapX
		tay

		// ****************** Current Room ******************

		ldx mapY

		lda Room_Visited,x
		ora Room_Mark,y
		sta Room_Visited,x

		lda #MAP_ROOM_START_POS_Y
		clc
		adc mapY
		tax

		lda Row_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		lda #MAP_ROOM_START_POS_X
		clc
		adc mapX
		tay

		lda #MAP_ROOM_CURRENT_COLOR
		sta (ZP_ROW_COLOR_LO),y

		// ****************** Previous Room ******************

		lda #MAP_ROOM_START_POS_Y
		clc
		adc mapYprev
		tax

		lda Row_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		lda #MAP_ROOM_START_POS_X
		clc
		adc mapXprev
		tay

		lda #MAP_ROOM_VISITED_COLOR
		sta (ZP_ROW_COLOR_LO),y

		rts


	manualUpdateMapPos:
		ldx roomNr

		lda Map_Y,x
		sta mapY

		lda Map_X,x
		sta mapX

		lda #MAP_ROOM_START_POS_Y
		clc
		adc mapY
		tax

		lda Row_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		lda #MAP_ROOM_START_POS_X
		clc
		adc mapX
		tay

		lda #MAP_ROOM_CURRENT_COLOR
		sta (ZP_ROW_COLOR_LO),y

		rts


	clearRoomVisited:
		txa
		pha
		tya
		pha

		ldx #0
		clearRoomVisitedLoop:
			lda #%00000000
			sta Room_Visited,x
			inx
			cpx #MAP_HEIGHT
			bne clearRoomVisitedLoop

		ldx #MAP_ROOM_START_POS_Y
		clearRoomVisitedColorRow:
			lda Row_LO,x
			sta ZP_ROW_COLOR_LO
			lda Row_Color_HI,x
			sta ZP_ROW_COLOR_HI

			ldy #MAP_ROOM_START_POS_X
			clearRoomVisitedColorCol:
				lda #MAP_ROOM_NOT_VISITED_COLOR
				sta (ZP_ROW_COLOR_LO),y
				iny
				cpy #MAP_ROOM_START_POS_X + MAP_WIDTH
				bne clearRoomVisitedColorCol

			inx
			cpx #MAP_ROOM_START_POS_Y + MAP_HEIGHT
			bne clearRoomVisitedColorRow
		pla
		tay
		pla
		tax

		rts


	hideMapLabel:
		lda #BLACK
		sta MAP_LABEL_START_POS + 0
		sta MAP_LABEL_START_POS + 1
		sta MAP_LABEL_START_POS + 2
		rts


	showMapLabel:
		lda #WHITE
		sta MAP_LABEL_START_POS + 0
		sta MAP_LABEL_START_POS + 1
		sta MAP_LABEL_START_POS + 2
		rts


	updateHealth:
		txa
		pha
		tya
		pha

		ldx #HEALTH_START_Y

		lda Row_LO,x
		sta ZP_ROW_LO
		sta ZP_ROW_COLOR_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		// ****************** DRAW MAX HEALTH ******************
		ldy #HEALTH_START_X

		ldx #0
		drawMaxHealth:
			lda #HEALTH_EMPTY_SYMBOL
			sta (ZP_ROW_LO),y
			lda #HEALTH_EMPTY_SYMBOL_COLOR
			sta (ZP_ROW_COLOR_LO),y
			iny

			inx
			cpx playerMaxHealth
			bne drawMaxHealth

		// ****************** DRAW PLAYER HEALTH ******************
		ldy #HEALTH_START_X

		ldx #0
		drawPlayerHealth:
			lda #HEALTH_FULL_SYMBOL
			sta (ZP_ROW_LO),y
			lda #HEALTH_FULL_SYMBOL_COLOR
			sta (ZP_ROW_COLOR_LO),y
			iny

			inx
			cpx playerHealth
			bne drawPlayerHealth

		pla
		tay
		pla
		tax

		rts


	clearItems:
		txa
		pha
		tya
		pha

		lda #0
		sta playerItems

		ldx #ITEMS_START_Y

		lda Row_LO,x
		sta ZP_ROW_COLOR_LO
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		ldy #ITEMS_START_X
		lda #ITEMS_NOT_COLLECTED_COLOR
		clearItemsColorCol:
			sta (ZP_ROW_COLOR_LO),y
			iny
			cpy #ITEMS_START_X + ITEMS_MAX
			bne clearItemsColorCol

		pla
		tay
		pla
		tax

		rts


	addItem:
		txa
		pha
		tya
		pha


		ldx #ITEMS_START_Y

		lda Row_LO,x
		sta ZP_ROW_LO
		sta ZP_ROW_COLOR_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		lda Row_Color_HI,x
		sta ZP_ROW_COLOR_HI

		lda #ITEMS_START_X
		clc
		adc itemNumber
		tay

		lda (ZP_ROW_LO),y
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		sta (ZP_ROW_COLOR_LO),y

		pla
		tay
		pla
		tax

		rts
}
