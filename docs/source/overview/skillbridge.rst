Skillbridge
============

Virtue includes support for the
`skillbridge <https://unihd-cag.github.io/skillbridge/>`_
library for running SKILL code in a Virtuoso session from Python.
It communicates between SKILL and Python using IPC and a TCP port.

Menu
-----

Skillbridge can be started from the Virtue menu in the library manager.
Once it is running, it can be shutdown by toggling the same menu item.

.. image:: ../../_static/virtue_menu.png
   :alt: Virtue library manager menu

Workspace ID
------------

Virtue also provides a workspace ID that can be used to create a unique
workspace for each user and project.

The workspace ID is based on environment variables and is defined as

workspace_id = "${PRJ_ID}-${USER}"

Where $PRJ_ID is the name of the current project.

