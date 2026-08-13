{
  home-manager.users.sindre = { pkgs, ... }: {
    home.packages = with pkgs; [
      zathura
      zathuraPkgs.zathura_pdf_mupdf
    ];
  };
}
