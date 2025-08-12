{ pkgs, ... }:

{
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/precious-dark-eleven.yaml";
    polarity = "dark";
  };
}
