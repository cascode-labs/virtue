***************
SKILL++ Modules
***************

Virtue SKILL++ modules organize closely related code without defining any
global symbols. They allow it to share private functions and variables between
functions and avoid name collisions between modules.  Modules can then be
imported into a local lexical SKILL++ environment from the module Import
table without affecting the top-level environment.  A module can be created
as a DPL or a table.

Impoort a Module
-------------------

A module can be imported into the lexical environment of a SKILL++ let
statement by defining a local variable to a module from the Package Import
table.

Define a DPL Module
-------------------

A module can be created as a decomposed property list (DPL), similar to the
`"SKILL++ packages" defined in the user manual <https://support.cadence.com/apex/techpubDocViewerPage?path=sklanguser/sklanguserIC6.1.8/sklanguserTOC.html#firstpage>`_`.
Public functions are defined as part of the DPL property list.  Private module
variables are defined in the variable list of the named let function.
Functions defined within the package's let statement but aren't in the DPL
property list are local.

example:

.. dropdown:: Lcv.ils SKILL++ Module

    .. literalinclude:: ../../_static/src/Lcv.ils
       :language: scheme
       :linenos:


Define a Table Module
---------------------

A module can also be defined as a table.  Table modules are similar to DPL
modules, however public functions are defined by
adding them as entries in the table.  The key is the function symbol and
the value is the function object.

example

.. dropdown:: Str.ils SKILL++ Module

    .. literalinclude:: ../../_static/src/Str.ils
       :language: scheme
       :linenos:
