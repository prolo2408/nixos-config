{ pkgs, ... }: {
  programs.plasma = {
    enable = true;

    # Overrides manual KDE GUI changes. 
    # Set to false if you prefer configuring via the GUI and just want backups.
    overrideConfig = true; 

    panels = [
      {
        location = "top";
        floating = true;
        hiding = "autohide";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    shortcuts = {
      "kwin" = {
        "Firefox" = "Meta+F";
      };
      "services/org.kde.konsole.desktop" = {
        "_launch" = "Ctrl+Alt+T";
      };
    };
  };
}
