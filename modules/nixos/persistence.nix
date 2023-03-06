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
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
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
        #".cache"
        ".mozilla"
        ".vscode-oss"
        ".local/share/fish"
        ".local/share/direnv"
        ".local/share/TelegramDesktop"
        "downloads"
        "documents"
        "desktop"
        "templates"
        "public"
        "music"
        "photos"
        "videos"
        "bin"
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
