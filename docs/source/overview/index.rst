========
Overview
========
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

License
-------

Virtue is licensed under an MIT license.

.. dropdown:: MIT License

    .. literalinclude:: ../_static/LICENSE
       :linenos:

Installation
------------

From Source
^^^^^^^^^^^^

Just load the "virtue.init.ils" from the CIW window or add the following to
your .cdsinit file:

.. code-block:: lisp

   load("/path/to/repo/virtue/virtue/virtue.init.ils")


Reminder: The following will change your top-level interpreter to SKILL++:

.. code-block:: lisp

   toplevel('ils)

Pip
^^^^^

You can install Virtue using pip from the [virtue-skill PyPi package](https://pypi.org/project/virtue-skill/)

.. code-block:: bash

   pip install virtue-skill

Conda
^^^^^

Coming soon!

.. _install-library-manager-customizations:

Install the Library Manager Customizations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Library customizations for all packages installed in a Virtue SKILL environment
can be loaded by adding the following code to the "cdsLibMgr.il" file in the 
current working directory, a user's home directory, or a site installation 
directory from setup.loc list.  You should also follow the instructions for 
`loading multiple cdsLibMgr.il files<https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1Od0000000nYLwEAM&pageName=ArticleContent>`_,
especially when existing site customizations must be loaded in addition to the
user's.

.. code-block:: lisp
   :linenos:
   :caption: install_cdsLibMgr.il
   :name: install_cdsLibMgr-il

   when(getShellEnvVar("VIRTUE_SKILL_PREFIX") && isFile(strcat(env(VIRTUE_SKILL_PREFIX) "/virtue//virtue.lmgrinit"))
      printf("Loading virtue.cdsLibMgr.il...\n")
      loadi(strcat(env(VIRTUE_SKILL_PREFIX) "/virtue/virtue.cdsLibMgr.il"))
   )

.. toctree::
   :maxdepth: 2
   :caption: Contents:
   :hidden:

   packaging/index
   conda
   release_notes
