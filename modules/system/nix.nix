{ ... }:
{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = { 
      automatic = true;
      dates = "weekly"; # or "daily"
      options = "--delete-older-than 30d";
    };
  };
  nixpkgs.config.allowUnfree = true;
}
