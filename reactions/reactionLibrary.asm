REACTION:
{
	charCollisionReaction:
		lda charCollision
		jmp checkReactionNumber

	spriteCollisionReaction:
		lda spriteCollision
		jmp checkReactionNumber

	checkReactionNumber:
		cmp #0 // NO REACTION
		bne notReaction0
			rts
		notReaction0:
		cmp #1 // STOP MOVING
		bne notReaction1
			// Stop sprite movement...
			rts
		notReaction1:
		cmp #2 // REVERSE DIRECTION
		bne notReaction2
			// Reverse sprite direction...
			rts
		notReaction2:
			rts
}
