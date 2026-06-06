{ pkgs, ... }:

{
  # 1. Brave installieren
  home.packages = with pkgs; [
    brave
  ];

  # 2. Erweiterungen aktivieren
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };

  # 3. KORREKTUR: Die Richtlinie direkt in den Brave-spezifischen Ordner legen
  home.file.".config/BraveSoftware/Brave-Browser/policies/managed/bookmarks.json".text = builtins.toJSON {
    "ManagedBookmarks" = [
      {
        "toplevel_name" = "Meine Lesezeichen";
      }
      {
        "name" = "GitHub";
        "url" = "https://github.com";
      }
      {
        "name" = "NixOS Packages";
        "url" = "https://search.nixos.org/packages";
      }
    ];
  };
}