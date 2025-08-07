{ ... }:

{
  home.stateVersion = "25.05"; # keep same as system version

  imports = [
    ./modules/programs/git.nix
  ];
}
