from virtue.skill_package.metadata import read_metadata
from tests import skill_package
from importlib.resources import path

def test_read_metadata():
    with path(skill_package, "pyproject.toml") as toml_file:
        metadata = read_metadata(toml_file)
        assert metadata["project"]["name"] == "virtue-skill"
