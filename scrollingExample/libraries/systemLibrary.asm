
// ---------------------- SYSTEM LIBRARY ----------------------

SYSTEM:
{
	setup:
		sei // Disable system interrupts
		lda #%00110110 // Disable BASIC
		sta $0001 // Processor port
		cli // Enable system interrupts

		lda #%00011110 // Screen RAM: $0400   Charset: $3800
		sta $d018 // Screen memory setup

		lda #%11010111 // Enable screen multicolor   Screen width: 38 cols
					   // Scroll bits: Screen adjusted to the right
		sta $d016 // Screen control 2

		lda #BLACK
		sta $d020 // Screen border color

		lda #BLACK
		sta $d021 // Screen background color

		lda #LIGHT_BLUE
		sta $d022 // Screen extra color 1

		lda #BROWN
		sta $d023 // Screen extra color 2

		jsr INTERRUPT.setupRasterInterrupt

		rts
}
