BasicUpstart2(main)

main:

// Create a solid white
// sprite pattern for
// sprite 0.
ldx #0 // Start loop at 0
lda #%11111111	// Fill all pixels in
patternLoop:		// the sprite pattern
	sta $2000,x	// at address $2000
	inx
	cpx #64	// A sprite graphic is 64 bytes
	bne patternLoop

	lda #100	// X start position
	sta $d000	// for sprite 0
	lda #100	// Y start position
	sta $d001	// for sprite 0
	lda #$80  	// Sprite pointer index
	sta $07f8 	// Sprite pointer
	lda #%00000001 // Enable sprite 0
	sta $d015

gameLoop:
	inc $d000	// Move sprite 0 one pixel right
	jmp gameLoop
