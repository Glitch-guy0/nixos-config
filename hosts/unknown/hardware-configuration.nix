# ============================================================
# PURPOSE:   Hardware configuration for HP Pavilion 14-dv0054tu.
# SCOPE:     host
# ============================================================
{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Intel 11th Gen specific setup
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableRedistributableFirmware = true;
    firmware = [ pkgs.sof-firmware ];
  };

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" "iwlwifi" ];
    extraModulePackages = [ ];
  };

  # Note: File systems and swap are now managed declaratively via disko.nix

  # Bang & Olufsen Audio requires SOF firmware

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
