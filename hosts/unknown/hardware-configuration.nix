# ============================================================
# PURPOSE:   Hardware configuration for HP Pavilion 14-dv0054tu.
# SCOPE:     host
# ============================================================
{ config, lib, pkgs, inputs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Intel 11th Gen specific setup
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault true;
    enableRedistributableFirmware = true;
    firmware = [ pkgs.sof-firmware ];
  };

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "usb_storage"
      "sd_mod"
      "part_gpt"
      "vfat"
      "ext4"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" "iwlwifi" ];
    extraModulePackages = [ ];
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  fileSystems = lib.mkForce {};

  # Bang & Olufsen Audio requires SOF firmware

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
