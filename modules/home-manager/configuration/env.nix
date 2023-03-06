{ lib, config, pkgs, ... }:

{
  home.sessionVariables = {
    # Editor
    EDITOR = "hx";
    # VSCodium wayland
    NIXOS_OZONE_WL = 1;
    # Firefox Acclaration
    MOZ_DISABLE_RDD_SANDBOX = 1;
    EGL_PLATFORM = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
