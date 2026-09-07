{
  home-manager.users.sindre =
    { pkgs, config, ... }:
    let
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

      sessionVariables = {
        ANDROID_HOME = "${config.xdg.dataHome}/android-sdk";
      };
    };
}
