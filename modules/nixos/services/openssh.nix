{ lib, config, pkgs, ... }:

{
  # SERVICES
  services.openssh = {
    enable = true;
    settings = {
      permitRootLogin = "no";
    };
  };
}
