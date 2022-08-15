from typing import Optional

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

def version_callback(value: bool):
    if value:
        print(f"v{virtue.__version__}")
        raise typer.Exit()

@app.command()
def install():
    """Installs the Virtue SKILL initialization files into the Virtue folder
    of the current Python environment."""
    api.install()
    init_path = str(api.get_skill_init_script_path())
    print("SKILL environment initialization script installed at:")
    print(f"  {init_path}\n")
    print("Add the following to your skill initialization file (e.g. .cdsinit):")
    code = ";Initialize the Virtue SKILL environment\n" + \
          f"loadi(\"{init_path}\")"
    console.print(Padding(Syntax(code,"scheme"),(1,2)))

@app.command()
def info():
    """Prints information on the virtue environment"""
    info_dict = api.info()
    print(info_dict)

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

@app.callback()
def main(
    version: Optional[bool] = typer.Option(
        None, "--version", callback=version_callback, is_eager=True, 
        help="""Prints the semantic version number prepended with 'v' 
                and exit"""
    ),
) -> None:
    """Virtue SKILL package manager"""
    pass


if __name__ == "__main__":
    app()
