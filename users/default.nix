# ============================================================
# PURPOSE:   Builds homeConfigurations map. Key: "user@profile".
# SCOPE:     global
# ============================================================
inputs:
let
  lib = import ../lib inputs.nixpkgs.lib;
in
  lib.buildAllUsers { inherit inputs; usersDir = ./.; }
