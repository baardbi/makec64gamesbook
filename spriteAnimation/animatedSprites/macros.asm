
// ------------------------------------ MACROS ------------------------------------

.macro SetSpriteAnimation(type,speed)
{
	lda #type
	sta Sprite_Anim_Type,x

	lda #speed
	sta Sprite_Anim_Speed,x
}
