import cocotb
from cocotb.triggers import Timer

def assert_isJumpR(dut, expected):
    """Helper function to assert the isJumpR value"""
    assert dut.opInfoOut.value[0] == expected, f"isJumpR mismatch: {dut.opInfoOut.value[0]} != {expected}"

def assert_isJumpA(dut, expected):
    """Helper function to assert the isJumpA value"""
    assert dut.opInfoOut.value[1] == expected, f"isJumpA mismatch: {dut.opInfoOut.value[1]} != {expected}"

def assert_isBranch(dut, expected):
    """Helper function to assert the isBranch value"""
    assert dut.opInfoOut.value[2] == expected, f"isBranch mismatch: {dut.opInfoOut.value[2]} != {expected}"

def assert_isStore(dut, expected):
    """Helper function to assert the isStore value"""
    assert dut.opInfoOut.value[3] == expected, f"isStore mismatch: {dut.opInfoOut.value[3]} != {expected}"

def assert_isLoad(dut, expected):
    """Helper function to assert the isLoad value"""
    assert dut.opInfoOut.value[4] == expected, f"isLoad mismatch: {dut.opInfoOut.value[4]} != {expected}"

def assert_rfWrEnable(dut, expected):
    """Helper function to assert the rfWrEnable value"""
    assert dut.opInfoOut.value[5] == expected, f"rfWrEnable mismatch: {dut.opInfoOut.value[5]} != {expected}"

def assert_rfWrNum(dut, expected):
    """Helper function to assert the rfWrNum value"""
    assert dut.opInfoOut.value[10:6] == expected, f"rfWrNum mismatch: {dut.opInfoOut.value[10:6]} != {expected}"

def assert_isALUInImm(dut, expected):
    """Helper function to assert the isALUInImm value"""
    assert dut.opInfoOut.value[11] == expected, f"isALUInImm mismatch: {dut.opInfoOut.value[11]} != {expected}"

def assert_jmpAddr(dut, expected):
    """Helper function to assert the jmpAddr value"""
    assert dut.opInfoOut.value[37:12] == expected, f"jmpAddr mismatch: {dut.opInfoOut.value[37:12]} != {expected}"

def assert_imm(dut, expected):
    """Helper function to assert the imm value"""
    assert dut.opInfoOut.value[53:38] == expected, f"imm mismatch: {dut.opInfoOut.value[53:38]} != {expected}"

def assert_funct(dut, expected):
    """Helper function to assert the funct value"""
    assert dut.opInfoOut.value[59:54] == expected, f"funct mismatch: {dut.opInfoOut.value[59:54]} != {expected}"

def assert_shamt(dut, expected):
    """Helper function to assert the shamt value"""
    assert dut.opInfoOut.value[64:60] == expected, f"shamt mismatch: {dut.opInfoOut.value[64:60]} != {expected}"

def assert_rt(dut, expected):
    """Helper function to assert the rt value"""
    assert dut.opInfoOut.value[69:65] == expected, f"rt mismatch: {dut.opInfoOut.value[69:65]} != {expected}"

def assert_rs(dut, expected):
    """Helper function to assert the rs value"""
    assert dut.opInfoOut.value[74:70] == expected, f"rs mismatch: {dut.opInfoOut.value[74:70]} != {expected}"

def assert_opcode(dut, expected):
    """Helper function to assert the opcode value"""
    assert dut.opInfoOut.value[:75] == expected, f"Opcode mismatch: {dut.opInfoOut.value[:75]} != {expected}"

# ================================================================
# R_Type Tests
# ================================================================

@cocotb.test()
async def add_1(dut):
    """Test Decoder: add operation"""

    # Arrange
    dut.insn.value = 0x00430820

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 32)
    assert_rfWrNum(dut, 1)
    assert_rs(dut, 2)
    assert_rt(dut, 3)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)
