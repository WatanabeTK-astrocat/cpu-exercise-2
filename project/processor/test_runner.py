import os
import sys
from pathlib import Path

from cocotb_tools.runner import get_runner

def run_test(runner, sources, module_name):
    """
    Run the test for the module using cocotb.
    """

    runner.build(
        sources=sources,
        hdl_toplevel=module_name,
        build_dir=f"sim_build/{module_name}"
    )
    runner.test(
        hdl_toplevel=module_name,
        test_module=f"test_{module_name}"
    )

if __name__ == "__main__":
    proj_path = Path(__file__).resolve().parent
    src_path = proj_path / "src"
    test_path = proj_path / "test"
    sys.path.append(str(test_path))

    runner = get_runner(os.getenv("SIM", "verilator"))
    sources = [
        src_path / "BasicTypes.sv",
        src_path / "Types.sv",
        src_path / "RegFile.sv",
        src_path / "ALU.sv",
        src_path / "Branch.sv",
        src_path / "PC.sv",
        src_path / "Decode.sv",
        src_path / "Reg_IF_ID.sv",
        src_path / "Reg_ID_EX.sv",
        src_path / "Reg_EX_MEM.sv",
        src_path / "Reg_MEM_WB.sv",
        src_path / "ForwardingUnit.sv",
        src_path / "HazardUnit.sv",
        src_path / "CPU.sv",
    ]

    run_test(runner, sources, module_name="ALU")
    run_test(runner, sources, module_name="BranchUnit")
    run_test(runner, sources, module_name="PC")
    run_test(runner, sources, module_name="Decode")
    run_test(runner, sources, module_name="CPU")
