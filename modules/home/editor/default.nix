# ============================================================
# PURPOSE:   Editor selector.
# SCOPE:     user
# ============================================================
{ config, lib, pkgs, ... }:
{
  imports = [ ./neovim.nix ./vscode.nix ./helix.nix ];
  options.editor.type = lib.mkOption {
    type = lib.types.enum [ "neovim" "vscode" "helix" ];
    default = "neovim";
    description = "Select the primary editor.";
  };
}
