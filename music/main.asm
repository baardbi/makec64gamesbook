.var music = LoadSid("/music/A_Computer_in_My_Backpack.sid")

BasicUpstart2(main)

main:
	ldx #0
	ldy #0
	lda #music.startSong-1
	jsr music.init
        
	sei
	lda #<irq
	sta $0314
	lda #>irq
	sta $0315
	asl $d019
	lda #%01111011
	sta $dc0d
	lda #%10000001
	sta $d01a
	lda #$1b
	sta $d011
	lda #128
	sta $d012
	cli

loop:
	jmp loop

irq:
	asl $d019
	inc $d020

	jsr music.play 

	dec $d020
	pla
	tay
	pla
	tax
	pla
	rti

*=music.location "Music"
.fill music.size, music.getData(i)
