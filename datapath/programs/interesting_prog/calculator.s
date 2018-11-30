# a simple one-function calculator
.constant TERMINAL 0xff10
.constant KB 0xff20
.constant STACK_TOP 0xf800
.constant HALT 0xff00

nop # first instr not execute
main:
	li $s0, TERMINAL
  li $s1, KB
  li $sp, STACK_TOP

loop_top:
  lw $t0, 0($s1)
	beq $t0, $zero, loop_top
	# write to terminal
  sw $t0, 0($s0)

	li $s3, 43     # load '+' operator for comparison
	beq $t0, $s3, loop_top

	li $s2, '\n'
  beq $t0, $s2, compute_sum
	addi $sp, $sp, -4
	addi $t0, $t0, -48 # compute the number
	# store into stack pointer pos
	sw $t0, 0($sp)
  j loop_top

compute_sum:
	li $t3, STACK_TOP
	beq $t3, $sp, end
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	lw $t1, 0($sp)
	add $a1, $t1, $t2
	jal print_number
	j loop_top

end:
	j HALT

# finally we can simply print the number!
print_number:
	bne $a0, $zero, else
	nop
	li $t0, 0x30
	sb $t0, 0($s0)
	j print_return #jump to return from print_num func
	nop

else:
	# push down the stack to store $ra and $a0
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	# load second argument of value 10
	li $a1, 10
	# jump to remainder subroutine to find $a0 % 10
	jal remainder
	nop
	# load the result $v0 into $s1
	addi $s1, $v0, 0
	# Store $s1, the remainder, which will be restored.
	sw $s1, 8($sp)
	# load back $a0 as the original n number
	lw $a0, 4($sp)
	# compare the remainder (digit) with n
	slt $t2, $s1, $a0 # t1 is digit, a0 is n
	beq $t2, $zero, post_recursion
	nop

	## store n into $a0
	li $a1, 10 # can be deleted later
	## jump and link to quotient
	jal quotient
	nop

	# store n / 10 into $a0
	addi $a0, $v0, 0
	# RECURSION STARTS HERE!!!
	jal print_number
	nop

post_recursion:
	# Restore $s1 first
	lw $s1, 8($sp)
	# print '0' + digit
	addi $t0, $s1, 0x30
	sb $t0, 0($s0)

	# RESTORE STACK HEREEE!!
	# restore $a0, $ra
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	# move stack pointer
	addi $sp, $sp, 12

print_return:
	# return from procedure
  jr $ra
	nop

# remainder subroutine
remainder:
	# $a0, $a1
	slt $t0, $a0, $a1
	bne $t0, $zero, remainder_return
	nop
remainder_while:
	sub $a0, $a0, $a1
	slt $t1, $a0, $a1
	beq $t1, $zero, remainder_while
	nop
remainder_return:
	addi $v0, $a0, 0
	jr $ra
	nop

# quotient subroutine
quotient:
	li $t2, 0
	slt $t0, $a0, $a1
	bne $t0, $zero, quotient_return
	nop
quotient_while:
	sub $a0, $a0, $a1
	addi $t2, $t2, 1
	slt $t1, $a0, $a1
	beq $t1, $zero, quotient_while
	nop
quotient_return:
	addi $v0, $t2, 0
	jr $ra
	nop
