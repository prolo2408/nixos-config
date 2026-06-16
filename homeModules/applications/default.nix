{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./browser/default.nix
    ./code-editor/default.nix
  ];

    home.packages = with pkgs; [
    htop
    fastfetch
    kdePackages.kate
    vim
    git
  ];
}