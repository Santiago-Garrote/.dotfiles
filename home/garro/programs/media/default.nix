{ pkgs, ... }:

let
  videoPlayer = "org.videolan.VLC.desktop";
in
{
  home.packages = with pkgs; [
    ffmpeg-full
    vlc
    zathura
  ];

  # xdg-open's default for application/pdf resolves to Krita (registered via
  # krita_pdf.desktop) since no explicit default is set — this bypasses that
  # for pax/lazypax specifically, which read this var before ever falling
  # back to xdg-open.
  home.sessionVariables.PAX_PDF_VIEWER = "zathura";

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "video/mp4" = videoPlayer;
      "video/x-matroska" = videoPlayer;
      "video/webm" = videoPlayer;
      "video/quicktime" = videoPlayer;
      "video/x-msvideo" = videoPlayer;
      "video/x-ms-wmv" = videoPlayer;
      "video/mpeg" = videoPlayer;
      "video/ogg" = videoPlayer;
      "video/x-flv" = videoPlayer;
    };
  };
}
