{
  services.tailscale.enable = true;

  # With systemd-resolved enabled (dns.nix), Tailscale registers
  # MagicDNS (*.ts.net) as a split-DNS route scoped to the tailscale0
  # interface via resolved, instead of taking over all of /etc/resolv.conf.
  # So *.ts.net names resolve through Tailscale while everything else still
  # goes to the AdGuard Home / Cloudflare servers set in dns.nix.
  services.tailscale.extraSetFlags = [ "--accept-dns=true" ];
}
