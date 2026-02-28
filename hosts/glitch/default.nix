# ============================================================
# PURPOSE:   Entry point for host "glitch".
# SCOPE:     host
# ============================================================
{ config, lib, pkgs, inputs, hostname, ... }:
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

  # Standard NixOS state version
  system.stateVersion = "23.11"; # Adjust to actual install version
}
