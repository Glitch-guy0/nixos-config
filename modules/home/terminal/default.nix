# ============================================================
# PURPOSE:   Terminal selector.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./kitty.nix ./wezterm.nix ./foot.nix ];
}
