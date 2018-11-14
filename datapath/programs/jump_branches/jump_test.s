# This is a simple program that tests the implementation of all instructions
# listed in the lab, including nop, and, andi, or, ori, nand, nandi, nor, nori,
# xor, xori, slt, slti, sltu and sltiu 

combo_test:
	nop
	li $ra, 28 # initially set up $ra to be 28, which is the addr of loop section 

jump_to_here:
	li $t0, 2 # load immediate value of 2 into t0
	li $t1, 7 # load immediate value of 7 into t1
	jr $ra    # the first time it'll jump to loop section, but
						# second time it jumps to the nop after the jal instruction.
	nop
	nop

loop:
	add $t1, $t0, $t1 # store sum of t0 and t1, which is 9, into t1.
	jal jump_to_here # jump and link to jump_to_here (writes addr of next)
	nop
	addi $t1, $t1, 1 # increment $t1 by 1
	j loop    # jumps back to the loop section again
	nop
