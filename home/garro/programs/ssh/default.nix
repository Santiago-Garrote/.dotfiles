let
  profiles = import ../dev-profiles/profiles.nix;

  profileConfig = identityFile: ''
    Host *
      AddKeysToAgent yes
      IdentitiesOnly yes
      IdentityFile ${identityFile}
  '';
in
{
  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";

  xdg.configFile."ssh/profiles/personal".text = profileConfig profiles.personal.sshIdentityFile;
  xdg.configFile."ssh/profiles/faculty".text = profileConfig profiles.faculty.sshIdentityFile;
}
