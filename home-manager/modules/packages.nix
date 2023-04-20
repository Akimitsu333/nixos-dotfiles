{ lib, config, pkgs, ... }:

{
  home.packages =
    with pkgs;
    [
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

  home.file =
    {
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
  programs.bash.historyIgnore =
    [
      "ls"
      "cd"
      "exit"
    ];

  programs.firefox.enable = true;
  programs.firefox.profiles.default =
    {
      search.force = true;
      search.default = "Bing";
      search.engines =
        {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            # icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            # iconUpdateURL = "https://nixos.wiki/favicon.png";
            # updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          # "Bing".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
        };
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
  programs.vscode.enableExtensionUpdateCheck = false;
  programs.vscode.enableUpdateCheck = false;
  # programs.vscode.mutableExtensionsDir = false;
  programs.vscode.extensions =
    with pkgs;
    [
      # Nix & Direnv
      vscode-extensions.arrterian.nix-env-selector
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.mkhl.direnv
      # C/C++
      vscode-extensions.llvm-vs-code-extensions.vscode-clangd
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-language-pack-zh-hans";
        publisher = "ms-ceintl";
        version = "1.64.3";
        sha256 = "sha256-irTSQcVXf/V3MuZwfx4tFcvBk+xhbFZTnb7IG28s/p4=";
      }
      {
        name = "github-vscode-theme";
        publisher = "github";
        version = "6.3.4";
        sha256 = "sha256-JbI0B7jxt/2pNg/hMjAE5pBBa3LbUdi+GF0iEZUDUDM=";
      }
      {
        name = "dot-icons";
        publisher = "anweber";
        version = "0.5.0";
        sha256 = "sha256-RKuLO0CN9TV67vIve0FZnEm/372q4tA5u3b6L4oiY+0=";
      }
      {
        name = "indenticator";
        publisher = "sirtori";
        version = "0.7.0";
        sha256 = "sha256-J5iNO6V5US+GFyNjNNA5u9H2pKPozWKjQWcLAhl+BjY=";
      }
      {
        name = "vsc-python-indent";
        publisher = "kevinrose";
        version = "1.18.0";
        sha256 = "sha256-hiOMcHiW8KFmau7WYli0pFszBBkb6HphZsz+QT5vHv0=";
      }
    ];

  programs.vscode.userSettings =
    {
      "workbench.iconTheme" = "dot_colored_root";
      "workbench.colorTheme" = "GitHub Dark";
      "window.titleBarStyle" = "custom";
      "workbench.startupEditor" = "none";
      "editor.formatOnSave" = "true";
    };

  programs.helix.enable = true;
  programs.helix.settings =
    {
      theme = "autumn";
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
      };
    };

}
