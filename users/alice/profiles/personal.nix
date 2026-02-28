# users/alice/profiles/personal.nix
# ============================================================
# PURPOSE:   Alice's personal profile.
# SCOPE:     user
# ============================================================
{ lib, pkgs, ... }:
{
  imports = [
    ../../../profiles/base.nix
    ../secrets.nix
  ];

  home.stateVersion = "23.11";
}
