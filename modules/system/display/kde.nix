# ============================================================
# PURPOSE:   KDE system setup.
# SCOPE:     system
# ============================================================
{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.display.server == "kde") {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
