# ============================================================
# PURPOSE:   Everyone gets this: shell, git, ssh.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  shell.type = "bash";
  home.packages = with pkgs; [ wget curl htop tree ];
}
