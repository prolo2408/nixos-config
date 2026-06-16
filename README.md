# nixos-config

Modulares Multi-Host NixOS-Flake mit Home-Manager.

- **nixos-laptop** – KDE Plasma 6 (SDDM/Wayland)
- **nixos-anaconda** – Hyprland

User: `awiesner`. Pins: `nixos-25.11` / `home-manager release-25.11` (unverändert aus dem Original übernommen, `flake.lock` identisch).

---

## Struktur

```
.
├── flake.nix                 # Inputs + mkHost (genAttrs über die Host-Liste)
├── flake.lock
├── modules/                  # SYSTEM-Module
│   ├── common.nix            #   für alle Hosts: Boot, Netzwerk, Locale, Tastatur,
│   │                         #   User, Nix-Settings, GC/Optimise, Basis-Pakete
│   └── desktop/
│       ├── plasma6.nix       #   System-Ebene KDE: SDDM + Paket-Include/Exclude
│       └── hyprland.nix      #   System-Ebene Hyprland
├── home/                     # HOME-MANAGER-Module
│   ├── home-manager.nix      #   NixOS <-> HM Verdrahtung
│   ├── default.nix           #   Basis-Home (stateVersion, Pakete, Imports)
│   ├── shell.nix             #   Bash + Aliase
│   ├── applications/
│   │   ├── default.nix
│   │   ├── browsers/         #   brave, firefox (+ optional chromium)
│   │   │   └── firefox/      #   firefox.nix + bookmarks.nix
│   │   └── editors/          #   vscode, zed
│   └── desktop/
│       ├── plasma.nix        #   plasma-manager-Konfiguration (nur Laptop)
│       └── hyprland.nix      #   Hyprland-Home-Konfiguration (nur anaconda)
└── hosts/
    ├── nixos-laptop/
    │   ├── default.nix       #   Hardware + plasma6 + plasma-Home + Hostname
    │   └── hardware-configuration.nix
    └── nixos-anaconda/
        ├── default.nix       #   Hardware + hyprland + hyprland-Home + Hostname
        └── hardware-configuration.nix   # PLATZHALTER – siehe unten
```

**Prinzip:** `modules/common.nix` und `home/home-manager.nix` gelten auf jedem Host.
Jeder Host fügt in `hosts/<name>/default.nix` nur noch seine Hardware, sein System-DE-Modul
und – über `home-manager.users.<user>.imports` – sein Home-DE-Modul hinzu.

---

## Was gegenüber dem Original geändert wurde

**Echte Bugfixes**

- `users/awiesner/default.nix` wurde **nirgends importiert** → Bash-Aliase und
  `programs.home-manager.enable` waren wirkungslos. Inhalt ist jetzt korrekt als
  `home/shell.nix` eingebunden.
- **Firefox-API auf 25.11 aktualisiert** (das Original baut auf dem aktuellen Pin nicht mehr):
  Lesezeichen jetzt `bookmarks = { force = true; settings = …; }`, Erweiterungen jetzt
  `extensions.packages = …`. Das fehlplatzierte `force = true` in `settings` wurde entfernt.
- **VSCode-API auf 25.11 aktualisiert:** `extensions` → `profiles.default.extensions`.
- **Hardware pro Host.** Vorher lag eine laptop-spezifische `hardware-configuration.nix`
  (feste UUIDs) im Root und wurde von *beiden* Hosts genutzt – für anaconda falsch.
- **Home-DE pro Host.** Vorher wurde die KDE/plasma-Home-Konfiguration über
  `homeModules` auf *jeden* Host gezwungen (auch auf den Hyprland-Host). Jetzt lädt jeder
  Host nur sein eigenes Desktop-Home-Modul.
- `programs.brave` hatte die Signatur `{ pkgs, fetchurl, … }` ohne Verwendung → bereinigt.

**Aufräumen / Struktur**

- Tippfehler `desktop-envirement` → konsistente Benennung (`desktop/`).
- Entfernt: `kde copy.nix` (Backup mit Leerzeichen im Namen), ungenutzte `macos-like.nix`,
  und die deklarierte, aber nie genutzte `nixos.desktop…plasma6`-Option.
- `home.stateVersion` und `nixpkgs.config.allowUnfree` standen mehrfach → je eine Quelle.
- `mkHost` nutzt `lib.genAttrs` statt `listToAttrs (map …)`.

**Quality of Life**

- `nix.gc` (wöchentlich, >14 Tage) und `nix.optimise.automatic`.
- `networking.hostName` pro Host gesetzt, passend zum Flake-Attribut. Dadurch funktioniert
  der generische Rebuild-Alias `nixos-rebuild switch --flake /etc/nixos#$(hostname)`
  auf beiden Maschinen (vorher war `#nixos-laptop` fest verdrahtet).

---

## Verwendung

```bash
# Repo nach /etc/nixos legen (oder symlinken) und bauen:
sudo nixos-rebuild switch --flake /etc/nixos#nixos-laptop
# bzw.
sudo nixos-rebuild switch --flake /etc/nixos#nixos-anaconda

# Mit gesetztem Hostnamen reicht der Alias:
rebuildNix      # baut die zum Hostnamen passende Konfiguration
updateNix       # flake update + rebuild
```

### Vor dem ersten Build auf nixos-anaconda

Die Datei `hosts/nixos-anaconda/hardware-configuration.nix` ist ein **Platzhalter** mit
absichtlich ungültigen UUIDs. Auf der echten Maschine:

```bash
sudo nixos-generate-config --show-hardware-config
```

…ausführen und die Ausgabe komplett in diese Datei einsetzen.

---

> Hinweis: In dieser Umgebung war kein `nix` verfügbar, daher konnte kein vollständiges
> `nix flake check` laufen. Die Modul-Struktur und die 25.11-API-Änderungen wurden gegen
> die Home-Manager-Quelle des Pins geprüft; ein lokales `nix flake check` vor dem
> Produktiv-Switch ist trotzdem empfehlenswert.
