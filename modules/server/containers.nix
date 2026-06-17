# Isolierte Dienste. Jeder Dienst bekommt einen eigenen Port (bzw. eigenes Subnetz) -
# kommt ein weiterer Dienst dazu, einfach unten ergänzen, ohne die anderen anzufassen.

{ ... }:

{
  # ---- Vaultwarden: natives NixOS-Modul -> eigener NixOS-Container (systemd-nspawn)
  # mit eigenem /24-Netz und eigener IP. ----
  containers.vaultwarden = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.233.1.1";
    localAddress = "10.233.1.2";

    forwardPorts = [
      { containerPort = 8222; hostPort = 8222; protocol = "tcp"; }
    ];

    config = { ... }: {
      services.vaultwarden = {
        enable = true;
        config = {
          ROCKET_ADDRESS = "0.0.0.0";
          ROCKET_PORT = 8222;
          SIGNUPS_ALLOWED = false;
        };
      };

      networking.firewall.allowedTCPPorts = [ 8222 ];
      system.stateVersion = "25.11";
    };
  };

  # ---- Seafile: nixpkgs hat kein natives Modul, Seafile gibt es offiziell nur als
  # Docker-Image -> via Podman/oci-containers direkt auf dem Host, eigener Host-Port.
  # WICHTIG: Vor dem ersten Start die aktuellen ENV-Variablen/DB-Anforderungen des
  # "seafile-mc"-Images in der offiziellen Doku prüfen - neuere Versionen brauchen
  # ggf. eine externe MySQL-Datenbank statt der eingebauten.
  virtualisation.podman.enable = true;
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers.seafile = {
    image = "seafileltd/seafile-mc:latest";
    autoStart = true;
    ports = [ "8001:80" ];
    environment = {
      SEAFILE_SERVER_HOSTNAME = "seafile.prolo.me"; # anpassen
      SEAFILE_ADMIN_EMAIL = "awiesner@prolo.me";
      SEAFILE_ADMIN_PASSWORD = "admin";
    };
    volumes = [ "/var/lib/seafile-data:/shared" ];
  };

  # Host-seitige Ports der oben weitergeleiteten/gemappten Dienste freigeben.
  networking.firewall.allowedTCPPorts = [ 8222 8001 ];
}
