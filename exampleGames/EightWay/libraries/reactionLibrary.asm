
// -------------------------------- REACTION LIBRARY --------------------------------

REACTION:
{
	edgeReaction:
		lda Sprite_Edge_Reaction,x
		jmp checkReactionNumber

	solidReaction:
		lda Sprite_Solid_Reaction,x
		jmp checkReactionNumber

	charReaction:
		ldy charCollision
		lda Char_Reaction,y
		jmp checkReactionNumber

	animEndReaction:
		ldy Sprite_Anim_Type,x
		lda Sprite_Anim_End,y
		jmp checkReactionNumber

	spriteSpriteCollision:
		rts

	checkReactionNumber:
		cmp #0 // NO REACTION
		bne notReaction0
			rts
		notReaction0:
		cmp #1 // STOP MOVING
		bne notReaction1
			rts
		notReaction1:
		cmp #2 // REVERSE DIRECTION
		bne notReaction2
			rts
		notReaction2:
		cmp #3 // GO TO NEXT ROOM
		bne notReaction3
			lda spriteEdge
			cmp #UP
			beq goOneRoomUp
			cmp #DOWN
			beq goOneRoomDown
			cmp #LEFT
			beq goOneRoomLeft
			cmp #RIGHT
			beq goOneRoomRight
				rts
			goOneRoomUp:
				lda roomNr
				sec
				sbc #MAP_WIDTH
				sta roomNr
				jsr ROOM.load

				lda #ROOM_BOTTOM_EDGE - 1
				sta Sprite_Y_Pos,x
				rts
			goOneRoomDown:
				lda roomNr
				clc
				adc #MAP_WIDTH
				sta roomNr
				jsr ROOM.load

				lda #ROOM_TOP_EDGE + 1
				sta Sprite_Y_Pos,x
				rts
			goOneRoomLeft:
				dec roomNr
				jsr ROOM.load

				lda #ROOM_RIGHT_EDGE - 1
				sta Sprite_X_Pos,x
				rts
			goOneRoomRight:
				inc roomNr
				jsr ROOM.load

				lda #ROOM_LEFT_EDGE + 1
				sta Sprite_X_Pos,x
				rts
		notReaction3:
		cmp #4 // HURT
		bne notReaction4
			rts
		notReaction4:
		cmp #5 // WATER
		bne notReaction5
			lda #10
			sta Sprite_Anim_Mode,x
			rts
		notReaction5:
		cmp #6 // NOT WATER
		bne notReaction6
			lda #0
			sta Sprite_Anim_Mode,x
			rts
		notReaction6:
		cmp #7 // DESTROY SPRITE
		bne notReaction7
			jsr SPRITE.destroySprite
			rts
		notReaction7:
		cmp #8
		bne notReaction8
			rts
		notReaction8:
		cmp #9
		bne notReaction9
			rts
		notReaction9:
			rts
}
