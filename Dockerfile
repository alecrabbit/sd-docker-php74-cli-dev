ARG REPO_OWNER
FROM ${REPO_OWNER}/php74-cli

ENV PHP_XDEBUG_VERSION 2.9.2

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN pecl install xdebug-${PHP_XDEBUG_VERSION} \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable xdebug \
    && composer --no-interaction global --prefer-stable require 'hirak/prestissimo' \
    && composer --no-interaction global --prefer-stable require 'ergebnis/composer-normalize' \
    && composer --no-interaction global --prefer-stable require 'squizlabs/php_codesniffer' \
    && composer --no-interaction global --prefer-stable require 'phpstan/phpstan' \
    && composer --no-interaction global --prefer-stable require 'vimeo/psalm' \
    && composer --no-interaction global --prefer-stable require 'sensiolabs/security-checker' \
    && composer --no-interaction global --prefer-stable require 'friendsofphp/php-cs-fixer'

COPY ./config/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
