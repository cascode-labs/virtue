from os import environ
from typing import Optional, Dict
from pathlib import Path

import typer
from rich import print
from rich.console import Console
from rich.table import Table
from rich.syntax import Syntax
from rich.padding import Padding

import virtue
from virtue import api

app = typer.Typer()
console = Console()



def _version_callback(value: bool):
    if value:
        print(f"v{virtue.__version__}")
        raise typer.Exit()

@app.callback()
def main(
    version: Optional[bool] = typer.Option(
        None, "--version", callback=_version_callback, is_eager=True,
        help="""Prints the semantic version number prepended with 'v'
                and exit"""
    ),
) -> None:
    """Virtue SKILL package manager"""
    pass


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
    _print_install_script_table(api.script_paths())


@app.command("list")
def list_packages() -> None:
    """List the Virtue packages"""
    packages = api.list_packages()
    print("\n:package: [bold green]Virtue Packages[/bold green] ")
    table = Table("Python Package", "SKILL Package", "Version")
    for package_name, package in packages.items():
        table.add_row(package_name, package["skill package"],
                      package["version"])
    console.print(table)


@app.command()
def install():
    """Installs the Virtue SKILL initialization files into the Virtue folder
    of the current Python environment."""
    init_file_paths = api.install()
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
