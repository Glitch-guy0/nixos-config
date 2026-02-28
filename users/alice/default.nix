# ============================================================
# PURPOSE:   User metadata for Alice.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  home.username = "alice";
  home.homeDirectory = "/home/alice";

  # Note: In a real system you'd also define the NixOS user in a system module
  # users.users.alice = { ... }
}
