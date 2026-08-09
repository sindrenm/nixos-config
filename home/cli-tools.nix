{ pkgs, ... }:

{
  programs.bat.enable = true;

  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [
      ".git/"
      ".jj/"
    ];
  };

  home.packages = with pkgs; [
    ripgrep
    speedtest-cli
    tokei
  ];
}
