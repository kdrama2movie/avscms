FROM php:7.3-apache

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod actions
RUN a2enmod cgi
RUN a2enmod include

# Install necessary packages & PHP extensions
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    curl \
    unzip \
    git \
    npm \
    && docker-php-ext-install mysqli curl pdo pdo_mysql mbstring exif pcntl bcmath

# Set PHP recommended configurations
RUN echo "safe_mode = Off" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "open_basedir = none" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "max_execution_time = 7200" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "max_input_time = 7200" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "memory_limit = 2048M" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "post_max_size = 2048M" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "upload_max_filesize = 2048M" >> /usr/local/etc/php/conf.d/custom.ini
RUN echo "register_argc_argv = On" >> /usr/local/etc/php/conf.d/custom.ini
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
RUN echo "session.save_path = /tmp" >> /usr/local/etc/php/conf.d/custom.ini
# Enable exec() (default in Docker PHP images unless disabled by hosting provider)
# No special action needed unless restricted by external php.ini

# Set session save path to /tmp
RUN mkdir -p /var/lib/php/sessions && chmod -R 777 /var/lib/php/sessions
ENV PHP_SESSION_SAVE_PATH="/tmp"

# Install LESS/SASS compilers for frontend assets
RUN npm install -g less sass

# Set correct permissions for upload/cache folders
RUN mkdir -p /var/www/html/uploads /var/www/html/cache && chmod -R 777 /var/www/html/uploads /var/www/html/cache

# Copy project files
COPY . /var/www/html/

# Expose Apache Port
EXPOSE 80
