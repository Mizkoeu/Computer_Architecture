test:
	nop
	li $t0, 5
	li $t1, 10
	push $t0
	push $t1
	pop $s1
	pop $s2
	#	pop $s3 # intentionally breaking program
