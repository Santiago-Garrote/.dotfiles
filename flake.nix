{
  description = "Santiago's NixOS laptop configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umu = {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher.git?dir=packaging/nix&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      umu,
      ...
    }:
    let
      system = "x86_64-linux";
      overlays = [
        (final: _prev: {
          dseg = final.callPackage ./packages/dseg.nix { };
        })
      ];
      pkgs = import nixpkgs {
        inherit overlays system;
      };

      umuPackage = umu.packages.${system}.default;
    in
    {
      packages.${system}.dseg = pkgs.dseg;

      formatter.${system} = import ./flake/formatter.nix { inherit pkgs; };

      devShells.${system}.default = import ./flake/devshell.nix { inherit pkgs; };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          { nixpkgs.overlays = overlays; }

          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Preserve conflicting manual files instead of deleting them.
            home-manager.backupFileExtension = "pre-home-manager";

            home-manager.users.garro = import ./home/garro { inherit umuPackage; };
          }
        ];
      };
    };
}
