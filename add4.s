
add4: 	nop			# Entry point of the add4 subroutine
	# Add the four arguments
	# Return the final value

	move $s0, $zero		# s0 = 0
	add $s0, $s0, $a0	# s0 += a0
	add $s0, $s0, $a1	# s0 += a1
	add $s0, $s0, $a2	# s0 += a2
	add $s0, $s0, $a3	# s0 += a3

	move $v0, $s0
	jr $ra



