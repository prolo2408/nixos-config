{ config, pkgs, inputs, ... }:
{
  programs.browserpass.enable = true;
  programs.firefox = {
    enable = true;

    profiles.awiesner = {

      id = 0;

      bookmarks = {
        force = true;
        
        settings = [
          {
              name = "NixOS";
              toolbar = true;
              bookmarks = [
              {
                name = "Packages";
                url = "https://search.nixos.org/packages";
              }
              {
                name = "Manual";
                url = "https://nixos.org/manual/nixos/stable/";
              }
            ];
          }
        ];

       };

      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        bitwarden
        ublock-origin
      ];
    };
  };
}   