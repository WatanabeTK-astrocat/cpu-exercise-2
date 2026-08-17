import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_ALU_addition_1(dut):
    """Test ALU with simple addition"""

    # Arrange
    dut.aluInA.value = 5
    dut.aluInB.value = 3
    dut.funct.value = 32  # Assuming op=32 corresponds to addition
    dut.shamt.value = 0

    # Act & Assert
    await cocotb.triggers.Timer(10, units='ns')
    assert dut.aluOut.value == 8, f"Addition failed: {dut.aluOut.value} != 8"

@cocotb.test()
async def test_ALU_addition_2(dut):
    """Test ALU with negative number addition"""

    # Arrange
    dut.aluInA.value = -5
    dut.aluInB.value = -3
    dut.funct.value = 32  # Assuming op=32 corresponds to addition
    dut.shamt.value = 0

    # Act & Assert
    await cocotb.triggers.Timer(10, units='ns')
    assert dut.aluOut.value == -8 + 2**32, f"Addition failed: {dut.aluOut.value} != -8 + 2**32"

@cocotb.test()
async def test_ALU_addition_3(dut):
    """Test ALU with zero addition"""

    # Arrange
    dut.aluInA.value = 0
    dut.aluInB.value = 0
    dut.funct.value = 32  # Assuming op=32 corresponds to addition
    dut.shamt.value = 0

    # Act & Assert
    await cocotb.triggers.Timer(10, units='ns')
    assert dut.aluOut.value == 0, f"Addition failed: {dut.aluOut.value} != 0"


