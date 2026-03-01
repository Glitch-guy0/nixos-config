# ============================================================
# PURPOSE:   Audio backend selector.
# SCOPE:     system
# ============================================================
{ lib, ... }:
{
  imports = [ ./pipewire.nix ./pulseaudio.nix ];
  options.audio.backend = lib.mkOption {
    type = lib.types.enum [ "pipewire" "pulseaudio" "none" ];
    default = "none";
    description = "Select the audio backend to use.";
  };
}
