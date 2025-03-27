{
  imports = [
    ./audio.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services = {
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
