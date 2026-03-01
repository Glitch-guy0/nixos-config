# ============================================================
# PURPOSE:   Steam, Lutris, MangoHUD, GameMode.
# SCOPE:     user
# ============================================================
{ pkgs, ... }:
{
  imports = [ ./base.nix ];
  home.packages = with pkgs; [ steam lutris mangohud ];
}
