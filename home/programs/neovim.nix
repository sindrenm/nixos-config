{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      mini-pick
      nvim-lspconfig
      oil-nvim
      typst-preview-nvim
      vim-jjdescription
      vim-repeat
      vim-surround
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./neovim/config/globals.lua}
      ${builtins.readFile ./neovim/config/keymaps.lua}
      ${builtins.readFile ./neovim/config/options.lua}

      ${builtins.readFile ./neovim/plugins/mini-pick.lua}
      ${builtins.readFile ./neovim/plugins/nvim-lspconfig.lua}
      ${builtins.readFile ./neovim/plugins/oil.lua}
    '';
  };
}
