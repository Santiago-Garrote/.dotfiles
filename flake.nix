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
      pkgs = nixpkgs.legacyPackages.${system};

      umuPackage = umu.packages.${system}.default;
      formatter = pkgs.writeShellApplication {
        name = "dotfiles-format";
        runtimeInputs = [
          pkgs.git
          pkgs.nixfmt-rfc-style
        ];
        text = ''
          mode="format"

          if [ "''${1:-}" = "--check" ]; then
            mode="check"
            shift
          fi

          if [ "$#" -gt 0 ]; then
            files=("$@")
          else
            mapfile -t files < <(git ls-files '*.nix')
          fi

          formatted_files=()
          for file in "''${files[@]}"; do
            if [ "$file" = "nixos/hardware-configuration.nix" ]; then
              continue
            fi

            formatted_files+=("$file")
          done

          if [ "''${#formatted_files[@]}" -eq 0 ]; then
            exit 0
          fi

          if [ "$mode" = "check" ]; then
            nixfmt --check "''${formatted_files[@]}"
          else
            nixfmt "''${formatted_files[@]}"
          fi
        '';
      };
    in
    {
      formatter.${system} = formatter;

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.quickshell
          pkgs.qt6.qtdeclarative
        ];
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
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
