# ============================================================
# PURPOSE:   Theming configuration selector.
# SCOPE:     user
# ============================================================
_:
{
  imports = [ ./stylix.nix ];
  options.theme.scheme = lib.mkOption { type = lib.types.str; default = "dracula"; };
  options.theme.variant = lib.mkOption { type = lib.types.enum [ "dark" "light" ]; default = "dark"; };
}
