# ============================================================
# PURPOSE:   Custom option types.
# SCOPE:     global
# ============================================================
{ lib }:
{
  # Example custom type
  profileType = lib.types.enum [ "laptop" "desktop" "server" ];
}
