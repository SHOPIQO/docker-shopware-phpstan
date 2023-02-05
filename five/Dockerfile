ARG PHP_VERSION=8.0
ARG SHOPWARE_VERSION=6.4.0.0

FROM webdevops/php:${PHP_VERSION}-alpine

ARG SHOPWARE_VERSION

ENV COMPOSER_VERSION=2
ENV PHP_MEMORY_LIMIT=4G
ENV PHP_MAX_EXECUTION_TIME=600
ENV PHP_DISPLAY_ERRORS=1
ENV PHP_DISPLAY_STARTUP_ERRORS=1
ENV PHP_ERROR_REPORTING=E_ALL

COPY ./entrypoint.sh /entrypoint.sh

USER application

WORKDIR /home/application

RUN \
    set -e \
    && wget \
        -v \
        -O /tmp/v${SHOPWARE_VERSION}.zip \
        https://github.com/shopware/shopware/archive/refs/tags/v${SHOPWARE_VERSION}.zip \
    && cd /tmp/ \
    && unzip \
        v${SHOPWARE_VERSION}.zip \
    && mv \
        -v /tmp/shopware-${SHOPWARE_VERSION}/ /home/application/shopware \
    && rm -rf \
        /tmp/v${SHOPWARE_VERSION}.zip \
    \
    && cd /home/application/shopware \
    && composer install \
        --dev \
        --no-interaction \
        --no-progress \
    \
    && mkdir /home/application/.staged_files \
    && chown -R application:application /home/application/.staged_files

VOLUME ["/src"]

ENTRYPOINT ["/entrypoint.sh"]
