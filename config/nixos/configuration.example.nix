{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "media" ];
  boot.zfs.forceImportRoot = false;

  services.zfs.autoScrub = {
    enable = true;
    interval = "*-*-15 03:00:00";
    randomizedDelaySec = "0";
    pools = [ "media" ];
  };

  networking = {
    hostName = "homelab";
    useNetworkd = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 2222 3000 8096 9925 2049 ];
    };
    nameservers = [ "192.0.2.53" "1.1.1.1" ];
  };

  # Replace the interface and RFC 5737 example addresses for your network.
  systemd.network = {
    enable = true;
    wait-online.enable = false;
    networks."10-lan" = {
      matchConfig.Name = "enp1s0";
      address = [ "192.0.2.10/24" ];
      routes = [ { Gateway = "192.0.2.1"; } ];
      networkConfig.DNS = [ "192.0.2.53" "1.1.1.1" ];
    };
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.homelab = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "video" ];
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia-container-toolkit.enable = true;

  services.nfs.server = {
    enable = true;
    exports = ''/srv/media *(rw,sync,no_subtree_check)'';
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = { workgroup = "WORKGROUP"; security = "user"; };
      media = {
        path = "/srv/media";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
      };
    };
  };

  services.tailscale = { enable = true; openFirewall = true; };
  virtualisation.docker.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [ btop pciutils curl git vim wget docker-compose ];
  system.stateVersion = "26.05";
}
