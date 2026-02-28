# ============================================================
# PURPOSE:   Build a distributable NixOS derivative/ISO from this config.
# SCOPE:     global
# USAGE:     lib.mkDerivation { name = "unknown-os"; baseHost = "unknown"; }
# EXTENDS:   Pass extraModules for branding/package overrides.
# AGENT:     Derivatives MUST NOT modify hosts/, modules/, or lib/.
#            All derivative logic lives in pkgs/derivatives/<n>/.
# ============================================================
{ inputs, nixpkgs }:
{ name
, baseHost
, extraModules ? []
, isoName      ? name
, system       ? "x86_64-linux"
}:
nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    ../hosts/${baseHost}
    ../modules/system
    { isoImage.isoName = isoName;
      isoImage.squashfsCompression = "zstd -Xcompression-level 6"; }
  ] ++ extraModules;
}
