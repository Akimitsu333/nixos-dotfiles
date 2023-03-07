{ lib, config, pkgs, ... }:

let
  addpatches =
    path: (builtins.map
      (name: {
        inherit name;
        patch = "${path}/${name}";
      })
      (builtins.attrNames (builtins.readDir path)));
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
  users.users.akm.shell = pkgs.fish;

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
  #musnix.rtirq.enable = true;

  ## PATCHES
  boot.kernelPatches = addpatches ./patches ++ [
    {
      name = "xanmod-config";
      patch = null;
      extraConfig = ''
        TCP_CONG_BBR2 y
        DEFAULT_BBR2 y
      '';
    }
  ];

  # OPENGL & NVIDIA
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = with pkgs; [ vaapiVdpau ];
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
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  ## RT SOUND
  musnix.enable = true;
  musnix.soundcardPciId = "00:1f.3";

  # SECURITY
  security.tpm2.enable = true;
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
