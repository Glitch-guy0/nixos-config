# ============================================================
# PURPOSE:   Networking and firewall configuration for unknown.
# SCOPE:     host
# ============================================================
{ ... }:
{
  # HP Pavilion network management
  networking = {
    networkmanager.enable = true;

    # Firewall settings
    firewall.enable = true;
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
  };
}
