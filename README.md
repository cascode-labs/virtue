# VIRTUE

![PyPI](https://img.shields.io/pypi/v/virtue-skill) 
![GitHub issues](https://img.shields.io/github/issues/cascode-labs/virtue) 
![Conda](https://img.shields.io/conda/v/conda-forge/virtue?label=conda-forge)

Cadence Virtuoso SKILL++ framework

Features:

- A standard library of packages with functions for common tasks
- A test framework modeled after [pytest](https://docs.pytest.org/en/7.1.x/)
- A [TOML config file](https://toml.io) reader and writer
- A package import system that allows the library to define just a single
top-level import table symbol that allows each package to be imported locally.

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

It requires Python >= 3.7

### Using Conda **(recommended)**

I would recommend using Conda to install Virtue and any related packages.  
This will install both virtue and Python.

Install in a new environment:

```bash
conda env create -n virtuoso 
conda activate virtuoso
conda install -c conda-forge virtue python=3.9
```

Install in an existing environment:

```bash
conda install -c conda-forge virtue
```

### From Source

Just load the "virtue.init.ils" from the CIW window or add the following to
your .cdsinit file:

```lisp
load("/path/to/repo/virtue/virtue.init.ils")
```

Reminder: The following will change your top-level interpreter to SKILL++:

```lisp
toplevel('ils)
```

### Using Pip

You can install Virtue using pip from the [virtue-skill PyPi package](https://pypi.org/project/virtue-skill/)

```bash
pip install virtue-skill
```
