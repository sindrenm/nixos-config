{
  home-manager.users.sindre =
    {
      config,
      lib,
      noctalia,
      pkgs,
      ...
    }:
    {
      imports = [
        noctalia.homeModules.default
        {
          # TOML arrays can't be merged into, so other modules (e.g. noctalia-mangowm.nix) add widgets to the start
          # capsule group through this option, ordered with lib.mkOrder.
          options.noctalia.bar.startGroup = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "Widgets in the capsule group at the start of the main bar.";
          };
        }
      ];

      # Explicit orders leave room for other modules to slot widgets in between.
      noctalia.bar.startGroup = lib.mkMerge [
        (lib.mkOrder 500 [ "workspaces" ])
        (lib.mkOrder 700 [ "wallpaper" ])
        [
          "media"
          "nix-monitor"
        ]
      ];

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
              enable_builtin_templates = false;
              enable_community_templates = false;
              builtin_ids = [ ];
              community_ids = [ ];
            };
          };

          plugins.enabled = [
            "avivbintangaringga/nix-monitor"
            "davemhammer/tailscale"
            "pozzoo/hassio"
          ];

          widget = {
            clock.format = "{:%A, %B %d, %H:%M:%S}";
            home-assistant.type = "pozzoo/hassio:status";
            nix-monitor.type = "avivbintangaringga/nix-monitor:nix-monitor";
            tailscale.type = "davemhammer/tailscale:status";
          };

          bar.main = {
            padding = 16;

            start = [
              "group:start"
            ];

            center = [
              "clock"
            ];

            end = [
              "group:end"
              "tailscale"
              "home-assistant"
              "network"
              "volume"
              "battery"
              "session"
            ];

            capsule_group = [
              {
                id = "start";
                members = config.noctalia.bar.startGroup;
                fill = "surface";
                padding = 0.0;
                widget_spacing = 10;
              }
              {
                id = "end";
                members = [
                  "tray"
                  "clipboard"
                  "notifications"
                ];
                fill = "surface";
                border = "outline";
                padding = 12.0;
              }
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
            filename_pattern = "screenshot_%Y-%m-%d_%H:%M:%S";
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

          idle.behavior = {
            lock = {
              action = "lock";
              timeout = 300; # 5 minutes
            };

            screen-off = {
              action = "screen_off";
              timeout = 600; # 10 minutes
            };
          };

          nightlight.enabled = true;
          location = {
            auto_locate = true;
            address = "Oslo, Norway";
          };

          shell.telemetry_enabled = true;

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
