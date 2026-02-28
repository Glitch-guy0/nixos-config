# ============================================================
# PURPOSE:   Creative: Inkscape, Wacom, theming.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./base.nix ];
  home.packages = with pkgs; [ inkscape gimp ];
}
