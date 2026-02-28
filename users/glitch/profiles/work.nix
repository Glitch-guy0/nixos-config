# users/glitch/profiles/work.nix
# ============================================================
# PURPOSE:   Glitch's work profile — developer tools + work-specific config.
# SCOPE:     user
# DEPENDS:   profiles/developer.nix, modules/home/tools/git.nix
# EXTENDS:   Add work tools to home.packages. Override options sparingly.
# ============================================================
{ lib, pkgs, ... }:
{
  imports = [
    ../../../profiles/developer.nix
    ../secrets.nix
  ];

  # programs.git.userEmail = "glitch@company.com";
  # home.packages = with pkgs; [ slack zoom-us ];

  # sops.secrets."work-vpn-key" = {
  #   sopsFile = ../../../secrets/users/glitch.yaml;
  #   key      = "vpn-key";
  # };

  home.stateVersion = "23.11";
}
