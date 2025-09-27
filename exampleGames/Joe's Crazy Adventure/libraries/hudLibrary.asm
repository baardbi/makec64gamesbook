
// ----------------------------------- HUD LIBRARY -----------------------------------

HUD:
{
	updatePlayerLives:
		txa
		pha

		ldx #HUD_PLAYER_LIVES_Y_POS
		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy #HUD_PLAYER_LIVES_X_POS
		lda #HUD_BLANK_CHAR

		ldx #0
		clearPlayerLivesLoop:
			sta (ZP_ROW_LO),y
			iny
			inx
			cpx #HUD_MAX_PLAYER_LIVES
			bne clearPlayerLivesLoop

		ldy #HUD_PLAYER_LIVES_X_POS
		lda #HUD_PLAYER_LIVES_GRAPHIC

		ldx #0
		drawPlayerLivesLoop:
			sta (ZP_ROW_LO),y
			iny
			inx
			cpx playerLives
			bne drawPlayerLivesLoop

		pla
		tax
		rts


	updateScore:
		txa
		pha
		tya
		pha

		ldx #HUD_SCORE_Y_POS
		lda Row_LO,x
		sta ZP_ROW_LO
		lda Row_HI,x
		sta ZP_ROW_HI

		ldy #HUD_SCORE_X_POS

		ldx #0
		updateScoreLoop:
			lda score100000,x
			clc
			adc #$30 // Screen code for the 0 char
			sta (ZP_ROW_LO),y
			iny

			inx
			cpx #HUD_SCORE_DIGITS
			bne updateScoreLoop

		pla
		tay
		pla
		tax
		rts


	resetScore:
		txa
		pha

		lda #0
		tax
		resetScoreLoop:
			sta score100000,x
			inx
			cpx #HUD_SCORE_DIGITS
			bne resetScoreLoop
		pla
		tax
		rts


	removeHUD:
		txa
		pha
		tya
		pha

		ldx #HUD_START_POS_Y
		removeHUDrow:

			lda Row_LO,x
			sta ZP_ROW_LO
			lda Row_HI,x
			sta ZP_ROW_HI

			ldy #HUD_START_POS_X
			removeHUDcol:
				lda #HUD_BLANK_CHAR
				sta (ZP_ROW_LO),y
				iny
				cpy #HUD_START_POS_X + HUD_WIDTH
				bne removeHUDcol
			inx
			cpx #HUD_START_POS_Y + HUD_HEIGHT
			bne removeHUDrow
		pla
		tay
		pla
		tax
		rts
}
