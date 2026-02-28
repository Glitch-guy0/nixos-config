# ============================================================
# PURPOSE:   Intel GPU configuration.
# SCOPE:     system
# ============================================================
{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.hardware.gpu == "intel") {
    hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel         # LIBVA_DRIVER_NAME=i965
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
}
