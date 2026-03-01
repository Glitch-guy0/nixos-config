# ============================================================
# PURPOSE:   Shell selector.
# SCOPE:     user
# ============================================================
{ lib, ... }:
{
  imports = [ ./zsh.nix ./fish.nix ./bash.nix ./nushell.nix ];
  options.shell.type = lib.mkOption {
    type = lib.types.enum [ "zsh" "fish" "bash" "nushell" ];
    default = "bash";
    description = "Select the primary interactive shell.";
  };
}
