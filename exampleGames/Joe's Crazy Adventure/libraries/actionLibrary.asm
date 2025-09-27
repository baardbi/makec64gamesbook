
// ----------------------------------- ACTION LIBRARY -----------------------------------

// Actions:
.label ACT_NO_ACTION = 0
.label ACT_MONSTER_MOVE = 1
.label ACT_COIN_SPIN = 2
.label ACT_DIAMOND_SPARKLE = 3

ACTION:
{
	checkSpriteActionNumber:
		lda Sprite_Action,x

		checkSpriteAction0:
			cmp #0
			bne checkSpriteAction1
				jmp spriteAction0

		checkSpriteAction1:
			cmp #1
			bne checkSpriteAction2
				jmp spriteAction1

		checkSpriteAction2:
			cmp #2
			bne checkSpriteAction3
				jmp spriteAction2

		checkSpriteAction3:
			cmp #3
			bne doneSpriteActions
				jmp spriteAction3

		doneSpriteActions:
			rts


	spriteAction0: // No action
		doneSpriteAction0:
		rts

	spriteAction1: // Monster move towards player
		stx tempX
		ldx #0 // Player sprite
		lda Sprite_X_Pos,x // Check player x position
		ldx tempX
		cmp Sprite_X_Pos,x // Compare with monster x position
		beq monsterConfused
		bcs moveSpriteRight
			ClearSpriteDirection(RIGHT)
			SetSpriteDirection(LEFT + FACE_LEFT)
			AnimateSprite(ANIM_MONSTER_WALK_LEFT,80)
			jmp doneSpriteAction1
		moveSpriteRight:
			ClearSpriteDirection(LEFT)
			SetSpriteDirection(RIGHT + FACE_RIGHT)
			AnimateSprite(ANIM_MONSTER_WALK_RIGHT,80)
			jmp doneSpriteAction1
		monsterConfused:
			ClearSpriteDirection(ALL_DIRECTIONS)
			AnimateSprite(ANIM_MONSTER_CONFUSED,160)
		doneSpriteAction1:
			rts

	spriteAction2: // Coin spin animation
		AnimateSprite(ANIM_COIN,75)
		doneSpriteAction2:
			rts

	spriteAction3: // Diamond sparkle animation
		AnimateSprite(ANIM_DIAMOND,75)
		doneSpriteAction3:
			rts
}
