import pytest

from virtue.skill_package.metadata \
    import skill_packages_metadata, metadata


def test_virtue_package_data():
    data = skill_packages_metadata()
    assert isinstance(data, dict)
    assert "virtue-skill" in data
    assert data["virtue-skill"]["skill_package_name"] == "Virtue"

@pytest.mark.parametrize("metadata_key",
    [("cdsinit_paths"), ("cdslibmgr_paths"), ("cds_dev_libraries"),
     ("python_package_name"), ("skill_package_name")])
def test_metadata(metadata_key):
    data = metadata(metadata_key)
    assert isinstance(data, list)
    assert len(data) > 0
