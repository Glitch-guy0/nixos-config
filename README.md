# Glitch NixOS Configuration

Welcome to the **Glitch OS** configuration repository! This is a heavily modularized, purely declarative, multi-machine [NixOS](https://nixos.org/) configuration leveraging [Flakes](https://nixos.wiki/wiki/Flakes), [Home Manager](https://nix-community.github.io/home-manager/), and [sops-nix](https://github.com/Mic92/sops-nix) for secure, age-based secret management.

This repository strictly adheres to the architecture and rules defined in the [CONSTITUTION.md](./CONSTITUTION.md). **If you plan on extending this configuration, read the Constitution first.**

---

## 🧭 Repository Overview

The configuration is divided logically into system-wide configurations (`hosts/`) and user-space configurations (`users/`), glued together by reusable modules.

- `hosts/`: Machine-specific hardware configurations, bootloader logic, and high-level environment selectors (`config.nix`).
- `users/`: User declarations, identity metadata, and specific profile bindings.
- `modules/`: The core building blocks. `modules/system/` requires root access, while `modules/home/` configure user tools via Home Manager.
- `profiles/`: Reusable capability bundles (e.g., `developer.nix`, `gaming.nix`). Profiles are assembled by importing `modules/home/` components.
- `secrets/`: Encrypted configuration files using `sops`.
- `lib/`: Pure utility functions and wrappers (e.g., `lib.mkHost`, `lib.mkUser`).

---

## 🚀 Getting Started

### 1. Prerequisites

You must be booted into a NixOS live USB or have an existing NixOS installation. Ensure you have internet access and that [Flakes](https://nixos.wiki/wiki/Flakes#Enable_flakes) are enabled on your current system if you are testing this out.

### 2. Initial Setup (New Installation)

If you are installing this onto a fresh machine (like the provided `glitch` host):

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/nixos-config.git
   cd nixos-config
   ```

2. **Generate Hardware Config:**
   If you are installing this on a machine *other* than the predefined `glitch` host, you should generate a new host profile (see [Adding a Host](./docs/adding-a-host.md)):
   ```bash
   nixos-generate-config --show-hardware-config > hosts/your-hostname/hardware-configuration.nix
   ```

3. **Generate Age Keys:**
   This configuration relies entirely on `age` for secrets. You must generate an age key for your host:
   ```bash
   ./scripts/hosts/gen-age-key.sh glitch
   ```
   *Take note of the public key output and add it to `secrets/.sops.yaml`.*

4. **Install the System:**
   Assuming your disks are mounted correctly (usually at `/mnt`), you can install the flake:
   ```bash
   sudo nixos-install --flake .#glitch
   ```

### 3. Applying Changes (Existing System)

Once you have booted into your NixOS system, you manage updates using either `nixos-rebuild` (for system changes) or `home-manager` (for user profile changes).

**System Rebuild (requires root):**
```bash
# Rebuild the system and switch to the new generation immediately
sudo nixos-rebuild switch --flake .#glitch

# Build the system without switching (useful for testing if it compiles)
sudo nixos-rebuild build --flake .#glitch
```

**User Profile Switch (non-root):**
Users are configured via `user@profile` strings. For example, to switch user `alice` to the `work` profile:
```bash
home-manager switch --flake .#alice@work
```

*(Note: You can also use the intermediate flake for standalone home-manager testing: `home-manager switch --flake ./users#alice@work`)*

---

## 🔑 Secrets Management

Secrets are never stored in plain text. They are encrypted using `sops` and `age`.

1. **Add a key:** If you add a new machine or user, generate their age key, place the public key in `secrets/.sops.yaml`, and run:
   ```bash
   ./scripts/sops/add-key.sh <scope> <name> <pubkey>
   ```
2. **Rekeying:** If you change access rules in `.sops.yaml` (e.g., adding an admin), you must re-encrypt the secrets:
   ```bash
   ./scripts/sops/rekey-all.sh
   ```

For a deeper dive into secrets, see [docs/secrets-management.md](./docs/secrets-management.md).

---

## 📚 Documentation & Guides

For step-by-step guides on extending this repository, refer to the `docs/` folder:

- [Adding a New Host](./docs/adding-a-host.md)
- [Adding a New User](./docs/adding-a-user.md)
- [Adding a Reusable Module](./docs/adding-a-module.md)
- [Creating a Capability Profile](./docs/adding-a-profile.md)
- [Building Custom Derivatives (ISOs)](./docs/derivatives.md)

---

## 🛠 Contributing

Before committing changes, please run the checking script to ensure formatting and anti-patterns are resolved:
```bash
./scripts/check.sh
```

Please review the [CONTRIBUTING.md](./CONTRIBUTING.md) and [ARCHITECTURE.md](./ARCHITECTURE.md) for more context on the SOLID design principles used here.
