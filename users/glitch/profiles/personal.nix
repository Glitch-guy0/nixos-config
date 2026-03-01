# users/glitch/profiles/personal.nix
# ============================================================
# PURPOSE:   Glitch's personal profile.
# SCOPE:     user
# ============================================================
_:
{
  imports = [
    ../../../profiles/base.nix
    ../secrets.nix
  ];

  home.stateVersion = "23.11";
}
