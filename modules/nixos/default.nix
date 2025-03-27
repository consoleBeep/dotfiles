{
  lib,
  self,
  ...
}: let
  inherit (lib) mkDefault;
in {
  imports = [
    ./desktop
    ./nix
    ./virtualisation
    ./bootloader.nix
    ./btrfs.nix
    ./gaming.nix
    ./home-manager.nix
    ./language.nix
    ./misc.nix
    ./network-manager.nix
    ./nvidia.nix
    ./user.nix
  ];

  documentation.dev.enable = true;

  btrfs.enable = mkDefault true;
  network-manager.enable = mkDefault true;
  home-manager.enable = mkDefault true;

  system = {
    configurationRevision = self.shortRev or self.dirtyShortRev;
    stateVersion = mkDefault "24.11";
  };
}
