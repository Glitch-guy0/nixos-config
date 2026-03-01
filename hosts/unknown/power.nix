# ============================================================
# PURPOSE:   Power management configuration.
# SCOPE:     host
# ============================================================
{ lib, ... }:
{
  # TLP or auto-cpufreq is recommended to prevent Intel battery drain
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Limit max performance on battery
      CPU_MAX_PERF_ON_BAT = 60;
    };
  };

  # Optional: Disable GNOME/KDE's native power-profiles-daemon if using TLP
  services.power-profiles-daemon.enable = lib.mkForce false;
}
