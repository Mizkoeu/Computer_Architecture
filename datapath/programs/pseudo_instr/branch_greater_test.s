branch_test:
	nop
	li $t0, 3
	li $t1, 6
	li $t2, 3
	bgt! $t1, $t0, somewhere
	li $s0, 3
	j branch_test

somewhere:
	li $s0, 10
	bge! $t0, $t2, else
	li $s0, 3

else:
	li $s0, 11
