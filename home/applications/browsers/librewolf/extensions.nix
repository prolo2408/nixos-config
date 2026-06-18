{ pkgs, inputs }:

with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
[
  ublock-origin
  bitwarden
  multi-account-containers
]
