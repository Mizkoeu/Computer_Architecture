halt_test:
	li $t0, 5
	li $t1, 10
	add $t2, $t1, $t0
	j 0xff00
	nop
