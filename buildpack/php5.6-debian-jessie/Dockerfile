FROM goodrainapps/debian:jessie-20171210

ENV PHPIZE_DEPS \
		autoconf \
		file \
		build-essential \
		pkg-config \
		re2c

RUN apt-get update && apt-get install -y \
		$PHPIZE_DEPS \
		ca-certificates \
		libedit2 \
		libsqlite3-0 \
		libxml2 \
		xz-utils \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

ENV BUILD_DIR=/opt/goodrain
ENV PHP_DIR=${BUILD_DIR}/php-fpm
ENV PHP_INI_DIR=$PHP_DIR/etc
RUN mkdir -p $PHP_INI_DIR/conf.d

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=rain --with-fpm-group=rain
ENV PHP_CFLAGS="-fstack-protector-strong -fpic -fpie -O2"
ENV PHP_CPPFLAGS="$PHP_CFLAGS"
ENV PHP_LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie"
ENV GPG_KEYS 0BD78B5F97500D450838F95DFE857D9A90D90EC1 6E4F6AB321FDC07F2C332E3AC2BF0BC433CFC8B3
ENV PHP_VERSION=5.6.32
ENV PHP_URL="https://secure.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror" PHP_ASC_URL="https://secure.php.net/get/php-$PHP_VERSION.tar.xz.asc/from/this/mirror"
ENV PHP_SHA256="8c2b4f721c7475fb9eabda2495209e91ea933082e6f34299d11cba88cd76e64b" PHP_MD5=""


RUN set -xe; \
	\
	fetchDeps=' \
		wget \
	'; \
	if ! command -v gpg > /dev/null; then \
		fetchDeps="$fetchDeps \
			dirmngr \
			gnupg \
		"; \
	fi; \
	apt-get update; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	rm -rf /var/lib/apt/lists/*; \
	\
	mkdir -p /usr/src; \
	cd /usr/src; \
	\
	wget -O php.tar.xz "$PHP_URL"; \
	\
	if [ -n "$PHP_SHA256" ]; then \
		echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -; \
	fi; \
	if [ -n "$PHP_MD5" ]; then \
		echo "$PHP_MD5 *php.tar.xz" | md5sum -c -; \
	fi; \
	\
	if [ -n "$PHP_ASC_URL" ]; then \
		wget -O php.tar.xz.asc "$PHP_ASC_URL"; \
		export GNUPGHOME="$(mktemp -d)"; \
		for key in $GPG_KEYS; do \
			gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
		done; \
		gpg --batch --verify php.tar.xz.asc php.tar.xz; \
		rm -rf "$GNUPGHOME"; \
	fi; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps

# ENV for nginx
ENV PCRE_VERSION=8.41
ENV ZLIB_VERSION=1.2.11
ENV OPENSSL_VERSION=1.1.0g
ENV NGINX_VERSION=1.12.2
ENV NGINX_DIR=${BUILD_DIR}/nginx
ENV DOWNLOAD_URL=https://pkg.goodrain.com/src/ngnix

# download nginx dependents src
RUN set -x \
    && curl -sk $DOWNLOAD_URL/pcre-$PCRE_VERSION.tar.gz | tar xz -C /tmp/ \
    && curl -sk $DOWNLOAD_URL/zlib-$ZLIB_VERSION.tar.gz | tar xz -C /tmp/ \
    && curl -sk $DOWNLOAD_URL/openssl-${OPENSSL_VERSION}.tar.gz | tar xz -C /tmp/ \
    && curl -sk $DOWNLOAD_URL/nginx-${NGINX_VERSION}.tar.gz | tar xz -C /tmp/

# for build env
ENV PATH=$PATH:$PHP_DIR/bin:${NGINX_DIR}/sbin

COPY docker-php-* /usr/local/bin/
COPY build.sh /

RUN chmod +x /build.sh

VOLUME [ "/opt/package" ]

CMD [ "/build.sh" ]