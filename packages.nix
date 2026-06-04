{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    firefox
    vscode
  ];
}
