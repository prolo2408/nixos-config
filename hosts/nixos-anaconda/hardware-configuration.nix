# ╔══════════════════════════════════════════════════════════════════════╗
# ║  PLATZHALTER – auf der echten Maschine "nixos-anaconda" ERSETZEN!      ║
# ║                                                                        ║
# ║  Das Original-Repo hatte nur EINE (laptop-spezifische) Hardware-Datei  ║
# ║  im Root, die fälschlich von beiden Hosts genutzt wurde. Hardware ist  ║
# ║  jetzt pro Host. Auf nixos-anaconda ausführen:                         ║
# ║                                                                        ║
# ║      sudo nixos-generate-config --show-hardware-config                 ║
# ║                                                                        ║
# ║  und die Ausgabe komplett hier einsetzen.                              ║
# ║                                                                        ║
# ║  Die UUIDs unten sind ABSICHTLICH ungültig, damit nichts versehentlich ║
# ║  auf ein falsches Gerät gebaut/gemountet wird.                         ║
# ╚══════════════════════════════════════════════════════════════════════╝
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-ROOT-UUID";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-BOOT-UUID";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
