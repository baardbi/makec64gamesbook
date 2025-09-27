
// ----------------------------------- PLAYER LIBRARY -----------------------------------

PLAYER:
{
	createPlayer:
		lda #DEFAULT_PLAYER_LIVES
		sta playerLives

		lda #SPRITE_PLAYER
		sta spriteType
		lda #PLAYER_START_POS_X
		sta spriteX
		lda #PLAYER_START_POS_Y
		sta spriteY

		jsr SPRITE.createSprite
		rts
}
