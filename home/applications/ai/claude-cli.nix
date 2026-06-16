{ pkgs, ... }: 

{
  programs.claude-code = {
    # Installiert das Paket 'pkgs.claude-code' automatisch
    enable = true;

    # Optionale MCP-Server (Model Context Protocol) deklarativ anlegen
    # Home Manager schreibt diese direkt in die Konfiguration
    # mcpServers = {
    #   nixos = {
    #     command = "uvx";
    #     args = [ "mcp-nixos" ];
    #   };
    # };
  };

  # Falls du MCP-Server mit 'uvx' nutzt, benötigst du das 'uv'-Paket im Profil
  home.packages = [
    pkgs.uv
  ];
}
