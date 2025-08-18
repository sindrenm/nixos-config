let
  common = import ./shells/common.nix;
in
{
  programs.fish = {
    enable = true;

    inherit (common) shellAliases;

    interactiveShellInit = ''
      function source
        echo "DEBUG: 'source' called with: $argv"
        builtin source $argv
      end
    '';
  };
}
