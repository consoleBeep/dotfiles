{
  userInfo,
  pkgs,
  ...
}: {
  imports = [
    ./desktop
    ./terminal
  ];

  home = {
    inherit (userInfo) username;
    homeDirectory = "/home/${userInfo.username}";

    packages = with pkgs; [
      man-pages
      man-pages-posix
      qbittorrent
      wget
      jq
      teams-for-linux
      bitwarden
      mpv
      mit
      calculator
      copy-file
      libreoffice-fresh
    ];

    stateVersion = "24.11";
  };

  programs = {
    home-manager.enable = true;
    man.generateCaches = true;
  };

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";
}
