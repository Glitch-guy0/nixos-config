# ============================================================
# PURPOSE:   Dev tools: editors, direnv, containers.
# SCOPE:     user
# ============================================================
{ pkgs, ... }:
{
  imports = [ ./base.nix ];
  editor.type = "neovim";
  home.packages = with pkgs; [ ripgrep jq ];
}
