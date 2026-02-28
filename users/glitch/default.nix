# ============================================================
# PURPOSE:   User metadata for Glitch.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  home.username = "glitch";
  home.homeDirectory = "/home/glitch";

  home.packages = with pkgs; [
    brave
    zed-editor
  ];

  # Note: In a real system you'd also define the NixOS user in a system module
  # users.users.glitch = { ... }
}
