
// ----------------------------------- TEXT MACROS -----------------------------------

.macro WriteText(text,row,col,color)
{
	lda #<text
	sta ZP_TEXT_LO
	lda #>text
	sta ZP_TEXT_HI

	lda #row
	sta textRow
	lda #col
	sta textCol
	lda #color
	sta textColor

	jsr OUTPUT.writeText
}

.macro SetTextColor(row,col,length,colorVariable)
{
	lda #row
	sta tileRow
	lda #col
	sta tileCol
	lda #length
	sta textLength
	lda colorVariable
	sta textColor
	
	jsr OUTPUT.setTextColor
}
