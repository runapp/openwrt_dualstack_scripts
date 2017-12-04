#!/bin/sh

ROOT=/root

if test x"$1" == x"enable"; then
  $ROOT/ebt6.sh disable
  $ROOT/nat6.sh disable

  uci set network.globals.ula_prefix=
  uci set network.wan6.proto="dhcpv6"
  uci set network.wan6.reqaddress=
  uci set network.wan6.reqprefix=
  uci commit network

  uci set dhcp.lan.ra_management='1'
  uci set dhcp.lan.dhcpv6='relay'
  uci set dhcp.lan.ra='relay'
  uci set dhcp.lan.ndp='relay'

  uci set dhcp.wan6.master='1'
  uci set dhcp.wan6.dhcpv6='relay'
  uci set dhcp.wan6.ra='relay'
  uci set dhcp.wan6.ndp='relay'
  uci commit dhcp

elif test x"$1" == x"disable"; then
  uci set dhcp.wan6.master=
  uci set dhcp.wan6.dhcpv6=
  uci set dhcp.wan6.ra=
  uci set dhcp.wan6.ndp=
  uci commit dhcp

else
  echo "Usage: xxx6.sh enable|disable"
fi
