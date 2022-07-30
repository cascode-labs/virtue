Conda Packages
==============

SKILL can be included as a part of any Conda package and loaded when Cadence
is started with the "vsp" command.  A Conda recipe must be created to build 
a conda package

The conda package can :
* Automatically initialize SKILL Code 
* Customize the library manager 
* Register custom views with the data registry
* Include cadence libraries

Conda Recipe
------------
Conda is a tool for creating software packages.
A `Conda <https://docs.conda.io/en/latest/>`_ recipe provides the instructions
on how to create a conda package using
`conda-build <https://docs.conda.io/projects/conda-build/en/latest/>`_.
The conda-build documentation has instructions on creating a conda package.

SKILL Initialization
--------------------

The virtue.init.ils script initializes the Conda SKILL environment.  
The virtue SKILL library is initialized first, followed by all 
the initialization scripts of all the other packages.  The 
initialization scripts should be contained in $CONDA_PREFIX/lib/skill 
or, preferrably, a direct  subfolder. The
initialization scripts are any SKILL files with
".init.ils" (SKILL++) or ".init.il" (SKILL) suffixes

The virtue initialization script is ran in virtuoso when Virtuoso is started with
the sp command.

Library Manager Customization
-----------------------------

A virtue conda package can customize the Virtuoso library manager by including an
initialization in its SKILL lib.  This file needs to a ".lmgrinit" extension.
This file will be loaded by the license manager when it loads to setup menus,
etc.

This is supported by our system library manager initialization loading the
script using the following SKILL code.  $VIRTUE_LMGR_INIT is initialized by the
virtue activation script::


   when(getShellEnvVar("VIRTUE_LMGR_INIT") && isFile(strcat(env(VIRTUE_LMGR_INIT) "/virtue.lmgrinit"))
      printf("Loading virtue.lmgrinit...\n")
      loadi(strcat(env(VIRTUE_LMGR_INIT) "/virtue.lmgrinit"))
   )


Data Registry Customization
---------------------------

A virtue conda package can customize the Virtuoso data registry to include
custom view types in the library manager.  The package should install a
data.reg file in its SKILL lib folder and then add this as a SOFTINCLUDE in the
virtue.data.reg file in the root SKILL library.  Here's an example line to install
the data.reg in the build.sh script of the Softworks conda recipe.

```
# Install data.reg
echo "SOFTINCLUDE ${PREFIX}/lib/skill/Softworks/data.reg;" >> \
"${PREFIX}/lib/skill/virtue.data.reg"
```

This is supported by our system data.reg by including the following line in it.
$VIRTUE_DATA_REG is initialized by the virtue activation script to point to the
activated conda environment.

```
SOFTINCLUDE $VIRTUE_DATA_REG/virtue.data.reg;
```

Cadence Libraries
-----------------
A Conda SKILL package can add libraries to Virtuoso by adding its own cds.lib entry to the
environment's common cds.lib file.  This entry should be created as part of
the package's Conda recipe in the build.sh script. Here's an example of the
build commands:

```
# Install Cadence Virtuoso libraries
echo "SOFTINCLUDE ${PREFIX}/lib/skill/Softworks/cds.lib" >> \
"${PREFIX}/lib/skill/cds.lib"
```

An entry is then added to each project's cds.lib file to
SOFTINCLUDE the environment's common cds.lib file.
