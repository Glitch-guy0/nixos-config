# Adding a Host

1. Create a new directory under `hosts/<hostname>/`.
2. Generate hardware configuration (`nixos-generate-config`).
3. Set up `config.nix` environment selector.
4. Generate age key (`scripts/hosts/gen-age-key.sh <hostname>`).
5. Add public key and update sops rules in `.sops.yaml`.
6. Rebuild and test.
