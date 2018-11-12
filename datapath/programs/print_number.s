.constant TERMINAL 0xff10
.constant HALT 0xff00

nop # first instr not execute
main:
	li $s0, TERMINAL
	li $sp, 0xf800
	
	# to test print decimal number function
	li $a0, 50

print_number:
	bne $a0, $zero, else
	nop
	li $t0, 0x30
	sb $t0, 0($s0)	
else:	
	li $a1, 10	
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	jal remainder
	nop
	addi $t1, $v0, 0
	
	lw $a0, 4($sp)

	slt $t2, $t1, $a0 #t1 is digit, a0 is n
	bne $t2, $zero, post_recursion
	nop

	# recursion starts here
	# store n / 10 into $a0
	## store n into $a0
	li $a1, 10 # can be deleted later
	## jump and link to quotient
	jal quotient
	nop
	
	addi $a0, $v0, 0
	jal print_number
	nop

	# restore $a0, $ra
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	# move stack pointer
	addi $sp, $sp, 8
	
post_recursion:
	# print '0' + digit
	addi $t0, $t1, 0x30
	sb $t0, 0($s0)	
	# return from procedure
  #	jr $ra
	j HALT
	nop	
	
remainder:
	# $a0, $a1
	slt $t0, $a0, $a1
	bne $t0, $zero, return
	nop
while:
	sub $a0, $a0, $a1
	slt $t1, $a0, $a1
	beq $t1, $zero, while
	nop
return:
	addi $v0, $a0, 0
	jr $ra
	nop

quotient:
	li $t2, 0
	slt $t0, $a0, $a1
	bne $t0, $zero, return
	nop
while:
	sub $a0, $a0, $a1
	addi $t2, $t2, 1
	slt $t1, $a0, $a1
	beq $t1, $zero, while
	nop
return:
	addi $v0, $t2, 0
	jr $ra
	nop
	
	
