{
  programs.mango = {
    enable = true;
  };

  home-manager.users.sindre =
    {
      lib,
      pkgs,
      config,
      mangowm,
      ...
    }:
    let
      cursorFlavor = if config.theming.polarity == "light" then "latte" else "mocha";
      hex = name: alpha: "0x" + lib.removePrefix "#" config.theming.palette.${name} + alpha;
    in
    {
      imports = [ mangowm.hmModules.mango ];

      home.packages = with pkgs; [
        brightnessctl
        grim
        slurp
      ];

      xdg.configFile."mango/scripts/screenshot-window.nu" = {
        executable = true;
        source = ./mangowm/scripts/screenshot-window.nu;
      };

      wayland.windowManager.mango = {
        enable = true;

        settings = {
          # Mango imports its environment into systemd and starts mango-session.target (and thereby
          # graphical-session.target) on its own, but XDG_SESSION_ID isn't in its export list.
          #
          # Everything in the systemd user manager lives in logind's "manager" session, not the graphical one, so
          # GetSessionByPID finds nothing and noctalia never arms its logind session lock monitor. This causes
          # `loginctl lock-session` to silently do nothing. Noctalia falls back to XDG_SESSION_ID.
          #
          # Upstream fix pending in noctalia that resolves the session via logind's per-user Display session:
          # https://github.com/noctalia-dev/noctalia/pull/3907.
          exec_once = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd XDG_SESSION_ID";

          cursor_theme = "catppuccin-${cursorFlavor}-blue-cursors";
          cursor_size = 24;

          xkb_rules = {
            layout = "us";
            options = "compose:caps";
          };

          circle_layout = "tile,center_tile,scroller,grid,fair,monocle";

          scroller_default_proportion = 0.5;
          scroller_default_proportion_single = 0.5;
          scroller_ignore_proportion_single = 0;
          scroller_proportion_preset = "0.333,0.5,0.667,1.0";

          border_px = 2;
          border_radius = 4;
          focused_opacity = 1.0;
          unfocused_opacity = 0.9;
          focus_color = hex "sky" "ff";
          border_color = hex "crust" "ff";

          shadows = 1;
          shadow_only_floating = 0;
          shadows_size = 4;
          shadows_color = hex "crust" "ee";

          blur = 1;
          blur_params = {
            radius = 10;
            num_passes = 1;
          };

          layer_animations = 1;
          animation_type_open = "zoom";
          animation_type_close = "zoom";
          layer_animation_type_open = "fade";
          layer_animation_type_close = "fade";
          zoom_initial_ratio = 0.87;
          zoom_end_ratio = 1.0;

          window_rule = [
            "is_term:1,app_id:^kitty$"
            "is_floating:1,is_overlay:1,is_global:1,no_animation:1,no_blur:1,title:^Picture-in-Picture$"
          ];

          mousebind = [
            "SUPER,btn_left,moveresize,curmove"
            "SUPER,btn_right,moveresize,curresize"
          ];

          gesturebind = [
            "none,down,3,toggleoverview"
          ];

          # keysym binding because XF86AudioPause resolves to the same key as XF86AudioPlay
          bindls = [
            "NONE,XF86AudioPlay,spawn,playerctl play-pause"
            "NONE,XF86AudioPause,spawn,playerctl play-pause"
          ];

          bindl = [
            "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            "NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            "NONE,XF86MonBrightnessUp,spawn,brightnessctl s 10%+"
            "NONE,XF86MonBrightnessDown,spawn,brightnessctl s 10%-"
            "NONE,XF86AudioForward,spawn,playerctl position 10+"
            "NONE,XF86AudioRewind,spawn,playerctl position 10-"
            "NONE,XF86AudioNext,spawn,playerctl next"
            "NONE,XF86AudioPrev,spawn,playerctl previous"
          ];

          bind = [
            "SUPER,Return,spawn,kitty"
            "SUPER,Q,killclient"
            "SUPER,space,spawn,vicinae toggle"
            "SUPER,E,spawn,nautilus"
            "SUPER,Escape,spawn,loginctl lock-session"
            "SUPER+SHIFT,Escape,spawn,systemctl suspend"
            "CTRL+ALT,Delete,spawn,wleave --no-version-info"
            "SUPER+SHIFT,R,reload_config"
            "SUPER,O,toggleoverview"

            "SUPER,H,focusdir,left"
            "SUPER,J,focusdir,down"
            "SUPER,K,focusdir,up"
            "SUPER,L,focusdir,right"

            "SUPER+SHIFT,H,exchange_client,left"
            "SUPER+SHIFT,J,exchange_client,down"
            "SUPER+SHIFT,K,exchange_client,up"
            "SUPER+SHIFT,L,exchange_client,right"

            "SUPER+SHIFT,F,togglefloating"

            "SUPER,Tab,focusstack,next"
            "SUPER+SHIFT,Tab,focusstack,prev"

            "SUPER,M,minimized"
            "SUPER+SHIFT,M,restore_minimized,0"

            "SUPER,S,toggle_scratchpad"

            "SUPER,N,setkeymode,layout"

            "NONE,Print,spawn,noctalia msg screenshot-region"
            "CTRL,Print,spawn,~/.config/mango/scripts/screenshot-window.nu"
            "ALT,Print,spawn,noctalia msg screenshot-fullscreen monitor"
          ]
          ++ lib.concatMap (i: [
            "SUPER,${toString i},view,${toString i},0"
            "SUPER+SHIFT,${toString i},tag,${toString i},0"
          ]) (lib.range 1 9);

          key_mode = {
            layout = {
              bind = [
                "NONE,N,switch_layout"
                "NONE,T,setlayout,tile"
                "NONE,S,setlayout,scroller"
                "NONE,M,setlayout,monocle"
                "NONE,G,setlayout,grid"
                "NONE,C,centerwin"
                "NONE,Escape,setkeymode,default"
                "NONE,Return,setkeymode,default"
              ];
            };
          };
        };
      };
    };
}
