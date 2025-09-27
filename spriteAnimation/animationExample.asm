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
            cpx #8    // Max number of sprites
            beq doneSpriteAnimation
                jmp spriteAnimationLoop
    doneSpriteAnimation:
        rts
