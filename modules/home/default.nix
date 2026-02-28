# ============================================================
# PURPOSE:   Home Manager user-space modules root.
# SCOPE:     user
# ============================================================
{ lib, ... }:
{
  imports = [
    ./shell
    ./editor
    ./terminal
    ./de
    ./theming
    ./tools
    ./services
  ];
}
