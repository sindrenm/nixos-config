{ pkgs, ... }:

{
  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [
      ".git/"
      ".jj/"
    ];
  };

  home.packages = with pkgs; [
    bat
    ripgrep
    speedtest-cli
    tokei
  ];
}
