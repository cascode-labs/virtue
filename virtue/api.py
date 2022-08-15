import itertools
import sys
from importlib.resources import files
from importlib.metadata import metadata
from pathlib import Path
from typing import Any, Dict, Tuple
import virtue
from virtue.plugins.plugin_manager import plugin_manager


def install() -> None:
    """Installs the Virtue SKILL initialization files into the Virtue folder
    of the current Python environment."""
    _install_skill_init_script(get_skill_init_script_path())
    
def get_skill_init_script_path() -> Path:
    """The path to the SKILL environment initialization script"""
    return files(virtue) / "virtue-environment.ils"

def _get_virtue_skill_initialization_paths() -> Tuple[Path]:
    init_paths = plugin_manager.hook.virtue_skill_initialization_paths()
    return tuple(init_paths)

def _install_skill_init_script(filepath: Path):
    with filepath.open("w") as file:
        file.write((
            "printf(\"Initializing Virtue skill environment\\n\")\n"
            f"printf(\"  loading {filepath}\\n\")\n\n"
            "let((init_files)\n"
            "init_files = '(\n"
        ))
        for path in _get_virtue_skill_initialization_paths():
            file.write(f"  \"{path}\"\n")
        file.write(
            (")\n"
            "  fors(file init_files\n"
            "    loadi(file))\n"
            ")\n"
            "printf(\"  Done, initialized Virtue SKILL environment\\n\")\n")
        )
        
def info() -> Dict[str, Any]:
    return {
        "python version": sys. version_info,
        "skill env init path": get_skill_init_script_path(),
        "skill initialization": _get_virtue_skill_initialization_paths(),
    }

def list_packages() -> Dict[str,Any]:
    python_package_names = plugin_manager.hook.virtue_python_package_name()
    skill_package_names = plugin_manager.hook.virtue_skill_package_name()
    info_data = dict()
    for python_name, skill_name in zip(python_package_names,skill_package_names):
        data = metadata(python_name)
        info_data[python_name] = {
            "python package": python_name,
            "skill package": skill_name,
            "version": data["version"],
        }
    return info_data
