# NixOS Configuration: Agent Planning & Constitution Canvas

> **Purpose:** Single source of truth for planning, scaffolding, and extending this NixOS flake config.
> Any agent, contributor, or tool must read this before touching anything, and update it when structure changes.

---

## 0. Decisions Log

| Decision | Value | Rationale |
|---|---|---|
| First hostname | `unknown` | User-defined |
| Multi-machine | Yes (different hardware) | Per-host hardware abstraction needed |
| Secret strategy | **Age only** | Simple, portable, no keyring daemon |
| Home Manager | Non-root, standalone flake input | No privilege escalation for user config |
| Profile switching | All scenarios | Work/personal/dev/minimal per user |
| Non-root packages | Preferred | System packages only if truly global |
| nixpkgs track | `nixos-unstable` | Disco — latest |
| Custom derivatives | Yes — first-class | See Section 9 |
| Flake access | `user@profile` / hostname convention | Clean CLI ergonomics |
| **Documentation** | Split | `USER_GUIDE.md` for end-users. `docs/` for coding agents/maintainers. |

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

```
nixos-config/
│
├── flake.nix                        # Root flake. All inputs. Delegates outputs to lib/.
├── flake.lock                       # Locked inputs. Always commit this.
│
├── CONSTITUTION.md                  # This file. Read before touching anything.
├── USER_GUIDE.md                    # End-user setup, installation, and day-to-day usage guide.
├── ARCHITECTURE.md                  # Data flow, module graph, secrets topology.
├── CONTRIBUTING.md                  # Pre/post change checklists, style guide.
├── CHANGELOG.md                     # Human-readable change log, semver tagged.
│
├── docs/                            # EXCLUSIVELY FOR AGENTS & MAINTAINERS modifying the project folder structure.
│   ├── adding-a-host.md             # Step-by-step: new machine setup
│   ├── adding-a-user.md             # Step-by-step: new user + profiles
│   ├── adding-a-module.md           # Step-by-step: new system or home module
│   ├── adding-a-profile.md          # Step-by-step: new capability bundle
│   ├── secrets-management.md        # Age keys, sops workflow, rotation
│   ├── profile-switching.md         # How to build/switch profiles via CLI
│   └── derivatives.md               # Building and distributing custom derivatives
│
```
*(The rest of the structure remains as standard: `lib/`, `hosts/`, `modules/`, `profiles/`, `users/`, `secrets/`, `scripts/`, `overlays/`, `pkgs/`, `.github/`)*

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

**Before any edit:**
1. Read `PURPOSE` + `AGENT` header of every file you're touching.
2. Check `DEPENDS` — understand the chain before pulling threads.
3. Check `docs/` for specific workflow rules.
4. Run `scripts/check.sh` — know the baseline state.

**Where does new code go?**
```
System-wide service/driver?   ──► modules/system/    or  hosts/<n>/
User-facing tool/config?      ──► modules/home/       or  users/<n>/profiles/
Capability bundle?            ──► profiles/
Helper / utility function?    ──► lib/
Custom package?               ──► pkgs/
Distributable ISO/config?     ──► pkgs/derivatives/
Secret value?                 ──► secrets/<scope>/  + update .sops.yaml
Maintenance script?           ──► scripts/<category>/ + document in scripts/README.md
```

**After any edit:**
1. Update the file's `AGENT` comment if editing context changed.
2. Run `scripts/check.sh`.
3. Add `CHANGELOG.md` entry: `[date] <scope>: what changed and why`.
4. New file added → register in nearest `default.nix` or use `importDir`.
5. `.sops.yaml` changed → run `scripts/sops/rekey-all.sh`.

---

## 15. docs/ Reference Guide

*NOTE: This folder is exclusively for agents, maintainers, and contributors modifying the underlying code structure, NOT for end-users. End-users should refer to `USER_GUIDE.md`.*

| File | Covers |
|---|---|
| `docs/adding-a-host.md` | Dir scaffold → hardware-config → gen-age-key → sops rule → rebuild test |
| `docs/adding-a-user.md` | Dir scaffold → profiles → age key → secrets file → flake output |
| `docs/adding-a-module.md` | system vs home decision → mkOption pattern → default.nix registration |
| `docs/adding-a-profile.md` | Capability bundle pattern → composition → user profile import |
| `docs/secrets-management.md` | Age key gen → .sops.yaml rules → create/edit/rotate → scripts guide |
| `docs/profile-switching.md` | CLI commands → build vs switch → test without activating |
| `docs/derivatives.md` | mkDerivation → ISO build → derivative rules → distribution |

---

*Canvas v1.1.0 — hostname: unknown — age-only secrets — user@profile flake keys — intermediate users/flake.nix — scripts section — host config.nix environment selector — split documentation model*
