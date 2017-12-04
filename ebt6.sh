#!/bin/sh

ROOT=/root

if test x"$1" == x"enable"; then
  $ROOT/nat6.sh disable
  $ROOT/odh6.sh disable

  uci set network.globals.ula_prefix=
  uci set network.wan6.proto=none
  uci set network.wan6.reqaddress=
  uci set network.wan6.reqprefix=
  uci commit network

  uci set dhcp.lan.ra_management=
  uci set dhcp.lan.dhcpv6=
  uci set dhcp.lan.ra=
  uci set dhcp.lan.ndp=
  uci commit dhcp

  if test -z "$(grep ebt6_enable /etc/firewall.user)"; then
    cat $ROOT/ebt6.firewall.user >> /etc/firewall.user
  fi

  touch /etc/ebt6_enable
elif test x"$1" == x"disable"; then
  rm /etc/ebt6_enable
else
  echo "Usage: xxx6.sh enable|disable"
fi

