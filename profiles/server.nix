# ============================================================
# PURPOSE:   Headless, hardened, minimal.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./base.nix ];
}
