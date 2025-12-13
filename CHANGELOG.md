# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v0.8.0]

### Added

- Initial SKILL docstring extraction Python functions
- 'is_package Module metadata parameter

### Changed

- Modules don't add themselves to VrtImport when created
- Module->New "package" parameter renamed to "parent"
- Modules add themselves to a provided parent module
- Package->New function interface updated to be similar to Module->New.  You 
  don't need to create a new module before creating a package.  Package->New 
  will create the package's module.  Packages are addded to VrtImport.

## [0.7.0] - 2022-08-07

### Added

- Time module

### Fixed

- Export Path functions

## [0.6.0] - 2023-06-10

### Changed

- Rename Import table to VrtImport

## [0.5.0] - 2023-02-09

### Added

- Module->AddItem method
- Analog 2 digital calculator functions
- Path FileName function

## [0.4.0] - 2022-10-06

### Added

- Many updates

## [0.3.2] - 2022-08-18

### Fixed

- Env install 

## [0.3.1] - 2022-08-16

### Fixed

- Env install 

## [0.3.0] - 2022-08-15

### Added

- Virtue menu docs
- Python tests 
- Support for SKILL environment initialization using a Python plug-in system Fixes #17
- CLI install command

### Changed

- CLI info command now prints a table

## [0.2.1] - 2022-08-09

### Fixed

- Conda recipe build

## [0.2.0] - 2022-08-07

### Added

- Many updates

## [0.1.0] - 2022-07-30

### Added

- Initial release

[unreleased]: https://github.com/skyworksinc/IDS-skill/compare/v1.8.0...HEAD
[1.8.0]: https://github.com/skyworksinc/IDS-skill/compare/v1.7.1...v1.8.0
[1.7.1]: https://github.com/skyworksinc/IDS-skill/compare/v1.7.0...v1.7.1
[1.7.0]: https://github.com/skyworksinc/IDS-skill/compare/v1.6.0...v1.7.0
[1.6.0]: https://github.com/skyworksinc/IDS-skill/compare/v1.5.0...v1.6.0
[1.5.0]: https://github.com/skyworksinc/IDS-skill/compare/v1.2.1...v1.5.0
[1.2.1]: https://github.com/skyworksinc/IDS-skill/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/skyworksinc/IDS-skill/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/skyworksinc/IDS-skill/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/skyworksinc/IDS-skill/releases/tag/v1.0.0