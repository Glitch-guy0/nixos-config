# ============================================================
# PURPOSE:   Creative: Inkscape, Wacom, theming.
# SCOPE:     user
# ============================================================
{ pkgs, ... }:
{
  imports = [ ./base.nix ];
  home.packages = with pkgs; [ inkscape gimp ];
}
