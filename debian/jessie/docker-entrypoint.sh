#!/bin/bash

[[ $DEBUG ]] && set -x

case $1 in
"debug")
  /bin/bash;;
"version")
  echo "PHP:$PHP_VERSION"
  echo "Nginx: $APACHE_VERSION";;
*)
  exec $@
esac
