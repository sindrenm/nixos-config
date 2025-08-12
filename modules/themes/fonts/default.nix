{ pkgs, ... }:

{
  config.stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };

    sansSerif = {
      package = pkgs.roboto;
      name = "Roboto";
    };

    serif = {
      package = pkgs.roboto-serif;
      name = "Roboto Serif";
    };

    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Fonts Color Emoji";
    };

    sizes = {
      applications = 11;
    };
  };
}
