#!/bin/bash

cp .env.dist .env

KEY=$(php artisan key:generate --show)

echo "APP_KEY=$KEY" >> .env
