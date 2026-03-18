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
    value = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs hostname; };
      modules = [
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.home-manager
        ../modules/system
        ./${hostname}
      ];
    };
  }) hostDirs)
