{ config, ... }:

let
  stylix-colors = config.lib.stylix.colors;

  scheme = ''
    :root {
      --color-base00: #${stylix-colors.base00};
      --color-base01: #${stylix-colors.base01};
      --color-base02: #${stylix-colors.base02};
      --color-base03: #${stylix-colors.base03};
      --color-base04: #${stylix-colors.base04};
      --color-base05: #${stylix-colors.base05};
      --color-base06: #${stylix-colors.base06};
      --color-base07: #${stylix-colors.base07};
      --color-base08: #${stylix-colors.base08};
      --color-base09: #${stylix-colors.base09};
      --color-base0A: #${stylix-colors.base0A};
      --color-base0B: #${stylix-colors.base0B};
      --color-base0C: #${stylix-colors.base0C};
      --color-base0D: #${stylix-colors.base0D};
      --color-base0E: #${stylix-colors.base0E};
      --color-base0F: #${stylix-colors.base0F};
    }
  '';

  wlogout-style = builtins.readFile ./wlogout/style.css;
in
{
  programs.wlogout = {
    enable = true;

    style = ''
      ${scheme}
      ${wlogout-style}
    '';

    layout = [
      {
        label = "lock";
        action = "swaylock";
        text = "Lock";
        keybind = "l";
      }

      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Sign out";
        keybind = "o";
      }

      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "s";
      }

      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }

      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }

      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "d";
      }
    ];
  };
}
