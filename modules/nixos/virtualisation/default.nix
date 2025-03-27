{lib, ...}: {
  imports = [
    ./docker.nix
    ./qemu.nix
  ];

  docker.enable = lib.mkDefault true;
  qemu.enable = lib.mkDefault true;
}
