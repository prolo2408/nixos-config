{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./vscode/vscode.nix
    ./zed/zed.nix
  ];
}
