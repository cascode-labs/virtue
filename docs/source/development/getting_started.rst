Getting Started
================

I would recommend using vs code to develop virtue.  It has many helpful 
extensions, including a skill code extension for syntax highlighting.

Install a development version
------------------------------

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

Writing Documentation
----------------------

The documentation is built using the 
`Sphinx static site generator <https://www.sphinx-doc.org/>`_
and the 
`pydata theme <https://pydata-sphinx-theme.readthedocs.io/en/stable/>`_.

We use sphinx-autobuild to automatically rebuild the documentation whenever it
changes.  To start the auto-build, open a new terminal in the project repo root
directory and start it by calling the following.  If you're using a
vs code integrated terminal then a box will popup asking you to open the 
auto-built docs in a web browser.  Otherwise navigate to the indicated 
URL.

.. code-block::
   :linenos:
   :lineno-start: 5
   :caption: Start the docs' auto-build

   make auto-docs

To rebuild the documentation a single time:

.. code-block::
   :linenos:
   :lineno-start: 5
   :caption: Build the docs' once

   make docs
