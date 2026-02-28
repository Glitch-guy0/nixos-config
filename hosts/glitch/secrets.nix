# ============================================================
# PURPOSE:   Host-specific secrets declaration.
# SCOPE:     host
# ============================================================
{ config, lib, inputs, ... }:
{
  sops.defaultSopsFile = ../../secrets/hosts/glitch.yaml;
  sops.age.keyFile = "/root/.config/sops/age/keys.txt"; # Ensure scripts generate key to this path

  # Example secret declaration
  # sops.secrets."example-secret" = {};
}
