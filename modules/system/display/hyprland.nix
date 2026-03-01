# ============================================================
# PURPOSE:   Hyprland system setup.
# SCOPE:     system
# ============================================================
{ config, lib, ... }:
{
  config = lib.mkIf (config.display.server == "hyprland") {
    programs.hyprland.enable = true;
  };
}
