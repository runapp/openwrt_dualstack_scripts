# openwrt_dualstack_scripts
Three common ways to deal with dual stack networks on openwrt, including ebtables (layer2 passthrough), odhcpd and nat6 (nat66, similar to classic ipv4 nat)

## Usage
Copy them to anywhere you want on the router. Run one of the `.sh` file after booting, or add it to `rc.local`.
Each `.sh` file among the three will disable the other two automatically when called with `---.sh enable`.
Check the code for more details.

## ebtables
Bridge the WAN and LAN port, and uses ebtables to block any non-ipv6 packets between them.

## odhcpd
Suggested by OpenWRT. May not work if your ISP's device doesn't follows the IPv6 standards well.

## nat6
Anti the concept of IPv6, but really stable. Last method.
