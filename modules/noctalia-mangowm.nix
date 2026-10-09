{ config, lib, ... }:

{
  home-manager.users.sindre = lib.mkIf config.programs.mango.enable {
    # Insert after the shared workspace/wallpaper prefix and before the remaining widgets.
    noctalia.bar.startGroup = lib.mkOrder 750 [ "mango-keymode" ];

    programs.noctalia.settings = {
      widget = {
        mango-keymode = {
          type = "gambled23/mangowm-keymode:mangowm-keymode";

          hide_on_default = true;
          notify_change = false;
        };

        mango-layouts = {
          type = "ezequiel/mango_layouts:btn";

          show_text = true;
        };
      };

      bar.main.center = lib.mkAfter [ "mango-layouts" ];

      plugin_settings."ezequiel/mango_layouts" = {
        panel_placement = "attached";
        panel_open_near_click = true;

        # Match mango's circle_layout
        show_dwindle = false;
        show_right_tile = false;
        show_vertical_deck = false;
        show_vertical_fair = false;
        show_vertical_grid = false;
        show_vertical_scroller = false;
        show_vertical_tile = false;
      };
    };
  };
}
