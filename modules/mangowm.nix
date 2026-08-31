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
        jq
      ];

      xdg.configFile."mango/scripts/screenshot-window.sh" = {
        executable = true;
        source = ./mangowm/scripts/screenshot-window.sh;
      };

      wayland.windowManager.mango = {
        enable = true;

        # Setting this (even to a no-op) makes the mango module emit the exec-once/dbus-activation/mango-session.target
        # chain, which is what brings up graphical-session.target and starts systemd user services (e.g. noctalia) that
        # are WantedBy it.
        autostart_sh = ":";

        settings = {
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

          # Sticky, GNOME/Niri-style overview. With ov_tab_mode = 1 (the default), releasing SUPER exits overview
          # immediately, which makes it an Alt-Tab rather than a place you can look around in.
          ov_tab_mode = 0;

          borderpx = 2;
          border_radius = 4;
          focused_opacity = 1.0;
          unfocused_opacity = 0.9;
          focuscolor = hex "sky" "ff";
          bordercolor = hex "crust" "ff";

          shadows = 1;
          shadow_only_floating = 0;
          shadows_size = 4;
          shadowscolor = hex "crust" "ee";

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

          windowrule = [
            "isterm:1,appid:^kitty$"
            "isfloating:1,isoverlay:1,isglobal:1,isnoanimation:1,noblur:1,title:^Picture-in-Picture$"
          ];

          mousebind = [
            "SUPER,btn_left,moveresize,curmove"
            "SUPER,btn_right,moveresize,curresize"
          ];

          gesturebind = [
            "none,down,3,toggleoverview"
          ];

          bindl = [
            "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            "NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            "NONE,XF86MonBrightnessUp,spawn,brightnessctl s 10%+"
            "NONE,XF86MonBrightnessDown,spawn,brightnessctl s 10%-"
            "NONE,XF86AudioPlay,spawn,playerctl play-pause"
            "NONE,XF86AudioPause,spawn,playerctl play-pause"
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

            "SUPER+CTRL,R,setkeymode,resize"
            "SUPER,N,setkeymode,layout"
            "NONE,Print,setkeymode,screenshot"
          ]
          ++ lib.concatMap (i: [
            "SUPER,${toString i},view,${toString i},0"
            "SUPER+SHIFT,${toString i},tag,${toString i},0"
          ]) (lib.range 1 9);

          keymode = {
            resize = {
              bind = [
                "NONE,P,switch_proportion_preset"
                "NONE,H,resizewin,-20,+0"
                "NONE,J,resizewin,+0,+20"
                "NONE,K,resizewin,+0,-20"
                "NONE,L,resizewin,+20,+0"
                "NONE,Escape,setkeymode,default"
                "NONE,Return,setkeymode,default"
              ];
            };

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

            screenshot = {
              bind = [
                "NONE,A,spawn,noctalia msg screenshot-region"
                "NONE,O,spawn,noctalia msg screenshot-fullscreen monitor"
                "NONE,W,spawn,~/.config/mango/scripts/screenshot-window.sh"
                "NONE,Escape,setkeymode,default"
                "NONE,Return,setkeymode,default"
              ];
            };
          };
        };
      };
    };
}
