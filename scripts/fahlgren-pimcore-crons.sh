#!/usr/bin/env bash

if [ ! -d /etc/cron.d ]; then
    mkdir /etc/cron.d
fi

SITE_DOMAIN=$1
SITE_PUBLIC_DIRECTORY=$2

# Skip first two arguments
shift
shift

cron_commands=(["clear_cache"]="rm -rf")

for i in "$@"
do
  name="$(echo $i | cut -d ':' -f1 )"
  freq=$(awk -F: '{print $2}' <<< $i)

  cron="$freq vagrant ${cron_commands[$name]} $SITE_PUBLIC_DIRECTORY/../var/cache/"

  echo "$cron" > "/etc/cron.d/$SITE_DOMAIN"
done
