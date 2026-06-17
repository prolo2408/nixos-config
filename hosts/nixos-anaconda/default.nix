# Host: nixos-anaconda  (Headless Server, kein Desktop-Environment)
{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/server
  ];

  # Muss dem Flake-Attributnamen entsprechen (siehe flake.nix / rebuild-Alias).
  networking.hostName = "nixos-anaconda";
}
