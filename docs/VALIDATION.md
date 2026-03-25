# Command Validation Protocol

**Purpose**: Ensure all documented commands are accurate and tested

**Scope**: All commands in end-user, developer, and contributor documentation

---

## Validation Requirements

Every command in documentation MUST be:

1. **Tested** in a clean environment
2. **Verified** to produce expected output
3. **Documented** with test date and environment
4. **Updated** if discrepancies found

---

## Test Environment Setup

### Prerequisites

- NixOS system (physical or VM)
- Clean repository clone
- Internet connection
- Required tools installed (nix, home-manager, etc.)

### Environment Documentation

For each command test, record:

```markdown
**Test Environment**:
- NixOS Version: [e.g., 24.05]
- Repository Commit: [commit hash]
- Test Date: YYYY-MM-DD
- Tester: [name/initials]
```

---

## Validation Process

### Step 1: Pre-Test Preparation

1. Read the command and understand its purpose
2. Identify prerequisites (directory, permissions, state)
3. Set up clean test environment
4. Document environment details

### Step 2: Execute Command

1. Run the command exactly as documented
2. Capture all output (stdout and stderr)
3. Note any errors or unexpected behavior
4. Record execution time (if relevant)

### Step 3: Verify Output

1. Compare actual output with expected output
2. Verify side effects (files created, state changes)
3. Check system state after command
4. Document any discrepancies

### Step 4: Update Documentation

If discrepancies found:

1. Update command syntax if incorrect
2. Update expected output to match reality
3. Add missing prerequisites
4. Add warnings if destructive behavior not noted
5. Re-test after updates

### Step 5: Mark as Tested

Add test marker to command documentation:

```markdown
> **Tested**: 2026-03-24 on NixOS 24.05 ✅
```

---

## Command Categories

### Installation Commands

**Risk Level**: High (can destroy data)

**Validation**:
- Test on disposable VM first
- Verify disk operations match documentation
- Confirm system boots after installation
- Test rollback procedure

### Configuration Commands

**Risk Level**: Medium (can break system)

**Validation**:
- Test on non-production system
- Verify configuration applies correctly
- Check for error messages
- Test system functionality after changes

### Daily Operation Commands

**Risk Level**: Low (reversible)

**Validation**:
- Test on production-eligible system
- Verify expected behavior
- Check for side effects
- Confirm reversibility

---

## Validation Checklist

For each command, verify:

- [ ] Command syntax is correct
- [ ] Prerequisites are listed
- [ ] Expected output matches actual output
- [ ] Side effects are documented
- [ ] Warnings present for destructive operations
- [ ] Test environment documented
- [ ] Test date recorded
- [ ] Command marked as tested

---

## Revalidation Triggers

Commands MUST be revalidated when:

- NixOS version changes (major version)
- Repository structure changes
- Command syntax changes upstream
- User reports discrepancy
- 6 months since last validation (periodic review)

---

## Discrepancy Resolution

If a command fails validation:

1. **Document the failure**: What went wrong?
2. **Identify the cause**: Syntax? Environment? Upstream change?
3. **Fix the documentation**: Update command or output
4. **Re-test**: Verify fix resolves the issue
5. **Mark for review**: Flag for second pair of eyes if major change

---

## Version Information

**Version**: 1.0.0  
**Created**: 2026-03-24  
**Feature**: 001-update-docs
