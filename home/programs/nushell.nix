let
  common = import ./shells/common.nix;
in
{
  programs.nushell = {
    enable = true;

    inherit (common) environmentVariables;
    inherit (common) shellAliases;

    settings = {
      edit_mode = "vi";
      show_banner = false;
    };
  };
}
