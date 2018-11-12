# This is a simple program that tests the implementation of all instructions
# listed in the lab, including nop, and, andi, or, ori, nand, nandi, nor, nori,
# xor, xori, slt, slti, sltu and sltiu 

combo_test:
	nop
	li $ra, 24
	li $t0, 2 # load immediate value of 11 into t0
	li $t1, 7 # load immediate value of 7 into t1
	jr $ra
	nop
	nop

loop:
	add $t1, $t0, $t1
	jal combo_test
	nop
	add $t1, $t0, $t1
	jr $ra
