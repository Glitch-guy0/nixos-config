# Feature Specification: User Configuration Cleanup

**Feature Branch**: `001-user-cleanup`
**Created**: 2026-03-30
**Status**: Draft
**Input**: User description: "this feature is completed but there are some fixes need to be done. - so it has created like a temporary user but it hasn't updated the existing user for this feature which is currently in @hosts/unknown/ but has created new user called "alice" and "bob" which i removed the user in @users/ directory but not deep cleaned. so need to update this."

## Clarifications

### Session 2026-03-30

- Q: Which specific file types/locations should have alice/bob references removed vs. preserved? → A: Remove from: user-facing docs (docs/), README files, example configs. Preserve: specs/ directory (historical feature records), CHANGELOG.md, git history
- Q: What should explicitly remain unchanged to avoid unintended modifications? → A: Out of scope: Creating new users beyond "glitch", modifying other hosts (only hosts/unknown/), changing existing module code in modules/, altering flake.nix structure
- Q: When orphaned alice/bob references are discovered outside the known locations, what's the default action? → A: Search entire repo, remove all found references in .nix files, document locations in a cleanup log file, preserve in historical specs only

## User Scenarios & Testing

### User Story 1 - Clean Up Removed Users (Priority: P1)

As a system administrator, I want to completely remove user configurations that are no longer needed, so that the system doesn't contain orphaned or inconsistent user data.

**Why this priority**: This is the core issue - users "alice" and "bob" were removed from the users/ directory but references to them still exist in host configurations, creating inconsistency and potential deployment failures.

**Independent Test**: After cleanup, running `nixos-rebuild build --flake .#unknown` should succeed without errors related to missing user configurations for "alice" and "bob".

**Acceptance Scenarios**:

1. **Given** the hosts/unknown/ configuration references "alice" and "bob" in defaultUsers, **When** the configuration is built, **Then** no errors occur about missing user definitions.
2. **Given** users "alice" and "bob" directories are removed from users/, **When** the flake is evaluated, **Then** no references to these users remain in any configuration files.

---

### User Story 2 - Update Existing User Configuration (Priority: P2)

As a system administrator, I want the existing user "glitch" to be properly configured in the hosts/unknown/ host, so that the user configuration system works correctly with the current single-user setup.

**Why this priority**: The feature description mentions "it hasn't updated the existing user for this feature which is currently in @hosts/unknown/" - indicating the existing user (glitch) needs to be properly integrated into the host configuration.

**Independent Test**: The host "unknown" should build successfully with the "glitch" user properly configured and accessible.

**Acceptance Scenarios**:

1. **Given** the hosts/unknown/ configuration has defaultUsers set, **When** the configuration includes "glitch", **Then** the glitch user is created on the system with correct home directory and settings.
2. **Given** the glitch user configuration exists in users/glitch/default.nix, **When** the host is built, **Then** the user settings are applied correctly.

---

### Edge Cases

- What happens when a user is removed from users/ but still referenced in host configurations?
  - **Resolution**: Search and remove all orphaned references in .nix files, document in cleanup log
- How does the system handle building a host configuration when user directories are missing?
  - **Resolution**: Build will fail - this is why cleanup must complete before deployment
- What cleanup is needed in documentation files that reference removed users?
  - **Resolution**: Remove from docs/ and READMEs, preserve in specs/ as historical record

### Out of Scope

- Creating new users beyond "glitch"
- Modifying hosts other than hosts/unknown/
- Changing existing module code in modules/
- Altering flake.nix structure

## Requirements

### Functional Requirements

- **FR-001**: System MUST remove all references to users "alice" and "bob" from hosts/unknown/ configuration files
- **FR-002**: System MUST update hosts/unknown/ to use the existing "glitch" user instead of removed users
- **FR-003**: Users MUST be able to build the "unknown" host configuration without errors after cleanup
- **FR-004**: System MUST ensure users/flake.nix and users/default.nix work correctly with the remaining user(s)
- **FR-005**: Documentation MUST be updated to remove references to "alice" and "bob" from user-facing docs (docs/) and README files
- **FR-006**: System MUST preserve references to "alice" and "bob" in historical records (specs/, CHANGELOG.md, git history)
- **FR-007**: System MUST search entire repository for orphaned alice/bob references in .nix files and remove them
- **FR-008**: System MUST create a cleanup log documenting all locations where references were removed

### Key Entities

- **User Configuration Directory**: Location in users/<username>/ containing user-specific Nix configurations
- **Host Configuration**: Location in hosts/<hostname>/ containing host-specific settings including defaultUsers list
- **defaultUsers**: List of usernames that should be created on a specific host
- **User Profile**: Individual configuration file in users/<username>/profiles/<profile>.nix

## Success Criteria

### Measurable Outcomes

- **SC-001**: Host "unknown" builds successfully without any user-related errors in under 2 minutes
- **SC-002**: Zero references to "alice" or "bob" remain in active configuration files (excluding historical specs/docs)
- **SC-003**: The "glitch" user is fully functional and can log in after host deployment
- **SC-004**: All user configuration files in users/ directory are consistent with host configurations
