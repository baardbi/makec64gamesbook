
// -------------------------------- MAIN PROGRAM CODE --------------------------------

main:
	ldx #$ff
	txs

	jsr SYSTEM.setup


gameSetup:
	jsr HUD.initialize

	lda #START_ROOM
	sta roomNr
	jsr ROOM.load

	CreateSprite(PLAYER_START_POS_X,PLAYER_START_POS_Y,SPRITE_PLAYER)

	AddItem(ITEM_MAP)


gameLoop:
	jsr INPUT.readJoystick_2
	jsr SPRITE.handleSprites
	jmp gameLoop
