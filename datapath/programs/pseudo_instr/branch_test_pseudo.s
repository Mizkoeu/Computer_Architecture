branch_test:
	nop
	li $t0, 3
	li $t1, 6
	li $t2, 6
	blt! $t0, $t1, somewhere
	li $s0, 3
	j branch_test

somewhere:
	li $s0, 10
	ble! $t1, $t2, else
	li $s0, 3

else:
	li $s0, 11
