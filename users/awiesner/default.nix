{ config, pkgs, userName, ... }:

{
  imports = [
    # Hier binden wir die Brave-Konfiguration modular ein
    ./applications/default.nix
  ];

  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  # Andere normale Apps, die keine eigene Config brauchen
  home.packages = with pkgs; [
    firefox
    htop
    fastfetch
    kdePackages.kate
    vscode
    vim
    git
  ];

   # Bash (oder zsh) konfigurieren und Aliase anlegen
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      rebuildNix = "sudo git add /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos/#nixos-laptop";
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "25.11";
}