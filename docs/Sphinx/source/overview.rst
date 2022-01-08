Overview
========
Virtue supports the Cadence Virtuoso environment as part of the 
[Viper](http://www.cascode-labs.org/viper/) open circuit design environment
and provides a standard SKILL library. Enables the SKILL code contained in 
the active Viper [Conda environment](https://docs.conda.io/en/latest/) when 
a project is started using the "sp" command.

* Automatically loads the Viper SKILL environment from the active Conda environment
* Provides a standard SKILL library
* Enables SKILL Conda Packages
* Supports seamless execution of SKILL from Python using 
  `SkillBridge <https://unihd-cag.github.io/skillbridge/>`_

Command Line Interface
----------------------
Use the -h option with each command to learn how to use it and the available options.

* *sp*: Starts Virtuoso in the work area of the specified project with a Conda 
  SKILL environment loaded.

    .. dropdown:: Details

      Start Project (sp)
        sp [Options] [prj_name]
           Starts a cadence project in a Conda environment
        Example:
           sp sky58270_mk5872ASM_CR
        Options:
           -c, --code: Starts vs code in the project's code workspace
		        instead of running virtuoso
           -d, --dev: Development mode which sets the IDS_DEV_ROOT
              variable to /prj/crdc_dev/${USER} This is then used by each
              project's activate script to run from there
           -h, --help:	Display this help message
           --no: Don't load any SKILL code from any conda environments,
              just start the project
           -n, --name: Uses the conda environment specified by the name given
              If both -n and -p are specified then -p is used
           -p, --prefix: Uses the conda environment specified by the prefix given
              If both -c and -p are specified then -p is used

* *cdsinfo*: Displays some basic information from the specified Cadence
  project's README

* *include_cdslib*: Adds a library to a project's cds.lib in its work area
