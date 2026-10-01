{
  networking.networkmanager.enable = true;

  # DNS: default to the homeserver's AdGuard Home over Tailscale (ad-blocking
  # + local resolution), falling back to Cloudflare if the tailnet/server is
  # unreachable. Needs systemd-resolved (below) so Tailscale can still split
  # off *.ts.net (MagicDNS) names to its own resolver instead of these.
  networking.nameservers = [
    "100.92.186.32" # nixos.tail70aa47.ts.net (homeserver AdGuard Home)
    "1.1.1.1" # Cloudflare fallback
  ];

  # Keep DHCP-provided nameservers out of resolved entirely so they can't
  # compete with the two above.
  networking.networkmanager.connectionConfig = {
    "ipv4.ignore-auto-dns" = true;
    "ipv6.ignore-auto-dns" = true;
  };

  services.resolved.enable = true;
}
