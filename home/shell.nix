{
  programs.carapace = {
    enable = true;
  };

  programs.starship = {
    enable = true;

    settings = {
      git_branch.disabled = true;
      git_commit.disabled = true;

      custom.jj = {
        command = "prompt";
        format = "$output";
        ignore_timeout = true;
        shell = [
          "starship-jj"
          "--ignore-working-copy"
          "starship"
        ];
        use_stdin = false;
        when = true;
      };
    };
  };

  programs.nushell = {
    enable = true;

    settings = {
      buffer_editor = "v";
      edit_mode = "vi";
      show_banner = false;
    };

    environmentVariables = {
      EDITOR = "v";
      MANPAGER = "nvim +Man!";
    };
  };

  programs.zoxide.enable = true;
}
