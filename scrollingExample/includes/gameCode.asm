
// ---------------------- GAME CODE ----------------------

main:
	ldx #$ff
	txs // Initialize system stack

gameSetup:
	jsr SYSTEM.setup

	jsr $1000 // Init music

	lda #0 // Start scrolling from the beginning (left) of the map
	sta scrollX

	jsr MAP.loadMap_screen_1 // Load map to screen RAM $0400
	jsr MAP.colorMap

	lda #%00000001 // Sprite 0
	sta $d01c // Sprite multicolor

	lda #RED
	sta $d025 // Sprite extra color 1
	lda #WHITE
	sta $d026 // Sprite extra color 1

	// ----- Set up sprite 0 -----
	// Sprite 0 X-pos
	lda #160
	sta $d000
	// Sprite 0 Y-pos
	lda #130
	sta $d001
	// Sprite graphic plane 1
	lda #$a0
	sta $07f8
	// Sprite 0 color
	lda #LIGHT_RED
	sta $d027

	// ----- Set up sprite 1 -----
	// Sprite 1 X-pos
	lda #32
	sta $d002
	// Sprite 1 Y-pos
	lda #60
	sta $d003
	// Sprite graphic sun
	lda #$a2
	sta $07f9
	// Sprite 1 color
	lda #YELLOW
	sta $d028

	// Sprite X extended
	lda #%00000010 // Sprite 1 will be at a position past 256 on the X-axis
	sta $d010

	// Enable sprites
	lda #%00000011 // Sprite 0 and sprite 1
	sta $d015 // Enable sprite

gameLoop:
	// Read keyboard for testing and troubleshooting
	jsr $ff9f // SCNKEY
	jsr $ffe4 // GETIN
	cmp #$31 // Char 1
	bne notChar1
		// Show or hide raster time on the border
		lda showRasterTime
		eor #%00000001
		sta showRasterTime
		jmp doneReadKeyboard
	notChar1:
	cmp #$32 // Char 2
	bne notChar2
		// Play or stop music
		lda playMusic
		eor #%00000001
		sta playMusic
		jmp doneReadKeyboard
	notChar2:

	doneReadKeyboard:

	jmp gameLoop
