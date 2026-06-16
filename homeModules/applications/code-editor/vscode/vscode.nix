{ config, pkgs, inputs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-marketplace; [
      bbenoist.nix
    ];
  };
}
