from typing import Dict
from pathlib import Path
import typer
from rich import print
from rich.console import Console
from rich.table import Table
from rich.syntax import Syntax
from rich.padding import Padding
from rich.markup import escape
import toml

from virtue.skill_environment import init_scripts, api

app = typer.Typer()
console = Console()


@app.command()
def info():
    """Prints information on the virtue environment"""
    info_dict = api.info()
    table = Table(show_header=False, title="[bold green]Virtue Environment[/bold green]")

    if"Conda Env Prefix" in info_dict:
        table.add_row("Conda Env Prefix", info_dict["Conda Env Prefix"])

    major = info_dict["python version"][0]
    minor = info_dict["python version"][1]
    patch = info_dict["python version"][2]
    python_version = f"{major}.{minor}.{patch}"
    table.add_row("Python version", python_version)

    print("")
    console.print(Padding(table,(0,2)))
    _print_install_script_table(init_scripts.script_paths())


@app.command("list")
def list_packages(
    verbose: bool = typer.Option(False, "--verbose","-v", help=
        "Include additional package data such as init script paths"),
    export_toml: bool = typer.Option(False, "--toml","-t", help=
        "Print the full package list in TOML format"),
    export_python: bool = typer.Option(False, "--python","-p", help=
        "Prints the full package list in dict format")
    ) -> None:
    """List the Virtue packages"""

    packages = api.list_packages()
    if export_toml:
        print(escape(toml.dumps(packages)))
    elif export_python:
        print(packages)
    else:
        _print_package_table(packages, verbose)


def _print_package_table(packages: dict, verbose: bool):
    column_names = {
        "python_package_name": "Python Package",
        "skill_package_name": "SKILL Package",
        "version": "Version"
    }
    if verbose:
        column_names.update({
            "cdsinit_paths": ".cdsinit",
            "cdslibmgr_paths": "cdsLibMgr.il",
            "data_reg_paths": "data.reg",
        })
    display_names = column_names.values()
    table = Table(*display_names,
        title ="\n:package: [bold green]Virtue Packages[/bold green]",
        title_style="")
    """for column_header in display_names:
        if column_header in [".cdsinit"]:
            table.add_column(column_header,justify="center")
        else:
            table.add_column(column_header)"""
    for package in packages.values():
        package_filtered = {key: str(package[key]) for \
                            key in column_names.keys() if key in package}
        table.add_row(*package_filtered.values())
    console.print(table)

@app.command()
def init():
    """Initialializes the Virtue SKILL environment by creating the
    Virtuoso initialization files in the Virtue folder of the current
    Python environment."""
    init_file_paths = init_scripts.init()
    _print_install_script_table(init_file_paths)
    _print_install_cdsinit(init_file_paths)
    _print_install_datareg(init_file_paths)
    _print_install_cdslibmgr(init_file_paths)

def _print_install_script_table(init_file_paths: Dict[str,Path]):
    print("\nSKILL environment initialization scripts installed:")
    table = Table("Script", "Path")
    for script_name, script_path in init_file_paths.items():
        if script_path is not None:
            table.add_row(script_name, str(script_path))
        else:
            table.add_row(script_name,
                          "Not Applicable: No Virtue packages require it")
    print(Padding(table,(0,2)))
    print("")

def _print_install_cdsinit(init_file_paths: Dict[str,Path]):
    init_path = init_file_paths[".cdsinit"]
    print(("Add the following to your Virtuoso initialization file "
           "(e.g. .cdsinit):"))
    code = ("; Initialize the Virtue SKILL environment\n"
           f"when(isFile(\"{init_path}\")\n"
           f"  loadi(\"{init_path}\"))")
    console.print(Padding(Syntax(code,"scheme"),(1,2)))

def _print_install_datareg(init_file_paths: Dict[str,Path]):
    data_reg_path = init_file_paths["data.reg"]
    if data_reg_path is not None:
        print("Add the following to your data.reg file:")
        code = ("// Initialize the Virtue SKILL environment data registry\n"
              f"SOFTINCLUDE {data_reg_path};")
        console.print(Padding(Syntax(code,"scheme"),(1,2)))

def _print_install_cdslibmgr(init_file_paths: Dict[str,Path]):
    init_path = init_file_paths["cdsLibMgr.il"]
    print(("Add the following to your Virtuoso library manager "
           "initialization file (e.g. cdsLibMgr.il):"))
    code = (
        "; Initialize the Virtue SKILL environment in the library manager\n"
       f"when(isFile(\"{init_path}\")\n"
       f"  loadi(\"{init_path}\"))")
    console.print(Padding(Syntax(code,"scheme"),(1,2)))

typer_click_object = typer.main.get_command(app)

if __name__ == "__main__":
    app()
