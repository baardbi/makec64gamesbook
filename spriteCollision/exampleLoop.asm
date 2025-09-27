ldy #1 // Skip 0 since that's the player sprite
spriteSpriteCollisionLoop:
		lda Sprite_Y_Pos,x // Players Y position UP
		sec
		sbc #SPRITE_OFFSET_UP
		sta spriteCollisionUp

		lda Sprite_Y_Pos,x // Players Y position DOWN
		clc
		adc #SPRITE_OFFSET_DOWN
		sta spriteCollisionDown

		lda Sprite_X_Pos,x // Players X position LEFT
		sec
		sbc #SPRITE_OFFSET_LEFT
		sta spriteCollisionLeft

		lda Sprite_X_Pos,x // Players X position RIGHT
		clc
		adc #SPRITE_OFFSET_RIGHT
		sta spriteCollisionRight

		lda Sprite_Y_Pos,y // Other sprites X position
		cmp spriteCollisionUp
		bcc noCollision
		cmp spriteCollisionDown
		bcs noCollision
		lda Sprite_X_Pos,y // Other sprites Y position
		cmp spriteCollisionLeft
		bcc noCollision
		cmp spriteCollisionRight
		bcs noCollision
	collision:
		jsr REACTION.spriteSpriteCollision
		jmp doneHandleSpriteSpriteCollision
noCollision:
	iny
	cpy #MAX_NUMBER_OF_SPRITES
	bne spriteSpriteCollisionLoop
