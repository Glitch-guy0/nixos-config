# Feature Specification: Host User Configuration

**Feature Branch**: `001-host-user-config`
**Created**: 2026-03-29
**Status**: Draft
**Input**: User description: "i have to make some minor improvements and changes 1. default user option in host config file (default: none which goes to root) currently it falls to root user but i need a way to add user from here like a list of user which the value can be an array of users or none (only root) 2. initial password in config this changes also includes updating the docs at the end of these changes. need to create a checklist to keep track of it."

## Clarifications

### Session 2026-03-29

- Q: Where should the `defaultUsers` and `initialPassword` configuration options be defined in the NixOS module structure? → A: Define `defaultUsers` in host config, `initialPassword` in user-specific config files (e.g., `users/alice/default.nix`)
- Q: How should the system handle the case where the same username appears in multiple host configurations? → A: User definitions live in shared user config (`users/<name>/default.nix`), host config only declares which users should exist on that specific host
- Q: When a user is removed from a host's `defaultUsers` list, what should happen to that user account on the system? → A: User account is preserved (removal from list only stops future creation, doesn't delete existing users)
- Q: What authentication methods should default users support out-of-the-box? → A: Password authentication only (user must change password on first login)
- Q: What format should the checklist take for tracking completion of configuration and documentation changes? → A: Markdown checklist in the spec file (`tasks.md`) with checkboxes for each requirement

## User Scenarios & Testing

### User Story 1 - Configure Default Users for Host (Priority: P1)

As a system administrator, I want to specify a list of default users in the host configuration file so that these users are automatically created when the host is provisioned, instead of only having root access.

**Why this priority**: This is the core feature request. Without the ability to configure default users, administrators must manually create users after initial system setup, which is error-prone and not reproducible.

**Independent Test**: Can be fully tested by configuring a host with a list of users in the config file and verifying those users are created during system build.

**Acceptance Scenarios**:

1. **Given** a host configuration with `defaultUsers = [ "alice" "bob" ]`, **When** the host is provisioned, **Then** users "alice" and "bob" are created on the system.
2. **Given** a host configuration with `defaultUsers = [ ]` (empty list), **When** the host is provisioned, **Then** no additional users beyond root are created.
3. **Given** a host configuration without the `defaultUsers` option specified, **When** the host is provisioned, **Then** no additional users beyond root are created (default behavior preserved).

---

### User Story 2 - Set Initial Password for Default Users (Priority: P2)

As a system administrator, I want to specify an initial password for default users in their user-specific configuration files so that users have a known starting credential that can be changed later.

**Why this priority**: This complements the user creation feature by ensuring created users have accessible initial credentials. Without this, users would need alternative methods (SSH keys, manual password setting) to gain initial access.

**Independent Test**: Can be fully tested by configuring a user with `initialPassword` set in their user config file, provisioning the system, and verifying the user can authenticate with the specified password.

**Acceptance Scenarios**:

1. **Given** a user configuration file (`users/alice/default.nix`) with `initialPassword = "TempPass123!"`, **When** the host is provisioned, **Then** user "alice" can log in with password "TempPass123!".
2. **Given** a user configuration with `initialPassword` not specified, **When** the host is provisioned with default users, **Then** those users are created without a password (locked account).

---

### User Story 3 - Document Configuration Options (Priority: P3)

As a system administrator, I want clear documentation of the new `defaultUsers` and `initialPassword` configuration options so that I understand how to use them correctly.

**Why this priority**: Documentation ensures discoverability and correct usage of the new features. While not blocking the core functionality, it is essential for user adoption.

**Independent Test**: Can be fully tested by reviewing the documentation and verifying it accurately describes the configuration options, their default values, and usage examples.

**Acceptance Scenarios**:

1. **Given** the documentation is updated, **When** a user reads it, **Then** they find clear examples of how to configure `defaultUsers` as an array.
2. **Given** the documentation is updated, **When** a user reads it, **Then** they understand the relationship between `initialPassword` and `defaultUsers`.

---

### Edge Cases

- What happens when `defaultUsers` contains duplicate usernames? System should handle gracefully (deduplicate or error).
- How does system handle special characters in `initialPassword`? Password should support standard special characters used in secure passwords.
- What happens when `initialPassword` is set but `defaultUsers` is empty? Password setting is ignored (no users to apply to).
- How does system handle empty string in `defaultUsers` array? Empty strings should be ignored or cause validation error.
- What happens on re-building a host with existing users? User configuration should be idempotent (re-applying doesn't break existing users).
- What happens when a user is removed from a host's `defaultUsers` list? The user account is preserved on the system (removal only prevents future creation, does not delete existing users).
- How does the system handle a user referenced in multiple host configs? User definition lives in shared user config (`users/<name>/default.nix`); each host config declares which users exist on that specific host.

## Requirements

### Functional Requirements

- **FR-001**: System MUST provide a `defaultUsers` configuration option in host configuration files.
- **FR-002**: `defaultUsers` MUST accept an array of strings where each string is a username.
- **FR-003**: `defaultUsers` MUST default to an empty array (no users created beyond root) when not specified.
- **FR-004**: System MUST provide an `initialPassword` configuration option in user-specific configuration files (e.g., `users/<name>/default.nix`).
- **FR-005**: `initialPassword` MUST accept a string value representing the initial password.
- **FR-006**: `initialPassword` MUST default to unset (no password) when not specified.
- **FR-007**: When `initialPassword` is set in a user's config and that user is included in a host's `defaultUsers`, the system MUST apply the password to that user on the host.
- **FR-008**: When `initialPassword` is set but the user is not in any host's `defaultUsers`, the system MUST NOT create any users or raise an error.
- **FR-009**: User creation MUST be idempotent (re-applying configuration does not break existing users).
- **FR-010**: Documentation MUST be updated to describe `defaultUsers` and `initialPassword` options with usage examples.
- **FR-011**: A checklist MUST be created to track completion of all configuration and documentation changes.
- **FR-012**: Default users MUST authenticate via password only (password authentication required on first login).
- **FR-013**: When a user is removed from a host's `defaultUsers` list, the user account MUST be preserved on the system (not deleted or disabled).
- **FR-014**: User definitions MUST live in shared user config (`users/<name>/default.nix`); host configs only declare which users exist on that specific host.

### Key Entities

- **Host Configuration**: The NixOS configuration file that defines system settings for a specific host, including the new `defaultUsers` option that declares which users should exist on that host.
- **User Configuration**: The user-specific Nix file (e.g., `users/<name>/default.nix`) that defines user attributes like `initialPassword`, SSH keys, and other user-specific settings.
- **Default User**: A user account that is automatically created during host provisioning based on the `defaultUsers` configuration in the host file, with user-specific settings sourced from their user configuration.
- **Initial Password**: A temporary password assigned to a user during creation (defined in user config), intended to be changed by the user after first login.

## Success Criteria

### Measurable Outcomes

- **SC-001**: Administrators can configure multiple default users by specifying an array of usernames in the host configuration file.
- **SC-002**: When `defaultUsers` is not specified or is an empty array, no users beyond root are created (backward compatibility preserved).
- **SC-003**: Default users can successfully authenticate using the configured `initialPassword` (from their user config) after host provisioning.
- **SC-004**: Documentation includes clear examples showing both `defaultUsers` array syntax in host config and `initialPassword` usage in user config.
- **SC-005**: All configuration changes are tracked via a markdown checklist in `tasks.md` with 100% completion before feature is considered done.
- **SC-006**: Re-applying the same configuration to an existing host does not cause errors or duplicate users.
- **SC-007**: Removing a user from a host's `defaultUsers` list preserves the existing user account on the system.
- **SC-008**: User definitions in shared user config can be referenced by multiple hosts without duplication or conflict.
