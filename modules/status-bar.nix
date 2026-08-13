{
  home-manager.users.sindre =
    { config, ... }:
    let
      colors = config.theming.palette;
    in
    {
      programs.ashell = {
        enable = true;

        settings = {
          position = "Top";
          layer = "Bottom";

          modules = {
            left = [ "Workspaces" ];

            center = [ "WindowTitle" ];

            right = [
              [ "Tray" ]
              [ "SystemInfo" ]
              [ "Tempo" ]
              [
                "Privacy"
                "Settings"
              ]
            ];
          };

          tempo = {
            clock_format = "%A, %B %d, %H:%M:%S";
            weather_location.City = "Oslo, Norway";
          };

          appearance = {
            text_color = colors.text;

            background_color = {
              base = colors.base;
              strong = colors.surface1;
              weak = colors.surface0;
            };

            primary_color = {
              base = colors.peach;
              text = colors.base;
            };

            secondary_color = {
              base = colors.crust;
              strong = colors.mantle;
            };

            success_color = colors.green;

            danger_color = {
              base = colors.red;
              weak = colors.yellow;
            };

            workspace_colors = [
              colors.crust
            ];
          };
        };
      };

      services.tailscale-systray.enable = true;
    };
}
