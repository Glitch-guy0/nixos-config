# ============================================================
# PURPOSE:   Bare shell — survival/recovery kit.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [ vim wget ];
}
