.constant TERMINAL 0xff10
.constant HALT 0xff00

nop # first instr not execute
main:
	li $s0, TERMINAL
	li $sp, 0xf800
	# for printing whitespace
	li $s3, 0x20
	#### NOTE: DO NOT CHANGE $s0, $s3 under any circumstances.
	# to test print decimal number function
	li $a0, 15
	li $s1, 0
	# create a while loop to print all numbers
print_loop:
	beq $s1, $a0, exit_program
	nop
	# Increment $s1 counter by 1
	addi $s1, $s1, 1
	# Push values onto stack
	addi $sp, $sp, -8
	sw $a0, 0($sp)
	sw $s1, 4($sp)
	# set up argument
	addi $a0, $s1, 0
	# Compute the fibo number using recursion!
	jal fibonacci_calc
	nop
	# Set result to $a0 argument and print it!
	addi $a0, $v0, 0
	jal print_number
	nop
	# insert a whitespace
	sb $s3, 0($s0)
	# Restore the stack
	lw $a0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	j print_loop
	nop

exit_program:
	# else just exit the program
	j HALT
	nop

fibonacci_calc:
	li $t1, 1
	li $t2, 2
	# if n is 1
	bne $a0, $t1, notequalone
	nop
	# if not, print and return 1
	#addi $v0, $t1, 0x30 
	#sb $v0, 0($s0)
	# print whitespace
	#sb $s3, 0($s0)
	addi $v0, $t1, 0
	jr $ra
	nop
	
	# if n is 2
notequalone:
	bne $a0, $t2, notequaltwo
	nop
	# if not, print and return 2
	#addi $v0, $t1, 0x30 
	#sb $v0, 0($s0)
	# print whitespace
	#sb $s3, 0($s0)
	addi $v0, $t1, 0
	jr $ra
	nop

	# else just compute sum of prev two fibs
notequaltwo:
	# Push down stack to store $ra and $a0 for later.
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)

	# Call fibonacci(n-2) first
	addi $a0, $a0, -2
	jal fibonacci_calc
	nop
	addi $s1, $v0, 0
	sw $s1, 8($sp)

	# Call fibonacci(n-1) then
	lw $a0, 4($sp)
	addi $a0, $a0, -1
	jal fibonacci_calc
	nop
	addi $s2, $v0, 0

	# Compute sum and print it!
	lw $s1, 8($sp)
	add $v0, $s1, $s2
	# store result into $a0 and call print
	#addi $a0, $v0, 0
	#addi $s1, $v0, 0 # move from v0 to s1 to use later
	#jal print_number
	#nop

	# add a whitespace
	#sb $s3, 0($s0)
	# restore v0 value
	#addi $v0, $s1, 0  
	# Restore stack contents
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	# return 
	jr $ra
	nop

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
	
