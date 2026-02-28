# users/alice/profiles/minimal.nix
# ============================================================
# PURPOSE:   Alice's minimal profile. Base only.
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
