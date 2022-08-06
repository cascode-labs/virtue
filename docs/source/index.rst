.. IDS-skill documentation master file, created by
   sphinx-quickstart on Thu Oct 15 16:36:40 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

******
VIRTUE
******

Virtue is a SKILL framework for `Cadence Virtuoso <https://www.cadence.com/en_US/home/tools/custom-ic-analog-rf-design/circuit-design.html>`_

Features:

- A standard library of packages with functions for common tasks
- A test framework modeled after `pytest <https://docs.pytest.org/en/7.1.x/>`_
- A `TOML config file <https://toml.io>`_ reader and writer
- A SKILL code packaging system

  - Define SKILL++ modules 
  - Create a SKILL++ package from a set of modules
  - Import modules into a SKILL++ environment using the top-level "Import" table 

- Support for SKILL environment management using `Conda <https://docs.conda.io/en/latest/>`_
- Supports seamless execution of SKILL from Python using 
  `SkillBridge <https://unihd-cag.github.io/skillbridge/>`_

.. toctree::
   :maxdepth: 2
   :caption: Contents:
   :hidden:

   overview/index
   reference/index
   development/index


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
