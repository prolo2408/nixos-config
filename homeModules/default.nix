{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./applications/default.nix
  ];
}