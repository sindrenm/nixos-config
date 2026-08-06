{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim; # use nightly overlay
    sideloadInitLua = true; # manage my own Lua config
  };
}
