# Documentation Style Guide

**Purpose**: Ensure consistency across all documentation in this repository

**Audience**: All documentation writers (end-user, developer, contributor docs)

---

## Visual Style

**Tone**: Clean technical with friendly but professional tone

### Formatting Standards

#### Headers

```markdown
# H1 - Document title (one per document)

## H2 - Major sections

### H3 - Subsections

#### H4 - Minor subsections (use sparingly)
```

#### Code Blocks

Always use triple backticks with language identifier:

````markdown
```bash
# Shell commands
nixos-rebuild switch --flake .#hostname
```

```nix
# Nix code
{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.git ];
}
```
````

#### Callouts

Use blockquotes with bold labels for notes and warnings:

```markdown
> **Note**: Brief explanatory note

> **Important**: Critical information users need to know

> **Warning**: Potential risks or destructive operations

> **Tip**: Helpful shortcuts or best practices
```

#### Lists

Use hyphen-based unordered lists:

```markdown
- First item
- Second item
- Third item
```

Use numbered lists for sequential steps:

```markdown
1. First step
2. Second step
3. Third step
```

#### Tables

Use standard Markdown tables with alignment:

```markdown
| Column A | Column B | Column C |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
```

---

## Writing Standards

### Voice and Tone

- **Active voice**: "Run this command" not "This command should be run"
- **Imperative mood**: Use commands for instructions
- **Professional but friendly**: Technical accuracy with approachable language
- **Concise**: Avoid unnecessary words, but don't sacrifice clarity

### Terminology

Use consistent terms throughout all documentation:

| Term | Usage |
|------|-------|
| `flake.nix` | Always lowercase with `.nix` extension |
| `Home Manager` | Capitalized as proper noun |
| `nixos-rebuild` | Full command name, lowercase |
| `host` | Machine configuration |
| `profile` | User environment bundle |
| `NixOS` | Capitalized |
| `Nix` | Capitalized |

### Command Documentation

Every command must include:

1. **The command itself** in a code block
2. **Expected output** (if applicable)
3. **Prerequisites** (e.g., "must be in project root")
4. **Warnings** for destructive operations

Example:

```markdown
### Switch to a Profile

**Prerequisites**: Must be in the project root directory

```bash
home-manager switch --flake .#username@profile
```

**Expected Output**:
```
Starting Home Manager activation
Activating the configuration
...
```
```

---

## Documentation Structure

### Audience Sections

This documentation is organized by audience:

1. **End User** (`docs/end-user/`): Users who operate the system
2. **Developer** (`docs/developer/`): Contributors adding hosts/modules/profiles
3. **Contributor** (`docs/contributor/`): Deep contributors extending the codebase

### Cross-References

Link between related sections using relative paths:

```markdown
For more information, see [Profile Switching](end-user/profile-switching.md).
```

---

## Quality Standards

### Before Publishing

- [ ] All commands tested and verified
- [ ] Expected output matches actual output
- [ ] Links resolve correctly
- [ ] Terminology consistent with style guide
- [ ] Tone is professional but approachable
- [ ] No typos or grammatical errors

### Command Validation

Every command must be:

1. Executed in a clean test environment
2. Verified to produce expected output
3. Marked as "tested" with date
4. Updated if discrepancies found

---

## Version Information

**Version**: 1.0.0  
**Created**: 2026-03-24  
**Feature**: 001-update-docs
