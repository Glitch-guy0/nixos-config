# users/glitch/profiles/minimal.nix
# ============================================================
# PURPOSE:   Glitch's minimal profile. Base only.
# SCOPE:     user
# ============================================================
{ lib, pkgs, ... }:
{
  imports = [
    ../../../profiles/minimal.nix
    ../secrets.nix
  ];

  home.stateVersion = "23.11";
}
