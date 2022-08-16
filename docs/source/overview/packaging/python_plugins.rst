***********************
Virtue Python Plugins
***********************

Virtue uses `Pluggy <https://pluggy.readthedocs.io/en/stable/#>`_
to register Virtue packages and include their SKILL packages in the
Virtue SKILL environment.

The available hooks can be found in the hook specs:

.. note:: The hooks required to register a Virtue SKILL package are noted in the docstrings of the hooks

.. dropdown:: Virtue Hook Specs

    .. literalinclude:: ../../_static/src/plugins/hookspecs.py
       :language: python
       :linenos:

Virtue defines a subset of these for itself:

.. dropdown:: Virtue's own hook implementations

    .. literalinclude:: ../../_static/src/plugins/lib.py
       :language: python
       :linenos:
