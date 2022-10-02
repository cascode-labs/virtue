from typing import Dict
from importlib.metadata import metadata as python_metadata
from virtue.plugins.plugin_manager import plugin_manager
from virtue.skill_package.metadata_data import SKillPackageMetadata


def skill_packages_metadata()->Dict[str, SKillPackageMetadata]:
    """Provides metadata for each registerd Virtue skill package

    Returns:
        A dictionary containing a SkillPackageData dictionary for each
        registered skill package with each skill package's associated
        python package name as the key.
    """
    skill_packages_data_list = \
        plugin_manager.hook.virtue_register_skill_package()  # type: ignore
    packages = {}
    for skill_package_data_dict in skill_packages_data_list:
        python_package_name = skill_package_data_dict['python_package_name']
        python_package_metadata = python_metadata(python_package_name)
        packages[python_package_name] = skill_package_data_dict
        packages[python_package_name]["version"] = python_package_metadata["version"]
    return packages


def metadata(data_key):
    """Returns a list of the data with the given key from each
    SKILL package's metadata dictionary"""
    packages = skill_packages_metadata()
    output = []
    for package_data in packages.values():
        if data_key in package_data:
            output.append(package_data[data_key])
    return output
