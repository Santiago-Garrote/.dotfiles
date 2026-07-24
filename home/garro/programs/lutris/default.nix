{
  pkgs,
  umuPackage,
}:

{
  programs.lutris = {
    enable = true;

    extraPackages = with pkgs; [
      winetricks
      umuPackage
      vulkan-tools
    ];

    winePackages = with pkgs; [
      wineWow64Packages.stableFull
    ];

    protonPackages = with pkgs; [
      proton-ge-bin
    ];
  };
}
