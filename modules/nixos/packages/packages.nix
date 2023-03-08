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
    # wine
    wineWowPackages.waylandFull
    winetricks
    # Tools
    lsof
    wget
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

  programs = {
    gnupg.agent = {
      enable = true;
    };

    git = {
      enable = true;
      config = {
        user = {
          name = "Akimitsu";
          email = "2930255852@qq.com";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };

    fish = {
      enable = true;
      useBabelfish = true;
      shellInit = ''
        function fish_greeting
        echo Hello (whoami)!
        echo The time is (set_color yellow;date +%T;set_color normal) and this machine is called $hostname
        end
      '';
    };
  };
}
