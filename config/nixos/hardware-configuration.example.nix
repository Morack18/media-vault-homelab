# Example only. Regenerate this file with nixos-generate-config for your host.
{ lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  boot.initrd.availableKernelModules = [ "virtio_pci" "virtio_scsi" "sd_mod" ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/REPLACE-WITH-YOUR-UUID";
    fsType = "ext4";
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
