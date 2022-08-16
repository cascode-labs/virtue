# VIRTUE

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/cascode-labs/virtue?include_prereleases)
![Conda](https://img.shields.io/conda/v/conda-forge/virtue?label=conda-forge)
![PyPI](https://img.shields.io/pypi/v/virtue-skill)
![GitHub issues](https://img.shields.io/github/issues/cascode-labs/virtue)
![PyPI - License](https://img.shields.io/pypi/l/virtue-skill)

Cadence Virtuoso SKILL++ framework

Features:

- A standard library of packages with functions for common tasks
- A test framework modeled after [pytest](https://docs.pytest.org/en/7.1.x/)
- A [TOML config file](https://toml.io) reader and writer
- A SKILL code packaging system
  - Define SKILL++ modules
  - Create a SKILL++ package from a set of modules
  - Import modules into a SKILL++ environment using the top-level "Import" table
- Support for SKILL environment management using Python environments with
  [Conda](https://docs.conda.io/en/latest/) and
  [Pip](https://pip.pypa.io/en/stable/reference/build-system/pyproject-toml/)
- Supports seamless execution of SKILL from Python using
  [SkillBridge](https://unihd-cag.github.io/skillbridge/)

## Example Test File

Note the package imports at the top

``` scheme
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
```

Prints out the following when ran in the CIW:

``` sh
FILE: /path/to/file/test_Str.ils
  passed: Test_emptyp
  passed: Test_str2bool
  passed: Test_str2bool_error
3 / 3 tests passed
```

## Installation

Virtue requires Python >= 3.7 and can be installed using several methods:
- Conda
- Pip
- From source

See the
[installation instructions in the documentation](https://www.cascode-labs.org/virtue/overview/index.html#installation)
for detailed instructions.
