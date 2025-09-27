
// -------------------------------- SPRITE LIBRARY --------------------------------

SPRITE:
{
	// ============================================ HANDLE SPRITES ============================================
	handleSprites:
		ldx #0
		handleSpritesLoop:
			// ******************** Move sprite ********************

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
				CheckSpriteDirection(UP)
				beq moveSpriteUp
					jmp doneCheckSpriteUpDirection
				moveSpriteUp:
					CheckCharCollision(SPRITE_OFFSET_UP_LEFT,SPRITE_OFFSET_UP)
					cmp #CHAR_SOLID
					beq solidCollisionUp
					CheckCharCollision(SPRITE_OFFSET_UP_CENTER,SPRITE_OFFSET_UP)
					cmp #CHAR_SOLID
					beq solidCollisionUp
					CheckCharCollision(SPRITE_OFFSET_UP_RIGHT,SPRITE_OFFSET_UP)
					cmp #CHAR_SOLID
					beq solidCollisionUp
						dec Sprite_Y_Pos,x
						jmp doneCheckSpriteUpDirection
					solidCollisionUp:
						jsr REACTION.solidReaction
				doneCheckSpriteUpDirection:

			checkSpriteDownDirection:
				CheckSpriteDirection(DOWN)
				beq moveSpriteDown
					jmp doneCheckSpriteDownDirection
				moveSpriteDown:
					CheckCharCollision(SPRITE_OFFSET_DOWN_LEFT,SPRITE_OFFSET_DOWN)
					cmp #CHAR_SOLID
					beq solidCollisionDown
					CheckCharCollision(SPRITE_OFFSET_DOWN_CENTER,SPRITE_OFFSET_DOWN)
					cmp #CHAR_SOLID
					beq solidCollisionDown
					CheckCharCollision(SPRITE_OFFSET_DOWN_RIGHT,SPRITE_OFFSET_DOWN)
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
				CheckSpriteDirection(LEFT)
				beq moveSpriteLeft
					jmp doneCheckSpriteLeftDirection
				moveSpriteLeft:
					CheckCharCollision(SPRITE_OFFSET_LEFT,SPRITE_OFFSET_LEFT_UP)
					cmp #CHAR_SOLID
					beq solidCollisionLeft
					CheckCharCollision(SPRITE_OFFSET_LEFT,SPRITE_OFFSET_LEFT_CENTER)
					cmp #CHAR_SOLID
					beq solidCollisionLeft
					CheckCharCollision(SPRITE_OFFSET_LEFT,SPRITE_OFFSET_LEFT_DOWN)
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
					CheckCharCollision(SPRITE_OFFSET_RIGHT,SPRITE_OFFSET_RIGHT_UP)
					cmp #CHAR_SOLID
					beq solidCollisionRight
					CheckCharCollision(SPRITE_OFFSET_RIGHT,SPRITE_OFFSET_RIGHT_CENTER)
					cmp #CHAR_SOLID
					beq solidCollisionRight
					CheckCharCollision(SPRITE_OFFSET_RIGHT,SPRITE_OFFSET_RIGHT_DOWN)
					cmp #CHAR_SOLID
					beq solidCollisionRight
						inc Sprite_X_Pos,x
						jmp doneCheckSpriteRightDirection
					solidCollisionRight:
						jsr REACTION.solidReaction
				doneCheckSpriteRightDirection:

			doneMoveSprite:

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

			doneHandleSpriteSpriteCollision:

			// ******************** Check sprite at edge ********************

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
				jmp spriteNotAtEdge
			spriteAtTopEdge:
				lda #UP
				sta spriteEdge
				jmp doRoomEdgeReaction
			spriteAtBottomEdge:
				lda #DOWN
				sta spriteEdge
				jmp doRoomEdgeReaction
			spriteAtLeftEdge:
				lda #LEFT
				sta spriteEdge
				jmp doRoomEdgeReaction
			spriteAtRightEdge:
				lda #RIGHT
				sta spriteEdge
				jmp doRoomEdgeReaction

			doRoomEdgeReaction:
				jsr REACTION.edgeReaction

			spriteNotAtEdge:

			inx
			cpx #MAX_NUMBER_OF_SPRITES
			beq doneHandleSprites
				jmp handleSpritesLoop

		doneHandleSprites:
			rts

	// ============================================ CREATE SPRITE ============================================
	createSprite:
		txa
		pha
		tya
		pha

		ldx #0
		findFreeSpriteSlot:
			lda SPRITE_ENABLE
			and Sprite_Binary,x
			beq freeSpriteSlotFound
				inx
				cpx #MAX_NUMBER_OF_SPRITES
				bne findFreeSpriteSlot
					jmp doneCreateSprite // No free sprites
			freeSpriteSlotFound:
				stx newSpriteNr

				lda temp1
				sta Sprite_X_Pos,x
				lda temp2
				sta Sprite_Y_Pos,x

				jsr manualUpdateSpritePos

				ldy temp3
				lda Sprite_Type_LO,y
				sta ZP_SPRITE_TYPE_LO
				lda Sprite_Type_HI,y
				sta ZP_SPRITE_TYPE_HI

				ldy #0
				lda (ZP_SPRITE_TYPE_LO),y
				sta Sprite_Edge_Reaction,x
				iny
				lda (ZP_SPRITE_TYPE_LO),y
				sta Sprite_Solid_Reaction,x
				iny
				lda (ZP_SPRITE_TYPE_LO),y
				sta Sprite_V_Speed,x
				iny
				lda (ZP_SPRITE_TYPE_LO),y
				sta Sprite_H_Speed,x
				iny
				lda (ZP_SPRITE_TYPE_LO),y
				sta SPRITE_COLOR,x
				iny
				lda (ZP_SPRITE_TYPE_LO),y
				sta Sprite_Flags,x

				lda SPRITE_ENABLE
				ora Sprite_Binary,x
				sta SPRITE_ENABLE

		doneCreateSprite:
			pla
			tay
			pla
			tax

			rts

	// ============================================ DESTROY SPRITE ============================================
	destroySprite:
		lda SPRITE_ENABLE
		and Sprite_Binary_0,x
		sta SPRITE_ENABLE
		rts

	// ============================================ UPDATE SPRITE REGISTERS ============================================
	updateSpriteRegisters:
		ldx #0
		updateSpriteRegistersLoop:
			// ******************** Update sprite position ********************
			lda Sprite_X_Pos,x
			clc
			adc #24
			sta tempXpos
			
			lda Sprite_Y_Pos,x
			clc
			adc #50
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

			// ******************** Sprite animation ********************

			updateSpriteAnimFrame:
				ldy Sprite_Anim_Type,x
				lda Sprite_Anim_LO,y
				sta ZP_ANIM_LO
				lda Sprite_Anim_HI,y
				sta ZP_ANIM_HI

				ldy Sprite_Anim_Frame_Counter,x
				lda (ZP_ANIM_LO),y
				sta Sprite_Anim_Frame,x
				cmp #255 // Animation end code
				bne notEndOfAnimation
					lda #0
					sta Sprite_Anim_Frame_Counter,x
					tay
					lda (ZP_ANIM_LO),y
					sta Sprite_Anim_Frame,x

					jsr REACTION.animEndReaction
				notEndOfAnimation:
					lda #SPRITE_POINTER_INDEX
					clc
					adc Sprite_Anim_Mode,x
					adc Sprite_Anim_Frame,x
					sta SPRITE_POINTER,x

			checkAnimTimer:
				lda Sprite_Anim_Timer,x
				cmp Sprite_Anim_Speed,x
				beq resetAnimTimer
					inc Sprite_Anim_Timer,x
					jmp doneCheckAnimTimer
				resetAnimTimer:
					lda #0
					sta Sprite_Anim_Timer,x

					inc Sprite_Anim_Frame_Counter,x
				doneCheckAnimTimer:

			doneSpriteAnim:

				inx
				cpx #MAX_NUMBER_OF_SPRITES
				beq doneUpdateSpriteRegisters
					jmp updateSpriteRegistersLoop

		doneUpdateSpriteRegisters:
			rts


	manualUpdateSpriteAnimFrame:
		ldy Sprite_Anim_Type,x
		lda Sprite_Anim_LO,y
		sta ZP_ANIM_LO
		lda Sprite_Anim_HI,y
		sta ZP_ANIM_HI

		lda #0
		sta Sprite_Anim_Timer,x
		sta Sprite_Anim_Frame_Counter,x
		tay
		lda (ZP_ANIM_LO),y
		sta Sprite_Anim_Frame,x

		lda #SPRITE_POINTER_INDEX
		clc
		adc Sprite_Anim_Mode,x
		adc Sprite_Anim_Frame,x
		sta SPRITE_POINTER,x

		rts


	manualUpdateSpritePos:
		lda Sprite_X_Pos,x
		clc
		adc #24
		sta tempXpos
		
		lda Sprite_Y_Pos,x
		clc
		adc #50
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

		rts
}
