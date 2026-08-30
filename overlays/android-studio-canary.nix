final: prev:

# nixpkgs' `androidStudioPackages.canary` lags upstream (and is sometimes even behind `.beta`), so
# this pins canary to whatever the latest release actually is.
#
# When updating, fetch the latest entry from https://jb.gg/android-studio-releases-list.json, and
# update version/url/sha256Hash below.
let
  version = "2026.2.1.3"; # "Android Studio Rabbit 1 | 2026.2.1 Canary 3"
  sources = {
    x86_64-linux = {
      url = "https://edgedl.me.gvt1.com/android/studio/ide-zips/${version}/android-studio-rabbit1-canary3-linux.tar.gz";
      sha256Hash = "2f8e1796d8386ea2f3dd5a6e9f8ad306787d1cf8a75a6d2bb32e1df14d593d01";
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
