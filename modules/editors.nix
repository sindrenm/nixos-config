{
  home-manager.users.sindre =
    {
      nixCats,
      ...
    }:
    {
      imports = [ nixCats.homeModule ];

      nixCats = {
        enable = true;

        packageNames = [ "nvim" ];

        luaPath = ./editors/nvim;

        categoryDefinitions.replace =
          { pkgs, ... }:
          let
            touchup-nvim = pkgs.vimUtils.buildVimPlugin {
              pname = "touchup.nvim";
              version = "unstable-2026-09-30";
              src = pkgs.fetchFromGitHub {
                owner = "noisesfromspace";
                repo = "touchup.nvim";
                rev = "9464d6ca5775e8603b37b36500e5d9a4ab6d57cb";
                hash = "sha256-aXscTSn6OZrs7/WJPp1ImTT1XWC0yk/yE18Ps3xK5I8=";
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

              dotnet = with pkgs; [
                roslyn-ls
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
                prettier
              ];

              nix = with pkgs; [
                nixd
                nixfmt
              ];

              nushell = with pkgs; [
                nufmt
                nushell
              ];

              python = with pkgs; [
                basedpyright
                ruff
              ];

              rust = with pkgs; [
                rust-analyzer
              ];
            };

            startupPlugins = {
              general = with pkgs.vimPlugins; [
                artio-nvim
                blink-cmp
                blink-cmp-conventional-commits
                catppuccin-nvim
                conform-nvim
                fidget-nvim
                jj-nvim
                lazydev-nvim
                mini-diff
                mini-icons
                mini-surround
                nvim-autopairs
                nvim-jump
                nvim-lspconfig
                oil-lsp-diagnostics-nvim
                oil-nvim
                quicker-nvim
                rainbow-delimiters-nvim
                smart-splits-nvim
                tabout-nvim
                tiny-cmdline-nvim
                tiny-inline-diagnostic-nvim
                toggleterm-nvim
                touchup-nvim
                treesj
                vim-jjdescription
                which-key-nvim
              ];

              bash = mkTreesitterPlugin [ "bash" ];

              dotnet = mkTreesitterPlugin [
                "c_sharp"
                "xml"
              ];

              kotlin = mkTreesitterPlugin [ "kotlin" ];

              lua = mkTreesitterPlugin [ "lua" ];

              markdown = mkTreesitterPlugin [
                "markdown"
                "markdown_inline"
              ];

              nix = mkTreesitterPlugin [ "nix" ];

              nushell = mkTreesitterPlugin [ "nu" ];

              python = mkTreesitterPlugin [ "python" ];

              rust = mkTreesitterPlugin [ "rust" ];
            };
          };

        packageDefinitions.replace = {
          nvim =
            { ... }:
            {
              settings = {
                aliases = [ "v" ];

                # Normally the config is the read-only `luaPath` copy in the store,
                # so editing it requires a rebuild. Setting NIXCATS_DEV to a config
                # directory reads that live instead — no rebuild, no `git add`:
                #
                #   NIXCATS_DEV=/home/sindre/nixos-config/modules/editors/nvim nvim
                #
                wrapRc = "NIXCATS_DEV";
                unwrappedCfgPath = nixCats.utils.n2l.mkLuaInline ''os.getenv("NIXCATS_DEV")'';

                hosts.python3.enable = false;
                hosts.node.enable = false;
              };

              categories = {
                general = true;
                bash = true;
                dotnet = true;
                kotlin = true;
                lua = true;
                markdown = true;
                nix = true;
                nushell = true;
                python = true;
                rust = true;
              };
            };
        };
      };
    };
}
