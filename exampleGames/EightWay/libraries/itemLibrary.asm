
// -------------------------------- ITEM LIBRARY --------------------------------

ITEM:
{
	addItem:
		ldy itemNumber
		lda playerItems
		ora Items_Table,y
		sta playerItems

		lda itemNumber

		cmp #0 // Item 0 - Map
		bne notItem0
			jsr HUD.showMapLabel
			jsr HUD.manualUpdateMapPos
			rts
		notItem0:

		cmp #1 // Item 1 - Flippers
		bne notItem1
			rts
		notItem1:

		cmp #2 // Item 2 - Crystal
		bne notItem2
			rts
		notItem2:

		cmp #3 // Item 3 - Key
		bne notItem3
			rts
		notItem3:

		cmp #4 // Item 4 - Dynamite
		bne notItem4
			rts
		notItem4:

		cmp #5 // Item 5 - Pear
		bne notItem5
			rts
		notItem5:

			rts
}
