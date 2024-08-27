{
  lib,
  osOptions,
  ...
}: {
  config = lib.mkIf osOptions.qemu.enable {
    dconf.settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
