let
  profiles = import ./profiles.nix;

  sshConfigPath = profileName: "~/.config/ssh/profiles/${profileName}";

  profileEnvrc = profileName: profile: ''
    export DEVELOPMENT_PROFILE="${profileName}"
    export GIT_AUTHOR_NAME="${profile.name}"
    export GIT_AUTHOR_EMAIL="${profile.email}"
    export GIT_COMMITTER_NAME="${profile.name}"
    export GIT_COMMITTER_EMAIL="${profile.email}"
    export GIT_SSH_COMMAND="ssh -F ${sshConfigPath profileName}"
    export CLAUDE_CONFIG_DIR="$HOME/.claude/accounts/${profile.claudeAccount}"
    export GH_CONFIG_DIR="$HOME/.config/gh-${profileName}"
  '';
in
{
  home.file."dev/personal/.envrc".text = profileEnvrc "personal" profiles.personal;
  home.file."dev/faculty/.envrc".text = profileEnvrc "faculty" profiles.faculty;
}
