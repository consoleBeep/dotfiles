{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "512M";
              type = "EF02"; # For GRUB MBR.
            };

            ESP = {
              size = "18G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            luks = {
              size = "80%";
              content = {
                type = "luks";
                name = "luks_lvm";
                settings = {
                  allowDiscards = true;
                  crypttabExtraOpts = ["token-timeout=10"];
                };

                content = {
                  type = "lvm_pv";
                  vg = "nix";
                };
              };
            };
          };
        };
      };

      hdd = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "80%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/data";
              };
            };
          };
        };
      };
    };

    lvm_vg.nix = {
      type = "lvm_vg";
      lvs = {
        swap = {
          size = "18G";
          content = {
            type = "swap";
            resumeDevice = true;
          };
        };

        root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];
            subvolumes = {
              "/root" = {
                mountpoint = "/";
                mountOptions = ["compress=zstd" "noatime"];
              };
              "/nix" = {
                mountpoint = "/nix";
                mountOptions = ["compress=zstd" "noatime"];
              };
              "/home" = {
                mountpoint = "/home";
                mountOptions = ["compress=zstd" "noatime"];
              };
            };
          };
        };
      };
    };
  };
}
