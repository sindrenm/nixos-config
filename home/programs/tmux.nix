{ pkgs, ... }:

let
  conf = builtins.readFile ./tmux/tmux.conf;
in
{
  programs.tmux = {
    enable = true;

    keyMode = "vi";
    mouse = true;
    clock24 = true;
    baseIndex = 1;
    shortcut = "a";
    escapeTime = 50;
    historyLimit = 1000000;

    plugins = with pkgs.tmuxPlugins; [
      continuum
      resurrect
      sensible
      tmux-thumbs
      yank
    ];

    extraConfig = conf;
  };
}
