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
  sw $t0, 0($s0)
  li $t1, '\n'
  beq $t0, $t1, end
  j loop_top

end:
  li $s0, HALT
  jr $s0
