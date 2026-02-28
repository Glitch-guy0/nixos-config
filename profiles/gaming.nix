# ============================================================
# PURPOSE:   Steam, Lutris, MangoHUD, GameMode.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./base.nix ];
  home.packages = with pkgs; [ steam lutris mangohud ];
}
