# Host: nixos-laptop  (KDE Plasma 6)
{ userName, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop/plasma6.nix
    ../../modules/virtualisation.nix
  ];

  # Muss dem Flake-Attributnamen entsprechen (siehe flake.nix / rebuild-Alias).
  networking.hostName = "nixos-laptop";

  # Home-Manager: Plasma-Desktop-Konfiguration + GUI-Programme nur für diesen Host.
  home-manager.users.${userName}.imports = [
    ../../home/desktop/plasma.nix
    ../../home/applications
  ];
}
