from pathlib import Path
from typing import Tuple
import pluggy

hookspec = pluggy.HookspecMarker("virtue")

def virtue_python_package_name() -> str:
    """Provides the name of the Python package to register as a Virtue package.

    :return: The name of the module as a string
    """

@hookspec
def virtue_skill_package_name() -> str:
    """Provides the name of the SKILL package to register as a Virtue package.
    Required to registera Virtue SKILL package.

    :return: The name of the SKILL package as a string
    """

@hookspec
def virtue_skill_initialization_paths() -> Tuple[Path]:
    """Provides a list of paths to SKILL files to be initialized when
    Virtuoso starts.  They should end in ".cdsinit.il" or ".cdsinit.ils"
    Required to registera Virtue SKILL package.

    :return: a tuple of pathlib Path objects
    """

@hookspec
def virtue_data_reg_paths() -> Tuple[Path]:
    """Provide a list of paths to data.reg files to be added to the environment
    data.reg using "SOFT_INCLUDE".

    :return: a tuple of pathlib Path objects for data.reg files.
    """

@hookspec
def virtue_cdslibmgr_paths() -> Tuple[Path]:
    """Provide a list of paths to *.cdsLibMgr.il files to be loaded by
    the Virtuoso library manager to customize it.

    Returns: a tuple of pathlib Path objects for the package's
    *.cdsLibMgr.il files.
    """
