#!/usr/bin/env bash

if [ -a /etc/timezone ]; then
  DETECTED_TZ=$(cat /etc/timezone)
elif [ -a /etc/localtime ]; then
  DETECTED_TZ=$(readlink /etc/localtime|sed -n 's|^.*zoneinfo/||p')
fi

while [ -z "${PSODOX_TZ}" ]; do
  if [ -z "${DETECTED_TZ}" ]; then
    read -p "Timezone: " -e PSODOX_TZ
  else
    read -p "Timezone [${DETECTED_TZ}]: " -e PSODOX_TZ
    [ -z "${PSODOX_TZ}" ] && PSODOX_TZ=${DETECTED_TZ}
  fi
done

cat << EOF > psodox.conf
# ------------------------------
# SQL database configuration
# ------------------------------

DBNAME=psodox
DBUSER=psodox

# Please use long, random alphanumeric strings (A-Za-z0-9)

DBPASS=$(LC_ALL=C </dev/urandom tr -dc A-Za-z0-9 2> /dev/null | head -c 28)
DBROOT=$(LC_ALL=C </dev/urandom tr -dc A-Za-z0-9 2> /dev/null | head -c 28)

# Your timezone
# See https://en.wikipedia.org/wiki/List_of_tz_database_time_zones for a list of timezones
# Use the column named 'TZ identifier' + pay attention for the column named 'Notes'

TZ=${PSODOX_TZ}
EOF