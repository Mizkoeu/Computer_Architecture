# This is a simple program that tests the implementation of your li and add instructions.
add_test:
  li $s0, 3          # Load a 3 into $s0
  add $s1, $s0, $s0  # Store $s0 + $s0 into $s1
  add $s2, $s1, $s1  # Store $s1 + $s1 into $s2
  add $s3, $s2, $s2  # Store $s2 + $s2 into $s3
