
// -------------------------------- INTERRUPT LIBRARY --------------------------------

INTERRUPT:
{
	setupRasterInterrupt:
		sei

		lda #%01111111
		sta INTERRUPT_CONTROL_AND_STATUS1
		sta INTERRUPT_CONTROL_AND_STATUS2

		lda INTERRUPT_CONTROL_AND_STATUS1
		lda INTERRUPT_CONTROL_AND_STATUS2

		lda #240
		sta CURRENT_RASTER_LINE

		lda #%00011011
		sta SCREEN_CONTROL_1

		lda #<irq
		sta INTERRUPT_EXEC_ADDR1_SERVICE
		lda #>irq
		sta INTERRUPT_EXEC_ADDR2_SERVICE

		cli

		lda #%00000101
		sta INTERRUPT_CONTROL

		rts


	enableRasterInterrupt:
		lda #%00000101
		sta INTERRUPT_CONTROL
		rts


	disableRasterInterrupt:
		lda #%00000100
		sta INTERRUPT_CONTROL
		rts


	irq:
		lda #%11111111
		sta INTERRUPT_STATUS

		jsr SPRITE.updateSpriteRegisters

		jmp INTERRUPT_RETURN
}
