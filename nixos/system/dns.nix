{ pkgs, ... }:

{
  # Global DNS: resolved's single upstream is a local dnsmasq forwarder
  # (below) that tries AdGuard Home over Tailscale first on every query,
  # falling through to Cloudflare per-query only if AdGuard doesn't answer.
  # Plain multi-server DNS= in resolved itself is "sticky" — once it fails
  # over to the second server (even from one transient blip) it doesn't
  # reliably switch back even after the first is healthy again, which is
  # what silently defeated AdGuard's ad-blocking after the fact.
  networking.nameservers = [ "127.0.0.1" ];

  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = false; # wired to systemd-resolved manually below
    settings = {
      listen-address = "127.0.0.1";
      bind-interfaces = true;
      no-resolv = true; # don't read /etc/resolv.conf (resolved's own stub) as an upstream
      strict-order = true; # always query servers in listed order, no racing/round-robin
      server = [
        "100.92.186.32" # nixos.tail70aa47.ts.net (homeserver AdGuard Home)
        "1.1.1.1" # Cloudflare fallback
      ];
    };
  };

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
  # with resolved, so only the local dnsmasq forwarder above is ever
  # eligible for ordinary queries (tailscale0 keeps its own MagicDNS split
  # untouched).
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
