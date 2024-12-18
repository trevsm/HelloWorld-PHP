# PHP Server
# Version: 1.0.0
# Runs a PHP server on port 80 with Xdebug for debugging

FROM php:8.2-apache

# Install dependencies
RUN docker-php-ext-install mysqli pdo pdo_mysql&& \
    docker-php-ext-enable mysqli

# Install Xdebug
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# Copy Xdebug configuration
COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Copy apache config
COPY site.conf /etc/apache2/sites-available/site.conf

# Start Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    a2enmod rewrite headers && \
    a2dissite 000-default && \
    a2ensite site && \
    service apache2 restart