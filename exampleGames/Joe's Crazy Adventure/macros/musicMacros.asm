
// ----------------------------------- MUSIC MACROS -----------------------------------

.macro PlaySong(song)
{
	txa
	pha

	lda #song
	ldy #0
	ldx #0
	jsr MUSIC_INIT

	lda #1
	sta playMusic

	pla
	tax
}
