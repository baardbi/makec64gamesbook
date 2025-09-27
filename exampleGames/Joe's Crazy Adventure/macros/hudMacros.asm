
// ----------------------------------- HUD MACROS -----------------------------------

.macro AddToScore(value,place)
{
	// The place is where in the score the number should be added.
	// This is how the place values are set up:
	//
	// SCORE: 0 0 0 0 0 0
	//
	// Place  0 1 2 3 4 5
	//
	// Example: AddToScore(1,3) = This will add 1 to the 3 place. In this case we are adding 100 to the score.

	txa
	pha

	ldx #place

	lda score100000,x
	clc
	adc #value
	sta score100000,x

	lda score100000,x
	cmp #10
	bcs incNextScoreValue
		jmp updateHUDscore
	incNextScoreValue:
		lda #0
		sta score100000,x
		dex
		inc score100000,x

	updateHUDscore:
		jsr HUD.updateScore

		pla
		tax
}
