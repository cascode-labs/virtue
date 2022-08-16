Conda Package Manager
======================

`Conda <https://docs.conda.io/en/latest/>`_ is a package, environment and
dependency manager.  It can be used to create a Conda environement containing
Virtue SKILL++ packages, along with any version of Python and packages from any
language, to easily create an IC design environment.

Getting started with Conda
---------------------------

You can find instructions on how setup a design automation environment
on the Viper-forge site.

Then all you have to do is activate your shell and start virtuoso.  Either
start it the way you normally do or you can use the "sp" command provided by
Virtue.

Viper-forge is a project to add design automation Conda packages to the
conda-forge channel. (Conda package repository)

A Virtue skill environment will be created inside a conda
environment with Virtue installed in it.  Then if the conda environment
can be activated and virtuoso can be started

Build a SKILL Conda Package
---------------------------

A Conda recipe must be created to build
a conda package

`Conda-build <https://docs.conda.io/projects/conda-build/en/latest/>`_ and
`Boa <https://github.com/mamba-org/boa>`_ are tools for building Conda
packages.
A `Conda recipe <https://docs.conda.io/projects/conda-build/en/latest/concepts/recipe.html>`_
provides the instructions on how to build a conda package.  The conda package
metadata will be defined in a
`meta.yaml file <https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html>`_.
For example this is the meta.yaml file for Virtue:

.. dropdown:: Virtue meta.yaml

    .. literalinclude:: ../_static/conda-recipe/meta.yaml
       :language: yaml+jinja
       :linenos:

A SKILL package recipe will need a
`build script <https://docs.conda.io/projects/conda-build/en/latest/resources/build-scripts.html>`_, build.sh,
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
