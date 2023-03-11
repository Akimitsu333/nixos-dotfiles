# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "none";
      fsType = "tmpfs";
      neededForBoot = true;
      options = [ "size=30G" "mode=755" ];
    };

  fileSystems."/home/akm" =
    {
      device = "none";
      fsType = "tmpfs";
      neededForBoot = true;
      options = [ "size=10G" "mode=777" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/2EB5-1F09";
      fsType = "vfat";
      neededForBoot = true;
      options = [ "noatime" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/b81a931a-7586-40c9-9d46-dea1da0938b0";
      fsType = "f2fs";
      neededForBoot = true;
      options = [ "compress_algorithm=zstd:6" "compress_chksum" "atgc" "gc_merge" "lazytime" ];
    };

  fileSystems."/run/win" =
    {
      device = "/dev/nvme0n1p4";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "noatime" "prealloc" "noauto" ];
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/d84531c4-9ed1-4bf5-9738-01832e9a6e07"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
