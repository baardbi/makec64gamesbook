handleSprites:
	ldx #0
	handleSpritesLoop:
		
		// Move sprites (including character collision)
		// If a sprite needs animation, I set their
		// animation type here.

		// Handle sprite-sprite collision

		// Check if a sprite is at the edge of the screen

	inx
	cpx #8 // Max number of sprites
	beq doneHandleSprites
		jmp handleSpritesLoop
	doneHandleSprites:
		rts
