FROM php:7.0-fpm-alpine

ENV PHALCON_VERSION=3.2.4
ENV PHALCON_DEV_TOOLS_VERSION=3.2.0

RUN addgroup -g 1000 -S devteam && \
    adduser -u 1000 -S devteam -G devteam
#RUN addgroup -S devteam && adduser -S -G devteam devteam

# Compile Phalcon
RUN set -xe && \
    # Add virtual packages. It will remove when done.
    apk add --no-cache --virtual .build-deps autoconf g++ make pcre-dev && \
    curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
    tar xzf v${PHALCON_VERSION}.tar.gz && cd cphalcon-${PHALCON_VERSION}/build && sh install && \
    docker-php-ext-enable phalcon && \
    cd ../.. && rm -rf v${PHALCON_VERSION}.tar.gz cphalcon-${PHALCON_VERSION} && \
    apk del .build-deps && \
    # Insall Phalcon Devtools, see https://github.com/phalcon/phalcon-devtools/
    curl -LO https://github.com/phalcon/phalcon-devtools/archive/v${PHALCON_DEV_TOOLS_VERSION}.tar.gz && \
    tar xzf v${PHALCON_DEV_TOOLS_VERSION}.tar.gz && \
    mv phalcon-devtools-${PHALCON_DEV_TOOLS_VERSION} /usr/local/phalcon-devtools && \
    ln -s /usr/local/phalcon-devtools/phalcon.php /usr/local/bin/phalcon

# install another packages
RUN apk --no-cache add \
  php7-dev \
  git \
  supervisor \
  libpng \
  libpng-dev \
  zlib-dev \
  curl \
  libcurl \
  curl-dev \
  libxslt-dev \
  libmcrypt-dev \
  nginx \
  && rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && chmod +x /usr/local/bin/composer

RUN docker-php-ext-install mysqli \
    pdo \
    pdo_mysql \
    gd \
    calendar \
    curl \
    zip \
    xsl \
    mbstring

COPY /etc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY /etc/config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY /etc/config/php/php-fpm.conf /usr/local/etc/php-fpm.conf 
RUN rm /var/www/html/*.gz

RUN mkdir -p /var/log/supervisor
RUN mkdir -p /var/run/supervisor
RUN mkdir -p /var/run/php-fpm
RUN mkdir -p /run/nginx

COPY project /var/www/html/

RUN chown -Rf devteam.devteam /var/www/html/

USER devteam

RUN cd /var/www/html/ && composer update
RUN cd /var/www/html/ && php artisan key:generate

USER root

ENTRYPOINT ["/usr/bin/supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf","--logfile", "/var/log/supervisor/supervisord.log","--pidfile", "/var/run/supervisor/supervisord.pid"]
