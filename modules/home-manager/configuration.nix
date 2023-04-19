{ lib, config, pkgs, ... }:

{
  # ENV
  home.sessionVariables = {
    # Editor
    EDITOR = "hx";
    # VSCodium wayland
    NIXOS_OZONE_WL = 1;
    # Android SDK
    ANDROID_SDK_ROOT = "${androidsdk}/libexec/android-sdk";
    ANDROID_NDK_ROOT = "${ANDROID_SDK_ROOT}/ndk-bundle";
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
