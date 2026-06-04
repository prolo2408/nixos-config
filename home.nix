{ config, pkgs, ... }:

{
  # Benutzerinfos für Home-Manager
  home.username = "awiesner";
  home.homeDirectory = "/home/awiesner";

  # Pakete, die NUR für diesen Benutzer installiert werden
  home.packages = with pkgs; [
    #firefox
    htop
    fastfetch
    #vscode
    chromium
  ];

  # Git direkt über Home-Manager konfigurieren
  programs.git = {
    enable = true;
    userName = "prolo2408";
    userEmail = "artur.w2408@gmail.com";
  };

  # Bash (oder zsh) konfigurieren und Aliase anlegen
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake /etc/nixos/#nixos-laptop";
    };
  };

  # Home-Manager aktivieren
  programs.home-manager.enable = true;

  # Auch Home-Manager braucht eine State-Version.
  home.stateVersion = "25.11";
}