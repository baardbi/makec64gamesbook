
// ----------------------------------- SPRITE INFO -----------------------------------

Sprite_Player:
.byte SPRITE_FLAG_PLAYER // Sprite flags
.byte DEFAULT_PLAYER_V_SPEED // Vertical speed
.byte DEFAULT_PLAYER_H_SPEED // Horizontal speed
.byte DEFAULT_PLAYER_JUMP_STRENGTH // Jump strength
.byte PLAYER_COLOR // Color
.byte REACT_GO_TO_NEXT_SCREEN // Sprite edge reaction
.byte REACT_NO_REACTION // Sprite solid reaction
.byte ACT_NO_ACTION // Initial action

Sprite_Monster:
.byte SPRITE_FLAG_ENEMY // Sprite flags
.byte 8 // Vertical speed
.byte 30 // Horizontal speed
.byte 0 // Jump strength
.byte YELLOW // Color
.byte REACT_REVERSE_DIRECTION // Sprite edge reaction
.byte REACT_REVERSE_DIRECTION // Sprite solid reaction
.byte ACT_MONSTER_MOVE // Initial action

Sprite_Coin:
.byte SPRITE_FLAG_PICKUP // Sprite flags
.byte 5 // Vertical speed
.byte 0 // Horizontal speed
.byte 0 // Jump strength
.byte YELLOW // Color
.byte REACT_NO_REACTION // Sprite edge reaction
.byte REACT_NO_REACTION // Sprite solid reaction
.byte ACT_COIN_SPIN // Initial action

Sprite_Diamond:
.byte SPRITE_FLAG_PICKUP // Sprite flags
.byte 5 // Vertical speed
.byte 0 // Horizontal speed
.byte 0 // Jump strength
.byte LIGHT_BLUE // Color
.byte REACT_NO_REACTION // Sprite edge reaction
.byte REACT_NO_REACTION // Sprite solid reaction
.byte ACT_DIAMOND_SPARKLE // Initial action

// Sprite types:
.label SPRITE_PLAYER = 0
.label SPRITE_MONSTER = 1
.label SPRITE_COIN = 2
.label SPRITE_DIAMOND = 3

Sprite_Type_LO:
.byte <Sprite_Player
.byte <Sprite_Monster
.byte <Sprite_Coin
.byte <Sprite_Diamond

Sprite_Type_HI:
.byte >Sprite_Player
.byte >Sprite_Monster
.byte >Sprite_Coin
.byte >Sprite_Diamond
