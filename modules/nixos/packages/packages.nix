{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Gnome Theme
    kora-icon-theme
    bibata-cursors
    gnome.gnome-tweaks
    gnomeExtensions.wallpaper-switcher
    gnomeExtensions.transparent-top-bar-adjustable-transparency
    gnomeExtensions.no-activities-button
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.openweather
    gnomeExtensions.keep-awake
    # gnomeExtensions.tailscale-status
    gnomeExtensions.gtk4-desktop-icons-ng-ding
    # wine
    unstable.bottles
    # Tools
    lsof
    wget
    unstable.blesh
    unstable.clash-meta
  ];
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    yelp
    gnome-contacts
    gnome-maps
    gnome-weather
    cheese # webcam tool
    gnome-music
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  programs.gnupg.agent.enable = true;

  programs.git.enable = true;
  programs.git.config = {
    user = {
      name = "Akimitsu";
      email = "2930255852@qq.com";
    };
    init = {
      defaultBranch = "main";
    };
  };

  programs.bash.interactiveShellInit = ''
    source ${pkgs.blesh}/share/ble.sh
  '';
  # bash.blesh.enable = true; # NixOS 23.05

  # nix-index.enable = true; # NixOS 23.05
  programs.command-not-found.enable = false;

  programs.adb.enable = true;
}
