# MediaVault: A Privacy-First Docker Homelab

A self-hosted home platform for media, downloads, and automation—built to keep data on hardware I control.

## Mission

MediaVault centralizes a growing personal media library and makes it available at home through Jellyfin. Docker keeps services isolated, reproducible, and easier to maintain, while automated tools handle routine acquisition and processing.

The goal is to replace scattered subscriptions, cloud dependencies, and fragile one-off setups with a private system that I can understand, repair, and evolve over time.

## Configuration examples

- [Docker Compose stack](config/docker/compose.example.yml)
- [NixOS configuration](config/nixos/configuration.example.nix)
- [NixOS hardware template](config/nixos/hardware-configuration.example.nix)

These examples are intentionally sanitized. They contain no working credentials, real IP addresses, hostnames, user paths, device IDs, storage UUIDs, or personal media paths. They are for reference, not a ready-to-run deployment.

## What runs here

- **Jellyfin** for local media streaming
- **Docker** for service isolation and repeatable deployments
- **Automation services** for media and library workflows
- **Dedicated local storage** for the collection

---

Built as an ongoing home-lab project by [Morack18](https://github.com/Morack18).
