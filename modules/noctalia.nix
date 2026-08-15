{
  home-manager.users.sindre =
    {
      config,
      noctalia,
      pkgs,
      ...
    }:
    {
      imports = [ noctalia.homeModules.default ];

      programs.noctalia = {
        enable = true;
        systemd.enable = true;
        package = noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

        settings.theme = {
          mode = if config.theming.polarity == "light" then "light" else "dark";
          source = "builtin";
          builtin = "Catppuccin";

          # Empty ids = no app-theming templates applied. Noctalia's
          # per-app templates (gtk3, gtk4, qt, kitty, ...) are opt-in and
          # would otherwise fight the catppuccin/home-manager-managed
          # GTK/Qt/dconf config in modules/theming.nix. This only themes
          # Noctalia's own bar/launcher/control-center UI.
          templates = {
            builtin_ids = [ ];
            community_ids = [ ];
          };
        };
      };
    };
}
