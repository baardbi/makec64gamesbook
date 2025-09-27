BasicUpstart2(main)

main:
	lda #%11011000
	sta $d016

	lda #1  	// A
	sta $0400
	lda #1  	// High resolution white
	sta $d800
	lda #2  	// B
	sta $0401
	lda #1  	// High resolution white
	sta $d801
	lda #3  	// C
	sta $0402
	lda #1  	// High resolution white
	sta $d802

	rts
