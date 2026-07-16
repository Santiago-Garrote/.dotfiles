{ pkgs, ...}:

{
  # Enable the modern Nix CLI and flakes.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  users.users.garro = {
    isNormalUser = true;
    description = "Santiago Garrote";

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
 
  programs = { 
    hyprland = {
      enable = true;

      # Keep the manual start-hyprland workflow used previously.
      withUWSM = false;

      xwayland.enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    ssh = {
      startAgent = true;
    };
  };

  fonts.packages = with pkgs; [
    ibm-plex
  ];

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];
}
