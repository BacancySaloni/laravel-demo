FROM php:8.2-fpm
WORKDIR /home/ubuntu/laravel-demo

RUN apt-get update
RUN curl -sS https://getcomposer.org/installer | php -- --version=2.4.3 --install-dir=/usr/local/bin --filename=composer

ENV COMPOSER_ALLOW_SUPERUSER=1
COPY . .


RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql 
RUN apt-get install zip unzip 

RUN chmod 755 -R storage
RUN composer install --prefer-dist

#RUN php artisan key:generate
RUN php artisan passport:keys
RUN php artisan config:cache
CMD ["php","artisan","serve","--host=0.0.0.0"]
