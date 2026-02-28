# ============================================================
# PURPOSE:   Host-specific secrets declaration.
# SCOPE:     host
# ============================================================
_: {
  sops.defaultSopsFile = ../../secrets/hosts/unknown.yaml;
  sops.age.keyFile = "/root/.config/sops/age/keys.txt"; # Ensure scripts generate key to this path

  # Example secret declaration
  # sops.secrets."example-secret" = {};
}
