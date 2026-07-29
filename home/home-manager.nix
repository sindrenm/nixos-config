{ ... }:

{
  # Let Home Manager manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "26.05"; # match system.stateVersion
}
