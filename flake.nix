{
  description = "my nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=release-25.05";
    nixunstable.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  
  let
    system = "x86_64-linux";
    # legacypackages not like it's old or something
    # but similar to searching packages in vast amount of packages
    # you can use `nixpkgs.hello` but it will take a long time to process
    pkgs = nixpkgs.legacyPackages.${system};
    unstablepkgs = import inputs.nixunstable {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations."unknown" = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ 
        ./configuration.nix
      ];
      specialArgs = {inherit unstablepkgs;};
    };

  };
}
