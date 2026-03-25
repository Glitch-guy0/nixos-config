# Documentation Cross-Reference Conventions

**Purpose**: Standardize linking between documentation sections

**Scope**: All internal documentation links

---

## Link Format

### Relative Paths

All internal links use relative paths from the current file's location:

```markdown
# From docs/README.md
[Installation Guide](end-user/installation.md)

# From docs/end-user/profile-switching.md
[Secrets Management](secrets-management.md)

# From docs/developer/adding-host.md
[Style Guide](../STYLE.md)
```

### Anchor Links

Link to specific sections within a document:

```markdown
[Installation Steps](end-user/installation.md#installation-steps)

[Profile Types](end-user/profiles-overview.md#profile-types)
```

---

## Link Categories

### Navigation Links

Used in README.md and summary pages:

```markdown
**Key Documents**:
- [Installation Guide](end-user/installation.md)
- [Profile Switching](end-user/profile-switching.md)
```

### Inline References

Used within documentation text:

```markdown
For more information, see the [Style Guide](../STYLE.md).

After completing installation, proceed to [profile switching](end-user/profile-switching.md).
```

### Prerequisites Links

Used to link to required knowledge:

```markdown
**Prerequisites**:
- Basic Linux knowledge ([Installation Guide](end-user/installation.md#prerequisites))
- Git installed ([Developer Workflows](contributor/workflows.md#git-setup))
```

---

## Cross-Reference Patterns

### Forward References

Link to documentation that builds on current topic:

```markdown
**Next Steps**:
- [Profile Switching](end-user/profile-switching.md) - Learn to change your environment
- [Secrets Management](end-user/secrets-management.md) - Secure your sensitive data
```

### Backward References

Link to prerequisite documentation:

```markdown
> **Note**: Complete [installation](installation.md) before proceeding.

This guide assumes you have read [Profile Overview](profiles-overview.md).
```

### Related Content

Link to complementary topics:

```markdown
**Related**:
- [Adding a Host](developer/adding-host.md) - For setting up new machines
- [Troubleshooting](end-user/troubleshooting.md) - If you encounter issues
```

---

## Link Validation

### Checklist

Before publishing, verify:

- [ ] All links use correct relative paths
- [ ] All linked documents exist
- [ ] Anchor links point to valid sections
- [ ] Link text describes destination
- [ ] No broken links

### Validation Command

```bash
# Check for broken links (manual verification)
find docs -name "*.md" -exec grep -l "\](.*\.md)" {} \;
```

---

## External Link Guidelines

### When to Link Externally

- Official NixOS documentation
- Nixpkgs manual
- Home Manager documentation
- Tool documentation (sops, age, disko)

### External Link Format

```markdown
[NixOS Manual](https://nixos.org/manual/nixos/stable/)

[Home Manager](https://github.com/nix-community/home-manager)
```

### External Link Policy

- Link to stable URLs (avoid version-specific when possible)
- Prefer official documentation over blog posts
- Include link context (why this link?)

---

## Version Information

**Version**: 1.0.0  
**Created**: 2026-03-24  
**Feature**: 001-update-docs
