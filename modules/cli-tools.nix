{
  home-manager.users.sindre = { pkgs, ... }: {
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

    home.packages = with pkgs; [
      speedtest-cli
      tokei
    ];
  };
}
