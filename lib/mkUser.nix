# ============================================================
# PURPOSE:   Standard wrapper for a user+profile Home Manager configuration.
# SCOPE:     user
# USAGE:     lib.mkUser { username = "alice"; profile = "work"; }
# EXTENDS:   Add new extraSpecialArgs for new cross-cutting user concerns.
# ============================================================
{ inputs, nixpkgs, ... }:
{ username
, profile
, system       ? "x86_64-linux"
, extraModules ? []
}:
inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = nixpkgs.legacyPackages.${system};
  extraSpecialArgs = { inherit inputs username profile; };
  modules = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.stylix.homeManagerModules.stylix
    inputs.nix-colors.homeManagerModules.default
    ../modules/home                               # All home modules, opt-in
    ../users/${username}                          # User base config
    ../users/${username}/profiles/${profile}.nix  # Selected profile
  ] ++ extraModules;
}
