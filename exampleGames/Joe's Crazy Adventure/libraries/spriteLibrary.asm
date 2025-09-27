
// ----------------------------------- SPRITE LIBRARY -----------------------------------

SPRITE:
{
	createSprite:
		txa
		pha
		tya
		pha

		ldx #0
		createSpriteLoop:
			lda SPRITE_ENABLE
			and Sprite_Binary,x
			beq emptySpriteSlotFound
				jmp checkNextSpriteSlot
			emptySpriteSlotFound:
				stx tempX

				lda spriteX
				bne doCreateThisSprite
					jmp doneCreateSprite // If sprite X pos is 0 then skip create sprite
				doCreateThisSprite:
					sta Sprite_X_Pos,x

					lda spriteY
					sta Sprite_Y_Pos,x

					ldx spriteType
					lda Sprite_Type_LO,x
					sta ZP_SPRITE_TYPE_LO
					lda Sprite_Type_HI,x
					sta ZP_SPRITE_TYPE_HI

					ldx tempX

					ldy #0
					
					lda (ZP_SPRITE_TYPE_LO),y
					sta Sprite_Flags,x
					iny
					lda (ZP_SPRITE_TYPE_LO),y
					sta Sprite_V_Speed,x
					iny
					lda (ZP_SPRITE_TYPE_LO),y
					sta Sprite_H_Speed,x
					iny
					lda (ZP_SPRITE_TYPE_LO),y
					sta Sprite_Jump_Strength,x
					iny
					lda (ZP_SPRITE_TYPE_LO),y
					sta SPRITE_COLOR,x
					iny
					lda (ZP_SPRITE_TYPE_LO),y
					sta Sprite_Edge_Reaction,x
					iny
					lda (ZP_SPRITE_TYPE_LO),y
					sta Sprite_Solid_Reaction,x
					iny
					lda (ZP_SPRITE_TYPE_LO),y
					sta Sprite_Action,x

					lda SPRITE_X_EXTENDED
					and Sprite_Binary_0,x
					sta SPRITE_X_EXTENDED

					lda Sprite_X_Pos,x
					clc
					adc #24 // Default C64 sprite offset X
					sta tempXpos

					lda Sprite_Y_Pos,x
					clc
					adc #50 // Default C64 sprite offset Y
					sta tempYpos

					txa
					pha
					asl
					tax

					lda tempXpos
					sta SPRITE_X,x

					lda tempYpos
					sta SPRITE_Y,x

					pla
					tax

					lda Sprite_Anim_Graphic,x
					clc
					adc #SPRITE_POINTER_INDEX
					sta SPRITE_POINTER,x

					lda SPRITE_ENABLE
					ora Sprite_Binary,x
					sta SPRITE_ENABLE

					jmp doneCreateSprite

			checkNextSpriteSlot:
				inx
				cpx #MAX_NUMBER_OF_SPRITES
				beq doneCreateSprite
					jmp createSpriteLoop

			doneCreateSprite:
				pla
				tay
				pla
				tax
				rts


	handleSprites:
		ldx #0
		handleSpritesLoop:
			// ***************** Handle sprite action *****************
			handleSpriteAction:
				lda Sprite_Flags,x
				and #SPRITE_PLAYER
				bne doneHandleSpriteAction // This does not apply to the player sprite
					jsr ACTION.checkSpriteActionNumber
			doneHandleSpriteAction:

			// ***************** Handle sprite movement *****************
			handleSpriteMovement:

			checkSpriteVspeedTimer:
				lda Sprite_V_Speed_Timer,x
				cmp Sprite_V_Speed,x
				beq spriteVspeedTimerReached
					inc Sprite_V_Speed_Timer,x
					jmp checkSpriteHspeedTimer
				spriteVspeedTimerReached:
					lda #0
					sta Sprite_V_Speed_Timer,x

			checkUpDirection:
				lda Sprite_Direction,x
				and #UP
				bne moveSpriteUp
					jmp checkDownDirection
				moveSpriteUp:
					CheckCharCollision(SPRITE_OFFSET_UP_LEFT,SPRITE_OFFSET_UP)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionUp
					CheckCharCollision(SPRITE_OFFSET_UP_CENTER,SPRITE_OFFSET_UP)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionUp
					CheckCharCollision(SPRITE_OFFSET_UP_RIGHT,SPRITE_OFFSET_UP)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionUp
						lda Sprite_Jump_Timer,x
						cmp Sprite_Jump_Strength,x
						bcs solidCollisionUp
							dec Sprite_Y_Pos,x
							inc Sprite_Jump_Timer,x
							jmp checkDownDirection
					solidCollisionUp:
						ClearSpriteDirection(UP)

			checkDownDirection:
				lda Sprite_Direction,x
				and #DOWN
				bne moveSpriteDown
					jmp checkSpriteHspeedTimer
				moveSpriteDown:
					CheckCharCollision(SPRITE_OFFSET_DOWN_LEFT,SPRITE_OFFSET_DOWN)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionDown
					cmp #CHAR_JUMP_THROUGH
					beq solidCollisionDown
					CheckCharCollision(SPRITE_OFFSET_DOWN_CENTER,SPRITE_OFFSET_DOWN)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionDown
					cmp #CHAR_JUMP_THROUGH
					beq solidCollisionDown
					CheckCharCollision(SPRITE_OFFSET_DOWN_RIGHT,SPRITE_OFFSET_DOWN)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionDown
					cmp #CHAR_JUMP_THROUGH
					beq solidCollisionDown
						inc Sprite_Y_Pos,x

						lda Sprite_Flags,x
						ora #SPRITE_FALLING
						sta Sprite_Flags,x
						jmp checkSpriteHspeedTimer
					solidCollisionDown:
						lda #0 // Reset sprite jump timer
						sta Sprite_Jump_Timer,x

						lda Sprite_Flags,x
						and #%11111111 - SPRITE_FALLING
						sta Sprite_Flags,x

			checkSpriteHspeedTimer:

				// If sprite has 0 H speed we skip this part
				lda Sprite_H_Speed,x
				bne spriteHasHorizontalSpeed
					jmp doneHandleSpriteMovement
				spriteHasHorizontalSpeed:

				lda Sprite_H_Speed_Timer,x
				cmp Sprite_H_Speed,x
				beq spriteHspeedTimerReached
					inc Sprite_H_Speed_Timer,x
					jmp doneHandleSpriteMovement
				spriteHspeedTimerReached:
					lda #0
					sta Sprite_H_Speed_Timer,x

			checkLeftDirection:
				lda Sprite_Direction,x
				and #LEFT
				bne moveSpriteLeft
					jmp checkRightDirection
				moveSpriteLeft:
					CheckCharCollision(SPRITE_OFFSET_LEFT,SPRITE_OFFSET_LEFT_UP)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionLeft
					CheckCharCollision(SPRITE_OFFSET_LEFT,SPRITE_OFFSET_LEFT_CENTER)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionLeft
					CheckCharCollision(SPRITE_OFFSET_LEFT,SPRITE_OFFSET_LEFT_DOWN)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionLeft
						dec Sprite_X_Pos,x
						jmp checkRightDirection
					solidCollisionLeft:
						jsr REACTION.checkSolidReaction

			checkRightDirection:
				lda Sprite_Direction,x
				and #RIGHT
				bne moveSpriteRight
					jmp doneHandleSpriteMovement
				moveSpriteRight:
					CheckCharCollision(SPRITE_OFFSET_RIGHT,SPRITE_OFFSET_RIGHT_UP)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionRight
					CheckCharCollision(SPRITE_OFFSET_RIGHT,SPRITE_OFFSET_RIGHT_CENTER)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionRight
					CheckCharCollision(SPRITE_OFFSET_RIGHT,SPRITE_OFFSET_RIGHT_DOWN)
					lda charCollision
					cmp #CHAR_SOLID
					beq solidCollisionRight
						inc Sprite_X_Pos,x
						jmp doneHandleSpriteMovement
					solidCollisionRight:
						jsr REACTION.checkSolidReaction

			doneHandleSpriteMovement:

			// ***************** Handle sprite-sprite collision *****************
			handleSpriteSpriteCollision:
				lda Sprite_Flags,x
				and #SPRITE_FLAG_PLAYER // Only handle sprite-sprite collision for the player sprite
				beq doneHandleSpriteSpriteCollision
					stx selfSprite

					ldy #1 // Skip sprite 0 since we know that's the player sprite
					spriteSpriteCollisionLoop:
						lda SPRITE_ENABLE
						and Sprite_Binary,y
						beq noCollision
							sty otherSprite

							lda Sprite_Y_Pos,x // Players Y position UP
							sec
							sbc #PLAYER_HITBOX_UP // Defined in the config file
							sta spriteCollisionUp

							lda Sprite_Y_Pos,x // Players Y position DOWN
							clc
							adc #PLAYER_HITBOX_DOWN // Defined in the config file
							sta spriteCollisionDown

							lda Sprite_X_Pos,x // Players X position LEFT
							sec
							sbc #PLAYER_HITBOX_LEFT // Defined in the config file
							sta spriteCollisionLeft

							lda Sprite_X_Pos,x // Players X position RIGHT
							clc
							adc #PLAYER_HITBOX_RIGHT // Defined in the config file
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
							jsr REACTION.checkSpriteCollisionReaction
							jmp doneHandleSpriteSpriteCollision
					noCollision:
						iny
						cpy #MAX_NUMBER_OF_SPRITES
						bne spriteSpriteCollisionLoop

			doneHandleSpriteSpriteCollision:

			// ***************** Handle sprite edge detection *****************
			handleSpriteEdgeDetection:
				lda Sprite_Y_Pos,x
				cmp #ROOM_TOP_EDGE
				beq spriteAtTopEdge
				cmp #ROOM_BOTTOM_EDGE
				beq spriteAtBottomEdge

				lda Sprite_X_Pos,x
				cmp #ROOM_LEFT_EDGE
				beq spriteAtLeftEdge
				cmp #ROOM_RIGHT_EDGE
				beq spriteAtRightEdge
					jmp doneHandleSpriteEdgeDetection // Sprite not at an edge

				spriteAtTopEdge:
					lda #UP
					sta spriteEdge
					jmp checkSpriteEdgeReaction

				spriteAtBottomEdge:
					lda #DOWN
					sta spriteEdge
					jmp checkSpriteEdgeReaction

				spriteAtLeftEdge:
					lda #LEFT
					sta spriteEdge
					jmp checkSpriteEdgeReaction

				spriteAtRightEdge:
					lda #RIGHT
					sta spriteEdge

				checkSpriteEdgeReaction:
					jsr REACTION.checkEdgeReaction

			doneHandleSpriteEdgeDetection:

			// ***************** Handle gravity *****************
			handleGravity:

			lda Sprite_Flags,x
			and #SPRITE_FLAG_IGNORE_GRAVITY
			bne doneHandleGravity

			CheckSpriteDirection(UP)
			beq skipGravity
				SetSpriteDirection(DOWN)
				jmp doneHandleGravity
			skipGravity:
				ClearSpriteDirection(DOWN)
			doneHandleGravity:

			// ***************** Handle sprite animation *****************
			handleSpriteAnimation:

			// Has animation changed?
			lda Sprite_Current_Anim_Type,x
			cmp Sprite_Previous_Anim_Type,x
			beq sameAnimationDontResetAnim
				lda #0
				sta Sprite_Anim_Frame,x
				sta Sprite_Anim_Speed_Timer,x

				// Update previous animation type
				lda Sprite_Current_Anim_Type,x
				sta Sprite_Previous_Anim_Type,x
			sameAnimationDontResetAnim:

			checkSpriteAnimTimer:
				lda Sprite_Anim_Speed_Timer,x
				cmp Sprite_Anim_Speed,x
				beq spriteAnimTimerReached
					inc Sprite_Anim_Speed_Timer,x
					jmp doneHandleSpriteAnimation
				spriteAnimTimerReached:
					lda #0
					sta Sprite_Anim_Speed_Timer,x

					lda Sprite_Current_Anim_Type,x
					tay
					lda Anim_Type_LO,y
					sta ZP_ANIM_LO
					lda Anim_Type_HI,y
					sta ZP_ANIM_HI

					lda Sprite_Anim_Frame,x
					tay
					lda (ZP_ANIM_LO),y
					cmp #255 // Code for "End of animation"
					bne !notEndOfAnimation+
						lda #0
						sta Sprite_Anim_Frame,x
						tay
						lda (ZP_ANIM_LO),y
					!notEndOfAnimation:
						sta Sprite_Anim_Graphic,x

						inc Sprite_Anim_Frame,x

			doneHandleSpriteAnimation:

	nextSpriteToHandle:
		inx
		cpx #MAX_NUMBER_OF_SPRITES
		beq doneHandleSprites
			jmp handleSpritesLoop
		doneHandleSprites:
			rts


setSpriteAnimFrameManually:
	lda Sprite_Current_Anim_Type,x
	tay
	lda Anim_Type_LO,y
	sta ZP_ANIM_LO
	lda Anim_Type_HI,y
	sta ZP_ANIM_HI

	ldy #0 // First animation frame
	lda (ZP_ANIM_LO),y
	sta Sprite_Anim_Graphic,x
	rts


	updateSpriteRegisters:
		CheckRoomStatus(ROOM_LOADING)
		bne doUpdateSpriteRegisters
			jmp doneUpdateSpriteRegisters // Don't update sprite registers if a room is loading
		doUpdateSpriteRegisters:

		ldx #0
		updateSpriteRegistersLoop:
			// ***************** Update sprite X and Y registers *****************
			updateSprite_X_Y_Registers:

			lda Sprite_X_Pos,x
			clc
			adc #24 // Default C64 sprite offset X
			sta tempXpos

			lda Sprite_Y_Pos,x
			clc
			adc #50 // Default C64 sprite offset Y
			sta tempYpos

			txa
			pha
			asl
			tax

			lda tempXpos
			sta SPRITE_X,x

			lda tempYpos
			sta SPRITE_Y,x

			pla
			tax

			doneUpdateSprite_X_Y_Registers:

			// ***************** Update sprite pointer *****************
			updateSpritePointer:

				lda Sprite_Anim_Graphic,x
				clc
				adc #SPRITE_POINTER_INDEX
				sta SPRITE_POINTER,x

			doneUpdateSpritePointer:

		nextSpriteToUpdateRegisters:
			inx
			cpx #MAX_NUMBER_OF_SPRITES
			beq doneUpdateSpriteRegisters
				jmp updateSpriteRegistersLoop

			doneUpdateSpriteRegisters:
				rts
}
