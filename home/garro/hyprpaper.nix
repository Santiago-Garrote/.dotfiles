{ pkgs, ... }:

let
  wallpaper = ../../assets/wallpapers/industrial-amber.png;
in
{
  services.hyprpaper = {
    enable = true;

    package = null;

    settings = {
      ipc = true;
      splash = false;

      wallpaper = [
        {
          monitor = "eDP-1";
	  path = "${wallpaper}";
	  fit_mode = "cover";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    hyprpaper
  ];
}
