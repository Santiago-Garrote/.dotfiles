{ ... }:

{
  services.hyprlauncher = {
    enable = true;
    
    settings = {
      general = {
        grab_focus = true;
      };

      cache = {
        enabled = true;
      };

      finders = {
        default_finder = "desktop";

	desktop_prefix = "";
	unicode_prefix = ".";
	math_prefix = "=";
	font_prefix = "'";

	desktop_icons = false;

	desktop_launch_prefix = "uwsm app --";
      };

      ui = {
        window_size = "480 300";
      };
    };
  };
}
