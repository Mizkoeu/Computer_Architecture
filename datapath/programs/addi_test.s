# This is a sample assembly program that allows you to test the implementation of an addi instruction in your PIPS datapath.
# This program will begin executing at the first assembly instruction regardless of what label you give it.
addi_test:
  addi $t0, $zero, 0  # Load zero into $t0
  addi $t1, $t0, 1    # Set $t1 to $t0+1
  addi $t2, $t1, 1    # Set $t2 to $t1+1
  addi $t3, $t2, 1    # Set $t3 to $t2+1
  