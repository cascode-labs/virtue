***************
SKILL++ Modules
***************

SKILL++ modules allow closely related code to be grouped together and share 
private functions and variables.  Modules can then be imported 
into a local lexical SKILL++ environment without affecting the top-level 
environment.  A module can be created as a DPL or a table.

DPL Modules
------------

A module can be created as a decomposed property list (DPL), similar to the 
`SKILL++ packages defined in the user manual <https://support.cadence.com/apex/techpubDocViewerPage?path=sklanguser/sklanguserIC6.1.8/sklanguserTOC.html#firstpage>`_`.
Public functions are defined as part of the DPL property list.  Private module
variables are defined in the variable list of the named let function.

example:


Table Modules
--------------

A module can also be defined as a table.  Table modules are similar to DPL 
modules, however public functions are defined by 
adding them as entries in the table.  The key is the function symbol and 
the value is the function object.

example



The SKILL++ modules are either

* Automatically initialize SKILL Code 
* Customize the library manager
* Register custom views with the data registry
* Include cadence libraries
