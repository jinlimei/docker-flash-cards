FROM nginx:1-alpine

RUN mkdir /app

ADD flash_cards /app/flash_cards
ADD ./nginx/web.conf /etc/nginx/conf.d/default.conf

RUN chown -R nginx:nginx /app/

WORKDIR /app/flash_cards