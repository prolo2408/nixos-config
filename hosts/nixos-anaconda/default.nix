# Host: nixos-anaconda  (Hyprland)
{ userName, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop/hyprland.nix
  ];

  # Muss dem Flake-Attributnamen entsprechen (siehe flake.nix / rebuild-Alias).
  networking.hostName = "nixos-anaconda";

  # Home-Manager: Hyprland-Konfiguration nur für diesen Host.
  home-manager.users.${userName}.imports = [ ../../home/desktop/hyprland.nix ];
}
