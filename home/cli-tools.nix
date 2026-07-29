{ pkgs, ... }:

{
  home.packages = with pkgs; [
    atuin
    bat
    bottom
    carapace
    eza
    fd
    ripgrep
    speedtest-cli
    starship
    tokei
    yazi
    zoxide
  ];
}
