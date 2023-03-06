{ config, pkgs, ... }:

{
  systemd.services.v2raya = {
    enable = false;

    unitConfig = {
      Description = "v2rayA service";
      Documentation = "https://github.com/v2rayA/v2rayA/wiki";
      After = [ "network.target" "nss-lookup.target" "iptables.service" "ip6tables.service" ];
      Wants = [ "network.target" ];
    };

    serviceConfig = {
      User = "root";
      ExecStart = "${pkgs.unstable.v2raya}/bin/v2rayA --config /home/akm/.config/v2raya --log-disable-timestamp";
      LimitNPROC = 500;
      LimitNOFILE = 1000000;
      Environment = "V2RAYA_LOG_FILE=/var/log/v2raya/v2raya.log";
      Restart = "on-failure";
      Type = "simple";
    };

    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [ iptables bash iproute2 ]; # required by v2rayA TProxy functionality
  };

}
