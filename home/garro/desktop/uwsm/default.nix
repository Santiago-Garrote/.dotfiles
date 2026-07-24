{ config, ... }:

{
  # Load all Home Manager session variables before
  # starting the graphical session.
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
