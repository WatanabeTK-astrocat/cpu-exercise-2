import cocotb
from cocotb.triggers import Timer
from assertion_helper_func import *

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

# ================================================================
# Data Transfer Operations Tests
# ================================================================

@cocotb.test()
async def lw_1(dut):
    """Test Decoder: lw operation"""

    # Arrange
    dut.insn.value = 0x8c010000

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 35)
    assert_funct(dut, 32)
    assert_rfWrNum(dut, 1)
    assert_rs(dut, 0)
    assert_rt(dut, 1)
    #assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 0)
    assert_isLoad(dut, 1)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def sw_1(dut):
    """Test Decoder: sw operation"""

    # Arrange
    dut.insn.value = 0xac020004

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 43)
    assert_funct(dut, 32)
    #assert_rfWrNum(dut, 0)
    assert_rs(dut, 0)
    assert_rt(dut, 2)
    #assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 4)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 1)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def lh_1(dut):
    """Test Decoder: lh operation"""

    # Arrange
    dut.insn.value = 0x84030008

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 33)
    assert_funct(dut, 32)
    assert_rfWrNum(dut, 3)
    assert_rs(dut, 0)
    assert_rt(dut, 3)
    #assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 8)
    assert_isLoad(dut, 1)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def sh_1(dut):
    """Test Decoder: sh operation"""

    # Arrange
    dut.insn.value = 0xa404000c

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 41)
    assert_funct(dut, 32)
    #assert_rfWrNum(dut, 3)
    assert_rs(dut, 0)
    assert_rt(dut, 4)
    #assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 12)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 1)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def lb_1(dut):
    """Test Decoder: lb operation"""

    # Arrange
    dut.insn.value = 0x80050010

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 32)
    assert_funct(dut, 32)
    assert_rfWrNum(dut, 5)
    assert_rs(dut, 0)
    assert_rt(dut, 5)
    #assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 16)
    assert_isLoad(dut, 1)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def sb_1(dut):
    """Test Decoder: sb operation"""

    # Arrange
    dut.insn.value = 0xa0060014

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 40)
    assert_funct(dut, 32)
    #assert_rfWrNum(dut, 3)
    assert_rs(dut, 0)
    assert_rt(dut, 6)
    #assert_shamt(dut, 2)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 20)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 1)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def lui_1(dut):
    """Test Decoder: lui operation"""

    # Arrange
    dut.insn.value = 0x3c070064

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 15)
    assert_funct(dut, 16)
    assert_rfWrNum(dut, 7)
    #assert_rs(dut, 0)
    assert_rt(dut, 7)
    assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 1)
    assert_imm(dut, 100)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

# ================================================================
# Branch Operations Tests
# ================================================================

@cocotb.test()
async def beq_1(dut):
    """Test Decoder: beq operation"""

    # Arrange
    dut.insn.value = 0x40e8ff98

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 16)
    assert_funct(dut, 0)
    #assert_rfWrNum(dut, 7)
    assert_rs(dut, 7)
    assert_rt(dut, 8)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 0)
    assert_imm(dut, 65432)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 1)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def bne_1(dut):
    """Test Decoder: bne operation"""

    # Arrange
    dut.insn.value = 0x45090024

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 17)
    assert_funct(dut, 0)
    #assert_rfWrNum(dut, 7)
    assert_rs(dut, 8)
    assert_rt(dut, 9)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 0)
    assert_imm(dut, 36)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 1)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def blt_1(dut):
    """Test Decoder: blt operation"""

    # Arrange
    dut.insn.value = 0x514bff90

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 20)
    assert_funct(dut, 0)
    #assert_rfWrNum(dut, 7)
    assert_rs(dut, 10)
    assert_rt(dut, 11)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 0)
    assert_imm(dut, 65424)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 1)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def bge_1(dut):
    """Test Decoder: bge operation"""

    # Arrange
    dut.insn.value = 0x558d001c

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 21)
    assert_funct(dut, 0)
    #assert_rfWrNum(dut, 7)
    assert_rs(dut, 12)
    assert_rt(dut, 13)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 0)
    assert_imm(dut, 28)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 1)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def bltu_1(dut):
    """Test Decoder: bltu operation"""

    # Arrange
    dut.insn.value = 0x59cfff88

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 22)
    assert_funct(dut, 0)
    #assert_rfWrNum(dut, 7)
    assert_rs(dut, 14)
    assert_rt(dut, 15)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 0)
    assert_imm(dut, 65416)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 1)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def bgeu_1(dut):
    """Test Decoder: bgeu operation"""

    # Arrange
    dut.insn.value = 0x5e110014

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 23)
    assert_funct(dut, 0)
    #assert_rfWrNum(dut, 7)
    assert_rs(dut, 16)
    assert_rt(dut, 17)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 0)
    assert_imm(dut, 20)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 1)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 0)

# ================================================================
# Jump Operations Tests
# ================================================================

@cocotb.test()
async def j_1(dut):
    """Test Decoder: j operation"""

    # Arrange
    dut.insn.value = 0x08000000

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 2)
    assert_funct(dut, 0)
    #assert_rfWrNum(dut, 7)
    #assert_rs(dut, 16)
    #assert_rt(dut, 17)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 0)
    assert_jmpAddr(dut, 0)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 1)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def jal_1(dut):
    """Test Decoder: jal operation"""

    # Arrange
    dut.insn.value = 0x0c000090

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 3)
    assert_funct(dut, 0)
    assert_rfWrNum(dut, 31)
    #assert_rs(dut, 16)
    #assert_rt(dut, 17)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, 0)
    assert_jmpAddr(dut, 144)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 1)
    assert_isJumpR(dut, 0)

@cocotb.test()
async def jr_1(dut):
    """Test Decoder: jr operation"""

    # Arrange
    dut.insn.value = 0x10200000

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 4)
    assert_funct(dut, 0)
    #assert_rfWrNum(dut, 7)
    assert_rs(dut, 1)
    #assert_rt(dut, 17)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 0)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, -132)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 1)

@cocotb.test()
async def jalr_1(dut):
    """Test Decoder: jalr operation"""

    # Arrange
    dut.insn.value = 0x14400000

    # Act & Assert
    await Timer(10, unit='ns')
    assert_opcode(dut, 5)
    assert_funct(dut, 0)
    assert_rfWrNum(dut, 31)
    assert_rs(dut, 2)
    #assert_rt(dut, 17)
    #assert_shamt(dut, 16)
    assert_rfWrEnable(dut, 1)
    assert_isALUInImm(dut, 0)
    #assert_imm(dut, -132)
    assert_isLoad(dut, 0)
    assert_isStore(dut, 0)
    assert_isBranch(dut, 0)
    assert_isJumpA(dut, 0)
    assert_isJumpR(dut, 1)
