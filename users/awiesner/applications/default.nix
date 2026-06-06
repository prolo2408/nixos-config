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
    firefox
    htop
    fastfetch
    kdePackages.kate
    vscode
    vim
    git
  ];
}