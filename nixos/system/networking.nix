{ pkgs, ... }:

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

  # Global default; doesn't help on connection profiles that already carry
  # an explicit ipv4.ignore-auto-dns=false from before this was set (e.g.
  # saved Wi-Fi networks), which silently wins over this and lets that
  # network's own DNS back in as a competing default-route resolver in
  # resolved — which is what let ads back through AdGuard's blocklist.
  networking.networkmanager.connectionConfig = {
    "ipv4.ignore-auto-dns" = true;
    "ipv6.ignore-auto-dns" = true;
  };

  # Belt-and-suspenders for the above: on every interface except
  # tailscale0, strip whatever per-link DNS NetworkManager just registered
  # with resolved, so only the global servers above are ever eligible for
  # ordinary queries (tailscale0 keeps its own MagicDNS split untouched).
  networking.networkmanager.dispatcherScripts = [
    {
      type = "basic";
      source = pkgs.writeShellScript "revert-link-dns" ''
        PATH=${pkgs.systemd}/bin:$PATH
        [ "$1" = "tailscale0" ] && exit 0
        case "$2" in
          up | dhcp4-change | dhcp6-change) resolvectl revert "$1" ;;
        esac
      '';
    }
  ];

  services.resolved.enable = true;
}
