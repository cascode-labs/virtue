Getting Started
================

Development installation
-------------------------

1. Make sure you have
   `mambaforge <https://github.com/conda-forge/miniforge#mambaforge>`_
   (`conda <https://docs.conda.io/en/latest/>`_) installed

2. Create a new Conda development environment with all the Virtue dependencies
   installed

   .. code-block:: bash
      :linenos:
      :caption: create a conda development environment

      conda env create -f environment.yml

3. Install virtue as an editable package.

   .. code-block:: bash
      :linenos:
      :lineno-start: 2
      :caption: Install virtue as an editable package

      conda activate virtue-dev
      pip install --no-deps -e .

4. Initiailize the virtue SKILL environement by following the standard
   installation instructions.

   .. code-block:: bash
      :linenos:
      :lineno-start: 5
      :caption: Initialize the environment

      virtue env init

5. Install pre-commit git hooks

   .. code-block:: bash
      :linenos:
      :lineno-start: 7
      :caption: create a conda development environment

      pre-commit install

6. If you're using VS Code as your IDE, then install the extensions recommended
   by the workspace.
