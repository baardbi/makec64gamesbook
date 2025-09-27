jsr $ff9f    // Scan keyboard - KERNAL routine (SCNKEY)
jsr $ffe4    // Read keyboard buffer - KERNAL routine (GETIN)
cmp #$20 // PETSCII code for the space bar
bne spaceBarNotPressed
	  // Perform some code...
spaceBarNotPressed:
