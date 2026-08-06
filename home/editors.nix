{
  nixCats,
  pkgs,
  ...
}:

{
  imports = [ nixCats.homeModule ];

  # The old Neovim whose config is not tracked in this repo. Will eventually be
  # replaced by the `nixCats` build below.
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim; # use nightly overlay
    sideloadInitLua = true; # manage my own Lua config
  };

  nixCats = {
    enable = true;

    packageNames = [ "v" ];

    luaPath = ./editors/nvim;

    categoryDefinitions.replace =
      { pkgs, ... }:
      {
        lspsAndRuntimeDeps = {
          lua = with pkgs; [
            lua-language-server
            stylua
          ];
        };

        startupPlugins = {
          general = with pkgs.vimPlugins; [
            catppuccin-nvim
            lazydev-nvim
            mini-icons
            nvim-lspconfig
            which-key-nvim
          ];
        };
      };

    packageDefinitions.replace = {
      v =
        { ... }:
        {
          settings = {
            # Leave ~/.config/nvim/ alone for now.
            configDirName = "nixcats.nvim";

            # Normally the config is the read-only `luaPath` copy in the store,
            # so editing it requires a rebuild. Setting NIXCATS_DEV to a config
            # directory reads that live instead — no rebuild, no `git add`:
            #
            #   NIXCATS_DEV=/home/sindre/nixos-config/home/editors/nvim v
            #
            wrapRc = "NIXCATS_DEV";
            unwrappedCfgPath = nixCats.utils.n2l.mkLuaInline ''os.getenv("NIXCATS_DEV")'';

            hosts.python3.enable = false;
            hosts.node.enable = false;
          };

          categories = {
            general = true;
            lua = true;
          };
        };
    };
  };
}
