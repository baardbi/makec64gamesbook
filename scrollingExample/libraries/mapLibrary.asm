
// ---------------------- MAP LIBRARY ----------------------

MAP:
{
	scrollRight:
		lda $d016 // SCREEN_CONTROL_2
		and #%00000111
		cmp #%00000011 // Scroll bits at 3 (scrolling at the half position)
		bne dontLoadRightScreen
			// When the map has scrollen half way across the screen (4 pixels),
			// we load the next part of the map

			inc scrollX

			lda scrollX
			and #%00000001 // Bit 0 will always be either 0 or 1
			bne loadMapToScreen2_right
			loadMapToScreen1_right:
				jsr loadMap_screen_1
				jmp doneLoadingMapRight
			loadMapToScreen2_right:
				jsr loadMap_screen_2
			doneLoadingMapRight:

		dontLoadRightScreen:

		lda $d016 // SCREEN_CONTROL_2
		and #%00000111
		cmp #%00000000 // Scroll bits at 0 (scrolling at the full position)
		beq resetScrollMapLeft
			dec $d016 // SCREEN_CONTROL_2   Scroll screen 1 pixel left
			rts
		resetScrollMapLeft:

			// lda scrollX
			// and #%00000001
			// tax
			// lda Screen_Ram_HI_Table,x
			// sta SCREEN_RAM_HI

			// Reset scroll bits in $d016 to %00000111 (7)
			// That means adjusting the screen to the right
			lda $d016 // SCREEN_CONTROL_2
			ora #%00000111
			sta $d016 // SCREEN_CONTROL_2

			// Switch where screen RAM is ($0400 or $0c00)
			lda scrollX
			and #%00000001 // Bit 0 will always be either 0 or 1
			tax
			lda $d018 // SCREEN_MEMORY_SETUP
			and #%00001111
			ora Screen_Memory_Setup_Table,x
			sta $d018 // SCREEN_MEMORY_SETUP

		// Color the screen
		colorMap:
			ldy scrollX // scrollX keeps track of the map offset
			ldx #0
			colorMapCols:
				lda MAP_ROW_COLOR_0,y
				sta SCREEN_COLOR_ROW_0,x
				lda MAP_ROW_COLOR_1,y
				sta SCREEN_COLOR_ROW_1,x
				lda MAP_ROW_COLOR_2,y
				sta SCREEN_COLOR_ROW_2,x
				lda MAP_ROW_COLOR_3,y
				sta SCREEN_COLOR_ROW_3,x
				lda MAP_ROW_COLOR_4,y
				sta SCREEN_COLOR_ROW_4,x
				lda MAP_ROW_COLOR_5,y
				sta SCREEN_COLOR_ROW_5,x
				lda MAP_ROW_COLOR_6,y
				sta SCREEN_COLOR_ROW_6,x
				lda MAP_ROW_COLOR_7,y
				sta SCREEN_COLOR_ROW_7,x
				lda MAP_ROW_COLOR_8,y
				sta SCREEN_COLOR_ROW_8,x
				lda MAP_ROW_COLOR_9,y
				sta SCREEN_COLOR_ROW_9,x
				lda MAP_ROW_COLOR_10,y
				sta SCREEN_COLOR_ROW_10,x
				lda MAP_ROW_COLOR_11,y
				sta SCREEN_COLOR_ROW_11,x
				lda MAP_ROW_COLOR_12,y
				sta SCREEN_COLOR_ROW_12,x
				lda MAP_ROW_COLOR_13,y
				sta SCREEN_COLOR_ROW_13,x
				lda MAP_ROW_COLOR_14,y
				sta SCREEN_COLOR_ROW_14,x
				lda MAP_ROW_COLOR_15,y
				sta SCREEN_COLOR_ROW_15,x
				lda MAP_ROW_COLOR_16,y
				sta SCREEN_COLOR_ROW_16,x
				lda MAP_ROW_COLOR_17,y
				sta SCREEN_COLOR_ROW_17,x
				lda MAP_ROW_COLOR_18,y
				sta SCREEN_COLOR_ROW_18,x
				lda MAP_ROW_COLOR_19,y
				sta SCREEN_COLOR_ROW_19,x
				lda MAP_ROW_COLOR_20,y
				sta SCREEN_COLOR_ROW_20,x
				lda MAP_ROW_COLOR_21,y
				sta SCREEN_COLOR_ROW_21,x
				lda MAP_ROW_COLOR_22,y
				sta SCREEN_COLOR_ROW_22,x
				lda MAP_ROW_COLOR_23,y
				sta SCREEN_COLOR_ROW_23,x
				lda MAP_ROW_COLOR_24,y
				sta SCREEN_COLOR_ROW_24,x

				iny
				inx
				cpx #39 // We want to load the map with 39 columns
				beq doneLoadingMapColor
					jmp colorMapCols
				doneLoadingMapColor:
			doneScrollMapLeft:

		rts


	loadMap_screen_1:
		lda #$a0 // Sprite graphic - aeroplane 1
		sta $07f8 // Sprite pointer at $0400 RAM area

		lda #$a2 // Sprite graphic - sun
		sta $07f9 // Sprite pointer at $0400 RAM area

		ldy scrollX // scrollX keeps track of the map offset
		ldx #0
		loadMapCols_screen_1:
			lda MAP_ROW_0,y
			sta SCREEN_RAM_1_ROW_0,x
			lda MAP_ROW_1,y
			sta SCREEN_RAM_1_ROW_1,x
			lda MAP_ROW_2,y
			sta SCREEN_RAM_1_ROW_2,x
			lda MAP_ROW_3,y
			sta SCREEN_RAM_1_ROW_3,x
			lda MAP_ROW_4,y
			sta SCREEN_RAM_1_ROW_4,x
			lda MAP_ROW_5,y
			sta SCREEN_RAM_1_ROW_5,x
			lda MAP_ROW_6,y
			sta SCREEN_RAM_1_ROW_6,x
			lda MAP_ROW_7,y
			sta SCREEN_RAM_1_ROW_7,x
			lda MAP_ROW_8,y
			sta SCREEN_RAM_1_ROW_8,x
			lda MAP_ROW_9,y
			sta SCREEN_RAM_1_ROW_9,x
			lda MAP_ROW_10,y
			sta SCREEN_RAM_1_ROW_10,x
			lda MAP_ROW_11,y
			sta SCREEN_RAM_1_ROW_11,x
			lda MAP_ROW_12,y
			sta SCREEN_RAM_1_ROW_12,x
			lda MAP_ROW_13,y
			sta SCREEN_RAM_1_ROW_13,x
			lda MAP_ROW_14,y
			sta SCREEN_RAM_1_ROW_14,x
			lda MAP_ROW_15,y
			sta SCREEN_RAM_1_ROW_15,x
			lda MAP_ROW_16,y
			sta SCREEN_RAM_1_ROW_16,x
			lda MAP_ROW_17,y
			sta SCREEN_RAM_1_ROW_17,x
			lda MAP_ROW_18,y
			sta SCREEN_RAM_1_ROW_18,x
			lda MAP_ROW_19,y
			sta SCREEN_RAM_1_ROW_19,x
			lda MAP_ROW_20,y
			sta SCREEN_RAM_1_ROW_20,x
			lda MAP_ROW_21,y
			sta SCREEN_RAM_1_ROW_21,x
			lda MAP_ROW_22,y
			sta SCREEN_RAM_1_ROW_22,x
			lda MAP_ROW_23,y
			sta SCREEN_RAM_1_ROW_23,x
			lda MAP_ROW_24,y
			sta SCREEN_RAM_1_ROW_24,x

			iny
			inx
			cpx #39 // We want to load the map with 39 columns
			beq doneLoadingMap_screen_1
				jmp loadMapCols_screen_1
			doneLoadingMap_screen_1:
				rts

	loadMap_screen_2:
		lda #$a1 // Sprite graphic - aeroplane 2
		sta $0ff8 // Sprite pointer at $0c00 RAM area

		lda #$a2 // Sprite graphic - sun
		sta $0ff9 // Sprite pointer at $0c00 RAM area

		ldy scrollX // scrollX keeps track of the map offset
		ldx #0
		loadMapCols_screen_2:
			lda MAP_ROW_0,y
			sta SCREEN_RAM_2_ROW_0,x
			lda MAP_ROW_1,y
			sta SCREEN_RAM_2_ROW_1,x
			lda MAP_ROW_2,y
			sta SCREEN_RAM_2_ROW_2,x
			lda MAP_ROW_3,y
			sta SCREEN_RAM_2_ROW_3,x
			lda MAP_ROW_4,y
			sta SCREEN_RAM_2_ROW_4,x
			lda MAP_ROW_5,y
			sta SCREEN_RAM_2_ROW_5,x
			lda MAP_ROW_6,y
			sta SCREEN_RAM_2_ROW_6,x
			lda MAP_ROW_7,y
			sta SCREEN_RAM_2_ROW_7,x
			lda MAP_ROW_8,y
			sta SCREEN_RAM_2_ROW_8,x
			lda MAP_ROW_9,y
			sta SCREEN_RAM_2_ROW_9,x
			lda MAP_ROW_10,y
			sta SCREEN_RAM_2_ROW_10,x
			lda MAP_ROW_11,y
			sta SCREEN_RAM_2_ROW_11,x
			lda MAP_ROW_12,y
			sta SCREEN_RAM_2_ROW_12,x
			lda MAP_ROW_13,y
			sta SCREEN_RAM_2_ROW_13,x
			lda MAP_ROW_14,y
			sta SCREEN_RAM_2_ROW_14,x
			lda MAP_ROW_15,y
			sta SCREEN_RAM_2_ROW_15,x
			lda MAP_ROW_16,y
			sta SCREEN_RAM_2_ROW_16,x
			lda MAP_ROW_17,y
			sta SCREEN_RAM_2_ROW_17,x
			lda MAP_ROW_18,y
			sta SCREEN_RAM_2_ROW_18,x
			lda MAP_ROW_19,y
			sta SCREEN_RAM_2_ROW_19,x
			lda MAP_ROW_20,y
			sta SCREEN_RAM_2_ROW_20,x
			lda MAP_ROW_21,y
			sta SCREEN_RAM_2_ROW_21,x
			lda MAP_ROW_22,y
			sta SCREEN_RAM_2_ROW_22,x
			lda MAP_ROW_23,y
			sta SCREEN_RAM_2_ROW_23,x
			lda MAP_ROW_24,y
			sta SCREEN_RAM_2_ROW_24,x

			iny
			inx
			cpx #39 // We want to load the map with 39 columns
			beq doneLoadingMap_screen_2
				jmp loadMapCols_screen_2
			doneLoadingMap_screen_2:
				rts
}
