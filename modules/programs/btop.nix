{
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "adwaita-dark";
      theme_background = false;

      # Set to True to enable "h,j,k,l,g,G" keys for directional control in
      # lists. “Help” changes to shift-h and “Kill” changes to shift-k.
      vim_keys = true;

      temp_scale = "celsius";
    };
  };
}
