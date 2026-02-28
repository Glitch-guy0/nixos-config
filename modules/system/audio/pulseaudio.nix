# ============================================================
# PURPOSE:   Pulseaudio configuration.
# SCOPE:     system
# ============================================================
{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (config.audio.backend == "pulseaudio") {
    hardware.pulseaudio.enable = true;
  };
}
