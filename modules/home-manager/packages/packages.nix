{ lib, config, pkgs, ... }:

{
  home.packages =
    with pkgs; [
      # APP
      glances
      bilibili
      tdesktop
      # LSP
      pyright
      rust-analyzer
      # nodePackages.vscode-langservers-extracted
      # yaml-language-server
      # nodePackages.stylelint
      # marksman
      # FMT
      nixpkgs-fmt
      # Tools
      fd
      ripgrep
      nvtop
    ];

  home.file = {
    ".mozilla/firefox/default/user.js".source = ../dot/firefox/chrome/firefox-gnome-theme/configuration/user.js;
    ".mozilla/firefox/default/chrome".source = ../dot/firefox/chrome;
    ".mozilla/firefox/default/chrome".recursive = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Akimitsu";
    userEmail = "2930255852@qq.com";
    signing.signByDefault = true;
    signing.key = "94D5832252ED35EF";
    extraConfig.safe.directory = "/etc/nixos";
  };

  programs.bash = {
    enable = true;
    historyIgnore = [
      "ls"
      "cd"
      "exit"
    ];
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
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
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn";
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
      };
    };
  };

}
