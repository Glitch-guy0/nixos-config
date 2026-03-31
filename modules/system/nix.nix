{ ... }:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    gc = { keepDays = 30; };
  };
  nixpkgs.config.allowUnfree = true;
}
