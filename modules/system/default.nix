# ============================================================
# PURPOSE:   System-level NixOS modules root.
# SCOPE:     system
# ============================================================
_:
{
  imports = [
    ./audio
    ./display
    ./power
    ./hardware
    ./networking.nix
    ./locale.nix
    ./security.nix
    ./virtualization.nix
    ./fonts.nix
    ./printing.nix
    ./bluetooth.nix
  ];
}
