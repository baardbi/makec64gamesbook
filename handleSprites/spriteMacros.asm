.macro SetSpriteDirection(direction)
{
	lda Sprite_Direction,x
	ora #direction
	sta Sprite_Direction,x
}

.macro CheckSpriteDirection(direction)
{
	lda Sprite_Direction,x
	and #direction
	cmp #direction
}

.macro ClearSpriteDirection(direction)
{
	lda Sprite_Direction,x
	and #%11111111 - direction
	sta Sprite_Direction,x
}

.macro AnimateSprite(animationType,speed)
{
	lda #animationType
	sta Sprite_Anim_Type,x

	lda #speed
	sta Sprite_Anim_Speed,x
}

.macro CheckCharCollision(offsetX,offsetY)
{
	lda #offsetX
	sta spriteOffsetX
	lda #offsetY
	sta spriteOffsetY

	jsr CHAR_COLLISION.checkCharCollision
}
