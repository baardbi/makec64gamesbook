
// -------------------------------- SPRITE MACROS --------------------------------

.macro CreateSprite(xPos,yPos,type)
{
	lda #xPos
	sta temp1
	lda #yPos
	sta temp2
	lda #type
	sta temp3

	jsr SPRITE.createSprite
}

.macro SetSpriteDirection(direction)
{
	lda #direction
	sta Sprite_Direction,x
}

.macro CheckSpriteDirection(direction)
{
	lda Sprite_Direction,x
	and #direction
	cmp #direction
}

.macro SetSpriteAnimFrame(frameNr)
{
	lda #frameNr
	sta Sprite_Anim_Frame,x
}

.macro SetSpriteAnimation(animNr,speed)
{
	lda #animNr
	sta Sprite_Anim_Type,x

	lda #speed
	sta Sprite_Anim_Speed,x
}

.macro CheckCharCollision(offsetX,offsetY)
{
	lda #offsetX
	sta spriteXoffset
	lda #offsetY
	sta spriteYoffset

	jsr COLLISION.checkCharCollision
	lda charCollision
}
