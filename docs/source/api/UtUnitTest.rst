Unit Testing (UtUnitTest)
-------------------------

A unit testing framework for the Cadence SKILL language. It was inspired by a
`Cadence blog post series <https://community.cadence.com/cadence_blogs_8/b/cic/posts/skill-for-the-skilled-simple-testing-macros>`_.

References
^^^^^^^^^^^^^^

- `SKILL Development Reference <https://support.cadence.com/apex/techpubDocViewerPage?path=skdevref/skdevrefIC6.1.8/skdevrefTOC.html>`_
- `SKILL IDE User Guide <https://support.cadence.com/apex/techpubDocViewerPage?path=skillide/skillideIC6.1.8/skillideTOC.html>`_

Built-in Functions:

- ``sklint(...)``
  SKILL code linter

.. dropdown:: Details

      | sklint(
      |  [ ?file tl_inputFileName ]
      |  [ ?context t_contextName ]
      |  [ ?outputFile t_outputFileName ]
      |  [ ?ignoreGroups l_ignoreGroups ]
      |  [ ?globals l_globals ]
      |  [ ?depends l_depends ]
      |  [ ?rulesFile t_rulesFile ]
      |  [ ?ignores l_ignoresMessageList ]
      |  [ ?checkNlambda g_checkNlambda ]
      |  [ ?noPrintLog g_noPrintLog ]
      |  [ ?useGlobalIgnores g_useGlobalIgnores ]
      |  [ ?useGlobalRulesFileList g_useGlobalRulesFileList ]
      |  [ ?useDisableMessages g_useDisableMessages ]
      |  [ ?checkCdsFuncs g_checkCdsFuncs ]
      |  [ ?checkPvtFuncs g_checkPvtFuncs ]
      |  [ ?checkPubFuncs g_checkPubFuncs ]
      |  [ ?prefixes l_prefixList ]
      |  [ ?checkCdsPrefixes g_checkCdsPrefixes ]
      |  [ ?checkFuncPrefixes g_checkFuncPrefixes ]
      |  [ ?tabulate g_tabulate ]
      |  [ ?skPath t_skPath ]
      |  [ ?codeVersion t_release ]
      | )

UtUnitTest Class
^^^^^^^^^^^^^^^^

Methods:

- ``UtTest->new(name)``
  Instantiates UtUnitTest with the given name

- ``UtAssertTrue((obj UtUnitTest) val)``
  Asserts that the statement is true

- ``UtRun((obj UtUnitTest) @key (verbose t))``
  Run all test methods. A test method is any method that starts with ``test_``.

Macros:

- ``UtDefTest(@key project name class @rest body)``
  Skips defining the test if the current project does not match the
   project name specified
  Replaces the call to defmethod for the test.

- ``UtAssertTest(expr @key ident @rest printf_style_args)``
|    arguments:
|     expr - an expression to evaluate, asserting that it does not return nil
|     ?ident ident - specifies an optional identifier which will be printed with [%L] in
|                       the output if the assertion fails.  This will help you identify the
|                       exact assertion that failed when scanning a testing log file.
|     printf_style_args - additional printed information which will be output if the
|                       assertion fails.

- ``UtAssertFail (expression)``

UtSuite Class
^^^^^^^^^^^^^

Methods:

- ``UtTest->newSuite()``
  Instantiates UtSuite
- ``UtSuiteRunByPath ((obj UtSuite) path @key (verbose t))``
  Run all test files in the folder path given.
  A test file is any file with a "test_" prefix
  Args:
   Path: The path to a folder containing the test files to ran. (string or skyPath)


Source Code
^^^^^^^^^^^

.. dropdown:: UtUnitTest.ils sourcecode

    .. literalinclude:: _static/src/UtUnitTest.ils
       :language: none
       :linenos:
