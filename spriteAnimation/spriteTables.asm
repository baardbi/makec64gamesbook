Sprite_Anim_Type:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0

Sprite_Anim_Frame:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0

Sprite_Anim_Frame_Counter:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0

Sprite_Anim_Speed:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0

Sprite_Anim_Timer:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0

Sprite_Anim_LO:
.byte <Sprite_Anim_Bounce
.byte <Sprite_Anim_Spin
.byte <Sprite_Anim_Wobble
.byte <Sprite_Anim_Mix

Sprite_Anim_HI:
.byte >Sprite_Anim_Bounce
.byte >Sprite_Anim_Spin
.byte >Sprite_Anim_Wobble
.byte >Sprite_Anim_Mix

Sprite_Anim_Bounce:
.byte 0
.byte 1
.byte 2
.byte 3
.byte 255

Sprite_Anim_Spin:
.byte 4
.byte 5
.byte 6
.byte 7
.byte 8
.byte 0
.byte 255

Sprite_Anim_Wobble:
.byte 9
.byte 10
.byte 11
.byte 12
.byte 13
.byte 0
.byte 255
