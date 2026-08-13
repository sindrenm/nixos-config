{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      lua-language-server
      nixd
      rust-analyzer
    ];
  };
}
