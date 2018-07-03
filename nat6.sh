#!/bin/sh

ROOT=/root

if test ! -e /etc/init.d/nat6; then
  cp nat6 /etc/init.d/nat6
  chmod 755 /etc/init.d/nat6
fi

if test x"$1" == x"enable"; then
  $ROOT/ebt6.sh disable
  $ROOT/odh6.sh disable

  uci set network.globals.ula_prefix="$(uci get network.globals.ula_prefix | sed 's/^./d/')"
  uci set network.wan6.proto="dhcpv6"
  uci set network.wan6.reqaddress=
  uci set network.wan6.reqprefix=
  uci commit network

  uci set dhcp.lan.ra_management='1'
  uci set dhcp.lan.dhcpv6='server'
  uci set dhcp.lan.ra='server'
  uci set dhcp.lan.ndp=

  uci set dhcp.lan.ra_default='1'
  uci commit dhcp

  uci set firewall.@rule["$(uci show firewall | grep 'Allow-ICMPv6-Forward' | cut -d'[' -f2 | cut -d']' -f1)"].enabled='0'
  uci commit firewall

  /etc/init.d/nat6 enable
elif test x"$1" == x"disable"; then
  uci set dhcp.lan.ra_default=
  uci commit dhcp

  uci set firewall.@rule["$(uci show firewall | grep 'Allow-ICMPv6-Forward' | cut -d'[' -f2 | cut -d']' -f1)"].enabled='1'
  uci commit firewall

  /etc/init.d/nat6 disable
else
  echo "Usage: xxx6.sh enable|disable"
fi
