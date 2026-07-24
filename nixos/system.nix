{ pkgs, ... }:

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
      withUWSM = true;
      xwayland.enable = true;
    };
    ssh = {
      startAgent = true;
    };
  };

  fonts.packages = with pkgs; [
    ibm-plex
  ];

  security.pam.services.hyprlock = { };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
