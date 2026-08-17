import os
import sys
from pathlib import Path

from cocotb_tools.runner import get_runner

def run_test(proj_path, runner, sources, module_name):
    """
    Run the test for the module using cocotb.
    """

    runner.build(
        sources=sources,
        hdl_toplevel=module_name,
    )

    runner.test(hdl_toplevel=module_name, test_module=f"test_{module_name},")

if __name__ == "__main__":
    proj_path = Path(__file__).resolve().parent
    sys.path.append(str(proj_path / "test"))
    runner = get_runner(os.getenv("SIM", "verilator"))
    sources = [
        proj_path / "src" / "BasicTypes.sv",
        proj_path / "src" / "Types.sv",
        proj_path / "src" / "ALU.sv",
    ]
    run_test(proj_path, runner, sources, "ALU")
