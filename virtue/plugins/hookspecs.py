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

    :return: The name of the SKILL package as a string
    """

@hookspec
def virtue_skill_initialization_paths() -> Tuple[Path]:
    """Provides a list of paths to SKILL files to be initialized when
    Virtuoso starts.

    :return: a tuple of skill pathlib Path objects
    """

