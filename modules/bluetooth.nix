{
  hardware.bluetooth.enable = true;

  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      bluetui
    ];
  };
}
