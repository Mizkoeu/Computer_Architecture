branch_not:
	nop
	li $t0, 5
	li $t1, 7
	bne $t0, $t1, to_here
	nop
	nop
	nop	
	nop
	
to_here:	
	add $s0, $t0, $t1

