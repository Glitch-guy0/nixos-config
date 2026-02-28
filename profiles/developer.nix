# ============================================================
# PURPOSE:   Dev tools: editors, direnv, containers.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./base.nix ];
  editor.type = "neovim";
  home.packages = with pkgs; [ gcc gnumake ripgrep jq git ];
}
