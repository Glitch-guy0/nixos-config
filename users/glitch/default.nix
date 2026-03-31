# ============================================================
# PURPOSE:   User metadata for Glitch.
# SCOPE:     user
# ============================================================
{ pkgs, ... }:
{
  defaultProfile = "minimal";

  home = {
    username = "glitch";
    homeDirectory = "/home/glitch";
    initialPassword = "user";
    extraGroups = [ "wheel" "docker" ]
    packages = with pkgs; [
      brave
      zed-editor
    ];
  };

  # Note: In a real system you'd also define the NixOS user in a system module
  # users.users.glitch = { ... }
}
