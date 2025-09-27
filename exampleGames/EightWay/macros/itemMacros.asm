
// -------------------------------- ITEM MACROS --------------------------------

.macro AddItem(itemNr)
{
	lda #itemNr
	sta itemNumber

	jsr HUD.addItem
	jsr ITEM.addItem
}
