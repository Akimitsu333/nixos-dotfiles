{ lib, config, pkgs, ... }:

{
  home.sessionVariables = {
    # Editor
    EDITOR = "hx";
    # VSCodium wayland
    NIXOS_OZONE_WL = 1;
  };
}
