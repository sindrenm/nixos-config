{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      mpv
      playerctl
      stremio-linux-shell
    ];
  };
}
