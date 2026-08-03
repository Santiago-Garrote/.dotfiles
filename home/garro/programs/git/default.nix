let
  personalProfile = {
    name = "Santiago-Garrote";
    email = "santiagogarrote2005@gmail.com";
  };

  facultyProfile = {
    name = "GarroteSantiago";
    email = "sgarrote@mail.austral.edu.ar";
  };

  profileEnvrc = profileName: profile: sshConfig: ''
    export DEVELOPMENT_PROFILE="${profileName}"
    export GIT_AUTHOR_NAME="${profile.name}"
    export GIT_AUTHOR_EMAIL="${profile.email}"
    export GIT_COMMITTER_NAME="${profile.name}"
    export GIT_COMMITTER_EMAIL="${profile.email}"
    export GIT_SSH_COMMAND="ssh -F ${sshConfig}"
  '';

  profileGitConfig = profile: sshConfig: ''
    [user]
      name = ${profile.name}
      email = ${profile.email}
    [core]
      sshCommand = ssh -F ${sshConfig}
  '';

  personalSshConfig = "~/.config/ssh/profiles/personal";
  facultySshConfig = "~/.config/ssh/profiles/faculty";
in
{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";
      user = {
        name = personalProfile.name;
        email = personalProfile.email;
      };

      includeIf."gitdir:~/dev/personal/".path = "~/.config/git/profiles/personal.gitconfig";
      includeIf."gitdir:~/dev/faculty/".path = "~/.config/git/profiles/faculty.gitconfig";
    };
  };

  xdg.configFile."git/profiles/personal.gitconfig".text =
    profileGitConfig personalProfile personalSshConfig;
  xdg.configFile."git/profiles/faculty.gitconfig".text =
    profileGitConfig facultyProfile facultySshConfig;

  home.file."dev/personal/.envrc".text = profileEnvrc "personal" personalProfile personalSshConfig;
  home.file."dev/faculty/.envrc".text = profileEnvrc "faculty" facultyProfile facultySshConfig;
}
