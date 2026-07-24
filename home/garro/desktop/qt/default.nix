{ theme, ... }:

let
  commonSettings = {
    Appearance = {
      style = "adwaita-dark";
      icon_theme = "Papirus-Dark";
      standard_dialogs = "xdgdesktopportal";
    };

    Fonts = {
      general = ''"${theme.typography.interface},10"'';
      fixed = ''"${theme.typography.monospace},10"'';
    };

    Interface = {
      activate_item_on_single_click = 0;
      buttonbox_layout = 0;
      cursor_flash_time = 1000;
      dialog_buttons_have_icons = 0;
      double_click_interval = 400;
      menus_have_icons = true;
      show_shortcuts_in_context_menus = true;
      toolbutton_style = 4;
      underline_shortcut = 1;
      wheel_scroll_lines = 3;
    };
  };
in
{
  qt = {
    enable = true;

    platformTheme.name = "qtct";
    style.name = "adwaita-dark";

    qt5ctSettings = commonSettings;
    qt6ctSettings = commonSettings;
  };
}
