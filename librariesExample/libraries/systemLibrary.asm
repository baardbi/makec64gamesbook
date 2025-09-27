SYSTEM:
{
	setup:
		sei
		lda #%00110110   // Disable BASIC
		sta PROCESSOR_PORT   // RAM address $0001
		cli

		lda #%00011110   // Screen RAM: $0400   Charset: $3800
		sta SCREEN_MEMORY_SETUP   // RAM address $D018

		lda #%11011000   // Enable screen multicolor
		sta SCREEN_CONTROL_2   // RAM address $D016

		lda #%11111111   // Enable multicolor for all sprites
		sta SPRITE_MULTICOLOR   // RAM address $D01C

		lda #BLACK
		sta SCREEN_BORDER_COLOR   // RAM address $D020
		lda #BLACK
		sta SCREEN_BACKGROUND_COLOR   // RAM address $D021
		lda #LIGHT_BLUE
		sta SCREEN_EXTRA_COLOR_1   // RAM address $D022
		lda #BROWN
		sta SCREEN_EXTRA_COLOR_2   // RAM address $D023

		lda #BLACK
		sta SPRITE_EXTRA_COLOR_1   // RAM address $D025
		lda #WHITE
		sta SPRITE_EXTRA_COLOR_2   // RAM address $D026
		
		jsr SCREEN_CLEAR   // RAM address $E544

		jsr INTERRUPT.setupRasterInterrupt
		rts
}
