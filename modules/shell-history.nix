{
  home-manager.users.sindre = {
    programs.atuin = {
      enable = true;
      daemon.enable = true;

      # Atuin names both its Nushell keybindings `atuin`, which Nushell >= 0.115 warns about on every startup. Dropping
      # the up-arrow binding leaves only one, and I never use the up arrow shortcut anyway.
      #
      # See https://github.com/atuinsh/atuin/issues/3971.
      flags = [ "--disable-up-arrow" ];

      settings = {
        search_mode = "daemon-fuzzy";
        daemon.autostart = true;
        ai.enabled = true;
      };
    };
  };
}
