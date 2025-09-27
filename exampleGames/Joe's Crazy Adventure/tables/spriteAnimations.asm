
// ----------------------------------- SPRITE ANIMATIONS -----------------------------------

Anim_Player_Idle_Right:
.byte 0
.byte 255

Anim_Player_Idle_Left:
.byte 3
.byte 255

Anim_Player_Walk_Right:
.byte 1
.byte 0
.byte 255

Anim_Player_Walk_Left:
.byte 4
.byte 3
.byte 255

Anim_Player_Jump_Right:
.byte 2
.byte 255

Anim_Player_Jump_Left:
.byte 5
.byte 255

Anim_Player_Sad:
.byte 6
.byte 255

Anim_Player_Happy:
.byte 7
.byte 255

Anim_Monster_Walk_Left:
.byte 9
.byte 8
.byte 255

Anim_Monster_Walk_Right:
.byte 11
.byte 10
.byte 255

Anim_Monster_Confused:
.byte 16
.byte 17
.byte 18
.byte 18
.byte 255

Anim_Coin:
.byte 12
.byte 13
.byte 14
.byte 15
.byte 255

Anim_Diamond:
.byte 19
.byte 20
.byte 21
.byte 22
.byte 255

.label ANIM_PLAYER_IDLE_RIGHT = 0
.label ANIM_PLAYER_IDLE_LEFT = 1
.label ANIM_PLAYER_WALK_RIGHT = 2
.label ANIM_PLAYER_WALK_LEFT = 3
.label ANIM_PLAYER_JUMP_RIGHT = 4
.label ANIM_PLAYER_JUMP_LEFT = 5
.label ANIM_PLAYER_SAD = 6
.label ANIM_PLAYER_HAPPY = 7
.label ANIM_MONSTER_WALK_LEFT = 8
.label ANIM_MONSTER_WALK_RIGHT = 9
.label ANIM_MONSTER_CONFUSED = 10
.label ANIM_COIN = 11
.label ANIM_DIAMOND = 12

Anim_Type_LO:
.byte <Anim_Player_Idle_Right
.byte <Anim_Player_Idle_Left
.byte <Anim_Player_Walk_Right
.byte <Anim_Player_Walk_Left
.byte <Anim_Player_Jump_Right
.byte <Anim_Player_Jump_Left
.byte <Anim_Player_Sad
.byte <Anim_Player_Happy
.byte <Anim_Monster_Walk_Left
.byte <Anim_Monster_Walk_Right
.byte <Anim_Monster_Confused
.byte <Anim_Coin
.byte <Anim_Diamond

Anim_Type_HI:
.byte >Anim_Player_Idle_Right
.byte >Anim_Player_Idle_Left
.byte >Anim_Player_Walk_Right
.byte >Anim_Player_Walk_Left
.byte >Anim_Player_Jump_Right
.byte >Anim_Player_Jump_Left
.byte >Anim_Player_Sad
.byte >Anim_Player_Happy
.byte >Anim_Monster_Walk_Left
.byte >Anim_Monster_Walk_Right
.byte >Anim_Monster_Confused
.byte >Anim_Coin
.byte >Anim_Diamond
