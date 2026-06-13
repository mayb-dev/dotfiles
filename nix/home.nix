{config, pkgs, nixgl, ...} : 

let
  dotfilesDir = "/home/mpatel/develop/dotfiles";
in

{
  
  home.stateVersion = "26.05";
  home.username = "mpatel";
  home.homeDirectory = "/home/mpatel";

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

  home.packages = with pkgs; [
    neovim
    btop
    fastfetch
    (config.lib.nixGL.wrap ghostty)
    python314Packages.qtile
    python314Packages.qtile-extras
  ];


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
