
// -------------------------------- INPUT LIBRARY --------------------------------

INPUT:
{
	readJoystick_2:
		ldx #0 // Player sprite

		lda JOYSTICK_2
		cmp #JOY_2_IDLE
		beq joy2idle
			jmp notJoy2idle
		joy2idle:
			lda Sprite_Direction,x
			and #%11110000
			sta Sprite_Direction,x
			cmp #FACE_UP
			bne notIdleUp
				lda #ANIM_PLAYER_IDLE_UP
				jmp setIdleAnimation
			notIdleUp:
			cmp #FACE_DOWN
			bne notIdleDown
				lda #ANIM_PLAYER_IDLE_DOWN
				jmp setIdleAnimation
			notIdleDown:
			cmp #FACE_LEFT
			bne notIdleLeft
				lda #ANIM_PLAYER_IDLE_LEFT
				jmp setIdleAnimation
			notIdleLeft:
			cmp #FACE_RIGHT
			bne notIdleRight
				lda #ANIM_PLAYER_IDLE_RIGHT
				jmp setIdleAnimation
			notIdleRight:

			setIdleAnimation:
				sta Sprite_Anim_Type,x
				lda #0
				sta Sprite_Anim_Speed,x
				sta Sprite_Anim_Timer,x
				jmp doneReadJoystick2
		notJoy2idle:
		
		lda JOYSTICK_2
		cmp #JOY_2_UP
		beq joy2up
			jmp notJoy2up
		joy2up:
			SetSpriteAnimation(ANIM_PLAYER_WALK_UP,10)
			SetSpriteDirection(UP + FACE_UP)
		notJoy2up:

		lda JOYSTICK_2
		cmp #JOY_2_DOWN
		beq joy2down
			jmp notJoy2down
		joy2down:
			SetSpriteAnimation(ANIM_PLAYER_WALK_DOWN,10)
			SetSpriteDirection(DOWN + FACE_DOWN)
		notJoy2down:

		lda JOYSTICK_2
		cmp #JOY_2_LEFT
		beq joy2left
			jmp notJoy2left
		joy2left:
			SetSpriteAnimation(ANIM_PLAYER_WALK_LEFT,10)
			SetSpriteDirection(LEFT + FACE_LEFT)
		notJoy2left:

		lda JOYSTICK_2
		cmp #JOY_2_RIGHT
		beq joy2right
			jmp notJoy2right
		joy2right:
			SetSpriteAnimation(ANIM_PLAYER_WALK_RIGHT,10)
			SetSpriteDirection(RIGHT + FACE_RIGHT)
		notJoy2right:

		lda JOYSTICK_2
		cmp #JOY_2_UP_LEFT
		beq joy2upLeft
			jmp notJoy2upLeft
		joy2upLeft:
			SetSpriteAnimation(ANIM_PLAYER_WALK_LEFT,10)
			SetSpriteDirection(UP_LEFT + FACE_UP_LEFT)
		notJoy2upLeft:

		lda JOYSTICK_2
		cmp #JOY_2_UP_RIGHT
		beq joy2upRight
			jmp notJoy2upRight
		joy2upRight:
			SetSpriteAnimation(ANIM_PLAYER_WALK_RIGHT,10)
			SetSpriteDirection(UP_RIGHT + FACE_UP_RIGHT)
		notJoy2upRight:

		lda JOYSTICK_2
		cmp #JOY_2_DOWN_LEFT
		beq joy2downLeft
			jmp notJoy2downLeft
		joy2downLeft:
			SetSpriteAnimation(ANIM_PLAYER_WALK_LEFT,10)
			SetSpriteDirection(DOWN_LEFT + FACE_DOWN_LEFT)
		notJoy2downLeft:

		lda JOYSTICK_2
		cmp #JOY_2_DOWN_RIGHT
		beq joy2downRight
			jmp notJoy2downRight
		joy2downRight:
			SetSpriteAnimation(ANIM_PLAYER_WALK_RIGHT,10)
			SetSpriteDirection(DOWN_RIGHT + FACE_DOWN_RIGHT)
		notJoy2downRight:

		lda JOYSTICK_2
		cmp #JOY_2_FIRE
		beq joy2fire
			jmp notJoy2fire
		joy2fire:
			lda Sprite_Direction,x
			and #%11110000
			sta Sprite_Direction,x
			cmp #FACE_UP
			bne notAttackUp
				lda Sprite_X_Pos,x
				sta tempA
				lda Sprite_Y_Pos,x
				sec
				sbc #SPRITE_HEIGHT
				sta tempB

				lda #ANIM_SWORD_UP
				sta tempC

				lda #ANIM_PLAYER_ATTACK_UP
				jmp setAttackAnimation
			notAttackUp:
			cmp #FACE_DOWN
			bne notAttackDown
				lda Sprite_X_Pos,x
				sta tempA
				lda Sprite_Y_Pos,x
				clc
				adc #SPRITE_HEIGHT
				sta tempB

				lda #ANIM_SWORD_DOWN
				sta tempC

				lda #ANIM_PLAYER_ATTACK_DOWN
				jmp setAttackAnimation
			notAttackDown:
			cmp #FACE_LEFT
			bne notAttackLeft
				lda Sprite_X_Pos,x
				sec
				sbc #SPRITE_WIDTH
				sta tempA
				lda Sprite_Y_Pos,x
				sta tempB

				lda #ANIM_SWORD_LEFT
				sta tempC

				lda #ANIM_PLAYER_ATTACK_LEFT
				jmp setAttackAnimation
			notAttackLeft:
			cmp #FACE_RIGHT
			bne notAttackRight
				lda Sprite_X_Pos,x
				clc
				adc #SPRITE_WIDTH
				sta tempA
				lda Sprite_Y_Pos,x
				sta tempB

				lda #ANIM_SWORD_RIGHT
				sta tempC

				lda #ANIM_PLAYER_ATTACK_RIGHT
				jmp setAttackAnimation
			notAttackRight:

			setAttackAnimation:
				sta Sprite_Anim_Type,x
				lda #0
				sta Sprite_Anim_Speed,x
				sta Sprite_Anim_Timer,x

				lda tempA
				sta temp1
				lda tempB
				sta temp2
				lda #SPRITE_SWORD
				sta temp3

				jsr SPRITE.createSprite

				txa
				pha

				ldx newSpriteNr
				lda tempC
				sta Sprite_Anim_Type,x
				jsr SPRITE.manualUpdateSpriteAnimFrame

				pla
				tax
		notJoy2fire:

		doneReadJoystick2:
			rts
}
