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
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "boot";
              size = "1GB";
              type = "EF00"; # EFI System Partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                label = "boot";
                options = [
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            }
            {
              name = "swap";
              size = "8GB";
              type = "8200"; # Linux Swap
              content = {
                type = "swap";
                label = "swap";
              };
            }
            {
              name = "root";
              size = "100%"; # Remaining space
              type = "8300"; # Linux Filesystem
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                label = "nixos";
              };
            }
          ];
        };
      };
    };
  };
}
