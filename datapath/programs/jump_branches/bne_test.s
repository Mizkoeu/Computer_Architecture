branch_not:
	nop
	li $t0, 5 						# load 5 into t0
	li $t1, 7							# load 7 into t1
	bne $t0, $t1, to_here # testing bne instruction, which should branch
	nop										# add a bunch of nops after bne
	nop
	nop	
	nop
	li $s0, 1234 # this line should never execute since we should've branched.
	
to_here:	
	add $s0, $t0, $t1 # this line should execute and assign 12 to s0 register.
	# j HALT

