{ config, pkgs, ... }:

{
  systemd.services.glances = {
    enable = true;

    unitConfig = {
      Description = "Glances Webserver Daemon";
      After = [ "network.target" "NetworkManager.service" "systemd-networkd.service" "iwd.service" ];
    };

    serviceConfig = {
      ExecStart = "${pkgs.glances}/bin/glances -w";
      Restart = "on-abort";
      RemainAfterExit = "yes";
      Type = "simple";
    };

    wantedBy = [ "multi-user.target" ];
  };

}
