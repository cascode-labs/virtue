Install
========

I would recommend using Conda to install Virtue and any related packages.
This will install both virtue and Python into a virtual environments and makes
it easy to use different versions of Python in each Conda environment.

.. tabbed:: Conda **(recommended)**

   0. Install mambaforge if some form of conda or mamba isn't already installed
      using the `mambaforge installer <https://github.com/conda-forge/miniforge#mambaforge>`_.

   1. Create a new environment named "virtuoso".

      This can be done using the environment definition from
      `our anaconda cloud <https://anaconda.org/cascode-labs/virtuoso>`_:

      .. code-block:: bash
         :linenos:
         :lineno-start: 1

         conda env create cascode-labs/virtuoso

      **OR**

      If you want to edit the packages to be installed you can download
      the virtuoso environment definition file,
      `virtuoso.yml, <../_static/virtuoso.yml>`_, and create the env
      from the downloaded file:

      .. code-block:: bash
         :linenos:
         :lineno-start: 1

         conda env create -f virtuoso.yml

   2. Activate the newly created Conda environment and then
      install the Virtue SKILL environment into its Python environment.


      .. code-block:: bash
         :linenos:
         :lineno-start: 2

         conda activate virtuoso
         virtue install


.. tabbed:: Pip / venv

   You can install Virtue using pip from the `virtue-skill PyPi package <https://pypi.org/project/virtue-skill/>`_

   0. You'll need to have Python and pip installed and it's recommended to create
      a new new virtual environment for virtuoso before installing virtue.

   1. Install Virtue using Pip.  skillbridge and softworks are both optional
      recommendations to be installed with virtue.

      .. code-block:: bash

         # Remember to activate your virtual environment first
         pip install virtue-skill skillbridge softworks
         virtue install

.. tabbed:: Source

   1. You'll need to have either Conda or Python and pip installed.  It's
      recommended to create a new Conda or venv virtual environment for virtuoso
      before installing virtue.

   2. Clone the repo from GitHub

   3. Pip install from source:

   For a read-only installation:

      .. code-block:: bash
         :linenos:
         :lineno-start: 1


         # Remember to activate your virtual environment first
         pip install .
         virtue install

   **OR**

   For an editable installation that will include local updates:

      .. code-block:: bash
         :linenos:
         :lineno-start: 1

         # Remember to activate your virtual environment first
         pip install -e .
         virtue install


Then Follow the instructions to add the Virtue SKILL environment initialization
scripts to your Virtuoso initialization scripts.
Each script will need to be initialized in a different way in your Virtuoso
environment.  See ":ref:`Install the Library Manager Customizations`" and
":ref:`Install the View Type Registry`" sections for more details and hints.

You can also just load the "virtue.init.ils" from the CIW window to enable only
the main skill code for just the current session.  This also doesn't enable
the data registry required to define custom view types and doesn't enable the
library manager customizations.

.. code-block:: lisp

   load("/path/to/repo/virtue/virtue/virtue.init.ils")


Reminder: The following will change your top-level interpreter to SKILL++
if you want to test it out interactively in SKILL++:

.. code-block:: lisp

   toplevel('ils)

.. _install-library-manager-customizations:

Install the Library Manager Customizations
--------------------------------------------

Library customizations for all packages installed in a Virtue SKILL environment
can be loaded by adding the following code to the "cdsLibMgr.il" file in the
current working directory, a user's home directory, or a site installation
directory from the
`setup.loc <https://support.cadence.com/apex/techpubDocViewerPage?xmlName=caiuser.xml&title=Cadence%20Application%20Infrastructure%20User%20Guide%20--%20Cadence%20Setup%20Search%20File:%20setup.loc%20-%20Cadence%20Setup%20Search%20File:%20setup.loc&hash=pgfId-1012853&c_version=IC6.1.8&path=caiuser/caiuserIC6.1.8/chap3.html#pgfId-1012853>`_
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
-------------------------------

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
