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

Installation
------------

Conda **(recommended)**
^^^^^^^^^^^^^^^^^^^^^^^^

I would recommend using Conda to install Virtue and any related packages.  
This will install both virtue and Python.

Install in a new environment namde "virtuoso":

.. code-block:: bash
   :linenos:

   conda env create -n virtuoso 
   conda activate virtuoso
   conda install -c conda-forge virtue python=3.9

Install in an existing environment:

.. code-block:: bash
   :linenos:

   conda install -c conda-forge virtue

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

You can install Virtue using pip from the `virtue-skill PyPi package <https://pypi.org/project/virtue-skill/>`_

.. code-block:: bash

   pip install virtue-skill

.. _install-library-manager-customizations:

Install the Library Manager Customizations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Library customizations for all packages installed in a Virtue SKILL environment
can be loaded by adding the following code to the "cdsLibMgr.il" file in the 
current working directory, a user's home directory, or a site installation 
directory from the `setup.loc <https://support.cadence.com/apex/techpubDocViewerPage?xmlName=caiuser.xml&title=Cadence%20Application%20Infrastructure%20User%20Guide%20--%20Cadence%20Setup%20Search%20File:%20setup.loc%20-%20Cadence%20Setup%20Search%20File:%20setup.loc&hash=pgfId-1012853&c_version=IC6.1.8&path=caiuser/caiuserIC6.1.8/chap3.html#pgfId-1012853>`_
list.  You should also follow the instructions for 
`loading multiple cdsLibMgr.il files <https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1Od0000000nYLwEAM&pageName=ArticleContent>`_,
especially when existing site customizations must be loaded in addition to the
user's.

.. code-block:: lisp
   :linenos:
   :caption: Load virtue-environment.cdsLibMgr.il
   :name: install_cdsLibMgr-il

   when(getShellEnvVar("VIRTUE_SKILL_PREFIX") 
        && isFile(strcat(env(VIRTUE_SKILL_PREFIX) "/virtue/virtue-environment.cdsLibMgr.il"))
      printf("virtue-environment.cdsLibMgr.il...\n")
      loadi(strcat(env(VIRTUE_SKILL_PREFIX) "/virtue/virtue-environment.cdsLibMgr.il"))
   )

.. _install_view_types:

Install the View Type Registry
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Custom cell view types must be included in a 
`data.reg data registry file <https://support.cadence.com/apex/techpubDocViewerPage?xmlName=caiuser.xml&title=Cadence%20Application%20Infrastructure%20User%20Guide%20--%20Cadence%20Data%20Registry%20File:%20data.reg%20-%20Cadence%20Data%20Registry%20File:%20data.reg&hash=pgfId-1021736&c_version=ICADVM20.1&path=caiuser/caiuserICADVM20.1/chap6.html#pgfId-1021736>`_
before starting Virtuoso.

You can add the following SOFTINCLUDE line to a data.reg file in the current working, home, or 
$CDS_SITE directory. You should also 
`setup support for multiple files <https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1Od0000003runfEAA&pageName=ArticleContent>`_
if it's not already setup.  Each package
in the Virtue SKILL environment will then add itself to the environment's 
data.reg.

.. code-block::
   
   SOFTINCLUDE $VIRTUE_SKILL_PREFIX/virtue.data.reg;


License
-------

Virtue is licensed under an MIT license.

.. dropdown:: MIT License

    .. literalinclude:: ../_static/LICENSE
       :linenos:

Projects built with Virtue
--------------------------------

- `Softworks <https://github.com/cascode-labs/softworks>`_:
  View types for software and documentation views
- `Data-panels <https://github.com/cascode-labs/data-panels>`_: 
  Export data reports from simulation results to pptx slides

Other Open-source SKILL Projects
--------------------------------

- `skillbridge Python-SKILL interface <https://unihd-cag.github.io/skillbridge/>`_
- `SKILL_Tools Utilities for working with Cadence's SKILL/SKILL++ <https://github.com/MatthewLoveQUB/SKILL_Tools>`_
- `cdsgit Git design manager <http://cdsgit.github.io/cdsgit/>`_
- `cdsdm Git design manager <https://github.com/cdsdm/cdsdm>`_

.. toctree::
   :maxdepth: 2
   :caption: Contents:
   :hidden:

   standard_library
   testing_framework
   packaging/index
   conda
   toml
   release_notes
