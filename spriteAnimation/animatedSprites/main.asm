
// ------------------------------------ ANIMATION ------------------------------------

#import "constants.asm"
#import "macros.asm"

BasicUpstart2(main)

main:
	lda #DARK_GREY
	sta SCREEN_BACKGROUND_COLOR
	lda #BLACK
	sta SCREEN_BORDER_COLOR
	jsr SCREEN_CLEAR
	jsr setupRasterInterrupt

	lda #%11111111 // Enable multicolor for all sprites
	sta SPRITE_MULTICOLOR

	lda #BLACK
	sta SPRITE_EXTRA_COLOR_1
	lda #WHITE
	sta SPRITE_EXTRA_COLOR_2


	// -------- Set up sprite 0 --------
	ldx #0

	lda #RED
	sta SPRITE_COLOR,x

	lda #100
	sta $d000

	lda #100
	sta $d001


	// -------- Set up sprite 1 --------
	ldx #1

	lda #GREEN
	sta SPRITE_COLOR,x

	lda #150
	sta $d002

	lda #150
	sta $d003


	// -------- Set up sprite 2 --------
	ldx #2

	lda #YELLOW
	sta SPRITE_COLOR,x

	lda #50
	sta $d004

	lda #170
	sta $d005


	// -------- Set up sprite 3 --------
	ldx #3

	lda #BLUE
	sta SPRITE_COLOR,x

	lda #200
	sta $d006

	lda #75
	sta $d007


	lda #%00001111 // Make sure all sprites are disabled
	sta SPRITE_ENABLE



// ====================== GAME LOOP ======================
gameLoop:

	// ---- Animate sprite 0 ----
	ldx #0
	SetSpriteAnimation(0,10) // Animation type = 0    Animation speed = 10

	// ---- Animate sprite 1 ----
	ldx #1
	SetSpriteAnimation(1,5)  // Animation type = 1    Animation speed = 5

	// ---- Animate sprite 2 ----
	ldx #2
	SetSpriteAnimation(2,8)  // Animation type = 2    Animation speed = 8

	// ---- Animate sprite 3 ----
	ldx #3
	SetSpriteAnimation(3,6)  // Animation type = 3    Animation speed = 6

	jsr activateSprite

	jmp gameLoop
// ========================================================



// ---------------------- Sprite animation subroutine -----------------------
spriteAnimation:
	ldx #0
	spriteAnimationLoop:

		updateSpriteAnimFrame:
			ldy Sprite_Anim_Type,x
			lda Sprite_Anim_LO,y
			sta ZP_ANIM_LO
			lda Sprite_Anim_HI,y
			sta ZP_ANIM_HI

			ldy Sprite_Anim_Frame_Counter,x
			lda (ZP_ANIM_LO),y
			sta Sprite_Anim_Frame,x
			cmp #255 // Animation end code
			bne notEndOfAnimation
				//inc $d027,x
				
				lda #0
				sta Sprite_Anim_Frame_Counter,x
				tay
				lda (ZP_ANIM_LO),y
				sta Sprite_Anim_Frame,x
			notEndOfAnimation:
				lda #SPRITE_POINTER_INDEX
				clc
				adc Sprite_Anim_Frame,x
				sta SPRITE_POINTER,x

		checkAnimTimer:
			lda Sprite_Anim_Timer,x
			cmp Sprite_Anim_Speed,x
			beq resetAnimTimer
				inc Sprite_Anim_Timer,x
				jmp doneCheckAnimTimer
			resetAnimTimer:
				lda #0
				sta Sprite_Anim_Timer,x

				inc Sprite_Anim_Frame_Counter,x
			doneCheckAnimTimer:

		inx
		cpx #8 // Max number of sprites
		beq doneSpriteAnimation
			jmp spriteAnimationLoop
	doneSpriteAnimation:
		rts
// --------------------------------------------------------------------------



// ---------------------- Raster interrupt routine -----------------------
irq:
	lda #%11111111
	sta INTERRUPT_STATUS
	jsr spriteAnimation // Run sprite animation subroutine
	jmp INTERRUPT_RETURN
// -----------------------------------------------------------------------


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



activateSprite:
	jsr SCNKEY
	jsr GETIN
	cmp #$30
	bcc dontGetInput
	cmp #$34
	bcs dontGetInput
		and #%00001111
		tax
		lda SPRITE_ENABLE
		eor Sprite_Binary,x
		sta SPRITE_ENABLE
	dontGetInput:
		rts



*=SPRITE_PATTERN_ADDRESS "Sprite Patterns"
.import binary "spritePatterns.bin"


*=TABLES_ADDRESS "Tables"
#import "tables.asm"
