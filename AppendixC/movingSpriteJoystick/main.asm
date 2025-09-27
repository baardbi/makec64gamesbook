BasicUpstart2(main)

.label JOYSTICK_2 = $dc00
.label JOYSTICK_2_IDLE = %01111111

.label UP 		= %00000001
.label DOWN		= %00000010
.label LEFT		= %00000100
.label RIGHT		= %00001000
.label FIRE		= %00010000

.label SCREEN_CLEAR = $e544

.label SPRITE_X = $d000
.label SPRITE_Y = $d001
.label SPRITE_ENABLE = $d015
.label SPRITE_COLOR = $d027
.label SPRITE_POINTER = $07f8


main:
	jsr SCREEN_CLEAR

	lda #100
	sta SPRITE_X

	lda #100
	sta SPRITE_Y

	lda #$80
	sta SPRITE_POINTER

	lda #WHITE
	sta SPRITE_COLOR

	lda #%00000001
	sta SPRITE_ENABLE

gameLoop:
	jsr delay
	jsr readJoystick_2
	jmp gameLoop


readJoystick_2:
	lda JOYSTICK_2
	cmp #JOYSTICK_2_IDLE
	beq joy2_IDLE
		jmp checkJoy2_UP
	joy2_IDLE:

	checkJoy2_UP:
		lda JOYSTICK_2
		and #UP
		beq joy2_UP
			jmp checkJoy2_DOWN
		joy2_UP:
			dec SPRITE_Y

	checkJoy2_DOWN:
		lda JOYSTICK_2
		and #DOWN
		beq joy2_DOWN
			jmp checkJoy2_LEFT
		joy2_DOWN:
			inc SPRITE_Y
			
	checkJoy2_LEFT:
		lda JOYSTICK_2
		and #LEFT
		beq joy2_LEFT
			jmp checkJoy2_RIGHT
		joy2_LEFT:
			dec SPRITE_X
			
	checkJoy2_RIGHT:
		lda JOYSTICK_2
		and #RIGHT
		beq joy2_RIGHT
			jmp checkJoy2_FIRE
		joy2_RIGHT:
			inc SPRITE_X
			
	checkJoy2_FIRE:
		lda JOYSTICK_2
		and #FIRE
		beq joy2_FIRE
			jmp doneReadJoystick_2
		joy2_FIRE:
			inc SPRITE_COLOR
			
doneReadJoystick_2:
		rts


delay:
	ldx #0

	delayLoop1:
		ldy #100

		delayLoop2:
			iny
			cpy #255
			bne delayLoop2

		inx
		cpx #10
		bne delayLoop1
	rts

*=$2000 "My Sprite"
.import binary "/sprites/mySprite.bin"
