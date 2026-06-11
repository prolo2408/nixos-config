{ config, lib, pkgs, ... }:
{
  options.nixos.desktop.desktopEnvironment.plasma6 = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enable Plasma6 desktop environment.";
    };
  };

  config = {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    environment = {
      plasma6.excludePackages =
        with pkgs;
        with kdePackages;
        [
          breeze
          breeze-gtk
          breeze-icons
          elisa
          kwalletmanager
          oxygen
          oxygen-icons
          oxygen-sounds
          plasma-welcome
          plasma-workspace-wallpapers
        ];
      systemPackages =
        with pkgs;
        with kdePackages;
        [
          akonadi
          akonadi-calendar-tools
          bluedevil
          colord-kde
          filelight
          kaccounts-integration
          kaccounts-providers
          kate
          kdepim-addons
          kdeplasma-addons
          kcontacts
          konsole
          kpeople
          kpipewire
          libplasma
          merkuro
          plasma-activities
          plasma-activities-stats
          plasma-browser-integration
          plasma-desktop
          plasma-disks
          plasma-integration
          plasma-keyboard
          plasma-nm
          plasma-pa
          plasma-systemmonitor
          plasma-thunderbolt
          plasma-wayland-protocols
          plasma5support
          powerdevil
          print-manager
          spectacle
          systemsettings
        ];
    };
  };
}
