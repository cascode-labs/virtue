Getting Started
================

Development installation
-------------------------

1. Make sure you have mambaforge (conda) installed
2. Create a new Conda development environment

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
      virtue install
      pre-commit install

4. Install the virtue SKILL environement by following the standard
   installation instructions.

   .. code-block:: bash
      :linenos:
      :lineno-start: 5
      :caption: create a conda development environment

      virtue install
      pre-commit install

5. Install pre-commit git hooks

   .. code-block:: bash
      :linenos:
      :lineno-start: 7
      :caption: create a conda development environment

      pre-commit install

6. If you're using VS Code as your IDE, then install the extensions recommended
   by the workspace.
