{
  home-manager.users.sindre = { pkgs, ... }: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.packages = with pkgs; [
      difftastic
      gcc
      jq
      nixfmt
      stow
      tree-sitter
    ];
  };
}
