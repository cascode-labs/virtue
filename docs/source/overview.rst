Overview
========
Virtue provides a Cadence Virtuoso SKILL library and supports Viper projects in
Cadence Virtuoso.  It also supports the Cadence Virtuoso environment as 
part of the [Viper](http://www.cascode-labs.org/viper/) open circuit design 
environment. It loads the SKILL code contained in the active Viper 
[Conda environment](https://docs.conda.io/en/latest/) when 
a project is started using the "vsp" virtue command.

* Automatically loads the Viper SKILL environment from the active Conda environment
* Provides a standard SKILL library
* Includes instructions for including SKILL code in Viper Packages
* Supports seamless execution of SKILL from Python using 
  `SkillBridge <https://unihd-cag.github.io/skillbridge/>`_
