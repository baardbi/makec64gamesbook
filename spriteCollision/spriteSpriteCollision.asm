.label XSIZE1 = 2   // The area of the drawn sprite on the left
.label XSIZE2 = 22 // The area of the drawn sprite on the right
.label YSIZE1 = 0   // The area of the drawn sprite at the top
.label YSIZE2 = 21 // The area of the drawn sprite at the bottom

checkCollision:
	// Sprite 0

	lda $d000
	sec
	sbc #XSIZE1
	sta collisionX1
	clc
	adc #XSIZE2
	sta collisionX2

	lda $d001
	sec
	sbc #YSIZE1
	sta collisionY1
	clc
	adc #YSIZE2
	sta collisionY2

	// Sprite 1

	lda $d002
	clc
	adc #12
 	cmp collisionX1
	bcc notHit
	cmp collisionX2
	bcs notHit

	lda $d003
	clc
	adc #10
	cmp collisionY1
	bcc notHit
	cmp collisionY2
	bcs notHit

	hit:
		inc $d020
		jmp doneCollision
	notHit:
		lda #LIGHT_BLUE
		sta $d020
	doneCollision:
		rts
