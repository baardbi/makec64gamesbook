
// -------------------------------- SPRITE TYPE TABLES --------------------------------

Sprite_Type_LO:
.byte <Player_Sprite

Sprite_Type_HI:
.byte >Player_Sprite

// SPRITE FLAGS:
//
// %00000001 = Player
// %00000010 = Player weapon
// %00000100 = Enemy
// %00001000 = Enemy weapon
// %00010000 = Pickup object
// %00100000 = 
// %01000000 = 
// %10000000 = 

// *************** PLAYER ***************
Player_Sprite:
.byte 3 // EDGE REACTION: Go to next room
.byte 0 // SOLID REACTION: Null
.byte PLAYER_V_SPEED // Vertical speed
.byte PLAYER_H_SPEED // Horizontal speed
.byte LIGHT_RED
.byte %00000001 // Sprite flags

// *************** SWORD ***************
Sword_Sprite:
.byte 0 // EDGE REACTION: Null
.byte 0 // SOLID REACTION: Null
.byte 0 // Vertical speed
.byte 0 // Horizontal speed
.byte WHITE
.byte %00000010 // Sprite flags

// *************** BLOB ***************
Blob_Sprite:
.byte 2 // EDGE REACTION: Reverse direction
.byte 2 // SOLID REACTION: Reverse direction
.byte 20 // Vertical speed
.byte 20 // Horizontal speed
.byte RED
.byte %00000100 // Sprite flags
