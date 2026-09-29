{
  home.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
    # xdg-open's default for application/pdf resolves to Krita (registered
    # via krita_pdf.desktop) since no explicit default is set — this
    # bypasses that for pax/lazypax specifically, which read this var
    # before ever falling back to xdg-open.
    PAX_PDF_VIEWER = "zathura";
  };
}
