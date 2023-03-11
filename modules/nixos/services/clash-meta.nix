{ config, pkgs, ... }:

{
  systemd.services.clash-meta = {
    enable = true;

    unitConfig = {
      Description = "Clash-Meta Daemon";
      Documentation = "https://github.com/MetaCubeX/Clash.Meta";
      After = [ "network.target" "NetworkManager.service" "systemd-networkd.service" "iwd.service" ];
    };

    serviceConfig = {
      User = "root";
      ExecStart = "${pkgs.clash-meta}/bin/clash-meta -d /etc/clash";
      LimitNPROC = 500;
      LimitNOFILE = 1000000;
      Restart = "on-failure";
      Type = "simple";
    };

    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [ iptables bash iproute2 ]; # required by TProxy functionality
  };

}
