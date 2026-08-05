{ ... }:

{
  programs.yazi = {
    enable = true;

    settings = {
      mgr = {
        scrolloff = 10;
        show_symlink = true;
        sort_by = "natural";
        sort_dir_first = true;
        sort_sensitive = true;
      };
    };
  };
}
