import itertools
import sys
from os import environ
from importlib.resources import files
from importlib.metadata import metadata
from pathlib import Path
from typing import Any, Dict, Tuple, Optional
import virtue
from virtue.plugins.plugin_manager import plugin_manager


def info() -> Dict[str, Any]:
    data = {
        "skill initialization": _get_virtue_skill_initialization_paths(),
        "python version": sys. version_info,
    }
    if(environ["CONDA_PREFIX"]):
        data["Conda Env Prefix"] = environ["CONDA_PREFIX"]
    datareg_path = _get_data_reg_env_script_path()
    if datareg_path is not None:
        data["data.reg"] = datareg_path
    return data

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

def install() -> Dict[dict,Path]:
    """Installs the Virtue SKILL initialization files into the Virtue folder
    of the current Python environment.

    Returns:
        A dictionary with the paths to the created initialization files.
    """
    init_paths = script_paths()
    _install_env_cdsinit_script(init_paths[".cdsinit"])
    _install_env_cdslibmgr_script(init_paths["cdsLibMgr.il"])
    if init_paths["data.reg"] is not None:
        _install_data_reg_init_script(init_paths["data.reg"])
    return init_paths

def _get_cdsinit_script_path() -> Path:
    """The path to the SKILL environment initialization script"""
    return files(virtue) / "virtue-environment.cdsinit.ils"

def _get_data_reg_env_script_path() -> Optional[Path]:
    """The path to the SKILL environment initialization script"""
    if len(_get_virtue_data_reg_paths()) > 0:
        return files(virtue) / "virtue-environment.data.reg"
    else:
        return None

def _get_virtue_skill_initialization_paths() -> Tuple[Path]:
    init_paths = plugin_manager.hook.virtue_skill_initialization_paths()
    return tuple(itertools.chain(*init_paths))

def _get_libmgr_env_script_path() -> Path:
    """The path to the library manager initialization script"""
    return files(virtue) / "virtue-environment.cdsLibMgr.il"

def _install_env_cdsinit_script(filepath: Path) -> None:
    with filepath.open("w") as file:
        file.write((
            "printf(\"\\n---------------------------------------------------"
            "--------------\\n\")\n"
            "printf(\"Initializing Virtue skill environment\\n\")\n"
            f"printf(\"  loading {filepath}\\n\")\n\n"
            "let((init_files)\n"
            "  init_files = '(\n"
        ))
        for path in _get_virtue_skill_initialization_paths():
            file.write(f"    \"{path}\"\n")
        file.write(
            ("  )\n"
            "  foreachs(file init_files\n"
            "    loadi(file))\n"
            ")\n"
            "printf(\"  Done, initialized Virtue SKILL environment\\n\")\n"
            "printf(\"------------------------------------------------------"
            "-----------\\n\\n\")")
        )

def _get_virtue_data_reg_paths() -> Tuple[Path]:
    paths = plugin_manager.hook.virtue_data_reg_paths()
    return tuple(itertools.chain(*paths))

def _install_data_reg_init_script(filepath: Path) -> None:
    if len(_get_virtue_data_reg_paths()) > 0:
        with filepath.open("w") as file:
            for path in _get_virtue_data_reg_paths():
                file.write(f"SOFTINCLUDE {path};\n")

def _get_virtue_cdslibmgr_paths() -> Tuple[Path]:
    paths = plugin_manager.hook.virtue_cdslibmgr_paths()
    return tuple(itertools.chain(*paths))

def _install_env_cdslibmgr_script(filepath: Path) -> None:
    with filepath.open("w") as file:
        file.write((
            "printf(\"Initializing Virtue library manager environment\\n\")\n"
            f"printf(\"  loading {filepath}\\n\")\n\n"
            "let((init_files)\n"
            "  init_files = '(\n"
        ))
        for path in _get_virtue_cdslibmgr_paths():
            file.write(f"    \"{path}\"\n")
        file.write(
            ("  )\n"
            "  foreachs(file init_files\n"
            "    loadi(file))\n"
            ")\n"
            "printf(\"  Done, initialized IDS library manager environment"
            "\\n\")\n")
        )

def script_paths() -> Dict[str, Path]:
    return {
        ".cdsinit": _get_cdsinit_script_path(),
        "cdsLibMgr.il": _get_libmgr_env_script_path(),
        "data.reg": _get_data_reg_env_script_path(),
    }
