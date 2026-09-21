final: prev:

# nixpkgs' `androidStudioPackages.canary` lags upstream (and is sometimes even behind `.beta`), so
# this pins canary to whatever the latest release actually is.
#
# When updating, fetch the latest entry from https://jb.gg/android-studio-releases-list.json, and
# update version/url/sha256Hash below.
let
  version = "2026.2.2.1"; # "Android Studio Rabbit 2 | 2026.2.2 Canary 1"
  sources = {
    x86_64-linux = {
      url = "https://edgedl.me.gvt1.com/android/studio/ide-zips/${version}/android-studio-rabbit2-canary1-linux.tar.gz";
      sha256Hash = "9ba13980023a84ed8ce737fb9c341a42d9c799d8a675766c05848a3951f89db4";
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
