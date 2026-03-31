# ============================================================
# PURPOSE:   Host-level module for user configuration.
# SCOPE:     host
# ============================================================
{ config, lib, pkgs, inputs, ... }:
let
  inherit (lib) types;
  
  getUserConfig = username: 
    let
      userFile = ./users/${username}/default.nix;
    in
      if builtins.pathExists userFile then 
        import userFile { inherit pkgs; }
      else
        { };
        
  createUsersConfig = lib.foldl' (acc: username: 
    let
      userConfig = getUserConfig username;
      password = if userConfig ? initialPassword then userConfig.initialPassword else "";
    in
      acc // {
        ${username} = {
          isNormalUser = true;
          description = "User account for ${username}";
          password = password;
          extraGroups = if userConfig ? extraGroups then userConfig.extraGroups else [ ];
        };
      }
  ) { };
in
{
  options = {
    defaultUsers = {
      type = types.listOf types.str;
      default = [ ];
      description = "List of usernames to create on this host";
    };
  };

  config = {
    users.users = lib.mkIf (config.defaultUsers != [ ]) (createUsersConfig config.defaultUsers);
  };
}