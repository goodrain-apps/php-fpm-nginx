#!/bin/bash

[[ $DEBUG ]] && set -x

function start-php-fpm(){
  echo -e "Start php-fpm in background."
  php-fpm &
}

function start-nginx(){
  echo -e "Start nginx in foreground...\n"
  nginx -g 'daemon off;'
}

case $1 in
"debug")
  /bin/bash;;
"version")
  echo "PHP: $PHP_VERSION"
  echo "Nginx: $NGINX_VERSION";;
"start")
  start-php-fpm
  start-nginx;;
esac
