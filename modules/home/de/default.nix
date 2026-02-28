# ============================================================
# PURPOSE:   DE user-space configuration selector.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./hyprland.nix ./gnome.nix ./kde.nix ];
}
