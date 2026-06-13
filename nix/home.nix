{config, pkgs, nixgl, lib, ...} : 

let
  homeDir = "/home/mpatel";
  dotfilesDir = "${homeDir}/develop/dotfiles";
in

{
  
  home.stateVersion = "26.05";
  home.username = "mpatel";
  home.homeDirectory = "${homeDir}";

  programs.home-manager.enable = true;

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium
      { id = "noimedcjdohhokijigpfcbjcfcaaahej"; } # Rose pine theme
    ];
  };

  targets.genericLinux.enable = true;

  targets.genericLinux.nixGL = {
    packages = nixgl.packages;
    defaultWrapper = "mesa";
    installScripts = ["mesa"];
  };

  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    monospace = ["Hurmit Nerd Font"];
  };

  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <include ignore_missing="yes">conf.d</include>
    </fontconfig>
  '';

  home.packages = with pkgs; [
    neovim
    go
    gcc
    btop
    ripgrep
    fastfetch

    fontconfig
    nerd-fonts.hurmit
    # display stuff to be move to module 
    (config.lib.nixGL.wrap ghostty)
    python314Packages.qtile
    python314Packages.qtile-extras
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
  ];

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    GDK_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "qtile";
    FONTCONFIG_PATH = "${homeDir}/.config/fontconfig";
    FONTCONFIG_FILE = "${homeDir}/.config/fontconfig/fonts.conf";
  };


  home.file = {
    ".config/qtile" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/qtile";
    };

    ".xinitrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/x11-config/xinitrc";
    };

    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/nvim";
    };

    ".config/ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/ghostty";
    };

    ".config/git/config" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/gitconfig/.gitconfig";
    };
  };

}
