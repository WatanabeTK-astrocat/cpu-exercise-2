import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock
import pandas as pd
from assertion_helper_func import *

async def cpu_io_mock(dut, df):
    """Mock CPU I/O for testing"""

    # Arrange
    dut.rst.value = 1
    await Timer(10, unit='ns')
    dut.rst.value = 0

    c = Clock(dut.clk, 10, unit="ns")
    cocotb.start_soon(c.start())

    # Act & Assert
    for i, row in df.iterrows():
        # IMEM → CPU (insnIn)
        dut.insnIn.value = row['insn'].item()

        # CPU → IMEM (insnAddr/PC)
        assert dut.insnAddr.value == row['insnAddr'].item(), f"PC value mismatch: {dut.insnAddr.value} != {row['insnAddr'].item()} at row {i}"

        # DMEM → CPU (dataIn, dataAddr)
        if row['dataRdChkEnable'].item() == 1:
            dut.dataIn.value = row['dataRdData'].item()
            assert dut.dataAddr.value == row['dataAddr'].item(), f"Data memory address mismatch: {dut.dataAddr.value} != {row['dataAddr'].item()} at row {i}"

        # CPU → DMEM (dataWrEnable, dataOut)
        assert dut.dataWrEnable.value == row['dataWrEnable'].item(), f"Data memory write enable mismatch: {dut.dataWrEnable.value} != {row['dataWrEnable'].item()} at row {i}"
        if row['dataWrEnable'].item() == 1:
            assert dut.dataAddr.value == row['dataAddr'].item(), f"Data memory address mismatch: {dut.dataAddr.value} != {row['dataAddr'].item()} at row {i}"
            assert dut.dataOut.value == row['dataWrData'].item(), f"Data memory write data mismatch: {dut.dataOut.value} != {row['dataWrData'].item()} at row {i}"

        # ID assertions
        if pd.notna(df.loc[i, 'ID_rfRdNumA']):
            assert_rs(dut.ID_opInfo, row['ID_rfRdNumA'].item(), f" at row {i}")
        if pd.notna(df.loc[i, 'ID_rfRdNumB']):
            assert_rt(dut.ID_opInfo, row['ID_rfRdNumB'].item(), f" at row {i}")
        if pd.notna(df.loc[i, 'ID_rfRdDataA']):
            assert dut.ID_rfRdDataA.value == row['ID_rfRdDataA'].item(), f"ID_rfRdDataA mismatch: {dut.ID_rfRdDataA.value} != {row['ID_rfRdDataA'].item()} at row {i}"
        if pd.notna(df.loc[i, 'ID_rfRdDataB']):
            assert dut.ID_rfRdDataB.value == row['ID_rfRdDataB'].item(), f"ID_rfRdDataB mismatch: {dut.ID_rfRdDataB.value} != {row['ID_rfRdDataB'].item()} at row {i}"
        if pd.notna(df.loc[i, 'ID_rfWrEnable']):
            assert_rfWrEnable(dut.ID_opInfo, row['ID_rfWrEnable'].item(), f" at row {i}")

        # EX assertions
        if pd.notna(df.loc[i, 'EX_aluInA']):
            assert dut.EX_aluInA.value == row['EX_aluInA'].item(), f"EX_aluInA mismatch: {dut.EX_aluInA.value} != {row['EX_aluInA'].item()} at row {i}"
        if pd.notna(df.loc[i, 'EX_aluInB']):
            assert dut.EX_aluInB.value == row['EX_aluInB'].item(), f"EX_aluInB mismatch: {dut.EX_aluInB.value} != {row['EX_aluInB'].item()} at row {i}"

        await Timer(10, unit='ns')

@cocotb.test()
async def load_add_store(dut):
    """Test CPU: load-add-store sequence"""

    # Arrange
    df = pd.DataFrame({
        "insnAddr":         [0, 4, 8, 12, 16, 20, 24, 28, 32],
        "insn":             [0x200a0003, 0x200b0002, 0x014b6020, 0x014b6822, 0xac0c0010, 0xac0d0014, 0, 0, 0],
        "dataAddr":         [0, 0, 0, 0, 0, 5, 1, 16, 20],
        "dataRdChkEnable":  [0, 0, 0, 0, 0, 1, 1, 0, 0],
        "dataRdData":       [0, 0, 0, 0, 0, 0, 0, 0, 0],
        "dataWrEnable":     [0, 0, 0, 0, 0, 0, 0, 1, 1],
        "dataWrData":       [0, 0, 0, 0, 0, 0, 0, 5, 1],
        'ID_rfRdNumA':      [0, 0, 0, 10, 10, 0, 0, 0, 0],
        'ID_rfRdNumB':      [0, 10, 11, 11, 11, 12, 13, 0, 0],
        'ID_rfRdDataA':     [0, 0, 0, 0, 3, 0, 0, 0, 0],
        'ID_rfRdDataB':     [0, 0, 0, 0, 0, 0, 0, 0, 0],
        'ID_rfWrEnable':    [1, 1, 1, 1, 1, 0, 0, 1, 1],
        'EX_aluInA':        [0, 0, 0, 0, 3, 3, 0, 0, 0],
        'EX_aluInB':        [0, 0, 3, 2, 2, 2, 16, 20, 0]
    })
    # note: nop instruction leads to sll r0, r0, r0, which is a write to r0.
    # This means that nop instructions will have rfWrEnable = 1,
    # but the write will not change the value of r0 (it will remain 0).

    # Act & Assert
    await cpu_io_mock(dut, df)
