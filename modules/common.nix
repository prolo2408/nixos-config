# Gemeinsame System-Konfiguration für ALLE Hosts.
# Host-spezifisches (Hardware, Desktop, Hostname) liegt in hosts/<name>/.
{ pkgs, inputs, userName, ... }:

{
  imports = [ ./nix-ld.nix ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "librewolf-151.0.2-1"
    "librewolf-unwrapped-151.0.2-1"
  ];
  nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Netzwerk
  networking.networkmanager.enable = true;

  # Zeitzone
  time.timeZone = "Europe/Berlin";

  # Lokalisierung
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Tastaturlayout (X11/Wayland + Konsole)
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  console.keyMap = "de";

  # Benutzerkonto. Passwort einmalig mit `passwd` setzen.
  users.users.${userName} = {
    isNormalUser = true;
    description = "Artur Wiesner";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Flakes & nix-command aktivieren
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatische Garbage Collection + Store-Optimierung (Quality of Life)
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;

  # System-weite Basis-Pakete (Desktop-Pakete liegen pro DE-Modul)
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  # NICHT ÄNDERN: legt den Release-Stand für stateful Daten fest.
  system.stateVersion = "25.11";
}
