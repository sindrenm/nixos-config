{ pkgs, ... }:

{
  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [ ".git/" ".jj/" ];
  };

  home.packages = with pkgs; [
    atuin
    bat
    carapace
    ripgrep
    speedtest-cli
    tokei
    zoxide
  ];
}
