{
  personal = {
    name = "Santiago-Garrote";
    email = "santiagogarrote2005@gmail.com";
    sshIdentityFile = "~/.ssh/id_ed25519";
    claudeAccount = "personal";
  };

  faculty = {
    name = "GarroteSantiago";
    email = "sgarrote@mail.austral.edu.ar";
    sshIdentityFile = "~/.ssh/id_ed25519_austral";
    # Shares the personal Claude account rather than logging in separately.
    claudeAccount = "personal";
  };
}
