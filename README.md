![Virtue](docs/source/_static/logo/virtue_banner_with_tagline.png "Virtue")

[![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/cascode-labs/virtue?include_prereleases)](https://github.com/cascode-labs/virtue/releases/latest)
[![Conda](https://img.shields.io/conda/v/conda-forge/virtue?label=conda-forge)](https://anaconda.org/conda-forge/virtue)
[![PyPI](https://img.shields.io/pypi/v/virtue-skill)](https://pypi.org/project/virtue-skill/)
[![GitHub issues](https://img.shields.io/github/issues/cascode-labs/virtue)](https://github.com/cascode-labs/virtue/issues)
[![PyPI - License](https://img.shields.io/pypi/l/virtue-skill)](https://choosealicense.com/licenses/mit/)

A SKILL and Python Framework for automating IC design in
[Cadence Virtuoso](https://www.cadence.com/en_US/home/tools/custom-ic-analog-rf-design/circuit-design.html)
with the following goals:

1. Bring the capabilities of skill to Python so (ideally) you don't have
   to write skill code to do EDA in Python
2. In those cases where you do need to write skill, make it pythonic


## Projects Built with Virtue

- [Softworks](https://github.com/cascode-labs/softworks):
  Software and documentation view types in the Cadence Virtuoso IC design environment.
- [Data-panels](https://github.com/cascode-labs/data-panels):
  Export rich data reports from simulation results to pptx slides and
  xlsx tables
- [Morpheus](https://github.com/cascode-labs/morpheus):
  Generate Maestro test benches in a standard way compatible with an associated
  data-panels report

> [YouTube Video Explanation](https://www.youtube.com/watch?v=5GJbBLpHo6s&t=1s)

## Features

- A [SKILL standard library](https://www.cascode-labs.org/virtue/reference/skill_api/index.html) of "batteries included" modules
- A [SKILL test framework](https://www.cascode-labs.org/virtue/overview/testing_framework.html) modeled after [pytest](https://docs.pytest.org/en/7.1.x/)
- A [SKILL TOML config file reader and writer](https://www.cascode-labs.org/virtue/overview/toml.html)
  for the [TOML standard](https://toml.io)
- A SKILL package manager
  - Define [SKILL++ modules](https://www.cascode-labs.org/virtue/overview/packaging/modules.html)
  - Import modules into a SKILL++ lexical scope using the top-level "Import" table
  - Create [SKILL++ packages](https://www.cascode-labs.org/virtue/overview/packaging/skill_packages.html)
- SKILL environment manager using
  [Conda](https://docs.conda.io/en/latest/) or
  [Pip](https://pip.pypa.io/en/stable/reference/build-system/pyproject-toml/)
  Python environments
- Seamless execution of SKILL from Python using
  [SkillBridge](https://unihd-cag.github.io/skillbridge/)

## Example SKILL++ Package

```scheme
let((Str
     (module_description "String functions")
     (Module Import['Module])
    )
Str = let(()

procedure(emptyp(in "g")
  "Checks if the input is an empty string
  @param Any type of object to be checked
  @return A boolean, 't if it is an empty string, otherwise nil"
  stringp(in) && strlen(in) == 0)

procedure(str2bool(input_string "t")
  "Converts a case-insensitive 'TRUE' or 'FALSE' string to a boolean
   ('t / nil) If it is not a boolean, the string is returned."
 if(stringp(input_string) && (upperCase(input_string) == "TRUE") then
   't
  else if(stringp(input_string) && (upperCase(input_string) == "FALSE") then
    nil
  else
    error("%s is not a boolean, must be \"TRUE\" or \"FALSE\"
           (case insensitive)" input_string)
  ))
)

list(nil
  'emptyp emptyp
  'str2bool str2bool
))

Module->New('Str Str
             ?package Import['Virtue]
             ?description module_description)

)
```

## Example Test Script

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
