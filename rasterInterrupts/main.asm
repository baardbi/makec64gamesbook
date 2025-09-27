BasicUpstart2(main)

main:

	jsr setupRasterInterrupt


loop:
	jmp loop



#import "rasterInterrupts.asm"
