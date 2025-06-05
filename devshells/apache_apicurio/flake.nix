{
  description = "nix devshell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.apicurio = pkgs.mkShell {
        name = "apache-apicurio";
        buildInputs = with pkgs;[
          docker
          docker-compose
        ];
        shellHook = ''
          echo "running apicurio devshell"
          echo "running docker-compose up"
          docker-compose up -d
          echo "apicurio devshell is ready"
          echo "check http://localhost:8888 for the Apicurio UI"
          echo "rest is working on port 8080"
        '';
      };
    };
}
