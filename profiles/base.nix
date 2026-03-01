# ============================================================
# PURPOSE:   Everyone gets this: shell, git, ssh.
# SCOPE:     user
# ============================================================
{ pkgs, ... }:
{
  shell.type = "bash";
  home.packages = with pkgs; [ wget curl btop tree git ];
}
