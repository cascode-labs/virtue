from virtue.skill_environment import api, init_scripts


def test_api_info_python_version():
    info_data = api.info()
    assert info_data["python version"][0] == 3

def test_api_info_install_paths():
    info_data = api.info()
    assert "python version" in info_data

def test_api_list_packages():
    packages = api.list_packages()
    assert "virtue-skill" in packages
    assert "version" in packages["virtue-skill"]

def test_api_init():
    env_init_file_paths = init_scripts.init()
    assert ".cdsinit" in env_init_file_paths
    assert "cdsLibMgr.il" in env_init_file_paths
    assert "data.reg" in env_init_file_paths
    assert env_init_file_paths[".cdsinit"] is not None
    assert env_init_file_paths["cdsLibMgr.il"] is not None
