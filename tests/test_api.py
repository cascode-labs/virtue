import virtue
from virtue import api


def test_api_info_python_version():
    info_data = api.info()
    assert info_data["python version"][0] == 3

def test_api_info_install_paths():
    info_data = api.info()
    assert isinstance(info_data["skill initialization"], tuple)

def test_api_list_packages():
    packages = api.list_packages()
    assert "virtue-skill" in packages
    assert "version" in packages["virtue-skill"]

def test_api_install():
    env_init_file_paths = api.install()
    assert "cdsinit" in env_init_file_paths
    assert len(env_init_file_paths["cdsinit"]) > 0
    assert "data.reg" in env_init_file_paths
