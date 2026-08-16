# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-08-15

### Added
- One-liner installer script `install.sh` to automate extension installation for current or specified PHP versions.
- Machine-readable index `manifest.json` containing PHP version, extension types, file paths, SHA256 checksums, and architectures.
- Integrity verification with `checksums.txt` containing SHA256 hashes of all `.so` binaries.
- Automated checksum verification details added to the installation guide in `README.md`.
- Compilation support for PHP versions `8.0.3` through `8.4.2` appended to build systems.
- Script `generate-manifest.py` / `generate-manifest.sh` to dynamically compile manifest metadata.
- Download helper functions supporting both `wget` and `curl`.

### Changed
- Refactored `pcntl()` and `redis()` build functions in `populate.sh` to resolve the `php-config` path dynamically.
- Improved documentation in `README.md` with build environment requirements and version guide.

## [0.3.0] - 2025-06-21

### Added
- Support for `curl` extension (commit `25e4e2a`).
- Detailed extension comparison table in `README.md` (commit `531c2bd`).
- Coverage for additional PHP versions (commit `f65d0a8`).

### Changed
- Improved overall project documentation in `README.md` (commit `2423a13`).

## [0.2.0] - 2021-03-10

### Added
- Support for `redis` and `pcntl` pre-compiled extensions for PHP versions `5.4.*`, `5.5.*`, and `5.6.*` (commit `45c1914`).

### Changed
- Rebuilt pre-compiled extension binaries (commit `35600d0`).
- Updated repository structure to organize `.so` files by PHP version.

## [0.1.0] - 2021-03-10

### Added
- Initial pre-compiled shared libraries for `redis` and `pcntl` extensions across PHP 5.5, 5.6, and early 7.x/8.x versions.
- Base build script and configuration for compilation of PHP extensions.
- Project `README.md` detailing usage and installation steps.

[Unreleased]: https://github.com/jrquick17/php-extension-library/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/jrquick17/php-extension-library/compare/v0.3.0...v1.0.0
[0.3.0]: https://github.com/jrquick17/php-extension-library/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/jrquick17/php-extension-library/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/jrquick17/php-extension-library/releases/tag/v0.1.0
