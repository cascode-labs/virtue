from pathlib import Path
from skillbridge import Workspace, Symbol

if __name__ == "__main__":
    tests_path = Path(__file__).parent.resolve()
    run_tests_path = tests_path / "run_tests.ils"
    src_init_path = tests_path /".." / "virtue.init.ils"
    ws = Workspace.open('ids_dev-mayberc')
    print("setup")
    load_result = ws["load"](str(src_init_path))
    ws["toplevel"](Symbol("ils"))
    print("run_tests")
    result = ws[f"Test->run_directory_suite"](str(tests_path))
    print(result)