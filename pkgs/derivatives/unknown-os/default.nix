# ============================================================
# PURPOSE:   Custom unknown-os derivative.
# SCOPE:     global
# ============================================================
{ inputs, nixpkgs }:
let
  lib = import ../../../lib nixpkgs.lib;
in
lib.mkDerivation {
  inherit inputs;
  nixpkgs = inputs.nixpkgs;
  name = "unknown-os";
  baseHost = "unknown";
}
