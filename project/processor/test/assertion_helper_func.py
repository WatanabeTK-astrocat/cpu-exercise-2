import cocotb

# ================================================================
# Helper Functions for Assertions
# ================================================================

def assert_isJumpR(dut, expected, opt_str=""):
    """Helper function to assert the isJumpR value"""
    assert dut.value[0] == expected, f"isJumpR mismatch: {dut.value[0]} != {expected} {opt_str}"

def assert_isJumpA(dut, expected, opt_str=""):
    """Helper function to assert the isJumpA value"""
    assert dut.value[1] == expected, f"isJumpA mismatch: {dut.value[1]} != {expected} {opt_str}"

def assert_isBranch(dut, expected, opt_str=""):
    """Helper function to assert the isBranch value"""
    assert dut.value[2] == expected, f"isBranch mismatch: {dut.value[2]} != {expected} {opt_str}"

def assert_isStore(dut, expected, opt_str=""):
    """Helper function to assert the isStore value"""
    assert dut.value[3] == expected, f"isStore mismatch: {dut.value[3]} != {expected} {opt_str}"

def assert_isLoad(dut, expected, opt_str=""):
    """Helper function to assert the isLoad value"""
    assert dut.value[4] == expected, f"isLoad mismatch: {dut.value[4]} != {expected} {opt_str}"

def assert_rfWrEnable(dut, expected, opt_str=""):
    """Helper function to assert the rfWrEnable value"""
    assert dut.value[5] == expected, f"rfWrEnable mismatch: {dut.value[5]} != {expected} {opt_str}"

def assert_rfWrNum(dut, expected, opt_str=""):
    """Helper function to assert the rfWrNum value"""
    assert dut.value[10:6] == expected, f"rfWrNum mismatch: {dut.value[10:6]} != {expected} {opt_str}"

def assert_isALUInImm(dut, expected, opt_str=""):
    """Helper function to assert the isALUInImm value"""
    assert dut.value[11] == expected, f"isALUInImm mismatch: {dut.value[11]} != {expected} {opt_str}"

def assert_jmpAddr(dut, expected, opt_str=""):
    """Helper function to assert the jmpAddr value"""
    assert dut.value[37:12] == expected, f"jmpAddr mismatch: {dut.value[37:12]} != {expected} {opt_str}"

def assert_imm(dut, expected, opt_str=""):
    """Helper function to assert the imm value"""
    assert dut.value[53:38] == expected, f"imm mismatch: {dut.value[53:38]} != {expected} {opt_str}"

def assert_funct(dut, expected, opt_str=""):
    """Helper function to assert the funct value"""
    assert dut.value[59:54] == expected, f"funct mismatch: {dut.value[59:54]} != {expected} {opt_str}"

def assert_shamt(dut, expected, opt_str=""):
    """Helper function to assert the shamt value"""
    assert dut.value[64:60] == expected, f"shamt mismatch: {dut.value[64:60]} != {expected} {opt_str}"

def assert_rt(dut, expected, opt_str=""):
    """Helper function to assert the rt value"""
    assert dut.value[69:65] == expected, f"rt mismatch: {dut.value[69:65]} != {expected} {opt_str}"

def assert_rs(dut, expected, opt_str=""):
    """Helper function to assert the rs value"""
    assert dut.value[74:70] == expected, f"rs mismatch: {dut.value[74:70]} != {expected} {opt_str}"

def assert_opcode(dut, expected, opt_str=""):
    """Helper function to assert the opcode value"""
    assert dut.value[:75] == expected, f"Opcode mismatch: {dut.value[:75]} != {expected} {opt_str}"
