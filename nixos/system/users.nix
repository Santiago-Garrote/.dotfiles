{
  users.users.garro = {
    isNormalUser = true;
    description = "Santiago Garrote";

    extraGroups = [
      "networkmanager" # manage network connections without root
      "wheel" # sudo access
    ];
  };
}
