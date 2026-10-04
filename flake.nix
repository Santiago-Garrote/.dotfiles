{
  description = "Santiago's NixOS laptop configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Tracks fresher leaf packages that go stale on the stable branch (e.g.
    # signal-desktop, which hard-expires its build a few months after
    # release and isn't rebuilt often on nixos-26.05).
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umu = {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher.git?dir=packaging/nix&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claudeCode = {
      url = "github:ryoppippi/nix-claude-code";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    codebaseMemoryMcp = {
      url = "github:DeusData/codebase-memory-mcp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixvim,
      umu,
      claudeCode,
      codebaseMemoryMcp,
      ...
    }:
    let
      system = "x86_64-linux";

      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      overlays = [
        (final: _prev: {
          dseg = final.callPackage ./packages/dseg.nix { };
        })
        (_final: _prev: {
          inherit (unstablePkgs) signal-desktop;
        })
      ];
      pkgs = import nixpkgs {
        inherit overlays system;
      };

      umuPackage = umu.packages.${system}.default;
      claudeCodePackage = claudeCode.packages.${system}.default;
      codebaseMemoryMcpPackage = codebaseMemoryMcp.packages.${system}.default;
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

            home-manager.sharedModules = [
              nixvim.homeModules.nixvim
            ];

            home-manager.users.garro = import ./home/garro {
              inherit umuPackage;
              inherit claudeCodePackage;
              inherit codebaseMemoryMcpPackage;
            };
          }
        ];
      };
    };
}
