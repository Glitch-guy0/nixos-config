# ============================================================
# PURPOSE:   Bootloader, initrd, and kernel parameters for unknown.
# SCOPE:     host
# ============================================================
_:
{
  # Use systemd-boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    # Enable GuC/HuC firmware loading to reduce CPU overhead for Intel Iris Xe
    kernelParams = [ "i915.enable_guc=3" ];

    # Hibernation requires passing resume partition UUID/device
    resumeDevice = "/dev/disk/by-partlabel/swap";
  };
}
