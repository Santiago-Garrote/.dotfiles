{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      wlrobs
    ];
  };

  home.packages = with pkgs; [
    gpu-screen-recorder
    qpwgraph
    wf-recorder
  ];

  xdg.configFile."obs-studio/global.ini" = {
    force = true;
    text = ''
      [General]
      CurrentProfile=Screen Recording
      CurrentSceneCollection=Firefox Capture

      [Basic]
      ProfileDir=Screen Recording
      SceneCollection=Firefox Capture
      SceneCollectionFile=Firefox Capture
    '';
  };

  xdg.configFile."obs-studio/basic/profiles/Screen Recording/basic.ini" = {
    force = true;
    text = ''
      [General]
      Name=Screen Recording

      [Output]
      Mode=Simple

      [SimpleOutput]
      FilePath=/home/garro/Videos/Recordings
      RecFormat2=mkv
      RecQuality=Small
      VBitrate=12000
      ABitrate=320

      [Audio]
      SampleRate=48000
    '';
  };

  home.activation.createObsRecordingDirectory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD install -d $VERBOSE_ARG "${config.home.homeDirectory}/Videos/Recordings"
  '';
}
