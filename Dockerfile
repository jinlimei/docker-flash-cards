FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -yqq \
  git curl wget unzip nano php8.1-cli php8.1-fpm php8.1-mbstring php8.1-intl php8.1-zip php8.1-curl php8.1-mysql php8.1-xml mariadb-client && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p /app/

WORKDIR /app/

ADD flash_cards /app/flash_cards
ADD .env.dist /app/flash_cards/.env.dist

WORKDIR /app/flash_cards

ADD scripts ./scripts/

RUN /bin/bash ./scripts/install-composer.sh && \
    mv composer.phar /usr/bin/composer && \
    composer install -n --prefer-dist && \
    /bin/bash ./scripts/generate-env.sh && \
    php artisan config:cache && \
    chown -R www-data:www-data /app

ADD php-fpm/www.conf /etc/php/8.1/fpm/pool.d/www.conf
ADD php-fpm/php-fpm.conf /etc/php/8.1/fpm/php-fpm.conf    

ENTRYPOINT ["/bin/bash", "scripts/run-flash-cards.sh"]