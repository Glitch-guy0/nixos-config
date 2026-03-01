# ============================================================
# PURPOSE:   Exposes all lib functions as an attrset.
# SCOPE:     global
# ============================================================
nixpkgsLib:
let
  lib = nixpkgsLib // {
    mkSecret     = import ./mkSecret.nix;
    importDir    = import ./importDir.nix;
    mkDerivation = import ./mkDerivation.nix;
    types        = import ./types.nix { inherit lib; };
    utils        = import ./utils.nix { inherit lib; };

    forAllSystems = f: nixpkgsLib.genAttrs [ "x86_64-linux" "aarch64-linux" ] f;
  };
in lib
