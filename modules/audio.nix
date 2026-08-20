{
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    pulse.enable = true;
  };

  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      easyeffects
    ];
  };
}
