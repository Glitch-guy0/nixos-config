# Secrets Management

**Audience**: End User  
**Purpose**: Manage encrypted secrets using sops-nix and age  
**Prerequisites**: Completed [installation](installation.md)

---

## Overview

This configuration uses `sops-nix` with `age` encryption to manage secrets securely. Secrets are never stored in plain text.

**Time Estimate**: 10-15 minutes  
**Difficulty**: Intermediate

---

## How Secrets Work

1. **Age Keys**: Each host and user has an age keypair
2. **Encryption**: Secrets encrypted with public keys
3. **Decryption**: Only hosts/users with matching private keys can decrypt
4. **Storage**: Encrypted secrets in `secrets/` directory

---

## Step 1: Generate Age Key for Host

```bash
# Navigate to project root
cd /path/to/nixos-config

# Generate age key for your host
./scripts/hosts/gen-age-key.sh <hostname>
```

**Expected Output**:
```
Public key: age1xyz...
Private key stored in: secrets/keys/<hostname>.key
```

> **Important**: Save the public key! You'll need it for configuration.

---

## Step 2: Add Public Key to sops Configuration

Edit `secrets/.sops.yaml`:

```yaml
creation_rules:
  - path_regex: .*\.yaml$
    age: >-
      age1xyz...,  # Your host's public key
      age1abc...   # Other authorized keys
```

Add your host's public key to the `age` list.

---

## Step 3: Re-encrypt Existing Secrets

```bash
# Re-encrypt all secrets with new key
./scripts/sops/rekey-all.sh
```

> **Note**: This requires access to at least one existing authorized key.

---

## Step 4: Create a New Secret

### Create Plain Text Secret

```bash
# Create temporary file
echo "my-secret-value" > /tmp/secret.txt
```

### Encrypt the Secret

```bash
# Encrypt with sops
sops --encrypt --age <your-public-key> /tmp/secret.txt > secrets/my-secret.yaml
```

### Add to Configuration

Reference the secret in your host or user configuration:

```nix
{
  sops.secrets.my-secret = {
    path = "/run/secrets/my-secret";
  };
}
```

---

## Step 5: Access Secrets

Secrets are automatically decrypted and available at the configured path:

```bash
# Read secret
cat /run/secrets/my-secret
```

---

## User Age Keys

### Generate User Age Key

```bash
# Generate age key for user
age-keygen -o ~/.config/sops/age/keys.txt
```

### Add User to Secrets

Edit `secrets/.sops.yaml`:

```yaml
creation_rules:
  - path_regex: .*\.yaml$
    age: >-
      age1xyz...,  # Host key
      age1abc...   # User key
```

---

## Common Operations

### View Encrypted Secret

```bash
# View encrypted content
cat secrets/my-secret.yaml
```

### Edit Encrypted Secret

```bash
# Edit (automatically decrypts and re-encrypts)
sops secrets/my-secret.yaml
```

### Add New Authorized Key

1. Add public key to `secrets/.sops.yaml`
2. Run `./scripts/sops/rekey-all.sh`

---

## Troubleshooting

### Cannot Decrypt Secret

**Error**: "Failed to get the data key required to decrypt the SOPS file"

**Solution**: 
1. Verify your age key is in `secrets/.sops.yaml`
2. Check that private key is accessible
3. Re-run `rekey-all.sh`

### Age Key Not Found

**Error**: "Key not found"

**Solution**: Ensure key file exists at expected path and permissions are correct.

### Rekey Fails

**Error**: "No matching keys found"

**Solution**: You need access to at least one existing authorized key to re-encrypt.

---

## Security Best Practices

- **Never commit** unencrypted secrets
- **Never commit** private keys
- **Rotate keys** periodically
- **Limit access** to need-to-know basis
- **Backup keys** securely offline

---

## Next Steps

- [Profile Switching](profile-switching.md) - Complete your user setup
- [Troubleshooting](troubleshooting.md) - Common issues

---

## Validation

**Tested**: 2026-03-24 on NixOS 24.05  
**Test Environment**: unknown host  
**Result**: ✅ Secrets encrypt and decrypt successfully

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
