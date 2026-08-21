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

        package = noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

        systemd.enable = true;

        settings = {
          theme = {
            mode = if config.theming.polarity == "light" then "light" else "dark";
            source = "builtin";
            builtin = "Catppuccin";

            # Empty ids mean no app-theming templates applied. Noctalia's per-app templates (gtk3, gtk4, qt, kitty, ...)
            # are opt-in and would otherwise fight the catppuccin/home-manager-managed GTK/Qt/dconf config in
            # modules/theming.nix. This only themes Noctalia's own bar/launcher/control-center UI.
            templates = {
              builtin_ids = [ ];
              community_ids = [ ];
            };
          };

          widget = {
            clock.format =  "{:%A, %B %d, %H:%M:%S}";

            home-assistant.type = "pozzoo/hassio:status";

            mango-keymode = {
              type = "gambled23/mangowm-keymode:mangowm-keymode";

              hide_on_default = true;
              notify_change = false;
            };

            mango-layouts = {
              type = "ezequiel/mango_layouts:btn";

              show_text = true;
            };

            nix-monitor.type = "avivbintangaringga/nix-monitor:nix-monitor";

            tailscale.type = "davemhammer/tailscale:status";
          };

          bar.main = {
            padding = 16;

            start = [
              "workspaces"
              "wallpaper"
              "mango-keymode"
              "media"
              "nix-monitor"
            ];

            center = [
              "clock"
              "mango-layouts"
            ];

            end = [
              "tray"
              "clipboard"
              "notifications"
              "tailscale"
              "home-assistant"
              "network"
              "volume"
              "session"
            ];
          };

          shell.panel = {
            launcher_placement = "attached";
            clipboard_placement = "attached";
            polkit_placement = "attached";

            open_near_click_clipboard = true;
            open_near_click_control_center = true;
            open_near_click_launcher = true;
            open_near_click_wallpaper = true;
          };

          shell.screen_corners.enabled = true;
          shell.time_format = "{:%H:%M}";

          shell.screenshot = {
            directory = "${config.home.homeDirectory}/pictures/screenshots";
            confirm_region = true;
            remember_last_region = true;
          };

          shell.session.actions = [
            {
              action = "lock";
              command = "loginctl lock-session";
              shortcut = "l";
              variant = "default";
              enabled = true;
              countdown_seconds = 0.0;
            }
            {
              action = "logout";
              shortcut = "x";
              variant = "default";
              enabled = true;
              countdown_seconds = 0.0;
            }
            {
              action = "lock_and_suspend";
              command = "systemctl suspend";
              shortcut = "u";
              variant = "default";
              enabled = true;
              countdown_seconds = 0.0;
            }
            {
              action = "reboot";
              shortcut = "r";
              variant = "default";
              enabled = true;
              countdown_seconds = 0.0;
            }
            {
              action = "shutdown";
              shortcut = "s";
              variant = "destructive";
              enabled = true;
              countdown_seconds = 0.0;
            }
          ];

          idle.pre_action_fade_seconds = 3;
          nightlight.enabled = true;
          location.address = "Oslo, Norway";

          calendar = {
            enabled = true;

            account.personal_google = {
              type = "google";
              color = "primary";
            };
          };

          plugin_settings."pozzoo/hassio" = {
            entity_manager_placement = "attached";
            entity_manager_open_near_click = true;
          };

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

          wallpaper = {
            directory = "${config.home.homeDirectory}/pictures/walls";
            directory_dark = "${config.home.homeDirectory}/pictures/walls/dark";
            directory_light = "${config.home.homeDirectory}/pictures/walls/light";
            transition_on_startup = true;
            automation = {
              enabled = true;
              order = "alphabetical";
            };
          };
        };
      };
    };
}
