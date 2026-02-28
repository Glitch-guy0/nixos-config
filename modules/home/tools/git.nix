# ============================================================
# PURPOSE:   Git user configuration.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
    # userEmail = "..."; # Set in profiles
    # userName  = "...";
  };
}
