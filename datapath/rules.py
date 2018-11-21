import assembler
import pips

# The instruction decorator tells the assembler to create a new syntax rule for add instructions.
# The "#" spots indicate operands, which are passed in as parameters to the function below.
# The second parameter indicates the number of instructions this rule will create (1 in this case)

@assembler.instruction('add #, #, #', 1)
def add_instr(dest, operand1, operand2):
  return pips.rformat(opcode='add', r0=dest, r1=operand1, r2=operand2)

# Encode an addi instruction
@assembler.instruction('addi #, #, #', 1)
def addi(dest, op1, immediate):
  return pips.iformat(opcode='add', r0=dest, r1=op1, imm=immediate)

# Encode nop instruction
@assembler.instruction('nop', 1)
def nop():
  return add_instr('$zero', '$zero', '$zero')

# Encode the li pseudoinstruction using an addition to zero
@assembler.instruction('li #, #', 1)
def li(dest, immediate):
  return addi(dest, '$zero', immediate)

@assembler.instruction('sub #, #, #', 1)
def sub_instr(dest, operand1, operand2):
  return pips.rformat(opcode='sub', r0=dest, r1=operand1, r2=operand2)

@assembler.instruction('subi #, #, #', 1)
def subi(dest, op1, immediate):
  return pips.iformat(opcode='sub', r0=dest, r1=op1, imm=immediate)

# Encode and instruction
@assembler.instruction('and #, #, #', 1)
def and_instr(dest, operand1, operand2):
  return pips.rformat(opcode='and', r0=dest, r1=operand1, r2=operand2)

# Encode andi instruction
@assembler.instruction('andi #, #, #', 1)
def andi(dest, op1, immediate):
  return pips.iformat(opcode='and', r0=dest, r1=op1, imm=immediate)

# Encode or instruction
@assembler.instruction('or #, #, #', 1)
def or_instr(dest, operand1, operand2):
  return pips.rformat(opcode='or', r0=dest, r1=operand1, r2=operand2)

# Encode ori instruction
@assembler.instruction('ori #, #, #', 1)
def ori(dest, op1, immediate):
  return pips.iformat(opcode='or', r0=dest, r1=op1, imm=immediate)

# Encode nand instruction
@assembler.instruction('nand #, #, #', 1)
def nand_instr(dest, operand1, operand2):
  return pips.rformat(opcode='nand', r0=dest, r1=operand1, r2=operand2)

# Encode nandi instruction
@assembler.instruction('nandi #, #, #', 1)
def nandi(dest, op1, immediate):
  return pips.iformat(opcode='nand', r0=dest, r1=op1, imm=immediate)

# Encode nor instruction
@assembler.instruction('nor #, #, #', 1)
def nor_instr(dest, op1, op2):
  return pips.rformat(opcode='nor', r0=dest, r1=op1, r2=op2)

# Encode nori instruction
@assembler.instruction('nori #, #, #', 1)
def nori(dest, op1, immediate):
  return pips.iformat(opcode='nor', r0=dest, r1=op1, imm=immediate)

# Encode xor instruction
@assembler.instruction('xor #, #, #', 1)
def xor_instr(dest, op1, op2):
  return pips.rformat(opcode='xor', r0=dest, r1=op1, r2=op2)

# Encode xori instruction
@assembler.instruction('xori #, #, #', 1)
def xori(dest, op1, immediate):
  return pips.iformat(opcode='xor', r0=dest, r1=op1, imm=immediate)

# Encode slt instruction
@assembler.instruction('slt #, #, #', 1)
def slt(dest, op1, op2):
  return pips.rformat(opcode='slt', r0=dest, r1=op1, r2=op2)

# Encode slti instruction
@assembler.instruction('slti #, #, #', 1)
def slti(dest, op1, immediate):
  return pips.iformat(opcode='slt', r0=dest, r1=op1, imm=immediate)

# Encode sltu instruction
@assembler.instruction('sltu #, #, #', 1)
def sltu(dest, op1, op2):
  return pips.rformat(opcode='sltu', r0=dest, r1=op1, r2=op2)

# Encode sltiu instruction
@assembler.instruction('sltiu #, #, #', 1)
def sltiu(dest, op1, immediate):
  return pips.iformat(opcode='sltu', r0=dest, r1=op1, imm=immediate)

# Encode j instruction
@assembler.instruction('j #', 1)
def jump(label):
  return pips.iformat(opcode='j', r0='$zero', r1='$zero', imm=label)

# Encode jr instruction
@assembler.instruction('jr #', 1)
def jump_register(register):
  return pips.rformat(opcode='j', r0='$zero', r1='$zero', r2=register)

# Encode jal instruction
@assembler.instruction('jal #', 1)
def jump_link(label):
  return pips.iformat(opcode='j', r0='$ra', r1='$zero', imm=label, link=True)

# Encode beq instruction
@assembler.instruction('beq #, #, #', 1)
def beq(op1, op2, label):
  return pips.iformat(opcode='beq', r0=op1, r1=op2, imm=label)

# Encode bne instruction
@assembler.instruction('bne #, #, #', 1)
def bne(op1, op2, label):
  return pips.iformat(opcode='bne', r0=op1, r1=op2, imm=label)

# Encode lw instruction
@assembler.instruction('lw #, #(#)', 1)
def load_word(write, offset, addr):
  return pips.iformat(opcode='lw', r0=write, r1=addr, imm=offset)

# Encode lb instruction
@assembler.instruction('lb #, #(#)', 1)
def load_byte(write, offset, addr):
  return pips.iformat(opcode='lb', r0=write, r1=addr, imm=offset)

# Encode sw instruction
@assembler.instruction('sw #, #(#)', 1)
def store_word(read, offset, addr):
  return pips.iformat(opcode='sw', r0=read, r1=addr, imm=offset)

# Encode sb instruction
@assembler.instruction('sb #, #(#)', 1)
def store_byte(read, offset, addr):
  return pips.iformat(opcode='sb', r0=read, r1=addr, imm=offset)

# Encode sll instruction
@assembler.instruction('sll #, #, #', 1)
def sll(dest, shift_reg, shift):
    return pips.rformat(opcode='add', r0=dest, r1='$zero', r2=shift_reg, shift_type=pips.SHIFT_LEFT, shift_amt=shift)

# Encode srl instruction
@assembler.instruction('srl #, #, #', 1)
def srl(dest, shift_reg, shift):
    return pips.rformat(opcode='add', r0=dest, r1='$zero', r2=shift_reg,
            shift_type=pips.SHIFT_RIGHT_LOGICAL, shift_amt=shift)

# Encode sra instruction
@assembler.instruction('sra #, #, #', 1)
def sra(dest, shift_reg, shift):
    return pips.rformat(opcode='add', r0=dest, r1='$zero', r2=shift_reg,
            shift_type=pips.SHIFT_RIGHT_ARITHMETIC, shift_amt=shift)

# Encode not pseudoinstruction
@assembler.instruction('not #, #', 1)
def not_instr(destination, src):
    return xori(dest = destination, op1 = src, immediate = '-1')

# push and pop
@assembler.instruction('push #', 2) # <- notice the 2 here. This tells the assembler that we will emit two instructions for this rule
def push_instr(reg):
  return addi('$sp', '$sp', '-2') + store_word(reg, 0, '$sp')

# pop
@assembler.instruction('pop #', 2) # <- notice the 2 here. This tells the assembler that we will emit two instructions for this rule
def pop_instr(reg):
  return load_word(reg, 0, '$sp') + addi('$sp', '$sp', '2')

# blt branch less than
@assembler.instruction('blt! #, #, #', 2)
def blt_instr(op1, op2, label):
  return slt(op1, op1, op2) + bne(op1, '$zero', label)

# ble branch less than or equal
@assembler.instruction('ble! #, #, #', 2)
def ble_instr(op1, op2, label):
  return slt(op1, op2, op1) + beq(op1, '$zero', label)

# bgt branch greater than
@assembler.instruction('bgt! #, #, #', 2)
def bgt_instr(op1, op2, label):
  return slt(op1, op2, op1) + bne(op1, '$zero', label)

# bge branch greater than or equal
@assembler.instruction('bge! #, #, #', 2)
def bge_instr(op1, op2, label):
  return slt(op1, op1, op2) + beq(op1, '$zero', label)

