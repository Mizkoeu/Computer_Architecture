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
  lw $t0, 0($s1)     # read from keyboard
	beq $t0, $zero, loop_top # if no input, then keep spin-waiting.
  sw $t0, 0($s0)     # write to terminal

	li $s2, '+'        # load '+' operator for comparison
	beq $t0, $s2, loop_top  # if the char is '+', then loop back without storing

	li $s2, '\n'
  beq $t0, $s2, compute_sum # if char is newline, start calculating sum.
	addi $t0, $t0, -48 # compute the number
	push $t0           # store into stack pointer pos
  j loop_top

compute_sum:
	li $t3, STACK_TOP
	beq $t3, $sp, end  # if nothing is stored in the stack, end program.
	pop $t1						 # pop stack to get the digit
	pop $t2            # pop stack again to get next digit

	add $a0, $t1, $t2  # add them up and store into argument for printing
	jal print_number   # now we can print the sum
	li $t0, 10         # print a new line for next prompt
	sw $t0, 0($s0)     # output to terminal!

	# before jumping back to loop_top, restore all constants.
	li $s0, TERMINAL
  li $s1, KB
	j loop_top         # afterwhich, we go back to loop_top to wait for input.

end:
	j HALT     				 # end the program gracefully.

# finally we can simply print the number!
print_number:
	bne $a0, $zero, else
	nop
	li $t0, 0x30
	sw $t0, 0($s0)
	j print_return #jump to return from print_num func

else:
	# push down the stack to store $ra and $a0
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	# load second argument of value 10
	li $a1, 10
	# jump to remainder subroutine to find $a0 % 10
	jal remainder
	# load the result $v0 into $s1
	addi $s1, $v0, 0
	# Store $s1, the remainder, which will be restored.
	sw $s1, 8($sp)
	# load back $a0 as the original n number
	lw $a0, 4($sp)
	# compare the remainder (digit) with n
	slt $t2, $s1, $a0 # t1 is digit, a0 is n
	beq $t2, $zero, post_recursion

	## store n into $a0
	li $a1, 10 # can be deleted later
	## jump and link to quotient
	jal quotient

	# store n / 10 into $a0
	addi $a0, $v0, 0
	# RECURSION STARTS HERE!!!
	jal print_number

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

# remainder subroutine
remainder:
	# $a0, $a1
	slt $t0, $a0, $a1
	bne $t0, $zero, remainder_return
remainder_while:
	sub $a0, $a0, $a1
	slt $t1, $a0, $a1
	beq $t1, $zero, remainder_while
remainder_return:
	addi $v0, $a0, 0
	jr $ra

# quotient subroutine
quotient:
	li $t2, 0
	slt $t0, $a0, $a1
	bne $t0, $zero, quotient_return
quotient_while:
	sub $a0, $a0, $a1
	addi $t2, $t2, 1
	slt $t1, $a0, $a1
	beq $t1, $zero, quotient_while
quotient_return:
	addi $v0, $t2, 0
	jr $ra
