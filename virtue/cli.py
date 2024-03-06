from typing import Optional

import typer
from rich import print
from rich.console import Console

import virtue
import virtue.skill_environment.cli

app = typer.Typer()
console = Console()

app.add_typer(virtue.skill_environment.cli.app, name="env")


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
    """Virtue command line interface"""
    pass

typer_click_object = typer.main.get_command(app)

if __name__ == "__main__":
    app()
