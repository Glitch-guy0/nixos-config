# ============================================================
# PURPOSE:   Pipewire configuration.
# SCOPE:     system
# ============================================================
{ config, lib, ... }:
{
  config = lib.mkIf (config.audio.backend == "pipewire") {
    # Replace pulseaudio with pipewire
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
