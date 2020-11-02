#!/bin/bash
set -x 

is_IP() {
if [ $(echo $1 | grep -o '\.' | wc -l) -ne 3 ]; then
        echo "Parameter '$1' does not look like an IP Address (does not contain 3 dots).";
        exit 1;
elif [ $(echo $1 | tr '.' ' ' | wc -w) -ne 4 ]; then
        echo "Parameter '$1' does not look like an IP Address (does not contain 4 octets).";
        exit 1;
else
        for OCTET in $(echo $1 | tr '.' ' '); do
                if ! [[ $OCTET =~ ^[0-9]+$ ]]; then
                        echo "Parameter '$1' does not look like in IP Address (octet '$OCTET' is not numeric).";
                        exit 1;
                elif [[ $OCTET -lt 0 || $OCTET -gt 255 ]]; then
                        echo "Parameter '$1' does not look like in IP Address (octet '$OCTET' in not in range 0-255).";
                        exit 1;
                fi
        done
fi



return 0;
}

# Create Database
mysql -u root -e "create database $DBNAME"
mysql -u root -e "grant all privileges on $DBNAME.* to '$DBUSERNAME'@'$DBHOST' identified by '$DBPASS'"

# Validate IP
result2=$(is_IP $DBHOST)

# Update Humo-genealogy Config Files for Database
if [[ -z $result2 ]]; then
  sed -i -e '/^define("DATABASE_HOST"/s/localhost/'"$DBHOST"'/' /var/www/html/include/db_login.php
else
  sed -i -e '/^define("DATABASE_HOST"/s/localhost/'"$DBHOST"'/' /var/www/html/include/db_login.php
fi

sed -i -e '/^define("DATABASE_USERNAME"/s/root/'"$DBUSERNAME"'/' /var/www/html/include/db_login.php
sed -i -e 's/define("DATABASE_PASSWORD".*/define("DATABASE_PASSWORD", '\'''"$DBPASS"'\'\''\)\;/' /var/www/html/include/db_login.php
sed -i -e '/^define("DATABASE_NAME"/s/humo-gen/'"$DBNAME"'/' /var/www/html/include/db_login.php



