{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    difftastic
    gcc
    jetbrains-toolbox
    nixfmt
    stow
    tree-sitter
  ];
}
