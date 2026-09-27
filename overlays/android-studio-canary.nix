final: prev:

# nixpkgs' `androidStudioPackages.canary` lags upstream (and is sometimes even behind `.beta`), so
# this pins canary to whatever the latest release actually is.
#
# When updating, fetch the latest entry from https://jb.gg/android-studio-releases-list.json, and
# update version/url/sha256Hash below.
let
  version = "2026.2.2.2"; # "Android Studio Rabbit 2 | 2026.2.2 Canary 2"
  sources = {
    x86_64-linux = {
      url = "https://edgedl.me.gvt1.com/android/studio/ide-zips/${version}/android-studio-rabbit2-canary2-linux.tar.gz";
      sha256Hash = "906f357c3042cbce8747bf2dd00978009b9fb36f95c9746a5a0486144b783d0a";
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
