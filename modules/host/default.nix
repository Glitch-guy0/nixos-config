# ============================================================
# PURPOSE:   Host-level module for user configuration.
# SCOPE:     host
# ============================================================
{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) types;

  getUserConfig = username:
    let
      userFile = ../../users/${username}/default.nix;
    in
      if builtins.pathExists userFile then
        import userFile { inherit pkgs; }
      else
        { };

  createUsersConfig = lib.foldl' (acc: username:
    let
      userConfig = getUserConfig username;
      password = if userConfig.home ? initialPassword then userConfig.home.initialPassword else "";
    in
      acc // {
        ${username} = {
          isNormalUser = true;
          description = "${username}";
          password = password;
          extraGroups = if userConfig.home ? extraGroups then userConfig.home.extraGroups else [ ];
        };
      }
  ) { };
in
{
  options = {
    defaultUsers = lib.mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "List of usernames to create on this host";
    };
  };

  config = {
    users.users = lib.mkIf (config.defaultUsers != [ ]) (createUsersConfig config.defaultUsers);

    home-manager.users = lib.foldl' (acc: username:
      let
        userConfig  = getUserConfig username;
        profileName = userConfig.defaultProfile or "minimal";
        userProfile = ../../users/${username}/profiles/${profileName}.nix;
      in
        acc // {
          ${username} = { pkgs, ... }: {
            imports = [
              inputs.sops-nix.homeManagerModules.sops
              ../../modules/home
              userProfile
            ];
            home.username      = username;
            home.homeDirectory = userConfig.home.homeDirectory;
          };
        }
    ) { } config.defaultUsers;
  };
}
