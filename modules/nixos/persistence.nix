{ config, pkgs, ... }:

{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/bluetooth"
      "/var/lib/systemd"
      "/var/lib/containers"
      # "/var/lib/tailscale"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/etc/clash"
      # "/etc/secureboot"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.akm = {
      directories = [
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        #{ directory = ".local/share/Trash"; mode = "0700"; }
        ".config"
        ".mozilla"
        ".vscode-oss"
        ".local/share/bin"
        ".local/share/direnv"
        ".local/share/fonts"
        ".local/share/bottles"
        ".local/share/applications"
        ".local/share/TelegramDesktop"
        ".local/share/android"
        ".cache/blesh"
        "downloads"
        "documents"
        "desktop"
        "templates"
        "public"
        "music"
        "photos"
        "videos"
      ];
      files = [
        ".bash_history"
      ];
    };
  };

  environment.etc."xdg/user-dirs.defaults".text = ''
    DESKTOP=desktop
    DOWNLOAD=downloads
    TEMPLATES=templates
    PUBLICSHARE=public
    DOCUMENTS=documents
    MUSIC=music
    PICTURES=photos
    VIDEOS=videos
  '';

}
