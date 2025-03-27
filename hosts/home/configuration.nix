{inputs, ...}: let
  hardware = inputs.nixos-hardware.nixosModules;
in {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix

    hardware.common-cpu-amd
  ];

  desktop.audio.pipewire.enable = true;
  nvidia.enable = true;

  gaming.enable = true;
}
