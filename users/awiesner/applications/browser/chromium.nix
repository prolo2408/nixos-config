{ config, pkgs, ... }:

{
  # Chromium installieren
  programs.chromium = {
    enable = true;
  };
}
