from importlib.resources import files
from pathlib import Path
from typing import Dict, Optional

import virtue
from virtue.skill_package.get_metadata import get_metadata


def init() -> Dict[str,Optional[Path]]:
    """Initialializes the Virtue SKILL environment by creating the
    Virtuoso initialization files in the Virtue folder of the current
    Python environment.

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
    return Path(str(files(virtue) / "virtue-environment.cdsinit.ils"))

def _get_data_reg_env_script_path() -> Optional[Path]:
    """The path to the SKILL environment initialization script"""
    if len(get_metadata("data_reg_paths")) > 0:
        return Path(str(files(virtue) / "virtue-environment.data.reg"))
    else:
        return None

def _get_libmgr_env_script_path() -> Path:
    """The path to the library manager initialization script"""
    return Path(str(files(virtue) / "virtue-environment.cdsLibMgr.il"))

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
        for path in get_metadata("cdsinit_paths"):
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

def _install_data_reg_init_script(filepath: Path) -> None:
    data_reg_paths = get_metadata("data_reg_paths")
    if len(data_reg_paths) > 0:
        with filepath.open("w") as file:
            for path in data_reg_paths:
                file.write(f"SOFTINCLUDE {path};\n")

def _install_env_cdslibmgr_script(filepath: Path) -> None:
    with filepath.open("w") as file:
        file.write((
            "printf(\"Initializing Virtue library manager environment\\n\")\n"
            f"printf(\"  loading {filepath}\\n\")\n\n"
            "let((init_files)\n"
            "  init_files = '(\n"
        ))
        for path in get_metadata("cdslibmgr_paths"):
            file.write(f"    \"{path}\"\n")
        file.write(
            ("  )\n"
            "  foreachs(file init_files\n"
            "    loadi(file))\n"
            ")\n"
            "printf(\"  Done, initialized IDS library manager environment"
            "\\n\")\n")
        )

def script_paths() -> Dict[str, Optional[Path]]:
    return {
        ".cdsinit": _get_cdsinit_script_path(),
        "cdsLibMgr.il": _get_libmgr_env_script_path(),
        "data.reg": _get_data_reg_env_script_path(),
    }
