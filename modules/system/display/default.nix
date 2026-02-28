# ============================================================
# PURPOSE:   Display server and DE selector.
# SCOPE:     system
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./wayland.nix ./hyprland.nix ./gnome.nix ./kde.nix ];
  options.display.server = lib.mkOption {
    type = lib.types.enum [ "hyprland" "gnome" "kde" "none" ];
    default = "none";
    description = "Select the display server / DE to use.";
  };
}
