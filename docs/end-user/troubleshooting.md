# Troubleshooting

**Audience**: End User  
**Purpose**: Resolve common issues  
**Prerequisites**: Completed [installation](installation.md)

---

## Installation Issues

### Disko Fails to Mount

**Error**: "Device not found" or "Failed to mount"

**Causes**:
- Wrong disk device name
- Disk already mounted
- Hardware not detected

**Solutions**:

1. **Verify disk name**:
   ```bash
   lsblk
   ```

2. **Unmount if mounted**:
   ```bash
   sudo umount /dev/nvme0n1*
   ```

3. **Check hardware detection**:
   ```bash
   lspci
   lsusb
   ```

---

### Installation Build Fails

**Error**: "Flake attribute 'hostname' not found"

**Causes**:
- Hostname doesn't match `hosts/` directory
- Typo in hostname

**Solution**:
```bash
# List available hosts
ls hosts/

# Use exact hostname
sudo nixos-install --flake .#<hostname>
```

---

### System Doesn't Boot

**Symptoms**: Black screen, boot loop, or drops to initramfs

**Causes**:
- Incorrect boot loader configuration
- Wrong disk partitioning
- Hardware configuration mismatch

**Solutions**:

1. **Boot from Live USB**
2. **Check hardware-configuration.nix**
3. **Verify boot loader settings**
4. **Re-run installation**

---

## Profile Switching Issues

### Profile Switch Fails

**Error**: "attribute 'xyz' missing"

**Causes**:
- Profile doesn't exist
- Import path incorrect
- Syntax error in profile

**Solutions**:

1. **Verify profile exists**:
   ```bash
   ls profiles/
   ```

2. **Check syntax**:
   ```bash
   nix flake check
   ```

3. **Test build**:
   ```bash
   home-manager build --flake .#username@profile
   ```

---

### Packages Not Available After Switch

**Symptoms**: Command not found

**Causes**:
- Activation didn't complete
- Wrong profile selected
- Package not in profile

**Solutions**:

1. **Wait for completion**
2. **Open new terminal**
3. **Verify profile**:
   ```bash
   home-manager generations
   ```

---

## Secrets Management Issues

### Cannot Decrypt Secret

**Error**: "Failed to get the data key"

**Causes**:
- Age key not configured
- Key mismatch
- Permissions issue

**Solutions**:

1. **Check key exists**:
   ```bash
   ls -la secrets/keys/
   ```

2. **Verify .sops.yaml**:
   ```bash
   cat secrets/.sops.yaml
   ```

3. **Re-key secrets**:
   ```bash
   ./scripts/sops/rekey-all.sh
   ```

---

### Age Key Generation Fails

**Error**: "Command not found"

**Cause**: `age` not installed

**Solution**:
```bash
nix-env -iA nixos.age
```

---

## Build Issues

### Nix Build Fails

**Error**: Various build errors

**Causes**:
- Syntax error in Nix files
- Missing imports
- Dependency issues

**Solutions**:

1. **Check syntax**:
   ```bash
   nix flake check
   ```

2. **Show detailed error**:
   ```bash
   nixos-rebuild build --flake .#hostname --show-trace
   ```

3. **Validate with check script**:
   ```bash
   ./scripts/check.sh
   ```

---

### Cache Misses (Slow Builds)

**Symptoms**: Building from source, very slow

**Causes**:
- Binary cache unavailable
- Package not in cache

**Solutions**:

1. **Check internet connection**
2. **Use alternative caches**:
   ```nix
   nix.settings.substituters = [
     "https://cache.nixos.org"
     "https://cache.garnix.io"
   ];
   ```

---

## Performance Issues

### Slow System

**Symptoms**: Sluggish performance

**Causes**:
- Too many packages
- Resource-intensive services
- Hardware limitations

**Solutions**:

1. **Check resource usage**:
   ```bash
   htop
   ```

2. **Disable unnecessary services**
3. **Switch to minimal profile**

---

### Disk Space Low

**Symptoms**: "No space left on device"

**Causes**:
- Old generations
- Build artifacts

**Solutions**:

1. **Delete old generations**:
   ```bash
   # System
   sudo nix-collect-garbage -d
   
   # User
   nix-collect-garbage -d
   ```

2. **Vacuum store**:
   ```bash
   nix-store --optimize
   ```

---

## Getting Help

### Check Logs

```bash
# System logs
journalctl -xe

# Home Manager logs
~/.local/state/home-manager/log/
```

### Validate Configuration

```bash
# Run validation script
./scripts/check.sh
```

### Community Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Wiki](https://wiki.nixos.org/)
- [Discourse](https://discourse.nixos.org/)

---

## When to Seek Help

Contact maintainers or community when:

- Issue persists after trying all solutions
- Hardware not detected
- Data loss risk
- Security concerns

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
