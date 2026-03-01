# ============================================================
# PURPOSE:   Builds nixosConfigurations map from subdirectories.
# SCOPE:     global
# AGENT:     You rarely need to touch this. It auto-detects hosts.
# ============================================================
inputs:
let
  lib = import ../lib inputs.nixpkgs.lib;
  hostsDir = ./.;
  hostDirs = builtins.attrNames (lib.filterAttrs ( _: v: v == "directory" ) (builtins.readDir hostsDir));
in
  builtins.listToAttrs (map (hostname: {
    name = hostname;
    value = lib.mkHost {
      inherit inputs;
      inherit (inputs) nixpkgs;
    } {
      inherit hostname;
    };
  }) hostDirs)
