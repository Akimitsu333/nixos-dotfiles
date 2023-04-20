{ lib, config, pkgs, ... }:

{
  # PACKAGES & ENV
  environment.sessionVariables = {
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    EGL_PLATFORM = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
  };
  environment.localBinInPath = true;
}
