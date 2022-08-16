Packaging
=========

Virtue packages consist of both a Python package and a SKILL++ package.
The skill code is installed into a Python environment using either Conda or
Pip.  Then a SKILL environment is created within the Python environment using
the "virtue install" command.

Virtue packages allow SKILL++ code to be organized into modules.  Then these
modules can be accessed from the global "Import" table without cluttering the
global namespace. This system allows many modules to be defined without naming
collisions.  It also allows new tools to be easily added to the SKILL
environment.

.. toctree::
   :caption: Contents:
   :hidden:

   modules
   skill_packages
   python_plugins
