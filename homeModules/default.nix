{ config, lib, pkgs, ... }:

{
  imports = [
    ./desktop-envirement/default.nix
    ./applications/default.nix
  ];

  home.stateVersion = "25.11";
}
