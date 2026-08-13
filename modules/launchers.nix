{
  home-manager.users.sindre = {
    programs.vicinae = {
      enable = true;

      systemd.enable = true;
    };
  };
}
