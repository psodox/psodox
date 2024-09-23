FROM php:8.3.11-fpm-alpine3.20

RUN apk add -U --no-cache \
    bash \
    icu-dev \
    icu-libs \
    tzdata \
    && docker-php-ext-configure intl \
    && apk del --purge \
        icu-dev