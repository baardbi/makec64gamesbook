

// ------------------------------------------------ INTERRUPT LIBRARY ------------------------------------------------


INTERRUPT:
{
	actions:
		inc INTERRUPT_STATUS // $d019 - Set bit 0 in Interrupt Status Register to acknowledge raster interrupt
		//////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////
		////////////////////*** START INTERRUPT CODE *****////////////////////
		//
			lda showRasterTime
			beq dontShowRasterTimer1
				lda #YELLOW
				sta $d020
			dontShowRasterTimer1:

			jsr MAP.scrollRight

			lda playMusic
			beq dontPlayMusic
				jsr $1003 // Play music
			dontPlayMusic:

			lda showRasterTime
			beq dontShowRasterTimer2
				lda #BLACK
				sta $d020
			dontShowRasterTimer2:
		
			jmp INTERRUPT_RETURN // $ea81 - Return from interrupt
		//
		////////////////////***** END INTERRUPT CODE *****////////////////////
		//////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////



	setupRasterInterrupt:
		sei // Disable system interrupts

		lda #%01111111 // Turn off the CIA timer interrupt
		sta INTERRUPT_CONTROL_AND_STATUS1 // $dc0d
		sta INTERRUPT_CONTROL_AND_STATUS2 // $dd0d

		// Setup Raster Interrupt

		lda #%01111111 // Clear high bit of raster line
		and SCREEN_CONTROL_1 // $d011
		sta SCREEN_CONTROL_1 // $d011

		lda #250 // Set raster interrupt to trigger on line 250
		sta CURRENT_RASTER_LINE // $d012

		lda #<actions // Set pointer for raster interrupt
		sta INTERRUPT_EXEC_ADDR1_SERVICE // $0314
		lda #>actions
		sta INTERRUPT_EXEC_ADDR2_SERVICE // $0315

		lda #%00000001 // Enable raster interrupt
		sta INTERRUPT_CONTROL // $d01a

		cli // Enable system interrupts
		rts

	enableRasterInterrupt:
		lda #%00000001			// Enable raster interrupt
		sta INTERRUPT_CONTROL // $d01a
		rts

	disableRasterInterrupt:
		lda #%00000000			// Disable raster interrupt
		sta INTERRUPT_CONTROL // $d01a
		rts
}
