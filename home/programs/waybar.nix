{
  programs.waybar = {
    enable = true;

    style = builtins.readFile ./waybar/style.css;

    settings.main = {
      reload-style-on-change = true;

      layer = "bottom";
      position = "bottom";

      margin-bottom = 16;

      modules-left = [
        "niri/workspaces"
        "niri/window"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "tray"
        "pulseaudio"
        "network"
        "battery"
      ];

      # Modules

      battery = {
        interval = 10;

        states = {
          warning = 30;
          critical = 15;
        };

        format-time = "{H}:{M:02}";
        format = "BAT {capacity}% ({time})";
        format-charging = "BAT {capacity}% ({time})";
        format-charging-full = "BAT {capacity}%";
        format-full = "BAT {capacity}%";
        format-alt = "BAT {power}W";

        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];

        tooltip = false;
      };

      clock = {
        interval = 1;
        format = "{:%A, %B %d %Y, %H:%M:%S}";
        tooltip = false;
      };

      network = {
        interval = 5;
        format-wifi = "NET WiFi {essid} ({signalStrength}%)";
        format-ethernet = "NET Wired";
        format-disconnected = "NET No connection";
        format-alt = "IP {ipaddr}/{cidr}";
        tooltip = false;
      };

      pulseaudio = {
        format = "VOL {volume}%";
        format-bluetooth = "VOL (Bluetooth) {volume}%";
        format-muted = "VOL MUTE";

        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
          ];
        };

        scroll-step = 1;
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        tooltip = false;
      };

      tray = {
        icon-size = 24;
        spacing = 16;
      };
    };
  };
}
