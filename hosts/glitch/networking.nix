# ============================================================
# PURPOSE:   Networking and firewall configuration for glitch.
# SCOPE:     host
# ============================================================
{ config, lib, pkgs, ... }:
{
  # HP Pavilion network management
  networking.networkmanager.enable = true;

  # Firewall settings
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
