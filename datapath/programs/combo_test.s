# This is a simple program that tests the implementation of all instructions
# listed in the lab, including nop, and, andi, or, ori, nand, nandi, nor, nori,
# xor, xori, slt, slti, sltu and sltiu 

combo_test:
	li $t0, 11 # load immediate value of 11 into t0
	li $t1, 7 # load immediate value of 7 into t1

	add $t2, $t0, $t1 # $t2 stores the sum of t0 and t1, which is 18
	addi $t3, $t2, 1 # $t3 stores incremented t2, which is 19

	sub $t2, $t2, $t3 # $t2 stores t2-t3 which is 18-19 = -1
	subi $t3, $t2, 6 # $t3 stores t2-6 which is -1-6 = -7

	and $s0, $t0, $t1 # $s0 is 1011 & 0111 which gives 0011 (3 in decimal)
	andi $s1, $t0, 4 # $s1 is 1011 & 0100 which should give 0000

	or $s0, $t0, $t1 # $s0 is 1011 | 0111 which gives 1111 (15 in decimal)
	ori $s1, $t0, 3 # $s1 is 1011 | 0011 which gives 1011 (11 in decimal)
	
	nop # no operation, does no useful work at all.

	nand $s2, $t0, $t1 # $s2 stores 1011 nand 0111 which gives 0xfffc (-4 in dec)
	nandi $s3, $t0, 2 # $s3 stores 1011 nandi 0010 which gives 0xfffd (-3 in dec)

	nor $s2, $t0, $t1 # $s2 stores 1011 nor 0111 which gives 0xfff0 (-16_dec)
	nori $s3, $t0, 10 # $s3 stores 1011 nori 1010 which gives 0xfff4 (-12_dec)

	xor $s0, $t0, $t1 # $s0 stores 1011 xor 0111 which gives 0x000c (12_dec)
	xori $s1, $t0, 13 # $s1 stores 1011 xori 1101 which gives 0x0006 (6_dec)

	slt $s0, $t2, $t3 # $s0 stores slt(-1, -7) which gives 0 
	slti $s1, $t2, 1 # $s1 stores slt(-1, 1) which gives 1

	sltu $s0, $s1, $t2 # $s0 stores sltu(1, ffff) which gives 1
	sltiu $s1, $t2, 7 # $s1 stores sltu(ffff, 7) which gives 0
	
