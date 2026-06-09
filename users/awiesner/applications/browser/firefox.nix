{ config, pkgs, inputs, ... }:
{
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;
    profiles.awiesner = {
      bookmarks = { };
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        bitwarden
      ]; 
    };
  };
}   