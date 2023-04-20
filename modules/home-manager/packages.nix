{ lib, config, pkgs, ... }:

{
  home.packages =
    with pkgs; [
      # APP
      htop
      bilibili
      tdesktop

      unstable.qq
      unstable.wpsoffice-cn
      unstable.motrix
      unstable.androidStudioPackages.beta
      # Tools
      fd
      ripgrep
    ];

  home.file = {
    ".mozilla/firefox/default/user.js".source = ./dot/firefox/chrome/firefox-gnome-theme/configuration/user.js;
    ".mozilla/firefox/default/chrome".source = ./dot/firefox/chrome;
    ".mozilla/firefox/default/chrome".recursive = true;
  };

  programs.java.enable = true;
  # programs.java.package = pkgs.oraclejdk;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.git.enable = true;
  programs.git.userName = "Akimitsu";
  programs.git.userEmail = "2930255852@qq.com";
  programs.git.signing.signByDefault = true;
  programs.git.signing.key = "94D5832252ED35EF";
  programs.git.extraConfig.safe.directory = "/etc/nixos";

  programs.bash.enable = true;
  programs.bash.historyIgnore = [
    "ls"
    "cd"
    "exit"
  ];

  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox-esr;
  programs.firefox.profiles.default = {
    settings = {
      "layout.frame_rate" = 144;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "svg.context-properties.content.enabled" = true;
      "layers.acceleration.force-enabled" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "media.rdd-ffmpeg.enabled" = true;
      "gfx.x11-egl.force-enabled" = true;
    };
  };

  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscodium;

  programs.helix.enable = true;
  programs.helix.settings = {
    theme = "autumn";
    keys.normal = {
      space.space = "file_picker";
      space.w = ":w";
      space.q = ":q";
    };
  };

}
