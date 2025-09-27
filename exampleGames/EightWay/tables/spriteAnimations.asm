
// -------------------------------- SPRITE ANIMATIONS --------------------------------

.label ANIM_PLAYER_IDLE_DOWN = 0
.label ANIM_PLAYER_IDLE_UP = 1
.label ANIM_PLAYER_IDLE_LEFT = 2
.label ANIM_PLAYER_IDLE_RIGHT = 3
.label ANIM_PLAYER_WALK_DOWN = 4
.label ANIM_PLAYER_WALK_UP = 5
.label ANIM_PLAYER_WALK_LEFT = 6
.label ANIM_PLAYER_WALK_RIGHT = 7
.label ANIM_PLAYER_ATTACK_DOWN = 8
.label ANIM_PLAYER_ATTACK_UP = 9
.label ANIM_PLAYER_ATTACK_LEFT = 10
.label ANIM_PLAYER_ATTACK_RIGHT = 11
.label ANIM_SWORD_DOWN = 12
.label ANIM_SWORD_UP = 13
.label ANIM_SWORD_LEFT = 14
.label ANIM_SWORD_RIGHT = 15

Sprite_Anim_End:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 7 // Destroy
.byte 7 // Destroy
.byte 7 // Destroy
.byte 7 // Destroy

Sprite_Anim_LO:
.byte <Player_Idle_Down
.byte <Player_Idle_Up
.byte <Player_Idle_Left
.byte <Player_Idle_Right
.byte <Player_Walk_Down
.byte <Player_Walk_Up
.byte <Player_Walk_Left
.byte <Player_Walk_Right
.byte <Player_Attack_Down
.byte <Player_Attack_Up
.byte <Player_Attack_Left
.byte <Player_Attack_Right
.byte <Sword_Down
.byte <Sword_Up
.byte <Sword_Left
.byte <Sword_Right

Sprite_Anim_HI:
.byte >Player_Idle_Down
.byte >Player_Idle_Up
.byte >Player_Idle_Left
.byte >Player_Idle_Right
.byte >Player_Walk_Down
.byte >Player_Walk_Up
.byte >Player_Walk_Left
.byte >Player_Walk_Right
.byte >Player_Attack_Down
.byte >Player_Attack_Up
.byte >Player_Attack_Left
.byte >Player_Attack_Right
.byte >Sword_Down
.byte >Sword_Up
.byte >Sword_Left
.byte >Sword_Right

Player_Idle_Down:
.byte 0,255

Player_Idle_Up:
.byte 3,255

Player_Idle_Left:
.byte 6,255

Player_Idle_Right:
.byte 8,255

Player_Walk_Down:
.byte 1,2,255

Player_Walk_Up:
.byte 4,5,255

Player_Walk_Left:
.byte 7,6,255

Player_Walk_Right:
.byte 9,8,255

Player_Attack_Down:
.byte 20,255

Player_Attack_Up:
.byte 21,255

Player_Attack_Left:
.byte 22,255

Player_Attack_Right:
.byte 23,255

Sword_Down:
.byte 24,255

Sword_Up:
.byte 25,255

Sword_Left:
.byte 26,255

Sword_Right:
.byte 27,255
