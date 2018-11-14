# This is a simple program that tests the implem
sub_test:
  li $s0, 12          # Load a 12 into $s0
	li $t0, 3						# Load a 3 into $s4
  sub $s1, $s0, $t0  # Store $s0 + $s0 into $s1
  sub $s2, $s1, $t0  # Store $s1 + $s1 into $s2
  sub $s3, $s2, $t0  # Store $s2 + $s2 into $s3
