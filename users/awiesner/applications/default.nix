{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./browser/default.nix
  ];
}