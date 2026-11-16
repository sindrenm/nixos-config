# Extra btrfs mount options, merged into the mounts from ./hardware-configuration.nix (which is generated and shouldn't
# be edited). zstd compression applies to newly written data only; noatime avoids a metadata write on every read.
let
  options = [
    "compress=zstd"
    "noatime"
  ];
in
{
  fileSystems."/".options = options;
  fileSystems."/home".options = options;
  fileSystems."/nix".options = options;
}
