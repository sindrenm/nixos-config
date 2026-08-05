{ pkgs, ... }:

{
  home.packages = with pkgs; [
    atuin
    bat
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
