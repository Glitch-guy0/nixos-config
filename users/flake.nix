# users/flake.nix
# ============================================================
# PURPOSE:   Intermediate flake for standalone Home Manager management.
#            Lets you work on user configs without a full system rebuild.
# SCOPE:     user
# AGENT:     When adding a new user, their profiles auto-appear here via
#            lib.buildAllUsers scanning users/<n>/profiles/*.nix
# ============================================================
{
  description = "Standalone Home Manager — all users and profiles";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager     = { url = "github:nix-community/home-manager";
                         inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix         = { url = "github:Mic92/sops-nix";
                         inputs.nixpkgs.follows = "nixpkgs"; };
    stylix           = { url = "github:danth/stylix";
                         inputs.nixpkgs.follows = "nixpkgs"; };
    nix-colors.url   = "github:misterio77/nix-colors";
    root.url         = "path:..";   # Pull lib/ and profiles/ from repo root
  };

  outputs = { nixpkgs, ... } @ inputs:
  let
    lib = import ../lib nixpkgs.lib;
  in {
    # Auto-generates all "user@profile" outputs by scanning users/ subdirs
    homeConfigurations = lib.buildAllUsers {
      inherit inputs;
      usersDir = ./.;
      system   = "x86_64-linux";
    };
  };
}
