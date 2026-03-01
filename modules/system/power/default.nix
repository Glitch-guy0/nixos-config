# ============================================================
# PURPOSE:   Power profile selector.
# SCOPE:     system
# ============================================================
{ lib, ... }:
{
  imports = [ ./laptop.nix ./desktop.nix ];
  options.power.profile = lib.mkOption {
    type = lib.types.enum [ "laptop" "desktop" "server" ];
    default = "server";
    description = "Select the hardware power profile.";
  };
}
