.macro DrawText(text,color,row,col)
{
	lda #<text
	sta ZP_TEXT_LO
	lda #>text
	sta ZP_TEXT_HI

	lda #color
	sta charColor
	lda #row
	sta charRow
	lda #col
	sta charCol

	jsr TEXT.drawText
}
