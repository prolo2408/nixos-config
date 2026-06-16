{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "python"
      "git-firefly"  # Git-Integration (Blame, Diff, etc.)
    ];

    userSettings = {
      # KI: Claude als Assistant
      assistant = {
        enabled = true;
        version = "2";
        default_model = {
          provider = "anthropic";
          model = "claude-sonnet-4-5";
        };
      };

      # Terminal
      terminal = {
        shell = { program = "bash"; };
        font_size = 13;
      };

      # Git
      git = {
        inline_blame = {
          enabled = true;
        };
      };

      # Python
      lsp = {
        pyright = {
          binary = {
            path = "${pkgs.pyright}/bin/pyright-langserver";
          };
        };
      };

      # Nix
      nix = {
        lsp = {
          binary = {
            path = "${pkgs.nixd}/bin/nixd";
          };
        };
      };

      # Allgemein
      ui_font_size = 14;
      buffer_font_size = 13;
      theme = "One Dark";
      format_on_save = "on";
    };
  };

  home.packages = with pkgs; [
    nixd
    nixpkgs-fmt
    pyright
  ];
}
