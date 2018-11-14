load_test:
	nop
	li $s0, 5
	li $t0, 0
	sw $s0, 0($t0)
	lw $t1, 0($t0)
	
	li $s1, 0x0101
	sb $s1, 4($t0)
	lb $t2, 4($t0)
	lb $t3, 4($t0)
	
