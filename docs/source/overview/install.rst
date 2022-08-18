Install
========

Conda **(recommended)**
------------------------

I would recommend using Conda to install Virtue and any related packages.
This will install both virtue and Python.

You'll need to download the virtuoso environment definition file,
`environment-virtuoso.yml, <../_static/environment-virtuoso.yml>`_
which will be used to create the environment with the recommended Virtue
packages.

0. Install mambaforge if some form of conda or mamba isn't already installed
   using the `mambaforge installer <https://github.com/conda-forge/miniforge#mambaforge>`_.

1. Install in a new environment named "virtuoso":

   .. code-block:: bash

      conda env create -f environment-virtuoso.yml

2. Activate the newly created Conda environment and then
   install the Virtue SKILL environment into its Python environment.


   .. code-block:: bash

      conda activate virtuoso
      virtue install

3. Follow the instructions to add the Virtue SKILL environment initialization
   scripts to your Virtuoso initialization scripts.
   see ":ref:`Install the Library Manager Customizations`" and
   ":ref:`Install the View Type Registry`" sections for more details and hints.

Pip / venv
------------

You can install Virtue using pip from the `virtue-skill PyPi package <https://pypi.org/project/virtue-skill/>`_

0. You'll need to have Python and pip installed and it's recommended to create
   a new new virtual environment for virtuoso before installing virtue.

1. Install Virtue using Pip.  skillbridge and softworks are both optional
   recommendations to be installed with virtue.

   .. code-block:: bash

      # Remember to activate your virtual environment first
      pip install virtue-skill skillbridge softworks
      virtue install

2. Follow the instructions to add the Virtue SKILL environment initialization
   scripts to your Virtuoso initialization scripts.  Each script will need to
   be initialized in a different way in your Virtuoso environment.

.. _install-library-manager-customizations:

From Source
-------------

Just load the "virtue.init.ils" from the CIW window or add the following to
your .cdsinit file:

.. code-block:: lisp

   load("/path/to/repo/virtue/virtue/virtue.init.ils")


Reminder: The following will change your top-level interpreter to SKILL++:

.. code-block:: lisp

   toplevel('ils)

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
