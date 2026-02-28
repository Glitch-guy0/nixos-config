# ============================================================
# PURPOSE:   Standard wrapper for declaring a NixOS host.
# SCOPE:     global/system
# USAGE:     lib.mkHost { hostname = "unknown"; system = "x86_64-linux"; }
# EXTENDS:   Add new specialArgs keys for new cross-cutting system concerns.
# ============================================================
{ inputs, nixpkgs, ... }:
{ hostname ? "unknown"
, system      ? "x86_64-linux"
, modules     ? []
, specialArgs ? {}
}:
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs hostname; } // specialArgs;
  modules = [
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    ../modules/system            # All system modules, each off by default
    ../hosts/${hostname}         # config.nix + hardware + host specifics
  ] ++ modules;
}
