from pathlib import Path
from typing import Tuple, Dict, TypedDict


class SKillPackageOptionalMetadata(TypedDict, total=False):
    """Optional SKILL package metadata"""

    cdsinit_paths: Tuple[Path]
    """Paths to .cdsinit initialization files which will be loaded into the
    main SKILL environment."""
    data_reg_paths: Tuple[Path]
    """Paths to data.reg initialization files which will register tools and view types"""
    cdslibmgr_paths: Tuple[Path]
    """Paths to cdsLibMgr.il initialization files which will be loaded
       by the library manager to customize its menus and options."""
    cds_libraries: Dict[str, Path]
    """Specifies OA libraries to be included in the skill
    environment's cds.lib.  A dictionary with OA library names as the keys and
    Path objects to them for their values.
    """
    cds_dev_libraries: Dict[str, Path]
    """Specifies OA libraries to be included in a development environment's
    cds.lib.  A dictionary with OA library names as the keys and
    Path objects to them for their values.
    """


class SKillPackageMetadata(SKillPackageOptionalMetadata, total=True):
    """Required package metadata"""
    python_package_name: str
    "Name of the python package registering the skill package."
    skill_package_name: str
    "Name of the skill package."
