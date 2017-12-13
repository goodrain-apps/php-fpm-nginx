FROM goodrainapps/debian:jessie-20171210
LABEL MAINTAINER="zhouyq@goodrain.com"


ENV NGINX_DIR=/opt/goodrain/nginx
ENV NGINX_VERSION=1.12.2
ENV PHP_VERSION=5.6.32
ENV PHP_DIR=/opt/goodrain/php-fpm
ENV PATH=$PATH:${NGINX_DIR}/sbin:${PHP_DIR}/bin:${PHP_DIR}/sbin
ENV DOWNLOAD_URL=https://pkg.goodrain.com/grstack/debian

RUN apt-get update \
    && apt-get install -y libxml2 libedit2 \
    libpng12-dev libjpeg62-turbo-dev \
    libfreetype6-dev libmcrypt-dev --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

RUN set -x\
    && curl -k ${DOWNLOAD_URL}/nginx-${NGINX_VERSION}-jessie.tar.gz | tar xz -C / \
    && curl -k ${DOWNLOAD_URL}/php-fpm-${PHP_VERSION}-jessie.tar.gz | tar xz -C /

RUN set -x \
    && mkdir -p /app \
    && echo "<?php\nphpinfo();\n?>" > /app/index.php

EXPOSE 80

VOLUME [ "/data" ]

COPY docker-entrypoint.sh /
ADD php/etc $PHP_DIR/etc
ADD nginx/conf $NGINX_DIR/conf

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "start" ]
