# Shell + Aliase.
# (Vorher in users/awiesner/default.nix – diese Datei wurde nirgends importiert,
#  die Aliase waren also wirkungslos. Jetzt korrekt eingebunden.)
{ ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";

      # Baut automatisch die zum aktuellen Hostnamen passende Konfiguration.
      # Funktioniert, weil networking.hostName pro Host = Flake-Attributname gesetzt ist.
      rebuildNix = "sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)";

      # Inputs aktualisieren und neu bauen.
      updateNix = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)";
    };
  };
}
