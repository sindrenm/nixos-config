{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      nodejs_26
    ];
  };
}
