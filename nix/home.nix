{config, pkgs, nixgl, lib, ...} : 

let
  homeDir = "/home/mpatel";
  dotfilesDir = "${homeDir}/develop/dotfiles";

  # qtileEnv = pkgs.python314.withPackages (ps: [
  #   ps.qtile
  #   ps.qtile-extras
  # ]);

  wallpapers = import ./wallpaper.nix;
in

{
  
  home.stateVersion = "26.05";
  home.username = "mpatel";
  home.homeDirectory = "${homeDir}";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    initContent = ''
      alias hms="home-manager switch --flake ~/develop/dotfiles/nix#mpatel -b backup --show-trace"
      alias start-qtile="dbus-run-session qtile start -b wayland"
      alias pbcopy="wl-copy"
      alias pbpaste="wl-paste"
      alias v="nvim"
      command -v lsd > /dev/null && alias ls="lsd --group-dirs first"
      command -v lsd > /dev/null && alias tree="lsd --tree"
      alias l="ls -la"
      export BAT_THEME_DARK="ansi"
      export BAT_THEME_LIGHT="ansi"
      alias bat="bat --plain"
      command -v cat > /dev/null && alias cat="bat --pager=never"
      command -v less > /dev/null && alias less="bat"
      source <(fzf --zsh)
      eval "$(zoxide init zsh)"
      alias j="z"
      eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/prompt.json)"
    '';
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium
      { id = "noimedcjdohhokijigpfcbjcfcaaahej"; } # Rose pine theme
      # { id = "fjofdcgahcnlkdjapcbeonbnmjdnfcki"; } # Gruvbox
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
    monospace = ["GeistMono NFP SemiBold"];
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

    fontconfig
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.geist-mono
    # display stuff to be move to module 
    (config.lib.nixGL.wrap wezterm)
    # (config.lib.nixGL.wrap qtileEnv)
    (config.lib.nixGL.wrap hyprland)
    # xdg-desktop-portal
    # xdg-desktop-portal-wlr
    # xdg-desktop-portal-gtk

    # audio
    pavucontrol
    
    tmux
    cargo
    zoxide
    bat
    lsd
    delta
    wget
    wl-clipboard
    oh-my-posh
    fzf
    yazi
    obsidian
    waybar
    brightnessctl
  ];

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    GDK_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
    FONTCONFIG_PATH = "${homeDir}/.config/fontconfig";
    FONTCONFIG_FILE = "${homeDir}/.config/fontconfig/fonts.conf";
    EDITOR = "nvim";
    LANG = "en_CA.UTF-8";
  };

  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        duration = "5m";
        sorting = "random";
        path = "${homeDir}/Pictures/Wallpapers/rose-pine-wallpapers/irl";
      };
    };
  };

  home.file = {
    ".config/qtile" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/qtile";
    };

    ".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/hypr";
    };

    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/waybar";
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

    ".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/wezterm/wezterm.lua";
    };

    ".config/git/config" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/gitconfig/.gitconfig";
    };

    ".tmux/plugins/tpm" = {
      source = builtins.fetchGit {
        url = "https://github.com/tmux-plugins/tpm.git";
        shallow = true;
        rev = "e261deb1b47614eed3400089ce7197dc68acc4eb";
      };
    };

    ".config/oh-my-posh/prompt.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/oh-my-posh/prompt.json";
    };

    ".config/tmux" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/tmux";
    };

    ".config/scripts" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/scripts";
    };

    "Pictures/Wallpapers/gruvbox-wallpapers" = {
      source = "${wallpapers.gruvboxWallpapers}/wallpapers";
    };

    "Pictures/Wallpapers/rose-pine-wallpapers" = {
      source = "${wallpapers.rosePineWallpapers}/wallpapers";
    };

    "${dotfilesDir}/waybar/rose-pine" = {
      source = "${wallpapers.rosePineWaybar}";
    };
  };

}
