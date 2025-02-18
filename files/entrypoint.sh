#!/bin/ash

ulimit -u unlimited

unbound -c /opt/unbound/unbound.conf
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start unbound: $status"
  exit $status
fi

/opt/adguardhome/AdGuardHome -c /opt/adguardhome/conf/AdGuardHome.yaml -w /opt/adguardhome/work --no-check-update
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start AdGuardHome: $status"
  exit $status
fi
