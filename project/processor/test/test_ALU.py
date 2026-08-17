import cocotb
from cocotb.triggers import Timer

# ================================================================
# Addition Tests
# ================================================================

@cocotb.test()
async def addition_1(dut):
    """Test ALU with simple addition"""

    # Arrange
    dut.aluInA.value = 12
    dut.aluInB.value = 3
    dut.funct.value = 32  # Assuming op=32 corresponds to addition
    dut.shamt.value = 0

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 15, f"Addition failed: {dut.aluOut.value} != 15"

@cocotb.test()
async def addition_2(dut):
    """Test ALU with addition (no shamt influence)"""

    # Arrange
    dut.aluInA.value = 3
    dut.aluInB.value = 12
    dut.funct.value = 32  # Assuming op=32 corresponds to addition
    dut.shamt.value = 5   # shamt should not affect addition

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 15, f"Addition failed: {dut.aluOut.value} != 15"

@cocotb.test()
async def addition_3(dut):
    """Test ALU with negative number addition"""

    # Arrange
    dut.aluInA.value = -5
    dut.aluInB.value = -3
    dut.funct.value = 32  # Assuming op=32 corresponds to addition
    dut.shamt.value = 4   # shamt should not affect addition

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == -8 + 2**32, f"Addition failed: {dut.aluOut.value} != -8 + 2**32"

@cocotb.test()
async def addition_4(dut):
    """Test ALU with zero addition"""

    # Arrange
    dut.aluInA.value = 0
    dut.aluInB.value = 0
    dut.funct.value = 32  # Assuming op=32 corresponds to addition
    dut.shamt.value = 3   # shamt should not affect addition

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0, f"Addition failed: {dut.aluOut.value} != 0"

@cocotb.test()
async def addition_5(dut):
    """Test ALU with addition with large numbers without overflow"""

    # Arrange
    dut.aluInA.value = 2147483648
    dut.aluInB.value = 100
    dut.funct.value = 32  # Assuming op=32 corresponds to addition
    dut.shamt.value = 5   # shamt should not affect addition

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 2147483748, f"Addition failed: {dut.aluOut.value} != 2147483748"

@cocotb.test()
async def addition_6(dut):
    """Test ALU with addition with large numbers with overflow"""

    # Arrange
    dut.aluInA.value = 2147483649
    dut.aluInB.value = 2147483649
    dut.funct.value = 32  # Assuming op=32 corresponds to addition
    dut.shamt.value = 4   # shamt should not affect addition

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 2, f"Addition failed: {dut.aluOut.value} != 2"

# ================================================================
# Subtraction Tests
# ================================================================

@cocotb.test()
async def subtraction_1(dut):
    """Test ALU with simple subtraction"""

    # Arrange
    dut.aluInA.value = 12
    dut.aluInB.value = 3
    dut.funct.value = 34  # Assuming op=34 corresponds to subtraction
    dut.shamt.value = 0

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 9, f"Subtraction failed: {dut.aluOut.value} != 9"

@cocotb.test()
async def subtraction_2(dut):
    """Test ALU with subtraction with negative result"""

    # Arrange
    dut.aluInA.value = 3
    dut.aluInB.value = 12
    dut.funct.value = 34  # Assuming op=34 corresponds to subtraction
    dut.shamt.value = 5   # shamt should not affect subtraction

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == -9 + 2**32, f"Subtraction failed: {dut.aluOut.value} != -9+2**32"

@cocotb.test()
async def subtraction_3(dut):
    """Test ALU with subtraction with negative value"""

    # Arrange
    dut.aluInA.value = 3
    dut.aluInB.value = -12
    dut.funct.value = 34  # Assuming op=34 corresponds to subtraction
    dut.shamt.value = 15   # shamt should not affect subtraction

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 15, f"Subtraction failed: {dut.aluOut.value} != 15"

@cocotb.test()
async def subtraction_4(dut):
    """Test ALU with subtraction with zero"""

    # Arrange
    dut.aluInA.value = 3
    dut.aluInB.value = 0
    dut.funct.value = 34  # Assuming op=34 corresponds to subtraction
    dut.shamt.value = 15   # shamt should not affect subtraction

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 3, f"Subtraction failed: {dut.aluOut.value} != 3"

@cocotb.test()
async def subtraction_5(dut):
    """Test ALU with subtraction with large values without overflow"""

    # Arrange
    dut.aluInA.value = 2147483648
    dut.aluInB.value = 100
    dut.funct.value = 34  # Assuming op=34 corresponds to subtraction
    dut.shamt.value = 15   # shamt should not affect subtraction

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 2147483548, f"Subtraction failed: {dut.aluOut.value} != 2147483548"

@cocotb.test()
async def subtraction_6(dut):
    """Test ALU with subtraction with large values with overflow"""

    # Arrange
    dut.aluInA.value = 0
    dut.aluInB.value = 4294967295 # 2^32 - 1
    dut.funct.value = 34  # Assuming op=34 corresponds to subtraction
    dut.shamt.value = 15   # shamt should not affect subtraction

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 1, f"Subtraction failed: {dut.aluOut.value} != 1"

# ================================================================
# Logical Operation Tests
# ================================================================

@cocotb.test()
async def and_1(dut):
    """Test ALU with AND operation"""

    # Arrange
    dut.aluInA.value = 0b1100
    dut.aluInB.value = 0b1010
    dut.funct.value = 36  # Assuming op=36 corresponds to AND
    dut.shamt.value = 15   # shamt should not affect AND

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0b00000000000000000000000000001000, f"AND operation failed: {dut.aluOut.value} != 0b00000000000000000000000000001000"

@cocotb.test()
async def or_1(dut):
    """Test ALU with OR operation"""

    # Arrange
    dut.aluInA.value = 0b1100
    dut.aluInB.value = 0b1010
    dut.funct.value = 37  # Assuming op=37 corresponds to OR
    dut.shamt.value = 15   # shamt should not affect OR

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0b00000000000000000000000000001110, f"OR operation failed: {dut.aluOut.value} != 0b00000000000000000000000000001110"

@cocotb.test()
async def xor_1(dut):
    """Test ALU with XOR operation"""

    # Arrange
    dut.aluInA.value = 0b1100
    dut.aluInB.value = 0b1010
    dut.funct.value = 38  # Assuming op=38 corresponds to XOR
    dut.shamt.value = 15   # shamt should not affect XOR

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0b00000000000000000000000000000110, f"XOR operation failed: {dut.aluOut.value} != 0b00000000000000000000000000000110"

@cocotb.test()
async def nor_1(dut):
    """Test ALU with NOR operation"""

    # Arrange
    dut.aluInA.value = 0b1100
    dut.aluInB.value = 0b1010
    dut.funct.value = 39  # Assuming op=39 corresponds to NOR
    dut.shamt.value = 15   # shamt should not affect NOR

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0b11111111111111111111111111110001, f"NOR operation failed: {dut.aluOut.value} != 0b11111111111111111111111111110001"

@cocotb.test()
async def slt_1(dut):
    """Test ALU with SLT operation"""

    # Arrange
    dut.aluInA.value = 1
    dut.aluInB.value = 3
    dut.funct.value = 42  # Assuming op=42 corresponds to SLT
    dut.shamt.value = 15   # shamt should not affect SLT

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 1, f"SLT operation failed: {dut.aluOut.value} != 1"

@cocotb.test()
async def slt_2(dut):
    """Test ALU with SLT operation"""

    # Arrange
    dut.aluInA.value = 3
    dut.aluInB.value = 1
    dut.funct.value = 42  # Assuming op=42 corresponds to SLT
    dut.shamt.value = 15   # shamt should not affect SLT

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0, f"SLT operation failed: {dut.aluOut.value} != 0"

@cocotb.test()
async def slt_3(dut):
    """Test ALU with SLT operation"""

    # Arrange
    dut.aluInA.value = -1
    dut.aluInB.value = -3
    dut.funct.value = 42  # Assuming op=42 corresponds to SLT
    dut.shamt.value = 15   # shamt should not affect SLT

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0, f"SLT operation failed: {dut.aluOut.value} != 0"

@cocotb.test()
async def slt_4(dut):
    """Test ALU with SLT operation"""

    # Arrange
    dut.aluInA.value = -3
    dut.aluInB.value = 1
    dut.funct.value = 42  # Assuming op=42 corresponds to SLT
    dut.shamt.value = 15   # shamt should not affect SLT

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 1, f"SLT operation failed: {dut.aluOut.value} != 1"

# ================================================================
# Shift Operation Tests
# ================================================================


@cocotb.test()
async def sll_1(dut):
    """Test ALU with SLL operation"""

    # Arrange
    dut.aluInA.value = 0
    dut.aluInB.value = 0b1010
    dut.funct.value = 0  # Assuming op=0 corresponds to SLL
    dut.shamt.value = 2   # shamt should affect SLL

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0b101000, f"SLL operation failed: {dut.aluOut.value} != 0b101000"

@cocotb.test()
async def srl_1(dut):
    """Test ALU with SRL operation"""

    # Arrange
    dut.aluInA.value = 0
    dut.aluInB.value = 0b1010
    dut.funct.value = 2  # Assuming op=2 corresponds to SRL
    dut.shamt.value = 2   # shamt should affect SRL

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0b10, f"SRL operation failed: {dut.aluOut.value} != 0b10"

@cocotb.test()
async def srl_2(dut):
    """Test ALU with SRL operation"""

    # Arrange
    dut.aluInA.value = 0
    dut.aluInB.value = 0b11111111111111111111111111110001
    dut.funct.value = 2  # Assuming op=2 corresponds to SRL
    dut.shamt.value = 2   # shamt should affect SRL

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0b00111111111111111111111111111100, f"SRL operation failed: {dut.aluOut.value} != 0b00111111111111111111111111111100"

@cocotb.test()
async def sra_1(dut):
    """Test ALU with SRA operation"""

    # Arrange
    dut.aluInA.value = 0
    dut.aluInB.value = 0b1010
    dut.funct.value = 3  # Assuming op=3 corresponds to SRA
    dut.shamt.value = 2   # shamt should affect SRA

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0b10, f"SRA operation failed: {dut.aluOut.value} != 0b10"

@cocotb.test()
async def sra_2(dut):
    """Test ALU with SRA operation"""

    # Arrange
    dut.aluInA.value = 0
    dut.aluInB.value = 0b11111111111111111111111111110001
    dut.funct.value = 3  # Assuming op=3 corresponds to SRA
    dut.shamt.value = 2   # shamt should affect SRA

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.aluOut.value == 0b11111111111111111111111111111100, f"SRA operation failed: {dut.aluOut.value} != 0b11111111111111111111111111111100"
