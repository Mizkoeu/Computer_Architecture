# This is a sample assembly program that allows you to test the implementation of an addi instruction in your PIPS datapath.
# This program will begin executing at the first assembly instruction regardless of what label you give it.
subi_test:
  subi $t0, $zero, 6  # Load -6 into $t0
  subi $t1, $t0, 1    # Set $t1 to $t0+1
  subi $t2, $t1, 1    # Set $t2 to $t1+1
  subi $t3, $t2, 1    # Set $t3 to $t2+1
