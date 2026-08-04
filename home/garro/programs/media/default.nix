{ pkgs, ... }:

let
  videoPlayer = "org.videolan.VLC.desktop";
in
{
  home.packages = with pkgs; [
    ffmpeg-full
    vlc
  ];

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
