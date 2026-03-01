# ============================================================
# PURPOSE:   Root flake. Declares all inputs. Delegates all output logic to lib/.
#            It is intentionally bloated with inputs as a centralized dependency manager.
# SCOPE:     global
# AGENT:     Add new flake inputs here.
#            New hosts are auto-detected via hosts/default.nix (no manual wiring).
#            New user@profile combos auto-detected via users/default.nix.
#            Never put business logic in this file — delegate to lib/.
# ============================================================
{
  description = "unknown — composable multi-machine NixOS configuration";

  inputs = {
    # ── Core ──────────────────────────────────────────────────────
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # ── Home Manager ──────────────────────────────────────────────
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── Secrets: Age only ─────────────────────────────────────────
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── Hardware quirks database ───────────────────────────────────
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # ── Flake structure utilities ──────────────────────────────────
    flake-parts.url = "github:hercules-ci/flake-parts";

    # ── Theming ────────────────────────────────────────────────────
    nix-colors.url = "github:misterio77/nix-colors";   # base16 color schemes
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── Declarative disk partitioning (optional, enable per host) ──
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ── Ephemeral root support (optional) ─────────────────────────
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs @ { flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      flake = let
        lib = import ./lib nixpkgs.lib;
      in {
        # key: hostname — nixos-rebuild switch --flake .#unknown
        nixosConfigurations = import ./hosts inputs;

        # key: "user@profile" — home-manager switch --flake .#glitch@work
        homeConfigurations  = import ./users inputs;

        # Custom packages + derivative ISOs
        packages = lib.forAllSystems (system:
          import ./pkgs { pkgs = nixpkgs.legacyPackages.${system}; inherit inputs; }
        );

        # Exported lib for external use / testing
        inherit lib;

        overlays.default = import ./overlays;
      };

      # Dev shell for working on this config itself
      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            age sops
            nixfmt-rfc-style statix deadnix
            home-manager nil   # Nix LSP
          ];
        };
      };
    };
}
