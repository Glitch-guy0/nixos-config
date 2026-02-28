# Architecture Document

## Data Flow

```text
flake.nix  (root entry point — no logic, all delegation)
  │
  ├─ inputs: nixpkgs · home-manager · sops-nix · stylix
  │          nixos-hardware · flake-parts · nix-colors
  │          disko · impermanence
  │
  └─ outputs
       │
       ├─ nixosConfigurations  (key: hostname)
       │    └─ lib.mkHost
       │         ├─ hosts/<n>/config.nix          ← DE · audio · power · GPU
       │         ├─ hosts/<n>/hardware-configuration.nix
       │         ├─ modules/system/               ← reusable, all off by default
       │         └─ secrets/hosts/<n>.yaml        ← age-encrypted
       │
       ├─ homeConfigurations  (key: "user@profile")
       │    └─ lib.mkUser
       │         ├─ users/<n>/default.nix         ← user metadata
       │         ├─ users/<n>/profiles/<p>.nix    ← profile composes bundles
       │         ├─ profiles/                     ← capability bundles
       │         ├─ modules/home/                 ← reusable, all opt-in
       │         └─ secrets/users/<n>.yaml        ← age-encrypted
       │
       ├─ packages
       │    └─ pkgs/ + pkgs/derivatives/
       │
       └─ lib  (mkHost · mkUser · mkSecret · mkDerivation · importDir)

users/flake.nix  (intermediate — standalone HM without system)
  └─ home-manager switch --flake users/#alice@work
```
