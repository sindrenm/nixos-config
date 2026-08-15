{
  programs.mango = {
    enable = true;
  };

  # Basic bindings mirroring modules/hyprland.nix's keymap (see
  # ~/dotfiles/hyprland/dot-config/hypr/conf/10-keybindings.lua).
  home-manager.users.sindre =
    { mangowm, ... }:
    {
      imports = [ mangowm.hmModules.mango ];

      wayland.windowManager.mango = {
        enable = true;

        # Non-empty so mango's own module wires up its systemd session
        # integration: without this, mango never runs `systemctl --user
        # start mango-session.target`, so mango-session.target never
        # starts. mango-session.target BindsTo graphical-session.target
        # (which pulls it in, same as Requires), so this one line is also
        # what makes anything WantedBy either target actually autostart:
        # mangobar.service below, and vicinae.service (see launchers.nix,
        # WantedBy graphical-session.target).
        # autostart_sh = ''
        #   : # systemd session activation only, nothing to launch directly
        # '';
      };
    };
}
