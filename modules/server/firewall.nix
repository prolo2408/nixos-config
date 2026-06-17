# Firewall + Brute-Force-Schutz für SSH.
{ ... }:

{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  services.fail2ban = {
    enable = true;
    maxretry = 5;
  };
}
