# ============================================================
# PURPOSE:   Declarative disk partitioning for host 'unknown'.
# SCOPE:     host
# DEPENDS:   inputs.disko
# AGENT:     Update this if the physical disk layout changes.
# ============================================================
{
  disks ? [ "/dev/nvme0n1" ],
  ...
}:
{
  disko.devices = {
    disk = {
      main = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1G";
              type = "EF00"; # EFI System Partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            };
            swap = {
              size = "8G";
              type = "8200"; # Linux Swap
              content = {
                type = "swap";
              };
            };
            root = {
              size = "100%";
              type = "8300"; # Linux Filesystem
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
