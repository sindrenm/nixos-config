{
  home-manager.users.sindre =
    {
      config,
      hunk,
      pkgs,
      ...
    }:
    let
      signingKey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";

      jjWithoutNushellComp = pkgs.symlinkJoin {
        name = "jujutsu-without-nushell-vendor-completion";
        paths = [ pkgs.jujutsu ];
        postBuild = ''
          rm "$out/share/nushell/vendor/autoload/jj.nu"
        '';
      };

      useCarapaceCompletions = config.programs.carapace.enable;
      jjPkg = if useCarapaceCompletions then jjWithoutNushellComp else pkgs.jujutsu;
      catppuccinFlavor = if config.theming.polarity == "light" then "latte" else "mocha";
    in
    {
      imports = [ hunk.homeManagerModules.default ];

      programs.git = {
        enable = true;

        ignores = [
          ".antigravitycli/"
          ".claude/"
          ".codex"
          "/.jj-workspaces/"
          "/.git-worktrees/"
        ];

        signing = {
          key = signingKey;
          format = "ssh";
          signByDefault = true;
        };

        settings = {
          user = {
            name = "Sindre Moen";
            email = "sindrenm@gmail.com";
          };

          github.user = "sindrenm";

          core = {
            pager = "less -FRSX";
            editor = "nvim";
          };

          diff.external = "difft";

          color = {
            ui = "auto";
            diff.whitespace = "red reverse";
          };

          init.defaultBranch = "main";

          push = {
            default = "simple";
            autoSetupRemote = true;
          };

          pull.rebase = false;
          clean.requireForce = false;
          merge.conflictstyle = "diff3";
          rebase.updateRefs = true;

          alias = {
            bicep = "bisect";
            co = "checkout";
            cb = "checkout -b";
            ci = "commit -v";
            cp = "cherry-pick";
            st = "status";
            br = "branch -vv";
            df = "diff";
            lg = "log --graph --pretty=format:'%C(red)%h%Creset %C(green)%ad%Creset | %s%C(yellow)%d%Creset %C(bold blue)<%an>%Creset' --date=short";
            since = "!f() { git lg $1..HEAD; }; f";
            last = "!f() { git lg --max-count $1; }; f";
            pr = "pull --rebase --ff-only";
            dfc = "diff --cached";
            rob = "!f() { git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done }; f";
            tags = "tag --list --sort=-creatordate";
          };
        };
      };

      programs.gh = {
        enable = true;

        settings = {
          git_protocol = "ssh";
          aliases.co = "pr checkout";
        };
      };

      programs.jujutsu = {
        enable = true;
        package = jjPkg;

        settings = {
          user = {
            name = "Sindre Moen";
            email = "sindrenm@gmail.com";
          };

          ui = {
            "default-command" = "log";
            editor = "v";
            pager = ":builtin";
          };

          # Use Hunk as the diff viewer, not as a pager for unsupported commands.
          # See https://github.com/modem-dev/hunk/issues/1277
          "--scope" = [
            {
              "--when" = {
                commands = [
                  "diff"
                  "interdiff"
                  "show"
                ];
              };
              ui = {
                pager = "hunk pager";
                diff-formatter = ":git";
              };
            }
          ];

          signing = {
            key = signingKey;
            backend = "ssh";
            behavior = "own";
          };

          aliases = {
            gf = [
              "git"
              "fetch"
            ];

            gp = [
              "git"
              "push"
            ];

            retrunk = [
              "rebase"
              "-d"
              "trunk()"
              "--skip-emptied"
            ];
          };

          revsets.bookmark-advance-to = "@-";

          remotes.origin.auto-track-bookmarks = "glob:*";

          git."private-commits" = "description(glob:'private! *')";
        };
      };

      programs.hunk = {
        enable = true;
        enableClaudeIntegration = true;

        settings = {
          theme = "catppuccin-${catppuccinFlavor}";
        };
      };
    };
}
