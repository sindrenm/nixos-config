final: prev:

# nixpkgs' `androidStudioPackages.canary` lags upstream (and is sometimes even behind `.beta`), so
# this pins canary to whatever the latest release actually is.
#
# When updating, fetch the latest entry from https://jb.gg/android-studio-releases-list.json, and
# update version/url/sha256Hash below.
let
  version = "2026.2.3.2"; # "Android Studio Rabbit 3 | 2026.2.3 Canary 2"
  sources = {
    x86_64-linux = {
      url = "https://edgedl.me.gvt1.com/android/studio/ide-zips/${version}/android-studio-rabbit3-canary2-linux.tar.gz";
      sha256Hash = "51deae1b14923bcec3073c12e062f05613b9fb5cc000254227d98a99c861df7a";
    };
  };
  inherit (prev.androidStudioPackages.canary) pname meta;
  builder = "${prev.path}/pkgs/applications/editors/android-studio/linux.nix";
in
{
  androidStudioPackages = prev.androidStudioPackages // {
    canary = final.callPackage (
      import builder {
        channel = "canary";
        inherit pname version sources meta;
      }
    ) {
      inherit (final) buildFHSEnv;
      tiling_wm = false;
      fontsConf = final.makeFontsConf { fontDirectories = [ ]; };
    };
  };
}
