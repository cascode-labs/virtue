"""
Run the SKILL tests from Python.  Makes it easy to run them from a
python IDE.  Make sure the skillbridge server is running first.
"""

from pathlib import Path
from skillbridge import Workspace, Symbol

if __name__ == "__main__":
    tests_path = Path(__file__).parent.resolve()
    run_tests_path = tests_path / "run_tests.ils"
    src_init_path = tests_path /".." / "virtue" / "virtue.init.ils"
    ws = Workspace.open('ids_dev-mayberc')
    skill_import = ws.__.Import
    test_pkg = skill_import[Symbol("Test")]
    print(f"\nRunning tests in:\n  {run_tests_path}")
    run_dir_tests = test_pkg[8]
    result = run_dir_tests(str(tests_path))
    function_count = result["FunctionCount"]()
    pass_count = result["FunctionPassCount"]()
    if result["pass"]:
        print(f"All {pass_count} tests passed! ")
    else:
        print(("Some tests failed:\n"
              f"  {pass_count} passed out of {function_count}\n"))
