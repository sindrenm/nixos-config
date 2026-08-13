{
  home-manager.users.sindre =
    {
      catppuccin,
      catppuccin-palette,
      config,
      lib,
      pkgs,
      ...
    }:
    let
      catppuccinFlavor = if config.theming.polarity == "light" then "latte" else "mocha";
      gtkThemeName = if config.theming.polarity == "light" then "adw-gtk3" else "adw-gtk3-dark";
      colorScheme = if config.theming.polarity == "light" then "prefer-light" else "prefer-dark";

      jsonPalette = builtins.readFile "${catppuccin-palette}/palette.json";
      allPalettes = builtins.fromJSON jsonPalette;
      colors = allPalettes.${catppuccinFlavor}.colors;
    in
    {
      imports = [ catppuccin.homeModules.catppuccin ];

      options.theming.polarity = lib.mkOption {
        type = lib.types.enum [
          "light"
          "dark"
        ];
        default = "light";
        description = "Overall desktop polarity. Drives the Catppuccin flavor, \
          GTK theme variant, and the GNOME/libadwaita color-scheme preference.";
      };

      options.theming.palette = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        description = "Named hex colors for the active Catppuccin flavor, \
          for programs without an official catppuccin/nix integration.";
        default = lib.mapAttrs (_: color: color.hex) colors;
        readOnly = true;
      };

      config = {
        catppuccin = {
          enable = true;
          autoEnable = true;
          flavor = catppuccinFlavor;
          accent = "blue";
        };

        gtk = {
          enable = true;
          theme = {
            name = gtkThemeName;
            package = pkgs.adw-gtk3;
          };
        };

        dconf = {
          enable = true;
          settings."org/gnome/desktop/interface" = {
            color-scheme = colorScheme;
            gtk-theme = config.gtk.theme.name;
            icon-theme = config.gtk.iconTheme.name;
          };
        };
      };
    };
}
