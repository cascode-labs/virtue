***************
SKILL++ Modules
***************

Virtue SKILL++ modules ares SKILL tables that organize closely related code
without defining any global symbols. They allow it to share private functions
and variables between functions and avoid name collisions between modules.
Modules can then be imported into a local lexical SKILL++ environment from
the module Import table without affecting the top-level environment.
A module is saved as a table but can be created as a DPL or a table.

Import a Module
-------------------

A module can be imported into the lexical environment of a SKILL++ let
statement by defining a local variable to a module from the Package Import
table.

Define a DPL Module
-------------------

A module can be created as a decomposed property list (DPL), similar to the
`"SKILL++ packages" defined in the user manual <https://support.cadence.com/apex/techpubDocViewerPage?path=sklanguser/sklanguserIC6.1.8/sklanguserTOC.html#firstpage>`_.
Public functions are defined as part of the DPL property list.  Private module
variables are defined in the variable list of the named let function.
Functions defined within the package's let statement but aren't in the DPL
property list are local.  The public variables of the DPL are added to the
module's table.

example:

.. dropdown:: Lcv.ils SKILL++ Module

    .. literalinclude:: ../../_static/src/data_types/Lcv.ils
       :language: scheme
       :linenos:
