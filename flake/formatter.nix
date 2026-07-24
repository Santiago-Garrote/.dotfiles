{ pkgs }:

pkgs.writeShellApplication {
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
      if [ ! -e "$file" ]; then
        continue
      fi

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
}
