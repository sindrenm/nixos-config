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

    settings = {
      buffer_editor = "v";
      edit_mode = "vi";
      show_banner = false;
    };

    environmentVariables = {
      EDITOR = "v";
      MANPAGER = "nvim +Man!";
    };

    # Secrets and other machine-specific env vars that shouldn't be committed to this repo go in `local.nu` under the
    # nushell config dir, which is never managed or overwritten by home-manager (only guaranteed to exist, see the
    # activation script below).
    extraConfig = ''
      source-env ${nushellLocalEnv}
    '';
  };

  programs.zoxide.enable = true;

  home.activation.ensureNushellLocalEnv = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p ${lib.escapeShellArg nushellConfigDir}
    [ -e ${lib.escapeShellArg nushellLocalEnv} ] || run touch ${lib.escapeShellArg nushellLocalEnv}
  '';
}
