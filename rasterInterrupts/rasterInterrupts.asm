setupRasterInterrupt:
	sei 		// Disable interrupt requests

	lda #%01111111
	sta $dc0d          // Disable interrupt signals from CIA 1 chip
	sta $dd0d          // Disable interrupt signals from CIA 2 chip

	lda $dc0d    // Acknowledge pending interrupts from CIA 1
	lda $dd0d    // Acknowledge pending interrupts from CIA 2

	lda $d011
	and #%01111111	 // Clear bit 7 since we are not using raster   
                                                // interrupts past raster line 255
	sta $d011

	lda #250	         // Trigger a raster interrupt at scan line 250
	
	sta $d012

	lda #<irq       // Low byte of the address for our 
                                      // interrupt routine
	sta $0314
	lda #>irq		// High byte of the address for  
                                                               // our interrupt routine
	sta $0315

	lda $d01a
	ora #%00000001	// Enable raster interrupts
	sta $d01a

	cli 	// Enable interrupt requests

	rts


enableRasterInterrupt:
	lda $d01a
	ora #%00000001	// Enable raster interrupts
	sta $d01a
	rts

disableRasterInterrupt:
	lda $d01a
	and #%11111110	// Disable raster interrupts
	sta $d01a
	
	rts


irq:
	// ------------ Interrupt routine START --------------------
	lda $d019
	ora #%00000001 	// Acknowledge raster interrupt
	sta $d019

	dec $d020

	ldx #0
	delayLoop:
		inx
		bne delayLoop

	inc $d020

	jmp $ea81	// KERNAL interrupt return routine

	// ------------ Interrupt routine END --------------------
