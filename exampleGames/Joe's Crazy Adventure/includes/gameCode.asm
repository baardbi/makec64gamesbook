
// ----------------------------------- GAME CODE -----------------------------------

main:
	ldx #$ff // Initialize stack pointer
	txs

	jsr SYSTEM.setup


// *********************** START SCREEN ***********************
startScreenSetup:
	lda #LIGHT_RED
	sta SCREEN_EXTRA_COLOR_1

	lda #START_SCREEN
	sta roomNr
	jsr ROOM.load

	lda #%00000000 // Disable all sprites
	sta SPRITE_ENABLE

	lda #0
	sta playMusic // In this case the music routine
				  // will mess with the text drawing,
				  // so we temporarily disable music
				  // while the text is drawing.

	WriteText(BlinkingMessage,11,10,WHITE)

	WriteText(MusicBy,17,10,WHITE)

	PlaySong(0)

	lda #0 // Set text color to black
	sta textColor

startScreenLoop:
	// Blink start screen text
	lda textColor
	cmp #8 // Only 8 high res colors when screen is in multicolor mode
	bcc dontResetTextColor
		lda #0 // Reset text color to black
		sta textColor
	dontResetTextColor:
		SetTextColor(11,10,17,textColor)
		inc textColor

	Delay(100,100) // Set delay for text blinking

	jsr SCNKEY
	jsr GETIN
	cmp #KEY_F1
	bne startScreenLoop


// *********************** GAME ***********************
gameSetup:
	jsr PLAYER.createPlayer // Create player sprite

	jsr ROOM.resetRoomCoins

	lda #DEFAULT_SCREEN_EXTRA_COLOR_1
	sta SCREEN_EXTRA_COLOR_1

	lda #START_ROOM
	sta roomNr
	jsr ROOM.load

	LoadCharMap(HUD_CHAR_MAP_ADDRESS,HUD_START_POS_X,HUD_START_POS_Y,HUD_WIDTH,HUD_HEIGHT)
	jsr HUD.updatePlayerLives

	PlaySong(0)

gameLoop:
	jsr INPUT.readJoystick_2
	jsr SPRITE.handleSprites
	jmp gameLoop


// *********************** GAME OVER ***********************
gameOverSetup:
	lda #GAME_OVER_SCREEN
	sta roomNr
	jsr ROOM.load

	jsr HUD.removeHUD
	jsr HUD.resetScore

	lda #%00000000 // Diasble all sprites
	sta SPRITE_ENABLE

	PlaySong(0)

gameOverLoop:
	lda JOYSTICK_2
	and #JOY_FIRE
	bne gameOverLoop
		jmp startScreenSetup

// *********************** WIN SCREEN ***********************
winScreenSetup:
	lda #LIGHT_RED
	sta SCREEN_EXTRA_COLOR_1

	lda #WIN_SCREEN
	sta roomNr
	jsr ROOM.load

	jsr HUD.removeHUD
	jsr HUD.resetScore

	lda #%00000000 // Diasble all sprites
	sta SPRITE_ENABLE

	PlaySong(0)

winScreenLoop:
	lda JOYSTICK_2
	and #JOY_FIRE
	bne winScreenLoop
		jmp startScreenSetup
