#!/bin/bash

IS_FIRST_RUN=$(cat /app/first-run-file 2>/dev/null)

cd /app/flash_cards

# If it's an empty file/result then it is our first run
if [[ -z $IS_FIRST_RUN ]]; then
  echo "FIRST RUN ENCOUNTERED. RUNNING migrate:fresh AND db:seed"
  echo "WAITING FOR DB HOST..."
  while ! mysqladmin ping -h"db" --silent; do
    echo "WAITING FOR DB HOST..."
    sleep 1
  done

  echo "RUNNING MIGRATE & SEED"
  php artisan migrate:fresh --force
  php artisan db:seed --force
  # Create the first-run-file so we don't run this shit again
  echo "1" > /app/first-run-file
fi


echo "RUNNING PHP-FPM8.1 ON CARDSSSSSSSS"
# if we doin' fpm+nginx
/usr/sbin/php-fpm8.1 --nodaemonize --fpm-config /etc/php/8.1/fpm/php-fpm.conf
# if we just doin' dumb
#php artisan serve --host=0.0.0.0