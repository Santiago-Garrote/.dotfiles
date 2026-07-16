{
  description = "Santiago's NixOS laptop configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_x64-linux";
      theme = import ./themes;
    in
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit theme;
        };

        modules = [
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Preserve conflicting manual files instead of deleting them.
            home-manager.backupFileExtension = "pre-home-manager";

            home-manager.extraSpecialArgs = {
              inherit theme;
            };

            home-manager.users.garro = import ./home/garro;
          }
        ];
      };
  };
}
