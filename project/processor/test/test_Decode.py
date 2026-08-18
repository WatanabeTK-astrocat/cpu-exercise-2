import cocotb
from cocotb.triggers import Timer

# ================================================================
# R_Type Tests
# ================================================================

@cocotb.test()
async def add_1(dut):
    """Test Decoder: add operation"""

    # Arrange
    dut.insn.value = 0b

    # Act & Assert
    await Timer(10, unit='ns')
    assert dut.aluOut.value == 15, f"Addition failed: {dut.aluOut.value} != 15"