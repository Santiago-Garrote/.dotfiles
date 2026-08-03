{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    config.whitelist.exact = [
      "/home/garro/dev/personal/.envrc"
      "/home/garro/dev/faculty/.envrc"
    ];
  };
}
