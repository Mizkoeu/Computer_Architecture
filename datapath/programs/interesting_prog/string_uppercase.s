.constant HALT 0xff00
.constant TERM 0xff10
.constant KB 0xff20
.constant STACK_TOP 0xf800

nop
main:
	# set up the constants to be used later
  li $s0, TERM
  li $s1, KB
  li $sp, STACK_TOP  # initialize the stack pointer at the top
	li $s2, STACK_TOP  # to implement queue, need a pointer at head to dequeue.

loop_top:
  lw $t0, 0($s1)
  beq $t0, $zero, loop_topi  # if no input, simply keep spin-waiting.
  sw $t0, 0($s0)      # write to terminal
  li $t1, '\n'
  beq $t0, $t1, prom_process # if newline is read, go print line in uppercase.
	push $t0            # store into stack pointer pos
  j loop_top

prom_process:
	beq $s2, $sp, end   # if $s2 moved down below $sp, then end program
	addi $s2, $s2, -4   # iterate through stack from top to where $sp is.
	lw $t0, 0($s2)
  li $t1, 97 					# this is character encoding for 'a'
  ble! $t1, $t0, smaller # if char is below 'a', print without uppercase

continue:
  sw $t0, 0($s0)      # write the converted char to terminal
  j prom_process      # after which, we go back and continue down the stack

smaller:
  li $t2, 122					# this is character encoding for 'z'
  bge! $t2, $t0, beupper # if within a-z, then go convert to upper
	j continue    			# if char is beyond 'z', print without uppercase

beupper:
  addi $t0, $t0, -32  # convert from lower to upper case here.
  j continue					# proceed with printing!

end:
	li $sp, STACK_TOP   # some cleanup work, restore $sp to the top.
	j HALT
