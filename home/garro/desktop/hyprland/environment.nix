{ pkgs, ... }:

let
  kvitterm = import ../kvitterm.nix { inherit pkgs; };
in
''
  ---------------------
  ---- ENVIRONMENT ----
  ---------------------

  hl.env("XCURSOR_SIZE", "24")
  hl.env("HYPRCURSOR_SIZE", "24")

  -- Lets Quickshell's QML engine "import KvitTerm" for the embedded
  -- terminal widget; see desktop/kvitterm.nix.
  hl.env("QML_IMPORT_PATH", "${kvitterm}/qml")

  -- kvit-term's TerminalView (a QQuickPaintedItem) toggles the PTY's
  -- QSocketNotifier from inside paint(), which under Qt Quick's default
  -- threaded render loop runs on a separate render thread from the GUI
  -- thread that owns the notifier - producing "Socket notifiers cannot be
  -- enabled or disabled from another thread" and, worse, leaving the
  -- notifier stuck disabled (the terminal freezing). Forcing the basic
  -- (single-threaded) render loop keeps paint() on the GUI thread instead.
  hl.env("QSG_RENDER_LOOP", "basic")
''
