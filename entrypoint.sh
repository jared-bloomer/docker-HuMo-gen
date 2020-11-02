#!/bin/bash

/etc/init.d/mysql start
exec /usr/sbin/apache2ctl -D FORGROUND

exec "$@"
