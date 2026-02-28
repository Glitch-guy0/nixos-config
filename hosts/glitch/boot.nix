# ============================================================
# PURPOSE:   Bootloader, initrd, and kernel parameters for glitch.
# SCOPE:     host
# ============================================================
{ config, lib, pkgs, ... }:
{
  # Use systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Enable GuC/HuC firmware loading to reduce CPU overhead for Intel Iris Xe
  boot.kernelParams = [ "i915.enable_guc=3" ];

  # Hibernation requires passing resume partition UUID/device
  boot.resumeDevice = "/dev/disk/by-label/swap";
}
