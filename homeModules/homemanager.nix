{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = { inherit inputs; };

    users.${config.nixos.system.user.defaultuser.name} = import ./default.nix;
  };

  programs.dconf.enable = true;
}
