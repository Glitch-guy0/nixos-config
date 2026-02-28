# ============================================================
# PURPOSE:   KDE system setup.
# SCOPE:     system
# ============================================================
{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.display.server == "kde") {
    services = {
      xserver.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}
