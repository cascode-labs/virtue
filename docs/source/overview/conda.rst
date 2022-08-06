Conda Package Manager
======================

`Conda <https://docs.conda.io/en/latest/>`_ is a package, environment and
dependency manager.  It can be used to create a Conda environement containing 
Virtue SKILL++ packages, along with any version of Python and packages from any 
language, to easily create an IC design environment.

Getting started
---------------

You can find instructions on how setup a design automation environment
on the Viper-forge site.

Then all you have to do is activate your shell and start virtuoso.  Either 
start it the way you normally do or you can use the "sp" command provided by 
Virtue.

Viper-forge is a project to add design automation Conda packages to the 
conda-forge channel. (Conda package repository)





to create a shell environment that 
install Conda packages and handle 
dependencies between them. The SKILL code that will load automatically from the conda environment.

A Virtue skill environment will be created inside a conda
environment with Virtue installed in it.  Then if the conda environment 
can be activated and virtuoso can be 

The conda package can :
* Automatically initialize SKILL Code 
* Customize the library manager 
* Register custom views with the data registry



Build a SKILL Conda Package
---------------------------

A Conda recipe must be created to build 
a conda package

`Conda-build<https://docs.conda.io/projects/conda-build/en/latest/>`_ and 
`Boa<https://github.com/mamba-org/boa>`_ are tools for building Conda 
packages.
A `Conda recipe<https://docs.conda.io/projects/conda-build/en/latest/concepts/recipe.html>`_
provides the instructions on how to build a conda package.  The conda package
metadata will be defined in a 
`meta.yaml file<https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html>`_.
For example this is the meta.yaml file for Virtue:

.. dropdown:: Virtue meta.yaml

    .. literalinclude:: ../_static/conda-recipe/meta.yaml
       :language: yaml
       :linenos:

A SKILL package recipe will need a 
`build script<https://docs.conda.io/projects/conda-build/en/latest/resources/build-scripts.html>`_, build.sh,
in order to include a `Virtue SKILL++ package` as a part of the Conda package.  
The build script needs  to install the package's source code to the project's 
folder in the Conda environment's Virtue SKILL environment located at 
"$CONDA_PREFIX/libs/skill/". In the example build script below, from the 
Virtue recipe, the first section copies the package source code into the 
Conda environment's SKILL environment and then the second defines some 
activation scripts that are sourced when a Conda environment is activated.

.. dropdown:: Virtue build.sh

    .. literalinclude:: ../_static/conda-recipe/build.sh
       :language: bash
       :linenos:

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
