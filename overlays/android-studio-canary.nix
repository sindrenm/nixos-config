final: prev:

# nixpkgs' `androidStudioPackages.canary` lags upstream (and is sometimes even behind `.beta`), so
# this pins canary to whatever the latest release actually is.
#
# When updating, fetch the latest entry from https://jb.gg/android-studio-releases-list.json, and
# update version/url/sha256Hash below.
let
  version = "2026.2.1.5"; # "Android Studio Rabbit 1 | 2026.2.1 Canary 5"
  sources = {
    x86_64-linux = {
      url = "https://edgedl.me.gvt1.com/android/studio/ide-zips/${version}/android-studio-rabbit1-canary5-linux.tar.gz";
      sha256Hash = "21dae97259b8ca2cbce923fe86122d3126eab8233c478f4d07d9ff4362d79197";
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
