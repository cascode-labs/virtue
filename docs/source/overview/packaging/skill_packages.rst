*****************
SKILL++  Packages
*****************

A SKILL++ package is a set of related SKILL++ modules defined as part of a
project.  Normally each project contains a single SKILL++ package.

A Virtue SKILL++ conda package can :
* Automatically initialize it's SKILL Code
* Customize the library manager
* Register custom view types with the data registry
* Add OA libraries to the library manager

Initialize SKILL
----------------

Each SKILL++ package should have an initialization file which loads and
initializes all of the project's skill code.  The init file should follow be
named "<project-name>.cdsinit.ils" (SKILL++) or
"<project-name>.init.il" (SKILL) by convention.  It should be located
in the top-level source code directory.  This init file will then be loaded by
Virtue automatically once virtue is installed.

The virtue-environment.ils script initializes each package in the Virtue
SKILL environment containing it.
The Virtue package is initialized first, followed by all
the initialization scripts of all the other packages.  The
initialization scripts are loaded from the location registerd with Virtue.

Customize the Library Manager
-----------------------------

A Virtue SKILL++ package can customize the Virtuoso library manager to
customize its menus and settings. See the installation instructions for how
the library customization environment initialization script can be called.


A library manager initialization script can be included in the source code
directory.  It's file name should end in "cdsLibMgr.il". This file can contain
calls to any of the
`library manager SKILL functions <https://support.cadence.com/apex/techpubDocViewerPage?path=caiskill/caiskillICADVM20.1/Imgr.html#pgfId-962695>`_.
These functions **cannot** be called from the main SKILL initialization script
which is loaded in the top-level SKILL environment.

A project can add additional entries in the Virtue library manager menu
which can be referenced by name, "**VirtueMenu**".
If more than one item is needed for a project, it should be added as a
sub-menu.  Links to documentation for other projects can also be added to the
"**VirtueHelpMenu**".

.. image:: ../../_static/virtue_menu.png
   :alt: Virtue library manager menu

see :ref:`Install the Library Manager Customizations` for installation information.

Examples:

See `Library Manager customization example file <https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1Od0000000nYpvEAE&pageName=ArticleContent>`_
from Cadence online support for examples.

.. dropdown:: Virtue's virtue.cdsLibMgr.il script

    .. literalinclude:: ../../_static/src/virtue.cdsLibMgr.il
       :language: lisp
       :linenos:

Data Registry Customization
---------------------------

A virtue conda package can customize the Virtuoso data registry to include
custom view types in the library manager.  The package should then register the
location of it with Virtue using the plugin hooks.
Virtue will then add this as a SOFTINCLUDE in its data.reg along with all the
other packages in the same Python environment with data.reg files registered
so only the virtue data.reg needs to be installed in your environment.

See the :ref:`Install View Types <install_view_types>` section for
environment setup instructions.

Cadence Libraries
-----------------

**Still under development**

A Conda SKILL package can add libraries to Virtuoso by registering them with
Virtue.
