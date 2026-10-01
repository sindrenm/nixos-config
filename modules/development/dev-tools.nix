{
  home-manager.users.sindre = { pkgs, ... }: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home.packages = with pkgs; [
      difftastic
      firebase-tools
      gcc
      jq
      ngrok
      nixfmt
      stow
      tree-sitter
    ];
  };
}
