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
    ripgrep
    speedtest-cli
    tokei
    zoxide
  ];
}
