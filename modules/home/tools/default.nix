# ============================================================
# PURPOSE:   Home tools root.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./git.nix ./ssh.nix ./gpg.nix ./direnv.nix ];
}
