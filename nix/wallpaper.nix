{
  gruvboxWallpapers = builtins.fetchGit {
    url = "https://github.com/AngelJumbo/gruvbox-wallpapers.git";
    shallow = true;
    rev = "1416589456265c4bb2b5a8973db749bcc30ff45c";
  };

  rosePineWallpapers = builtins.fetchGit {
    url = "https://github.com/p4rfait/rose-pine-wallpapers.git";
    shallow = true;
    rev = "6936d227ef540acde4e6a9d6f402de9698bdaf73";
  };

  rosePineWaybar = builtins.fetchGit {
    url = "https://github.com/rose-pine/waybar.git";
    shallow = true;
    rev = "d337e99fac6e6d46170f9ad91ef0d70cf6a872d7";
  };

}
