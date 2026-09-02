{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      obs-studio
    ];
  };
}
