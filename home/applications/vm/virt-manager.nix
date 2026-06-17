# virt-manager GUI fürs Testen von Configs (z.B. der Server-Config) in einer VM.
# Der eigentliche libvirtd-Dienst läuft systemseitig (modules/virtualisation.nix).
{ pkgs, ... }:

{
  home.packages = [ pkgs.virt-manager ];
}
