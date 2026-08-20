{
  home-manager.users.sindre =
    { pkgs, config, ... }:
    let
      androidEnvVariables = {
        ANDROID_HOME = "${config.xdg.dataHome}/android-sdk";
      };
      tilingWmOverrides = {
        tiling_wm = true;
        forceWayland = true;
      };
    in
    {
      home.packages = with pkgs; [
        android-cli
        android-tools
        (androidStudioPackages.canary.override tilingWmOverrides)
        (androidStudioPackages.stable.override tilingWmOverrides)
      ];

      home.sessionVariables = androidEnvVariables;
      programs.nushell.environmentVariables = androidEnvVariables;
      systemd.user.sessionVariables = androidEnvVariables;
    };
}
