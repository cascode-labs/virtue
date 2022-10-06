******************************
Virtue Package Registration
******************************

Virtue uses `Pluggy <https://pluggy.readthedocs.io/en/stable/#>`_
to register Virtue packages and include their SKILL packages in the
Virtue SKILL environment.  A package can register itself as a Virtue SKILL
plugin by registering a dictionary by implementing a hook.

Softworks Example
-----------------

Softworks is registered as a Virtue SKILL package with the following steps

1. Include all your SKILL code under your top-level Python module.

2. Add a Virtue entry-point in your "pyproject.toml" (recommended) or
   "setup.py" files which points to the module containing the hook
   implementation.

    .. code-block:: yaml
        :linenos:
        :caption: pyproject.toml

        [project.entry-points.virtue]
        softworks = "softworks.virtue_softworks"

3. Add a Virtue hook implementation to register the Virtue SKILL package.
   The hook must be defined in the module selected in the entry-point.

    .. dropdown:: Softwork's Virtue Package registration hook implementation

        .. literalinclude:: ../../_static/plugins/softworks/virtue_softworks.py
            :language: python
            :linenos:
            :caption: softworks.virtue_softworks

Reference
---------

.. dropdown:: Virtue Registration Dictionary Entry Definitions

    A SKILL package can define the following entries in its registration
    dictionary:

    .. autoclass:: virtue.skill_package.metadata_data.SKillPackageMetadata
        :members:

    .. autoclass:: virtue.skill_package.metadata_data.SKillPackageOptionalMetadata
        :members:

.. dropdown:: Virtue Registration Function Definition

    .. autofunction:: virtue.plugins.hookspecs.virtue_register_skill_package

Virtue defines a subset of these for itself:

.. dropdown:: Virtue's own hook implementations

    .. literalinclude:: ../../_static/src/plugins/lib.py
       :language: python
       :linenos:
