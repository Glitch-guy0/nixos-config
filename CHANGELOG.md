# Changelog

All notable changes to this configuration will be documented in this file.

## [Unreleased]
### Added
- Initial scaffolding based on the Constitution Canvas.
- **Host User Configuration** (`001-host-user-config`): Added `defaultUsers` option in host module to create users declaratively. User configs in `users/<name>/default.nix` support `initialPassword` and `extraGroups` options. Users are created during system build and can be shared across multiple hosts.
