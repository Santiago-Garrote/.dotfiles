{
  networking.networkmanager.enable = true;

  # DNS: prefer the homeserver's AdGuard Home over Tailscale (ad-blocking +
  # local resolution), falling back to Cloudflare if the tailnet/server is
  # unreachable. Forced in because Tailscale's own DNS override
  # (--accept-dns, disabled in tailscale.nix) would otherwise take priority.
  networking.networkmanager.insertNameservers = [
    "100.92.186.32" # nixos.tail70aa47.ts.net (homeserver AdGuard Home)
    "1.1.1.1" # Cloudflare fallback
  ];

  # Drop DHCP-provided nameservers instead of just appending after ours.
  networking.networkmanager.connectionConfig = {
    "ipv4.ignore-auto-dns" = true;
    "ipv6.ignore-auto-dns" = true;
  };
}
