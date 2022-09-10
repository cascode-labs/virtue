import sys
from os import environ
from importlib.resources import files
from importlib.metadata import metadata
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
        data["Conda Env Prefix"] = environ["CONDA_PREFIX"]
    datareg_path = _get_data_reg_env_script_path()
    if datareg_path is not None:
        data["data.reg"] = datareg_path
    return data

def list_packages() -> Dict[str,Any]:
    python_package_names = metadata("python_package_name")
    skill_package_names = metadata("skill_package_name")
    python_packages = skill_packages_metadata()
    info_data = dict()
    for python_name, skill_name in zip(python_package_names,skill_package_names):
        data = metadata(python_name)
        info_data[python_name] = {
            "python package": python_name,
            "skill package": skill_name,
            "version": data["version"],
        }
    return info_data

def _get_data_reg_env_script_path() -> Optional[Path]:
    """The path to the SKILL environment initialization script"""
    if len(metadata("data_reg_paths")) > 0:
        return files(virtue) / "virtue-environment.data.reg"
    else:
        return None
