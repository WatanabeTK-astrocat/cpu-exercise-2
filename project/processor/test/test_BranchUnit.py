import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def beq_1(dut):
    """Test branch unit with BEQ operation"""

    # Arrange
    dut.compInA.value = 12
    dut.compInB.value = 12
    dut.opcode.value = 16  # Assuming op=16 corresponds to BEQ

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 1, f"BEQ operation failed: {dut.brTaken.value} != 1"

@cocotb.test()
async def beq_2(dut):
    """Test branch unit with BEQ operation"""

    # Arrange
    dut.compInA.value = 12
    dut.compInB.value = 15
    dut.opcode.value = 16  # Assuming op=16 corresponds to BEQ

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 0, f"BEQ operation failed: {dut.brTaken.value} != 0"

@cocotb.test()
async def beq_3(dut):
    """Test branch unit with BEQ operation"""

    # Arrange
    dut.compInA.value = -12
    dut.compInB.value = -12
    dut.opcode.value = 16  # Assuming op=16 corresponds to BEQ

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 1, f"BEQ operation failed: {dut.brTaken.value} != 1"

@cocotb.test()
async def bne_1(dut):
    """Test branch unit with BNE operation"""

    # Arrange
    dut.compInA.value = 12
    dut.compInB.value = 12
    dut.opcode.value = 17  # Assuming op=17 corresponds to BNE

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 0, f"BNE operation failed: {dut.brTaken.value} != 0"

@cocotb.test()
async def bne_2(dut):
    """Test branch unit with BNE operation"""

    # Arrange
    dut.compInA.value = 12
    dut.compInB.value = 15
    dut.opcode.value = 17  # Assuming op=17 corresponds to BNE

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 1, f"BNE operation failed: {dut.brTaken.value} != 1"

@cocotb.test()
async def blt_1(dut):
    """Test branch unit with BLT operation"""

    # Arrange
    dut.compInA.value = 12
    dut.compInB.value = 15
    dut.opcode.value = 20  # Assuming op=20 corresponds to BLT

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 1, f"BLT operation failed: {dut.brTaken.value} != 1"

@cocotb.test()
async def blt_2(dut):
    """Test branch unit with BLT operation"""

    # Arrange
    dut.compInA.value = 15
    dut.compInB.value = 12
    dut.opcode.value = 20  # Assuming op=20 corresponds to BLT

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 0, f"BLT operation failed: {dut.brTaken.value} != 0"

@cocotb.test()
async def blt_3(dut):
    """Test branch unit with BLT operation"""

    # Arrange
    dut.compInA.value = -15
    dut.compInB.value = 12
    dut.opcode.value = 20  # Assuming op=20 corresponds to BLT

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 1, f"BLT operation failed: {dut.brTaken.value} != 1"

@cocotb.test()
async def bge_1(dut):
    """Test branch unit with BGE operation"""

    # Arrange
    dut.compInA.value = 12
    dut.compInB.value = 15
    dut.opcode.value = 21  # Assuming op=21 corresponds to BGE

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 0, f"BGE operation failed: {dut.brTaken.value} != 0"

@cocotb.test()
async def bge_2(dut):
    """Test branch unit with BGE operation"""

    # Arrange
    dut.compInA.value = 15
    dut.compInB.value = 12
    dut.opcode.value = 21  # Assuming op=21 corresponds to BGE

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 1, f"BGE operation failed: {dut.brTaken.value} != 1"

@cocotb.test()
async def bltu_1(dut):
    """Test branch unit with BLTU operation"""

    # Arrange
    dut.compInA.value = 12
    dut.compInB.value = 15
    dut.opcode.value = 22  # Assuming op=22 corresponds to BLTU

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 1, f"BLTU operation failed: {dut.brTaken.value} != 1"

@cocotb.test()
async def bltu_2(dut):
    """Test branch unit with BLTU operation"""

    # Arrange
    dut.compInA.value = 15
    dut.compInB.value = 12
    dut.opcode.value = 22  # Assuming op=22 corresponds to BLTU

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 0, f"BLTU operation failed: {dut.brTaken.value} != 0"

@cocotb.test()
async def bltu_3(dut):
    """Test branch unit with BLTU operation"""

    # Arrange
    dut.compInA.value = -15
    dut.compInB.value = 12
    dut.opcode.value = 22  # Assuming op=22 corresponds to BLTU

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 0, f"BLTU operation failed: {dut.brTaken.value} != 0"

@cocotb.test()
async def bgeu_1(dut):
    """Test branch unit with BGEU operation"""

    # Arrange
    dut.compInA.value = 12
    dut.compInB.value = 15
    dut.opcode.value = 23  # Assuming op=23 corresponds to BGEU

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 0, f"BGEU operation failed: {dut.brTaken.value} != 0"

@cocotb.test()
async def bgeu_2(dut):
    """Test branch unit with BGEU operation"""

    # Arrange
    dut.compInA.value = 15
    dut.compInB.value = 12
    dut.opcode.value = 23  # Assuming op=23 corresponds to BGEU

    # Act & Assert
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.brTaken.value == 1, f"BGE operation failed: {dut.brTaken.value} != 1"
