{
  home-manager.users.sindre =
    { config, lib, ... }:
    let
      nushellConfigDir = config.programs.nushell.configDir;
      nushellLocalEnv = "${nushellConfigDir}/local.nu";
    in
    {
      programs.carapace = {
        enable = true;
      };

      programs.starship = {
        enable = true;

        settings = {
          git_branch.disabled = true;
          git_commit.disabled = true;

          custom.jj = {
            command = "prompt";
            format = "$output";
            ignore_timeout = true;
            shell = [
              "starship-jj"
              "--ignore-working-copy"
              "starship"
            ];
            use_stdin = false;
            when = true;
          };
        };
      };

      programs.nushell = {
        enable = true;

        shellAliases = {
          l = "eza";
          ll = "eza --long --git --icons=auto";
          lt = "eza --long --git --icons=auto --tree";
          lt2 = "eza --long --git --icons=auto --tree --level 2";
        };

        settings = {
          buffer_editor = "v";
          edit_mode = "vi";
          show_banner = false;
        };

        environmentVariables = {
          EDITOR = "v";
          MANPAGER = "nvim +Man!";
        };

        extraConfig = ''
          source-env ${nushellLocalEnv}

          ${lib.fileContents ./shell/jj-last.nu}
        '';
      };

      programs.zoxide.enable = true;

      home.activation.ensureNushellLocalEnv = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p ${lib.escapeShellArg nushellConfigDir}
        [ -e ${lib.escapeShellArg nushellLocalEnv} ] || run touch ${lib.escapeShellArg nushellLocalEnv}
      '';
    };
}
