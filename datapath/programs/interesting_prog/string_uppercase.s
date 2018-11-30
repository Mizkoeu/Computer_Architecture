.constant HALT 0xff00
.constant TERM 0xff10
.constant KB 0xff20
.constant STACK_TOP 0xf800

nop
main:
	# set up the constants to be used later
  li $s0, TERM
  li $s1, KB
  li $sp, STACK_TOP

loop_top:
  lw $t0, 0($s1)
  beq $t0, $zero, loop_top
  # write to terminal
  sw $t0, 0($s0)
  li $t1, '\n'
  beq $t0, $t1, prom_process
  # store into stack pointer pos
	push $t0
  j loop_top

prom_process:
  li $t2, STACK_TOP
  beq $t2, $sp, end
	pop $t0
  li $t1, 97
  bge! $t0, $t1, smaller

continue:
  sw $t0, 0($s0)
  j prom_process

smaller:
  li $t2, 122
  ble! $t0, $t2, beupper
  j continue

beupper:
  addi $t0, $t0, -32
  j continue

end:
	j HALT
