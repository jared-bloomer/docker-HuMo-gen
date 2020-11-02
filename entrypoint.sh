#!/bin/bash
set -x

/etc/init.d/mysql start 
/bin/bash /setupDB.sh 
/usr/sbin/apache2ctl -D FORGROUND

while true; do
  sleep 10000
done

exec "$@"
