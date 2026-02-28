# Scripts Reference

All scripts required to maintain the constitution constraints live here.

## Secrets
- `sops/add-key.sh`: Add age key and re-encrypt files.
- `sops/rotate-key.sh`: Replace a key and update keys.
- `sops/new-secret.sh`: Create new secret file with proper rules.
- `sops/rekey-all.sh`: Update all secrets.

## Hosts
- `hosts/new-host.sh`: Scaffolds a host directory.
- `hosts/gen-age-key.sh`: Generates age keypair for a host.

## Users
- `users/new-user.sh`: Scaffolds a user and profiles.
