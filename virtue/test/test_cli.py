from typer.testing import CliRunner

import virtue
from virtue.cli import app

runner = CliRunner()


def test_cli_version():
    result = runner.invoke(app, ["--version"])
    assert result.exit_code == 0
    assert f"v{virtue.__version__}" in result.stdout

def test_cli_info():
    result = runner.invoke(app, ["info"])
    assert result.exit_code == 0
    assert result.stdout != ""

def test_cli_list():
    result = runner.invoke(app, ["list"])
    assert result.exit_code == 0
    assert "Virtue Packages" in result.stdout
    assert "Python Package" in result.stdout
    assert "SKILL Package" in result.stdout
    assert "virtue-skill" in result.stdout
    assert "Virtue" in result.stdout
    assert f"{virtue.__version__}" in result.stdout
