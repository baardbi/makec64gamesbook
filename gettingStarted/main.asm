
BasicUpstart2(main)

main:
	ldx #$ff
	txs   // Initialize the stack

	jsr SYSTEM.setup


gameSetup:
	lda #START_ROOM
	sta roomNr
	jsr ROOM.load


gameLoop:
	jsr INPUT.readJoystick_2
	jsr SPRITE.handleSprites
	jmp gameLoop
