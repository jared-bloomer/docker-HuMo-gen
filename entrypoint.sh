#!/bin/bash

/etc/init.d/mysql start
exec /usr/sbin/apache2ctl -D FORGROUND

while true; do
  sleep 10000
done

exec "$@"
