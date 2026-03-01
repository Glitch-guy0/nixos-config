# users/glitch/profiles/dev.nix
# ============================================================
# PURPOSE:   Glitch's full development environment.
# SCOPE:     user
# ============================================================
_:
{
  imports = [
    ../../../profiles/developer.nix
    ../secrets.nix
  ];

  home.stateVersion = "23.11";
}
