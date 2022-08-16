TOML Config Files
-----------------

Virtue supports the reading and writing of
`TOML config files <https://toml.io>`_
which are easy to use and human-readable.

Currently Virtue supports basic TOML files including key-value pairs and
tables.  But it doesn't currently support the whole specification and is
missong some features such as in-line tables.

Read a ".toml" file into a SKILL Table using the following function:

.. code-block:: lisp
   :linenos:
   :caption: TOML read function signature

   Toml->ReadFile(filePath "t")

Write a ".toml" file from a SKILL table or association list input:

.. code-block:: lisp
   :linenos:
   :caption: TOML write function signature

   Toml->WriteFile(filePath input "tg")
