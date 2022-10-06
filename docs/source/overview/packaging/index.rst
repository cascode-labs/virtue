Packaging
=========

A Virtue package is a Python package which contains a SKILL package.
The skill code is installed into a Python environment using either Conda or
Pip.  Then a SKILL environment is created within the Python environment using
the "virtue env install" command.

Virtue packages can then contain SKILL moduels which organize SKILL code.
Then these modules can be accessed from the global "Import" table
without cluttering the global namespace. This system allows many modules
to be defined without naming collisions.  It also allows new tools to be
easily added to the SKILL environment.  Each module consists of a SKILL
table which can be defined directly as a table or as a DPL.

.. toctree::
   :caption: Contents:
   :hidden:

   package_registration
   modules
   skill_packages
