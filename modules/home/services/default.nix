# ============================================================
# PURPOSE:   Home services root.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./syncthing.nix ];
}
