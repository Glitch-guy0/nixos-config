# users/alice/profiles/dev.nix
# ============================================================
# PURPOSE:   Alice's full development environment.
# SCOPE:     user
# ============================================================
{ lib, pkgs, ... }:
{
  imports = [
    ../../../profiles/developer.nix
    ../secrets.nix
  ];

  home.stateVersion = "23.11";
}
