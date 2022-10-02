import sys
from os import environ
from importlib.resources import files
from pathlib import Path
from typing import Any, Dict, Optional
import virtue
from virtue.skill_package.metadata \
    import metadata, skill_packages_metadata

def info() -> Dict[str, Any]:
    data = {
        "python version": sys.version_info,
    }
    if("CONDA_PREFIX" in environ):
        data["Conda Env Prefix"] = environ["CONDA_PREFIX"]  # type: ignore
    datareg_path = _get_data_reg_env_script_path()
    if datareg_path is not None:
        data["data.reg"] = datareg_path
    return data

def list_packages() -> Dict[str,Any]:
    python_packages = skill_packages_metadata()
    return python_packages

def _get_data_reg_env_script_path() -> Optional[Path]:
    """The path to the SKILL environment initialization script"""
    if len(metadata("data_reg_paths")) > 0:
        return Path(str(files(virtue) / "virtue-environment.data.reg"))
    else:
        return None
