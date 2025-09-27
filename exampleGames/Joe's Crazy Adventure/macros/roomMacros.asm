
// ----------------------------------- ROOM MACROS -----------------------------------

.macro SetRoomStatus(status)
{
	lda #status
	sta roomStatus
}

.macro CheckRoomStatus(status)
{
	lda roomStatus
	cmp #status
}

.macro LoadCharMap(charMap,startX,startY,width,height)
{
	lda #<charMap
	sta ZP_ROOM_LO
	lda #>charMap
	sta ZP_ROOM_HI

	lda #startX
	sta charMapStartX
	lda #startY
	sta charMapStartY
	lda #width
	sta charMapWidth
	lda #height
	sta charMapHeight

	jsr ROOM.loadCharMap
}
