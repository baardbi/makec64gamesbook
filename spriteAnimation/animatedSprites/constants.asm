
// ------------------------------------ CONSTANTS ------------------------------------

// Zeropage:
.label ZP_ANIM_LO = $0020
.label ZP_ANIM_HI = $0021

// Screen:
.label SCREEN_RAM = $0400
.label SCREEN_COLOR_RAM = $d800

.label SCREEN_CONTROL_1 = $d011
.label SCREEN_CONTROL_2 = $d016
.label SCREEN_MEMORY_SETUP = $d018

.label SCREEN_BORDER_COLOR = $d020
.label SCREEN_BACKGROUND_COLOR = $d021
.label SCREEN_EXTRA_COLOR_1 = $d022
.label SCREEN_EXTRA_COLOR_2 = $d023

.label SCREEN_CLEAR = $e544

// Input:
.label SCNKEY = $ff9f
.label GETIN = $ffe4

// Sprite:
.label SPRITE_PATTERN_ADDRESS = $2000

.label SPRITE_X = $d000
.label SPRITE_Y = $d001

.label SPRITE_ENABLE = $d015

.label SPRITE_MULTICOLOR =$d01c

.label SPRITE_EXTRA_COLOR_1 = $d025
.label SPRITE_EXTRA_COLOR_2 = $d026
.label SPRITE_COLOR = $d027

.label SPRITE_POINTER = SCREEN_RAM + $03f8
.label SPRITE_POINTER_INDEX = SPRITE_PATTERN_ADDRESS / 64


// Tables:
.label TABLES_ADDRESS = $4000


// Interrupt:

.label INTERRUPT_STATUS = $d019
.label INTERRUPT_CONTROL = $d01a

.label CURRENT_RASTER_LINE = $d012

.label INTERRUPT_CONTROL_AND_STATUS1 = $dc0d
.label INTERRUPT_CONTROL_AND_STATUS2 = $dd0d

.label INTERRUPT_RETURN	= $ea81

.label INTERRUPT_EXEC_ADDR1_SERVICE = $0314
.label INTERRUPT_EXEC_ADDR2_SERVICE = $0315

