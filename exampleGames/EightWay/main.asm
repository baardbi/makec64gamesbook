
// -------------------------------- EIGHT WAY --------------------------------

#import "/system/config.asm"
#import "/system/memoryMap.asm"
#import "/includes/constants.asm"
#import "/includes/macros.asm"

BasicUpstart2(main)

*=MAIN_PROGRAM_CODE "Main Program Code"
#import "/includes/mainProgramCode.asm"

*=VARIABLES_ADDRESS "Variables"
#import "/includes/variables.asm"

*=CHARSET_ATTRIB_ADDRESS "Charset Attrib"
.import binary "/charset/charsetAttrib.bin"

*=TILESET_ADDRESS "Tileset"
.import binary "/tileset/tileset.bin"

*=HUD_CHARMAP_ADDRESS "HUD Charmap"
.import binary "/hud/hudCharmap.bin"

//*=MUSIC_SFX_ADDRESS "Music SFX"
//#import "/sound/soundFX.asm"

*=SPRITE_PATTERN_ADDRESS "Sprite Patterns"
.import binary "/sprites/spritePatterns.bin"

*=CHARSET_ADDRESS "Charset"
.import binary "/charset/charset.bin"

*=TABLES_ADDRESS "Tables"
#import "/includes/tables.asm"

*=LIBRARIES_ADDRESS "Libraries"
#import "/includes/libraries.asm"

*=ROOMS_ADDRESS "Rooms"
.import binary "/rooms/rooms.bin"
