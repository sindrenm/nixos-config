{
  catppuccin,
  catppuccin-palette,
  lib,
  ...
}:

let
  jsonPalette = builtins.readFile "${catppuccin-palette}/palette.json";
  allPalettes = builtins.fromJSON jsonPalette;
  colors = allPalettes.latte.colors;
in
{
  imports = [ catppuccin.homeModules.catppuccin ];

  options.theming.palette = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    description = "Named hex colors for the active Catppuccin flavor, \
      for programs without an official catppuccin/nix integration.";
    default = lib.mapAttrs (_: color: color.hex) colors;
  };

  config.catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "latte";
    accent = "blue";
  };
}
