# NixOS Configuration: Agent Planning & Constitution Canvas

> **Purpose:** Single source of truth for planning, scaffolding, and extending this NixOS flake config.
> Any agent, contributor, or tool must read this before touching anything, and update it when structure changes.

---

## 0. Decisions Log

| Decision | Value | Rationale |
|---|---|---|
| First hostname | `glitch` | User-defined |
| Multi-machine | Yes (different hardware) | Per-host hardware abstraction needed |
| Secret strategy | **Age only** | Simple, portable, no keyring daemon |
| Home Manager | Non-root, standalone flake input | No privilege escalation for user config |
| Profile switching | All scenarios | Work/personal/dev/minimal per user |
| Non-root packages | Preferred | System packages only if truly global |
| nixpkgs track | `nixos-unstable` | Disco — latest |
| Custom derivatives | Yes — first-class | See Section 9 |
| Flake access | `user@profile` / hostname convention | Clean CLI ergonomics |

---

## 1. Repository Philosophy

**SOLID applied to Nix:**

- **S — Single Responsibility:** Every module does one thing. `audio.nix` handles audio only.
- **O — Open/Closed:** Extend via `lib.mkOption`. Don't edit existing option logic — add new options.
- **L — Liskov:** Any profile can substitute another. `minimal` is a valid `dev` — just fewer packages.
- **I — Interface Segregation:** Users import only what they need. No monolithic `home.nix`.
- **D — Dependency Inversion:** Hosts depend on `modules/system/` abstractions, not concrete implementations.

**Core rules:**
1. Written twice → goes in `lib/` or `modules/`.
2. User config never touches system config, and vice versa.
3. Secrets scoped minimally — host secrets stay host-side, user secrets stay user-side.
4. Every file has the standard header (Section 11).
5. Adding a new machine requires **zero changes** to existing hosts.
6. Adding a new user requires **zero changes** to existing users.

---

## 2. Full File & Directory Structure
*(See source for full structure tree)*

---

## 3. Flake Access Patterns
*(See source)*

---

## 4. Host config.nix — Environment Selector
*(See source)*

---

## 5. flake.nix Blueprint
*(See source)*

---

## 6. lib/ — Helper Functions
*(See source)*

---

## 7. Secrets Architecture (Age Only)
*(See source)*

---

## 8. Profile Switching — Mechanism
*(See source)*

---

## 9. Scripts Reference
*(See source)*

---

## 10. Custom Derivatives
*(See source)*

---

## 11. Inline Documentation Standard

**Every `.nix` file** opens with:
```nix
# ============================================================
# PURPOSE:   One-line description of what this module does.
# SCOPE:     host | user | shared | global
# DEPENDS:   Modules/options this file imports or requires.
# EXTENDS:   How to add new options or behaviors here.
# AGENT:     What to know before editing. What to update after.
# ============================================================
```

**Every `mkOption`** includes:
```nix
options.module.enable = lib.mkOption {
  type        = lib.types.bool;
  default     = false;
  description = "Enable module. When true, installs X and configures Y.";
  example     = true;
};
```

---

## 12. ARCHITECTURE Data Flow
*(See source)*

---

## 13. Naming Conventions
*(See source)*

---

## 14. Agent Quick Reference
*(See source)*

---

## 15. docs/ Reference Guide
*(See source)*

---

*Canvas v1.1.0 — hostname: glitch — age-only secrets — user@profile flake keys — intermediate users/flake.nix — scripts section — host config.nix environment selector*
