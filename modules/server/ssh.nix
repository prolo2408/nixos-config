# SSH-Zugang für den Server. Login per Passwort (bestehender User, siehe modules/common.nix),
# nur Root-Login per SSH ist deaktiviert.
{ ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };
}
