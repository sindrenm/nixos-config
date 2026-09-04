{
  home-manager.users.sindre =
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
          let
            touchup-nvim = pkgs.vimUtils.buildVimPlugin {
              pname = "touchup.nvim";
              version = "unstable-2026-08-13";
              src = pkgs.fetchFromGitHub {
                owner = "noisesfromspace";
                repo = "touchup.nvim";
                rev = "efc7df43515aeb29c84ef088f0197bde83e9ce12";
                hash = "sha256-T9x6zLsPmpZn8yTwzN4+TXgWb2RuZP2OIX8UNV8W0sU=";
              };
            };

            mkTreesitterPlugin = grammars: [
              (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: map (g: p.${g}) grammars))
            ];
          in
          {
            lspsAndRuntimeDeps = {
              general = with pkgs; [
                fd
                ripgrep
              ];

              bash = with pkgs; [
                bash-language-server
                shellcheck
                shfmt
              ];

              kotlin = with pkgs; [
                kotlin-lsp
                ktfmt
              ];

              lua = with pkgs; [
                lua-language-server
                stylua
              ];

              markdown = with pkgs; [
                marksman
              ];

              nix = with pkgs; [
                nixd
                nixfmt
              ];
            };

            startupPlugins = {
              general = with pkgs.vimPlugins; [
                artio-nvim
                blink-cmp
                blink-cmp-conventional-commits
                catppuccin-nvim
                fidget-nvim
                jj-nvim
                lazydev-nvim
                mini-diff
                mini-icons
                mini-surround
                nvim-jump
                nvim-lspconfig
                oil-lsp-diagnostics-nvim
                oil-nvim
                rainbow-delimiters-nvim
                smart-splits-nvim
                toggleterm-nvim
                touchup-nvim
                vim-jjdescription
                which-key-nvim
              ];

              bash = mkTreesitterPlugin [ "bash" ];

              kotlin = mkTreesitterPlugin [ "kotlin" ];

              lua = mkTreesitterPlugin [ "lua" ];

              markdown = mkTreesitterPlugin [
                "markdown"
                "markdown_inline"
              ];

              nix = mkTreesitterPlugin [ "nix" ];
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
                #   NIXCATS_DEV=/home/sindre/nixos-config/modules/editors/nvim v
                #
                wrapRc = "NIXCATS_DEV";
                unwrappedCfgPath = nixCats.utils.n2l.mkLuaInline ''os.getenv("NIXCATS_DEV")'';

                hosts.python3.enable = false;
                hosts.node.enable = false;
              };

              categories = {
                general = true;
                bash = true;
                kotlin = true;
                lua = true;
                markdown = true;
                nix = true;
              };
            };
        };
      };
    };
}
