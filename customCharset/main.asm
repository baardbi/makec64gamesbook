BasicUpstart2(main)

main:
	lda #%00011110
	sta $d018	// Screen memory setup

	lda #%11011000
	sta $d016	// Screen control 2

	lda #71
	sta $0400
	lda #72
	sta $0401
	lda #87
	sta $0428
	lda #88
	sta $0429

	lda #15		// Multicolor yellow
	sta $d800
	sta $d801
	sta $d828
	sta $d829

	lda #0		// Multicolor black
	sta $d021	// Background color

	lda #8		// Orange
	sta $d022	// Extra color 1
	lda #9		// Brown
	sta $d023	// Extra color 2

	rts

*=$3800
.import binary "custom1.bin"
