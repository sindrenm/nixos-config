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

    programs.ripgrep.enable = true;

    home.packages = with pkgs; [
      speedtest-cli
      tokei
    ];
  };
}
