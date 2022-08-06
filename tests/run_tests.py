"""
Run the SKILL tests from Python.  Makes it easy to run them from a 
python IDE.  Not working yet though as skillbridge doesn't currently support 
tables.
"""

from pathlib import Path
from skillbridge import Workspace, Symbol

if __name__ == "__main__":
    tests_path = Path(__file__).parent.resolve()
    run_tests_path = tests_path / "run_tests.ils"
    src_init_path = tests_path /".." / "virtue" / "virtue.init.ils"
    ws = Workspace.open('ids_dev-mayberc')
    print("setup")
    env = env = ws["theEnvironment"]()
    print(env)
    skill_import = ws.__.x
    #oad_result = ws["load"](str(src_init_path))
    #ws["toplevel"](Symbol("ils"))
    print(skill_import)
    test_pkg = skill_import[Symbol("Test")]
    print("run_tests")
    result = test_pkg.run_directory_suite(str(tests_path))
    print(result)