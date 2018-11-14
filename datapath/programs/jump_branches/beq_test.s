branch_test:
	nop
	li $t0, 5 						# load 5 into t0
	li $t1, 5							# load 5 into t1 too
	beq $t0, $t1, to_here # t0 and t1 are both 5, so take branch
	nop 									# add a bunch of nops
	nop
	nop	
	nop
	li $s0, 1234					# this line should never execute since we took branch.
	
to_here:	
	add $s0, $t0, $t1			# finally, this line should execute and assign 10 to s0
