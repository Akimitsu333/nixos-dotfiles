{ lib, config, pkgs, ... }:

{
  # ENV
  home.sessionVariables = rec {
    # Editor
    EDITOR = "hx";
    # VSCodium wayland
    NIXOS_OZONE_WL = 1;
  };

  # XDG DIR PATHS
  xdg.userDirs.enable = true;
  xdg.userDirs.desktop = "${config.home.homeDirectory}/desktop";
  xdg.userDirs.documents = "${config.home.homeDirectory}/documents";
  xdg.userDirs.download = "${config.home.homeDirectory}/downloads";
  xdg.userDirs.music = "${config.home.homeDirectory}/music";
  xdg.userDirs.pictures = "${config.home.homeDirectory}/photos";
  xdg.userDirs.publicShare = "${config.home.homeDirectory}/public";
  xdg.userDirs.templates = "${config.home.homeDirectory}/templates";
  xdg.userDirs.videos = "${config.home.homeDirectory}/videos";
}
