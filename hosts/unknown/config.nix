# ============================================================
# PURPOSE:   High-level environment declaration for this machine.
#            Edit this to change DE, audio, power profile, or GPU driver.
#            Copy this file when replicating the setup on new hardware.
# SCOPE:     host
# DEPENDS:   modules/system/display, modules/system/audio,
#            modules/system/power, modules/system/hardware
# EXTENDS:   Add new option axes as modules/system/ grows.
# AGENT:     First file to read when understanding what a host runs.
#            Do NOT put hardware-specific config here — that belongs in
#            hardware-configuration.nix.
# ============================================================
{ ... }:
{
  # ── Display / Desktop Environment ─────────────────────────
  display.server = "hyprland";    # hyprland | gnome | kde | none

  # ── Audio Backend ─────────────────────────────────────────
  audio.backend  = "pipewire";    # pipewire | pulseaudio | none
  # Requires SOF firmware for HP Bang & Olufsen (configured in modules/system/audio or hardware profile)

  # ── Power Profile ─────────────────────────────────────────
  power.profile  = "laptop";      # laptop | desktop | server

  # ── GPU / Hardware Acceleration ───────────────────────────
  hardware.gpu   = "intel";       # nvidia | amd | intel | none

  # ── Optional Feature Flags ────────────────────────────────
  features.virtualization = true;
  features.bluetooth      = true;
  features.printing       = false;
}
