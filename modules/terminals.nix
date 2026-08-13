{
  home-manager.users.sindre.programs.kitty = {
    enable = true;

    settings = {
      font_family = "JetBrains Mono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      allow_remote_control = true;
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled";

      enabled_layouts = "tall, fat, horizontal, vertical, stack";

      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      scrollback_lines = 10000;
    };

    keybindings = {
      # Disable Ctrl+S for flow control
      "ctrl+s" = "no_op";

      # Create new split panes
      "alt+enter" = "launch --location=vsplit --cwd=current";
      "alt+space" = "launch --location=hsplit --cwd=current";

      # Navigation between panes
      "alt+h" = "neighboring_window left";
      "alt+j" = "neighboring_window down";
      "alt+k" = "neighboring_window up";
      "alt+l" = "neighboring_window right";

      # Hand navigation over to smart-splits.nvim if Neovim's focused
      "--when-focus-on var:IS_NVIM alt+j" = "";
      "--when-focus-on var:IS_NVIM alt+k" = "";
      "--when-focus-on var:IS_NVIM alt+h" = "";
      "--when-focus-on var:IS_NVIM alt+l" = "";

      # Tab management and navigation
      "ctrl+t>n" = "launch --type=tab --cwd=current";
      "ctrl+t>x" = "close_tab";
      "ctrl+t>h" = "previous_tab";
      "ctrl+t>l" = "next_tab";
      "ctrl+t>r" = "set_tab_title";

      # Toggle layouts (m for “mode” as alt+l is already taken)
      "alt+m>s" = "toggle_layout stack";
      "alt+m>v" = "toggle_layout vertical";
      "alt+m>h" = "toggle_layout horizontal";
      "alt+m>t" = "toggle_layout tall";
      "alt+m>f" = "toggle_layout fat";

      # “Full-screen” shortcut for toggling stack
      "alt+f" = "toggle_layout stack";

      # Reload config file
      "alt+r" = "load_config_file";
    };
  };
}
