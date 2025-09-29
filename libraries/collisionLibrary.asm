COLLISION:
{
	checkCharCollision:
		txa
		pha
		tya
		pha

		stx tempX

		lda Sprite_Y_Pos,x
		clc
		adc spriteYoffset
		lsr
		lsr
		lsr
		tax

		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldx tempX

		lda Sprite_X_Pos,x
		clc
		adc spriteXoffset
		lsr
		lsr
		lsr
		tay

		lda (ZP_ROW_LO),y
		tax
		lda CHARSET_ATTRIB_ADDRESS,x
		and #%11110000
		lsr
		lsr
		lsr
		lsr
		sta charCollision
		
		pla
		tay
		pla
		tax

		jsr REACTION.charReaction

		rts
}
