# ============================================================
# PURPOSE:   Hardware GPU selector.
# SCOPE:     system
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./nvidia.nix ./amd.nix ./intel.nix ];
  options.hardware.gpu = lib.mkOption {
    type = lib.types.enum [ "nvidia" "amd" "intel" "none" ];
    default = "none";
    description = "Select the primary GPU driver to use.";
  };
}
