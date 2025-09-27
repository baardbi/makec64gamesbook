
// -------------------------------- ROOM MACROS --------------------------------

.macro DrawCharmap(charmapAddress,startRow,endRow,startCol,endCol)
{
	lda #<charmapAddress
	sta ZP_ROOM_LO
	lda #>charmapAddress
	sta ZP_ROOM_HI

	lda #startRow
	sta charmapStartRow
	lda #endRow
	sta charmapEndRow
	lda #startCol
	sta charmapStartCol
	lda #endCol
	sta charmapEndCol

	jsr ROOM.loadCharmap
}
