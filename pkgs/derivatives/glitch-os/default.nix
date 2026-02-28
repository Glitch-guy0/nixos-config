# ============================================================
# PURPOSE:   Custom glitch-os derivative.
# SCOPE:     global
# ============================================================
{ inputs, nixpkgs }:
let
  lib = import ../../../lib nixpkgs.lib;
in
lib.mkDerivation {
  inherit inputs nixpkgs;
  name = "glitch-os";
  baseHost = "glitch";
}
