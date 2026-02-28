# ============================================================
# PURPOSE:   Exposes all lib functions as an attrset.
# SCOPE:     global
# ============================================================
nixpkgsLib:
let
  lib = nixpkgsLib // {
    mkHost       = import ./mkHost.nix;
    mkUser       = import ./mkUser.nix;
    mkSecret     = import ./mkSecret.nix;
    importDir    = import ./importDir.nix;
    mkDerivation = import ./mkDerivation.nix;
    types        = import ./types.nix { inherit lib; };
    utils        = import ./utils.nix { inherit lib; };

    # Custom helper to auto-detect and generate users and profiles
    buildAllUsers = { inputs, usersDir, system ? "x86_64-linux" }:
      let
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
          value = lib.mkUser {
            inherit inputs nixpkgs;
          } {
            inherit profile system;
            username = user;
          };
        }) userProfiles);

    forAllSystems = f: nixpkgsLib.genAttrs [ "x86_64-linux" "aarch64-linux" ] f;
  };
in lib
