# Basis-Home-Konfiguration (Desktop-unabhängig).
{ pkgs, userName, ... }:

{
  imports = [
    ./shell.nix
    ./applications
  ];

  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  # Desktop-unabhängige Pakete.
  home.packages = with pkgs; [
    htop
    fastfetch
  ];

  programs.home-manager.enable = true;

  # Einzige Stelle für die Home-Manager stateVersion.
  home.stateVersion = "25.11";
}
