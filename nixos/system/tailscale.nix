{
  services.tailscale.enable = true;

  # Don't let Tailscale's MagicDNS stub (100.100.100.100) take over
  # /etc/resolv.conf — DNS servers are set explicitly in networking.nix
  # instead, so they fail over to Cloudflare when the tailnet is down.
  services.tailscale.extraSetFlags = [ "--accept-dns=false" ];
}
