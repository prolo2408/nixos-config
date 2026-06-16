{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    # Home-Manager 25.11: Erweiterungen liegen jetzt unter profiles.<name>.
    profiles.default.extensions = with pkgs.vscode-marketplace; [
      bbenoist.nix
      anthropic.claude-code
    ];
  };
}
