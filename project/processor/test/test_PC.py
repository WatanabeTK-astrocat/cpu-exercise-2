import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

@cocotb.test()
async def normal_operation(dut):
    """Test normal operation of PC"""

    # Arrange
    # このようにリセットしないと、なぜかテストケース間でpcの値がもつれ込んでしまう
    dut.rst.value = 1
    await cocotb.triggers.Timer(10, unit='ns')
    dut.rst.value = 0

    c = Clock(dut.clk, 10, unit="ns")

    # Act & Assert
    assert dut.addrOut.value == 0, f"Normal operation failed: {dut.addrOut.value} != 0"
    cocotb.start_soon(c.start())
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 4, f"Normal operation failed: {dut.addrOut.value} != 4"
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 8, f"Normal operation failed: {dut.addrOut.value} != 8"
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 12, f"Normal operation failed: {dut.addrOut.value} != 12"

@cocotb.test()
async def reset(dut):
    """Test PC reset"""

    # Arrange
    # このようにリセットしないと、なぜかテストケース間でpcの値がもつれ込んでしまう
    dut.rst.value = 1
    await cocotb.triggers.Timer(10, unit='ns')
    dut.rst.value = 0

    c = Clock(dut.clk, 10, unit="ns")

    # Act & Assert
    assert dut.addrOut.value == 0, f"Normal operation failed: {dut.addrOut.value} != 0"
    cocotb.start_soon(c.start())
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 4, f"Normal operation failed: {dut.addrOut.value} != 4"
    dut.rst.value = 1
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 0, f"Normal operation failed: {dut.addrOut.value} != 0"
    dut.rst.value = 0
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 4, f"Normal operation failed: {dut.addrOut.value} != 4"

@cocotb.test()
async def write(dut):
    """Test PC write"""

    # Arrange
    # このようにリセットしないと、なぜかテストケース間でpcの値がもつれ込んでしまう
    dut.rst.value = 1
    await cocotb.triggers.Timer(10, unit='ns')
    dut.rst.value = 0

    c = Clock(dut.clk, 10, unit="ns")

    # Act & Assert
    assert dut.addrOut.value == 0, f"Normal operation failed: {dut.addrOut.value} != 0"
    cocotb.start_soon(c.start())
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 4, f"Normal operation failed: {dut.addrOut.value} != 4"
    dut.wrEnable.value = 1
    dut.addrIn.value = 400
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 400, f"Normal operation failed: {dut.addrOut.value} != 400"
    dut.wrEnable.value = 0
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 404, f"Normal operation failed: {dut.addrOut.value} != 404"

@cocotb.test()
async def stall(dut):
    """Test PC stall"""

    # Arrange
    # このようにリセットしないと、なぜかテストケース間でpcの値がもつれ込んでしまう
    dut.rst.value = 1
    await cocotb.triggers.Timer(10, unit='ns')
    dut.rst.value = 0

    c = Clock(dut.clk, 10, unit="ns")

    # Act & Assert
    assert dut.addrOut.value == 0, f"Normal operation failed: {dut.addrOut.value} != 0"
    cocotb.start_soon(c.start())
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 4, f"Normal operation failed: {dut.addrOut.value} != 4"
    dut.stall.value = 1
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 4, f"Normal operation failed: {dut.addrOut.value} != 4"
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 4, f"Normal operation failed: {dut.addrOut.value} != 4"
    dut.stall.value = 0
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 8, f"Normal operation failed: {dut.addrOut.value} != 8"

@cocotb.test()
async def stall_and_write(dut):
    """Test PC stall and write"""

    # Arrange
    # このようにリセットしないと、なぜかテストケース間でpcの値がもつれ込んでしまう
    dut.rst.value = 1
    await cocotb.triggers.Timer(10, unit='ns')
    dut.rst.value = 0

    c = Clock(dut.clk, 10, unit="ns")

    # Act & Assert
    assert dut.addrOut.value == 0, f"Normal operation failed: {dut.addrOut.value} != 0"
    cocotb.start_soon(c.start())
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 4, f"Normal operation failed: {dut.addrOut.value} != 4"
    dut.stall.value = 1
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 4, f"Normal operation failed: {dut.addrOut.value} != 4"
    dut.wrEnable.value = 1
    dut.addrIn.value = 400
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 400, f"Normal operation failed: {dut.addrOut.value} != 400"
    dut.wrEnable.value = 0
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 400, f"Normal operation failed: {dut.addrOut.value} != 400"
    dut.stall.value = 0
    await cocotb.triggers.Timer(10, unit='ns')
    assert dut.addrOut.value == 404, f"Normal operation failed: {dut.addrOut.value} != 404"
