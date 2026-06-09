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

    home.packages = with pkgs; [
    htop
    fastfetch
    kdePackages.kate
    vscode
    vim
    git
  ];
}