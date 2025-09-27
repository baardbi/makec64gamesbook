
// ----------------------------------- REACTION LIBRARY -----------------------------------

// Reactions:
.label REACT_NO_REACTION = 0
.label REACT_STOP_MOVING = 1
.label REACT_REVERSE_DIRECTION = 2
.label REACT_GO_TO_NEXT_SCREEN = 3
.label REACT_DISABLE_SPRITE = 4
.label REACT_WARP = 5
.label REACT_HURT = 6

REACTION:
{
	checkEdgeReaction:
		lda Sprite_Edge_Reaction,x
		jmp checkReactionNumber

	checkSolidReaction:
		lda Sprite_Solid_Reaction,x
		jmp checkReactionNumber

	checkCharReaction:
		tay
		lda Char_Type_Reaction,y
		jmp checkReactionNumber

	checkSpriteCollisionReaction:
		lda Sprite_Flags,y
		and #SPRITE_FLAG_ENEMY
		bne collisionWithEnemy

		lda Sprite_Flags,y
		and #SPRITE_FLAG_PICKUP
		bne collisionWithPickup

		collisionWithEnemy:
			jmp reaction6 // Player death

		collisionWithPickup:
			jmp reaction7 // Coin pickup

		rts


	checkReactionNumber:

		checkReaction0:
		cmp #0
		beq reaction0
			jmp checkReaction1
		reaction0: // ********** No reaction **********
		doneReaction0:
			rts

		checkReaction1:
		cmp #1
		beq reaction1
			jmp checkReaction2
		reaction1: // ********** Stop moving (Only left/right movement) **********
			ClearSpriteDirection(LEFT + RIGHT)
		doneReaction1:
			rts

		checkReaction2:
		cmp #2
		beq reaction2
			jmp checkReaction3
		reaction2: // ********** Reverse direction (Only left/right movement) **********
			CheckSpriteDirection(FACE_LEFT)
			beq changeDirectionToRight
				ClearSpriteDirection(RIGHT + FACE_RIGHT)
				SetSpriteDirection(LEFT + FACE_LEFT)
				jmp doneReaction2
			changeDirectionToRight:
				ClearSpriteDirection(LEFT + FACE_LEFT)
				SetSpriteDirection(RIGHT + FACE_RIGHT)
		doneReaction2:
			rts

		checkReaction3:
		cmp #3
		beq reaction3
			jmp checkReaction4
		reaction3: // ********** Go to next screen **********
			lda spriteEdge
			cmp #UP
			beq goOneRoomUp
			cmp #DOWN
			beq goOneRoomDown
			cmp #LEFT
			beq goOneRoomLeft
			cmp #RIGHT
			beq goOneRoomRight
				jmp doneReaction3
			goOneRoomUp:
				lda roomNr
				sec
				sbc #MAP_WIDTH
				sta roomNr
				jsr ROOM.load

				lda #ROOM_BOTTOM_EDGE - 1
				sta Sprite_Y_Pos,x
				jmp doneReaction3
			goOneRoomDown:
				lda roomNr
				clc
				adc #MAP_WIDTH
				sta roomNr
				jsr ROOM.load

				lda #ROOM_TOP_EDGE + 1
				sta Sprite_Y_Pos,x
				jmp doneReaction3
			goOneRoomLeft:
				dec roomNr
				jsr ROOM.load

				lda #ROOM_RIGHT_EDGE - 1
				sta Sprite_X_Pos,x
				jmp doneReaction3
			goOneRoomRight:
				inc roomNr
				jsr ROOM.load

				lda #ROOM_LEFT_EDGE + 1
				sta Sprite_X_Pos,x
		doneReaction3:
			rts

		checkReaction4:
		cmp #4
		beq reaction4
			jmp checkReaction5
		reaction4: // ********** Disable sprite (Not player sprite) **********
			lda SPRITE_ENABLE
			and Sprite_Binary_0,y
			sta SPRITE_ENABLE

			lda #10 // Set inactive sprites slightly away from the edges
			sta Sprite_X_Pos,y
			sta Sprite_Y_Pos,y

			lda #BLANK_SPRITE // Make sprite invisible
			sta Sprite_Anim_Graphic,y

			lda SPRITE_X_EXTENDED
			ora Sprite_Binary,y
			sta SPRITE_X_EXTENDED
		doneReaction4:
			rts

		checkReaction5:
		cmp #5
		beq reaction5
			jmp checkReaction6
		reaction5: // ********** Warp **********
			lda warpOutRoom
			sta roomNr
			jsr ROOM.load

			lda warpInX
			sta Sprite_X_Pos,x
			lda warpInY
			sta Sprite_Y_Pos,x
		doneReaction5:
			rts

		checkReaction6:
		cmp #6
		beq reaction6
			jmp checkReaction7
		reaction6: // ********** Player death **********
			lda Sprite_Flags,x
			and #SPRITE_FLAG_PLAYER
			bne playerSpriteDoDeath
				jmp doneReaction6
			playerSpriteDoDeath:

			AnimateSprite(ANIM_PLAYER_SAD,0)
			jsr SPRITE.setSpriteAnimFrameManually

			PlaySong(2)

			Delay(250,250)

			dec playerLives
			lda playerLives
			bne notGameOver
				ldx #$ff // Reset stack
				txs
				jmp gameOverSetup
			notGameOver:
				jsr HUD.updatePlayerLives

			lda #START_ROOM
			sta roomNr
			jsr ROOM.load

			PlaySong(0)

			lda #PLAYER_START_POS_X
			sta Sprite_X_Pos,x
			lda #PLAYER_START_POS_Y
			sta Sprite_Y_Pos,x

			lda #FACE_RIGHT // Make sure the player faces right when he starts
			sta Sprite_Direction,x
			AnimateSprite(ANIM_PLAYER_IDLE_RIGHT,0)
			jsr SPRITE.setSpriteAnimFrameManually

		doneReaction6:
			rts

		checkReaction7:
		cmp #7
		beq reaction7 // Coin pickup
			jmp doneCheckReactionNumber
		reaction7:
			lda Sprite_Flags,x
			and #SPRITE_FLAG_PLAYER
			bne playerSpriteDoCoinPickup
				jmp doneReaction7
			playerSpriteDoCoinPickup:
				sty tempY
				ldy #0
				lda (ZP_ROOM_INFO_LO),y
				ora #ROOM_COIN_COLLECTED // Mark coin in this room as collected
				sta (ZP_ROOM_INFO_LO),y
				ldy tempY

				AddToScore(1,3) // Add 100 to score
				inc collectedCoins
				lda collectedCoins
				cmp #10
				bne notWinScreenYet
					ldx #$ff // Reset stack
					txs
					jmp winScreenSetup
				notWinScreenYet:
					jmp reaction4 // Disable sprite
		doneReaction7:
			rts

		doneCheckReactionNumber:
			rts
}
