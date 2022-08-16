SKILL Test Framework
====================

The Test module defines a testing framework modelled after the Python
`PyTest <https://docs.pytest.org/en/7.1.x/>`_

- The built-in assert is used for testing
- test function names start with 'test\_'
- Test setup fixtures are defined with input parameters.
- Additional Test setup fixtures can be added to the Test->Fixtures table.

The Test->Run function should be called at the end of each test script so
the tests run when the script is loaded. Each test case is defined as a function that uses the built-in
assert statement to test the code.  A function is considered passing if it
doesn't throw an error.

.. dropdown:: Example test script
    :open:

    .. code-block:: scheme
       :linenos:

        let(((Str Import['Str])
            (Test Import['Test])
            (Virtue Import['Virtue])
            )

        procedure(Test_emptyp()
            assert(Str->emptyp(""))
            assert(!Str->emptyp("test"))
        )

        procedure(Test_str2bool()
            assert(Str->str2bool("true"))
            assert(Str->str2bool("TRUE"))
            assert(!Str->str2bool("false"))
        )

        procedure(Test_str2bool_error()
            assert(!errset(Str->str2bool("Nothing")))
        )

        Test->RunFile(list(nil
        'Test_emptyp Test_emptyp
        'Test_str2bool Test_str2bool
        'Test_str2bool_error Test_str2bool_error
        )
        ?filepath Virtue->GetCurrentFilePath()
        )

        )

The Test->RunDirectory(test_dir_path) function will run all the test scripts
in a directory and report the results of them all.

.. dropdown:: run_tests.ils
    :open:

    .. literalinclude:: ../_static/tests/run_tests.ils
       :language: scheme
       :linenos:

The testing framework also includes test setup fixtures which can be called
by adding the name of the fixture function to a test case:

.. dropdown:: TestFixtures.ils
    :open:

    .. literalinclude:: ../_static/tests/test_TestFixtures.ils
       :language: scheme
       :linenos:

Additional test fixtures can be added by adding them to the Test->Fixtures
table:

.. dropdown:: TestFixtures.ils
    :open:

    .. literalinclude:: ../_static/src/test/TestFixtures.ils
       :language: scheme
       :linenos:
