# Adding a Host

1. Create a new directory under `hosts/<hostname>/`.
2. Initialize and configure a `disko.nix` file and a `disko.sh` runner for the host. Use the host's `disko.sh` to partition disks (`destroy,format,mount`).
3. Generate hardware configuration using the mounted disko layout (`nixos-generate-config`). Ensure `disko.nix` is imported in `default.nix`.
4. Set up `config.nix` environment selector.
5. Generate age key (`scripts/hosts/gen-age-key.sh <hostname>`).
6. Add public key and update sops rules in `.sops.yaml`.
7. Rebuild and test.
