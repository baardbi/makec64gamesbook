
// -------------------------------- INPUT MACROS --------------------------------

.macro CheckJoystickState(joystick,state)
{
	lda joystick
	cmp #state
}
