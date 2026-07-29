{ lib, ... }:

{
  imports = lib.pipe ./. [
    lib.filesystem.listFilesRecursive
    (lib.filter (lib.hasSuffix ".nix"))
    (lib.filter (path: path != ./default.nix))
  ];
}
