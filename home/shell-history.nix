{
  programs.atuin = {
    enable = true;
    daemon.enable = true;

    settings = {
      search_mode = "daemon-fuzzy";
      daemon.autostart = true;
      ai.enabled = true;
    };
  };
}
