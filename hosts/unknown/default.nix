# ============================================================
# PURPOSE:   Entry point for host "unknown".
# SCOPE:     host
# ============================================================
{ pkgs, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ./power.nix
    ./config.nix
    ./secrets.nix
  ];

  networking.hostName = hostname;

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  # Standard NixOS state version
  system.stateVersion = "23.11"; # Adjust to actual install version
}
