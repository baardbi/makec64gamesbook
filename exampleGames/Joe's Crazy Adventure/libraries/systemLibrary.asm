
// ----------------------------------- SYSTEM LIBRARY -----------------------------------

SYSTEM:
{
	setup:
		sei
		lda #%00110110 // Disable BASIC
		sta PROCESSOR_PORT
		cli

		lda #%00011110 // Screen RAM: $0400   Charset: $3800
		sta SCREEN_MEMORY_SETUP

		lda #%11011000 // Enable screen multicolor
		sta SCREEN_CONTROL_2

		lda #%11111111 // Enable multicolor for all sprites
		sta SPRITE_MULTICOLOR

		lda #DEFAULT_SCREEN_BORDER_COLOR
		sta SCREEN_BORDER_COLOR
		lda #DEFAULT_SCREEN_BACKGROUND_COLOR
		sta SCREEN_BACKGROUND_COLOR
		lda #DEFAULT_SCREEN_EXTRA_COLOR_1
		sta SCREEN_EXTRA_COLOR_1
		lda #DEFAULT_SCREEN_EXTRA_COLOR_2
		sta SCREEN_EXTRA_COLOR_2

		lda #DEFAULT_SPRITE_EXTRA_COLOR_1
		sta SPRITE_EXTRA_COLOR_1
		lda #DEFAULT_SPRITE_EXTRA_COLOR_2
		sta SPRITE_EXTRA_COLOR_2

		lda #>SCREEN_RAM
		sta SCREEN_RAM_HIGH_BYTE

		jsr SCREEN_CLEAR

		jsr INTERRUPT.setupRasterInterrupt
		rts


	delay:
		txa
		pha
		tya
		pha

		ldx #0

		delayLoop1:
			ldy #0

			delayLoop2:
				iny
				cpy delayTimer2
				bne delayLoop2

			inx
			cpx delayTimer1
			bne delayLoop1
			
		pla
		tay
		pla
		tax
		rts
}
