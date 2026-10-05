{ pkgs, ... }:

let
  kvitterm = import ../kvitterm.nix { inherit pkgs; };
in
{
  systemd.user.services.quickshell = {
    Unit = {
      Description = "Quickshell desktop shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      # hl.env() in hyprland/environment.nix only reaches processes
      # Hyprland itself spawns; a systemd user service sits outside that
      # process tree entirely, so these have to be set here too, or
      # Quickshell crashes on startup with "module KvitTerm is not
      # installed" (and, under QSG_RENDER_LOOP's default threaded loop,
      # the embedded terminal widget's PTY notifier can end up stuck
      # disabled - see environment.nix for the full explanation).
      Environment = [
        "QML_IMPORT_PATH=${kvitterm}/qml"
        "QSG_RENDER_LOOP=basic"
      ];

      ExecStart = "${pkgs.quickshell}/bin/quickshell --no-duplicate";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
