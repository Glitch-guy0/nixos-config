# ============================================================
# PURPOSE:   Bare shell — survival/recovery kit.
# SCOPE:     user
# ============================================================
{ pkgs, ... }:
{
  home.packages = with pkgs; [ vim wget ];
}
