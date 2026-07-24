{ theme }:

let
  color = value: "#${value}FF";
  colors = theme.colors;
in
{
  # Criteria order matters in Mako, so these rules remain explicit.
  services.mako.extraConfig = ''
    [urgency=low]
    border-color=${color colors.border}
    text-color=${color colors.textMuted}
    default-timeout=4000

    [urgency=normal]
    border-color=${color colors.primary}

    [urgency=critical]
    background-color=${color colors.error}
    text-color=${color colors.onError}
    border-color=${color colors.error}
    default-timeout=0
  '';
}
