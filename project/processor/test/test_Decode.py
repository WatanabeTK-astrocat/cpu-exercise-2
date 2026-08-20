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
# Arithmetic Operations Tests
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

@cocotb.test()
async def sub_1(dut):
    """Test Decoder: sub operation"""

    # Arrange
    dut.insn.value = 0x00a62022

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 34)
    assert_rfWrNum(dut, 4)
    assert_rs(dut, 5)
    assert_rt(dut, 6)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def addi_1(dut):
    """Test Decoder: addi operation"""

    # Arrange
    dut.insn.value = 0x21070064

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 8)
    assert_funct(dut, 32)
    assert_rfWrNum(dut, 7)
    assert_rs(dut, 8)
    #assert_rt(dut, 6)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def subi_1(dut):
    """Test Decoder: subi operation"""

    # Arrange
    dut.insn.value = 0x25490064

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 9)
    assert_funct(dut, 34)
    assert_rfWrNum(dut, 9)
    assert_rs(dut, 10)
    #assert_rt(dut, 6)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

# ================================================================
# Logical Operations Tests
# ================================================================

@cocotb.test()
async def and_1(dut):
    """Test Decoder: and operation"""

    # Arrange
    dut.insn.value = 0x018d5824

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 36)
    assert_rfWrNum(dut, 11)
    assert_rs(dut, 12)
    assert_rt(dut, 13)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def or_1(dut):
    """Test Decoder: or operation"""

    # Arrange
    dut.insn.value = 0x01f07025

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 37)
    assert_rfWrNum(dut, 14)
    assert_rs(dut, 15)
    assert_rt(dut, 16)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def xor_1(dut):
    """Test Decoder: xor operation"""

    # Arrange
    dut.insn.value = 0x02538826

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 38)
    assert_rfWrNum(dut, 17)
    assert_rs(dut, 18)
    assert_rt(dut, 19)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def nor_1(dut):
    """Test Decoder: nor operation"""

    # Arrange
    dut.insn.value = 0x02b6a027

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 39)
    assert_rfWrNum(dut, 20)
    assert_rs(dut, 21)
    assert_rt(dut, 22)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def andi_1(dut):
    """Test Decoder: andi operation"""

    # Arrange
    dut.insn.value = 0x33170064

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 12)
    assert_funct(dut, 36)
    assert_rfWrNum(dut, 23)
    assert_rs(dut, 24)
    #assert_rt(dut, 22)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def ori_1(dut):
    """Test Decoder: ori operation"""

    # Arrange
    dut.insn.value = 0x37590064

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 13)
    assert_funct(dut, 37)
    assert_rfWrNum(dut, 25)
    assert_rs(dut, 26)
    #assert_rt(dut, 22)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def xori_1(dut):
    """Test Decoder: xori operation"""

    # Arrange
    dut.insn.value = 0x3b9b0064

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 14)
    assert_funct(dut, 38)
    assert_rfWrNum(dut, 27)
    assert_rs(dut, 28)
    #assert_rt(dut, 22)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def slt_1(dut):
    """Test Decoder: slt operation"""

    # Arrange
    dut.insn.value = 0x03c1e82a

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 42)
    assert_rfWrNum(dut, 29)
    assert_rs(dut, 30)
    assert_rt(dut, 1)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def slti_1(dut):
    """Test Decoder: slti operation"""

    # Arrange
    dut.insn.value = 0x28620064

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 10)
    assert_funct(dut, 42)
    assert_rfWrNum(dut, 2)
    assert_rs(dut, 3)
    #assert_rt(dut, 1)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

# ================================================================
# Shift Operations Tests
# ================================================================

@cocotb.test()
async def sll_1(dut):
    """Test Decoder: sll operation"""

    # Arrange
    dut.insn.value = 0x00c52000

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 0)
    assert_rfWrNum(dut, 4)
    assert_rs(dut, 6)
    assert_rt(dut, 5)
    #assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def slli_1(dut):
    """Test Decoder: slli operation"""

    # Arrange
    dut.insn.value = 0x00083890

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 16)
    assert_rfWrNum(dut, 7)
    #assert_rs(dut, 5)
    assert_rt(dut, 8)
    assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def srl_1(dut):
    """Test Decoder: srl operation"""

    # Arrange
    dut.insn.value = 0x016a4802

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 2)
    assert_rfWrNum(dut, 9)
    assert_rs(dut, 11)
    assert_rt(dut, 10)
    #assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def srli_1(dut):
    """Test Decoder: srli operation"""

    # Arrange
    dut.insn.value = 0x000d6092

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 18)
    assert_rfWrNum(dut, 12)
    #assert_rs(dut, 5)
    assert_rt(dut, 13)
    assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def sra_1(dut):
    """Test Decoder: sra operation"""

    # Arrange
    dut.insn.value = 0x020f7003

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 3)
    assert_rfWrNum(dut, 14)
    assert_rs(dut, 16)
    assert_rt(dut, 15)
    #assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def srai_1(dut):
    """Test Decoder: srai operation"""

    # Arrange
    dut.insn.value = 0x00128893

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 0)
    assert_funct(dut, 19)
    assert_rfWrNum(dut, 17)
    #assert_rs(dut, 5)
    assert_rt(dut, 18)
    assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)
