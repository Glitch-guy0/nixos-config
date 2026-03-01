# ============================================================
# PURPOSE:   Builds homeConfigurations map. Key: "user@profile".
# SCOPE:     global
# ============================================================
inputs:
let
  lib = import ../lib inputs.nixpkgs.lib;
  usersDir = ./.;
  system = "x86_64-linux";

  # List subdirectories (potential users) in usersDir
  dirs = builtins.attrNames (lib.filterAttrs (n: v: v == "directory" && n != "profiles") (builtins.readDir usersDir));

  # For a user dir, list all .nix files in profiles/
  getUserProfiles = user:
    let
      profileDir = usersDir + "/${user}/profiles";
    in
      if builtins.pathExists profileDir then
        map (f: lib.removeSuffix ".nix" f)
          (builtins.filter (f: lib.hasSuffix ".nix" f && f != "default.nix")
            (builtins.attrNames (builtins.readDir profileDir)))
      else [];

  # Generate user@profile pairs
  userProfiles = lib.flatten (map (user: map (profile: { inherit user profile; }) (getUserProfiles user)) dirs);
in
  builtins.listToAttrs (map ({ user, profile }: {
    name = "${user}@${profile}";
    value = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs profile; username = user; };
      modules = [
        inputs.sops-nix.homeManagerModules.sops
        inputs.stylix.homeManagerModules.stylix
        inputs.nix-colors.homeManagerModules.default
        ../modules/home
        ./${user}
        ./${user}/profiles/${profile}.nix
      ];
    };
  }) userProfiles)
