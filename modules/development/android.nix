{
  home-manager.users.sindre =
    { pkgs, config, ... }:
    let
      androidEnvVariables = {
        ANDROID_HOME = "${config.xdg.dataHome}/android-sdk";
      };
    in
    {
      home.packages = with pkgs; [
        android-cli
        android-tools
        androidStudioPackages.canary
        androidStudioPackages.stable
      ];

      home.sessionVariables = androidEnvVariables;
      programs.nushell.environmentVariables = androidEnvVariables;
      systemd.user.sessionVariables = androidEnvVariables;
    };
}
