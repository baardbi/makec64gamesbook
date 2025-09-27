
// ----------------------------------- INPUT LIBRARY -----------------------------------

INPUT:
{
	readJoystick_2:
		ldx #0 // Player is sprite 0

		lda JOYSTICK_2
		cmp #JOY_2_IDLE
		bne joy2notIdle
			CheckSpriteDirection(FACE_LEFT)
			beq setIdleLeftAnim
				AnimateSprite(ANIM_PLAYER_IDLE_RIGHT,0)
				jmp skipSetIdleState
			setIdleLeftAnim:
				AnimateSprite(ANIM_PLAYER_IDLE_LEFT,0)
		skipSetIdleState:
			ClearSpriteDirection(UP + LEFT + RIGHT)
			jmp doneReadJoystick_2
		joy2notIdle:

			checkJoy2up:
				lda JOYSTICK_2
				and #JOY_UP
				beq joy2up
					ClearSpriteDirection(UP)
					jmp checkJoy2down
				joy2up:
					lda Sprite_Flags,x
					and #SPRITE_FALLING
					bne skipJump
						lda Sprite_Jump_Timer,x
						cmp Sprite_Jump_Strength,x
						beq skipJump
							SetSpriteDirection(UP)

							CheckSpriteDirection(FACE_LEFT)
							beq setJumpLeftAnim
								AnimateSprite(ANIM_PLAYER_JUMP_RIGHT,0)
								jmp checkJoy2down
							setJumpLeftAnim:
								AnimateSprite(ANIM_PLAYER_JUMP_LEFT,0)
								jmp checkJoy2down
					skipJump:

			checkJoy2down:
				lda JOYSTICK_2
				and #JOY_DOWN
				beq joy2down
					jmp checkJoy2left
				joy2down:

			checkJoy2left:
				lda JOYSTICK_2
				and #JOY_LEFT
				beq joy2left
					ClearSpriteDirection(LEFT)
					jmp checkJoy2right
				joy2left:
					CheckSpriteDirection(UP)
					beq skipSetWalkStateLeft
						AnimateSprite(ANIM_PLAYER_WALK_LEFT,100)
						jmp setLeftDirection
					skipSetWalkStateLeft:
						AnimateSprite(ANIM_PLAYER_JUMP_LEFT,0)
					setLeftDirection:
						ClearSpriteDirection(FACE_RIGHT)
						SetSpriteDirection(LEFT + FACE_LEFT)

			checkJoy2right:
				lda JOYSTICK_2
				and #JOY_RIGHT
				beq joy2right
					ClearSpriteDirection(RIGHT)
					jmp checkJoy2fire
				joy2right:
					CheckSpriteDirection(UP)
					beq skipSetWalkStateRight
						AnimateSprite(ANIM_PLAYER_WALK_RIGHT,100)
						jmp setRightDirection
					skipSetWalkStateRight:
						AnimateSprite(ANIM_PLAYER_JUMP_RIGHT,0)
					setRightDirection:
						ClearSpriteDirection(FACE_LEFT)
						SetSpriteDirection(RIGHT + FACE_RIGHT)

			checkJoy2fire:
				lda JOYSTICK_2
				and #JOY_FIRE
				beq joy2fire
					jmp doneReadJoystick_2
				joy2fire:

		doneReadJoystick_2:
			rts
}
