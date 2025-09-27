moveSprite:

checkSpriteVspeedTimer:
	lda Sprite_V_Speed_Timer,x
	cmp Sprite_V_Speed,x
	beq spriteVtimerReached
		inc Sprite_V_Speed_Timer,x
		jmp checkSpriteHspeedTimer
	spriteVtimerReached:
		lda #0
		sta Sprite_V_Speed_Timer,x


checkSpriteUpDirection:
	CheckSpriteDirection(UP)  // Is the UP bit set?
	beq moveSpriteUp              // If it is, then move sprite UP
		jmp doneCheckSpriteUpDirection
	moveSpriteUp:

	CheckCharCollision(OFFSET_UP_LEFT,OFFSET_UP)
	cmp #CHAR_SOLID
	beq solidCollisionUp
				
CheckCharCollision(OFFSET_UP_CENTER,OFFSET_UP)
	cmp #CHAR_SOLID
	beq solidCollisionUp
			
CheckCharCollision(OFFSET_UP_RIGHT,OFFSET_UP)
	cmp #CHAR_SOLID
	beq solidCollisionUp
		dec Sprite_Y_Pos,x
		jmp doneCheckSpriteUpDirection
	solidCollisionUp:
		jsr REACTION.solidReaction
	doneCheckSpriteUpDirection:


checkSpriteDownDirection:
	CheckSpriteDirection(DOWN)  // Is the DOWN bit set?
	beq moveSpriteDown        // If it is, then move sprite DOWN
		jmp doneCheckSpriteDownDirection
	moveSpriteDown:
		CheckCharCollision(OFFSET_DOWN_LEFT,OFFSET_DOWN)
	cmp #CHAR_SOLID
	beq solidCollisionDown
		CheckCharCollision(OFFSET_DOWN_CENTER,OFFSET_DOWN)
	cmp #CHAR_SOLID
	beq solidCollisionDown
		CheckCharCollision(OFFSET_DOWN_RIGHT,OFFSET_DOWN)
	cmp #CHAR_SOLID
	beq solidCollisionDown
		inc Sprite_Y_Pos,x
		jmp doneCheckSpriteDownDirection
	solidCollisionDown:
		jsr REACTION.solidReaction
	doneCheckSpriteDownDirection:


checkSpriteHspeedTimer:
	lda Sprite_H_Speed_Timer,x
	cmp Sprite_H_Speed,x
	beq spriteHtimerReached
		inc Sprite_H_Speed_Timer,x
		jmp doneMoveSprite
	spriteHtimerReached: 
		lda #0
		sta Sprite_H_Speed_Timer,x


checkSpriteLeftDirection:
	CheckSpriteDirection(LEFT) // Is the LEFT bit set?
	beq moveSpriteLeft              // If it is, then move sprite LEFT
		jmp doneCheckSpriteLeftDirection
	moveSpriteLeft:
		CheckCharCollision(OFFSET_LEFT,OFFSET_LEFT_UP)
	cmp #CHAR_SOLID
	beq solidCollisionLeft
		CheckCharCollision(OFFSET_LEFT,OFFSET_LEFT_CENTER)
	cmp #CHAR_SOLID
	beq solidCollisionLeft
		CheckCharCollision(OFFSET_LEFT,OFFSET_LEFT_DOWN)
	cmp #CHAR_SOLID
	beq solidCollisionLeft
		dec Sprite_X_Pos,x
		jmp doneCheckSpriteLeftDirection
	solidCollisionLeft:
		jsr REACTION.solidReaction
	doneCheckSpriteLeftDirection:


checkSpriteRightDirection:
	CheckSpriteDirection(RIGHT)
	beq moveSpriteRight
		jmp doneCheckSpriteRightDirection
	moveSpriteRight:
		CheckCharCollision(OFFSET_RIGHT,OFFSET_RIGHT_UP)
	cmp #CHAR_SOLID
	beq solidCollisionRight
		CheckCharCollision(OFFSET_RIGHT,OFFSET_RIGHT_CENTER)
	cmp #CHAR_SOLID
	beq solidCollisionRight
		CheckCharCollision(OFFSET_RIGHT,OFFSET_RIGHT_DOWN)
	cmp #CHAR_SOLID
	beq solidCollisionRight
		inc Sprite_X_Pos,x
		jmp doneCheckSpriteRightDirection
	solidCollisionRight:
		jsr REACTION.solidReaction
	doneCheckSpriteRightDirection:

doneMoveSprite:
