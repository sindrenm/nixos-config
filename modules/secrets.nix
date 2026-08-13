{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      bitwarden-cli
      bitwarden-desktop
    ];
  };
}
