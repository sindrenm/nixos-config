{
  home-manager.users.sindre = { pkgs, config, ... }: {
    programs.bat.enable = true;

    programs.fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/"
        ".jj/"
      ];
    };

    programs.ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--follow"
        "--max-columns=150"
        "--max-columns-preview"
        "--hidden"
        "--glob=!.git/"
        "--glob=!.jj/"
      ];
    };

    # The ripgrep module only exports this via home.sessionVariables, which nushell doesn't read.
    sessionVariables.RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/ripgreprc";

    home.packages = with pkgs; [
      speedtest-cli
      tokei
    ];
  };
}
