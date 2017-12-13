#!/bin/bash

[[ $DEBUG ]] && set -x

cd /tmp/nginx-$NGINX_VERSION \
&& ./configure \
	--prefix=$NGINX_DIR \
    --with-http_ssl_module \
    --with-pcre=/tmp/pcre-$PCRE_VERSION \
    --with-zlib=/tmp/zlib-$ZLIB_VERSION \
    --with-openssl=/tmp/openssl-${OPENSSL_VERSION} \
&& make \
&& make install \
&& tar czvf /opt/package/nginx.tar.gz $NGINX_DIR \
&& echo "Nginx $NGINX_VERSION build completed successfully."