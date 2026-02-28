# ============================================================
# PURPOSE:   GNOME system setup.
# SCOPE:     system
# ============================================================
{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.display.server == "gnome") {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
