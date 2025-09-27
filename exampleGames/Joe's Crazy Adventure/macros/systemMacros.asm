
// ----------------------------------- SYSTEM MACROS -----------------------------------

.macro Delay(timer1,timer2)
{
	lda #timer1
	sta delayTimer1
	lda #timer2
	sta delayTimer2

	jsr SYSTEM.delay
}
