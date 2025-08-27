{ config, ... }:

{
  programs.obsidian = {
    enable = true;

    vaults = {
      "second-brain" = {
        enable = true;

        target = "${config.xdg.userDirs.documents}/obsidian-vaults/second-brain";
      };
    };
  };
}
