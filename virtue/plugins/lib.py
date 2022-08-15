from importlib.resources import files
from pathlib import Path
from typing import Tuple
import virtue

@virtue.hookimpl
def virtue_skill_initialization_paths() -> Tuple[Path]:
    with files(virtue) as virtue_file_path:
        return (virtue_file_path / "virtue.init.ils")

@virtue.hookimpl
def virtue_python_package_name() -> str:
    return "virtue-skill"

@virtue.hookimpl
def virtue_skill_package_name() -> str:
    return "Virtue"
