{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
      karere
      signal-desktop
      slack
    ];
  };
}
