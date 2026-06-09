{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    #./chromium.nix
    ./brave.nix
    ./firefox/firefox.nix
  ];
}