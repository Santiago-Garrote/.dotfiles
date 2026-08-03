let
  personalIdentityFile = "~/.ssh/id_ed25519";
  facultyIdentityFile = "~/.ssh/id_ed25519_austral";

  profileConfig = identityFile: ''
    Host *
      AddKeysToAgent yes
      IdentitiesOnly yes
      IdentityFile ${identityFile}
  '';
in
{
  xdg.configFile."ssh/profiles/personal".text = profileConfig personalIdentityFile;
  xdg.configFile."ssh/profiles/faculty".text = profileConfig facultyIdentityFile;
}
