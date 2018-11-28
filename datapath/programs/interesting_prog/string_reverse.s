.constant HALT 0xff00
.constant TERM 0xff10
.constant KB 0xff20
.constant STACK_TOP 0xf800

nop
main:
  li $s0, TERM
  li $s1, KB
  li $sp, STACK_TOP
  
loop_top:
  lw $t0, 0($s1)
  beq $t0, $zero, loop_top
	addi $sp, $sp, -4
	# write to terminal
  sw $t0, 0($s0)
  li $t1, '\n'
  beq $t0, $t1, print_reverse
	# store into stack pointer pos
	sw $t0, 0($sp)
  j loop_top

print_reverse:
	lw $t2, 0($sp)
	sw $t2, 0($s0)
	addi $sp, $sp, 4
	li $t3, STACK_TOP
	beq $t3, $sp, end
	j print_reverse

end:
  li $s0, HALT
  jr $s0
