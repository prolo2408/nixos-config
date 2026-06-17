# VM-Hosts zum Testen von Configs (z.B. der Server-Config).
# Das virt-manager GUI selbst kommt per Home-Manager (siehe home/applications/vm).
#
# VirtualBox liefert Kernel-Modul (vboxdrv) + GUI als ein Paket - das kann nur
# system-seitig aktiviert werden, nicht per Home-Manager.
{ userName, ... }:

{
  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;

  users.users.${userName}.extraGroups = [ "libvirtd" "vboxusers" ];
}
