from importlib.resources import files
import virtue


@virtue.hookimpl
def virtue_register_skill_package():
    return {
        "python_package_name": "virtue-skill",
        "skill_package_name": "Virtue",
        "cdsinit_paths": (files(virtue) / "virtue.cdsinit.ils"),
        "cdslibmgr_paths": (files(virtue) / "virtue.cdsLibMgr.il"),
        "cds_dev_libraries": {
            "virtue_dev_work": (files(virtue) / "virtue_dev_work"),
        },
    }
