#!/bin/bash

case $1 in
"php")
    /build-php.sh;;
"nginx")
    /build-nginx.sh;;
"all")
    /build-php.sh
    /build-nginx.sh;;
"debug")
    /bin/bash;;
esac
