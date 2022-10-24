
syntax_error: 	nop			# Entry point of the add4 subroutine
	# Add the four arguments
	# Return the final value

	mve $s0, $zero		# s0 = 0
	ad $s0, $s0, $a0	# s0 += a0
	ad $s0, $s0, $a1	# s0 += a1
	ad $s0, $s0, $a2	# s0 += a2
	ad $s0, $s0, $a3	# s0 += a3

	move $v0, $s0
	jr $ra



