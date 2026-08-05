{ pkgs, ... }:

{
  home.packages = with pkgs; [
    atuin
    bat
    carapace
    fd
    ripgrep
    speedtest-cli
    starship
    tokei
    yazi
    zoxide
  ];
}
