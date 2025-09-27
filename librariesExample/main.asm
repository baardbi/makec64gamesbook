
#import "/constants/constants.asm"

BasicUpstart2(main)

main:
	
	jsr SYSTEM.setup


loop:
	
	jmp loop


#import "/libraries/systemLibrary.asm"
#import "/libraries/interruptLibrary.asm"
