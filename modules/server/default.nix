# Server-Grundausstattung: SSH, Firewall, isolierte Dienste per Container.
{ ... }:

{
  imports = [
    ./ssh.nix
    ./firewall.nix
    ./containers.nix
  ];
}
