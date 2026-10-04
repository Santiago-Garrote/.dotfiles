let
  profiles = import ../dev-profiles/profiles.nix;

  sshConfigPath = profileName: "~/.config/ssh/profiles/${profileName}";

  profileGitConfig = profileName: profile: ''
    [user]
      name = ${profile.name}
      email = ${profile.email}
    [core]
      sshCommand = ssh -F ${sshConfigPath profileName}
  '';

  globalGitConfig = ''
    [init]
      defaultBranch = main
    [user]
      name = ${profiles.personal.name}
      email = ${profiles.personal.email}
    [includeIf "gitdir:~/dev/personal/"]
      path = ~/.config/git/profiles/personal.gitconfig
    [includeIf "gitdir:~/dev/faculty/"]
      path = ~/.config/git/profiles/faculty.gitconfig
  '';
in
{
  programs.git.enable = true;
  programs.gh.enable = true;

  home.file.".gitconfig".text = globalGitConfig;
  xdg.configFile."git/profiles/personal.gitconfig".text =
    profileGitConfig "personal" profiles.personal;
  xdg.configFile."git/profiles/faculty.gitconfig".text =
    profileGitConfig "faculty" profiles.faculty;
}
