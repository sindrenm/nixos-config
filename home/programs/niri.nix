{ config, ... }:

{
  # See https://github.com/sodiboo/niri-flake/blob/main/docs.md
  programs.niri.settings = {
    environment = {
      DISPLAY = ":0";
    };

    spawn-at-startup = [
      { command = [ "waybar" ]; }
      { command = [ "xwayland-satellite" ]; }
    ];

    cursor = {
      hide-when-typing = true;
    };

    hotkey-overlay = {
      skip-at-startup = true;
    };

    input = {
      keyboard = {
        xkb = {
          layout = "us";
          options = "compose:caps";
        };
      };

      touchpad = {
        tap = true;
        natural-scroll = false;
      };

      # Do not change focus on mouse hover. This gets incredibly annoying when
      # you want to click on something in a window that is only partially
      # visible. You move your mouse to the location of the thing you wish to
      # click, the window gets focused, causing the screen to scroll to ensure
      # the entire window is visible, and the thing you wanted to click gets
      # moved with the window.
      focus-follows-mouse.enable = false;
      warp-mouse-to-focus.enable = false;
    };

    outputs = {
      # Run `niri msg outouts` to see a list of all outputs

      # Home desktop external monitor
      "Dell Inc. DELL U2719DC HN6Q5R2" = {
        mode = {
          width = 2560;
          height = 1440;
          refresh = 60.0;
        };

        scale = 1.0;
      };
    };

    window-rules = [
      {
        geometry-corner-radius = {
          bottom-left = 8.0;
          bottom-right = 8.0;
          top-left = 8.0;
          top-right = 8.0;
        };

        clip-to-geometry = true;
        draw-border-with-background = true;
      }

      {
        matches = [ { is-active = false; } ];

        opacity = 0.95;
      }

      {
        # Open the Firefox picture-in-picture player as floating by default.
        matches = [
          { app-id = "^firefox$"; }
          { title = "^Picture-in-Picture$"; }
        ];

        open-floating = true;
      }
    ];

    layout = {
      gaps = 16;

      preset-column-widths = [
        { proportion = 0.25; }
        { proportion = 0.50; }
        { proportion = 0.75; }
        { proportion = 1.00; }
      ];
    };

    # Ask the clients to omit their client-side decorations if possible. If the
    # client will specifically ask for CSD, the request will be honored.
    # Additionally, clients will be informed that they are tiled, removing some
    # client-side rounded corners. This option will also fix border/focus ring
    # drawing behind some semitransparent windows. After enabling or disabling
    # this, you need to restart the apps for this to take effect.
    prefer-no-csd = true;

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    binds = with config.lib.niri.actions; {
      #Keys consist of modifiers separated by + signs, followed by an XKB key
      #name in the end. To find an XKB name for a particular key, you may use a
      #program like wev.
      #
      #Most actions that you can bind here can also be invoked programmatically
      #with `niri msg action do-something`.

      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Mod+Return".action.spawn = "ghostty";
      "Mod+Space".action.spawn = "fuzzel";
      "Mod+Alt+L".action.spawn = "swaylock";

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;

        action.spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.1+"
        ];
      };

      "XF86AudioLowerVolume" = {
        allow-when-locked = true;

        action.spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.1-"
        ];
      };

      "XF86AudioMute" = {
        allow-when-locked = true;

        action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
      };

      "XF86AudioMicMute" = {
        allow-when-locked = true;

        action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];
      };

      "Mod+Q".action = close-window;
      "Mod+E".action = toggle-overview;

      # Change window focus using Vim keybindings
      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+L".action = focus-column-right;

      # Move windows using Vim keybindings
      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
      "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
      "Mod+Shift+L".action = move-column-right;

      "Mod+Alt+J".action = move-workspace-down;
      "Mod+Alt+K".action = move-workspace-up;

      # Navigate to workspaces by number. Note that workspaces are dynamic, so
      # if one doesn't exist, we will move to the closest one.
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      # Move entire column to workspace by number. The same rules about dynamic
      # workspaces apply as with navigating to them.
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      # Cycle back and forth between the current and the previously visited
      # workspace, e.g., from workspace 1 to 2 and back to 1 again.
      "Mod+Tab".action = focus-workspace-previous;

      "Mod+Comma".action = consume-or-expel-window-left;
      "Mod+Period".action = consume-or-expel-window-right;

      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;

      # Expand the focused column to fill up the remaining space not taken up
      # by other fully visible columns.
      "Mod+Ctrl+F".action = expand-column-to-available-width;

      # Center the currently selected column, potentially leaving space on each
      # side of it, depending on neighboring columns.
      "Mod+C".action = center-column;

      # Some finer width and height adjustments
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Toggle currently focused window between being floating and tiled, and
      # also allow for switching focus between what's floating and what's
      # potentially tiled behind it.
      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

      # Toggle tabbed column display mode. Windows in this column will appear
      # as vertical tabs, rather than stacked on top of each other.
      "Mod+T".action = toggle-column-tabbed-display;

      # Screenshot actions. Note the workaround from
      # https://github.com/sodiboo/niri-flake/issues/922.
      "Print".action = screenshot;
      "Ctrl+Print".action."screenshot-screen" = [ ];
      "Alt+Print".action = screenshot-window;

      # Applications such as remote-desktop clients and software KVM switches
      # may request that niri stops processing the keyboard shortcuts defined
      # here so they may, for example, forward the key presses as-is to a
      # remote machine. It's a good idea to bind an escape hatch to toggle the
      # inhibitor, so a buggy application can't hold your session hostage.
      "Mod+Escape" = {
        allow-inhibiting = false;
        action = toggle-keyboard-shortcuts-inhibit;
      };

      # Show a confirmation message and quit niri.
      "Ctrl+Alt+Delete".action = quit;
    };
  };
}
