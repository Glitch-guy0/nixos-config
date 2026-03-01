# ============================================================
# PURPOSE:   User-specific secrets declaration.
# SCOPE:     user
# ============================================================
{ config, ... }:
{
  sops.defaultSopsFile = ../../secrets/users/glitch.yaml;
  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
}
