{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      grimblast
      obs-studio
    ];
  };
}
