{ lib, config, pkgs, ... }:

let
  _patchStruct = path: name: { inherit name; patch = ./patches/${path}/${name}; };
  _patchesNames = path: builtins.attrNames (builtins.readDir ./patches/${path});
  _addPatches = path: builtins.map (_patchStruct path) (_patchesNames path);
  addPatches = paths: builtins.concatLists (builtins.map _addPatches paths);
in
{
  # USERS
  users.users.root.initialHashedPassword = "$6$bYTC78xpdSeyP.zz$9Iha3BmQssdn7oKowzX14cvL8srolQLfjzKqUQ0FqJcID3TOm0L5VP69ok4JqLjcn9ee/FVnVxu.RC/xycOZC/";
  users.users.akm.initialHashedPassword = "$6$bYTC78xpdSeyP.zz$9Iha3BmQssdn7oKowzX14cvL8srolQLfjzKqUQ0FqJcID3TOm0L5VP69ok4JqLjcn9ee/FVnVxu.RC/xycOZC/";
  users.users.akm.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHhgRKKn7yq0gAIR9RxevUq7BPDWpCO9iAU56t6+oaEn7MUQxfh6jbGHLsSm2oAgGVwPgTn2MFzUx8PVaBNxZHQ= u0_a311@localhost"
  ];
  users.users.akm.extraGroups = [ "wheel" "audio" "video" "networkmanager" ];
  users.users.akm.isNormalUser = true;
  #users.users.akm.shell = pkgs.fish;

  # BOOT
  boot.loader.timeout = 1;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.plymouth.enable = true;
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelParams = [ "quiet" "splash" "udev.log_level=3" "rootflags=atgc" ];

  ## RT PATCH
  musnix.kernel.realtime = true;
  musnix.rtirq.enable = true;

  ## PATCHES
  boot.kernelPatches = [
    {
      name = "xanmod-config";
      patch = null;
      extraConfig = ''
        TCP_CONG_BBR2 y
        DEFAULT_BBR2 y
      '';
    }
  ] ++ addPatches [
    "bbr2"
    #"wine"
    "clearlinux"
    #"xanmod"
  ];

  ## NORMAL KERNEL
  specialisation.normal-kernel.configuration = {
    system.nixos.tags = [ "laptop" ];
    musnix.kernel.realtime = lib.mkForce false;
    musnix.rtirq.enable = lib.mkForce false;
    boot.kernelPatches = lib.mkForce [ ];
    hardware.nvidia.powerManagement.enable = true;
  };

  # OPENGL & NVIDIA
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiVdpau ];
  #hardware.nvidia.open = true;
  hardware.nvidia.nvidiaSettings = false;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;


  # I18N
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ libpinyin ];


  # FONTS
  fonts.enableDefaultFonts = true;
  fonts.fontconfig.defaultFonts.monospace = [ "JetBrainsMono Nerd Font" "Noto Sans CJK SC" "Noto Color Emoji" ];
  fonts.fontconfig.defaultFonts.serif = [ "Noto Serif" "Noto Color Emoji" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Noto Sans" "Noto Sans CJK SC" "Noto Color Emoji" ];
  fonts.fontconfig.defaultFonts.emoji = [ "Noto Color Emoji" ];
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    twemoji-color-font
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  # ZSwap
  zramSwap.enable = true;
  zramSwap.algorithm = "lz4";

  # SOUND
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  services.pipewire.config.pipewire = {
    "context.properties" = {
      "link.max-buffers" = 16;
      "log.level" = 2;
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 128;
      "default.clock.min-quantum" = 128;
      "default.clock.max-quantum" = 8192;
      "core.daemon" = true;
      "core.name" = "pipewire-0";
    };
    "context.modules" = [
      {
        name = "libpipewire-module-rtkit";
        args = {
          "nice.level" = -15;
          "rt.prio" = 88;
          "rt.time.soft" = 200000;
          "rt.time.hard" = 200000;
        };
        flags = [ "ifexists" "nofail" ];
      }
      { name = "libpipewire-module-protocol-native"; }
      { name = "libpipewire-module-profiler"; }
      { name = "libpipewire-module-metadata"; }
      { name = "libpipewire-module-spa-device-factory"; }
      { name = "libpipewire-module-spa-node-factory"; }
      { name = "libpipewire-module-client-node"; }
      { name = "libpipewire-module-client-device"; }
      {
        name = "libpipewire-module-portal";
        flags = [ "ifexists" "nofail" ];
      }
      {
        name = "libpipewire-module-access";
        args = { };
      }
      { name = "libpipewire-module-adapter"; }
      { name = "libpipewire-module-link-factory"; }
      { name = "libpipewire-module-session-manager"; }
    ];
  };
  services.pipewire.config.pipewire-pulse = {
    "context.properties" = {
      "log.level" = 2;
    };
    "context.modules" = [
      {
        name = "libpipewire-module-rtkit";
        args = {
          "nice.level" = -15;
          "rt.prio" = 88;
          "rt.time.soft" = 200000;
          "rt.time.hard" = 200000;
        };
        flags = [ "ifexists" "nofail" ];
      }
      { name = "libpipewire-module-protocol-native"; }
      { name = "libpipewire-module-client-node"; }
      { name = "libpipewire-module-adapter"; }
      { name = "libpipewire-module-metadata"; }
      {
        name = "libpipewire-module-protocol-pulse";
        args = {
          "pulse.min.req" = "128/48000";
          "pulse.default.req" = "128/48000";
          "pulse.max.req" = "8192/48000";
          "pulse.min.quantum" = "128/48000";
          "pulse.max.quantum" = "8192/48000";
          "server.address" = [ "unix:native" ];
        };
      }
    ];
    "stream.properties" = {
      "node.latency" = "128/48000";
      "resample.quality" = 1;
    };
  };

  ## RT SOUND
  musnix.enable = true;
  musnix.soundcardPciId = "00:1f.3";

  # SECURITY
  security.tpm2.enable = true;
  security.sudo.execWheelOnly = true;
  security.sudo.wheelNeedsPassword = false;

  # NETWORKING
  networking.hostName = "akimitsu";
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 53 ];

  # GNOME
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  # AUTOLOGIN
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "akm";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
