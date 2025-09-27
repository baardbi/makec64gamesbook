SYSTEM:
{
	setup:
		sei
		lda #%00110110 // Disable BASIC
		sta PROCESSOR_PORT // $0001
		cli

		lda #%00011110 // Scr RAM: $0400 Chrset: $3800
		sta SCREEN_MEMORY_SETUP // $d018

		lda #%11011000 // Enable screen multicolor
		sta SCREEN_CONTROL_2 // $d016

		lda #%11111111 // Enable multicolor for all sprites
		sta SPRITE_MULTICOLOR // $d01c

		jsr SCREEN_CLEAR // $e544
		jsr INTERRUPT.setupRasterInterrupt

		rts
}
