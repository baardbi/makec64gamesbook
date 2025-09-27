
// ----------------------------------- CHAR COLLISION LIBRARY -----------------------------------

CHAR_COLLISION:
{
	checkCharCollision:
		lda Sprite_Y_Pos,x
		clc
		adc spriteOffsetY
		lsr
		lsr
		lsr

		stx tempX
		tax
		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI
		ldx tempX

		lda Sprite_X_Pos,x
		clc
		adc spriteOffsetX
		lsr
		lsr
		lsr
		tay

		lda (ZP_ROW_LO),y
		sec
		sbc #64 // The first 64 chars are letters and numbers
		tay

		lda Char_Type_Table,y // Get char type
		sta charCollision
		jsr REACTION.checkCharReaction

		rts
}
