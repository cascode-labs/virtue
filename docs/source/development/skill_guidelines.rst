SKILL Code guidelines
======================

SKILL Code Expectations
-----------------------

The following expectations are set to ensure the quality and consistency of
Virtue's code.

- Virtue code should be written using c-style function calls rather than
  lisp-style.
- Each file should contain less than 200 lines of code.
- Applications with gui elements should seperate the gui code from the
  underlying functionality.  The functionality should have a function that allows
  it to be called programmatically.  This make it easy to test and reuse the
  code.
- Public module functions should be documented with :ref:`SKILL Docstrings`.
- Every module should have a set of unit tests demonstrating its functionality.
  These should be included in the tests/ folder.

SKILL Training
--------------

- `Writing Good SKILL Code Video <https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1O0V000009MoibUAC&pageName=ArticleContent>`_
  by Andrew Beckett

SKILL Docstrings
----------------

Docstrings should be used to document public functions

They should follow the following format which is compatible with the
SKILL function browser:

.. code-block:: lisp
   :linenos:
   :caption: Example SKILL docstring

   procedure(exampleFunction(cellview)
   "Does something very important.
   @brief A shorter description
   @param cellview The cellview object it will act on.
   @return importantList A list of important strings"
   let((localVar)
    ...
   ))
