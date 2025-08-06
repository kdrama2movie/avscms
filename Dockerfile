FROM php:7.3-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    npm

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql mbstring exif pcntl bcmath gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install LESS and SASS (SCSS compiler)
RUN npm install -g less sass

# Copy project files into Apache's web directory
COPY . /var/www/html/

# Optional: Set permissions (if needed by Smarty cache/templates_c)
RUN chown -R www-data:www-data /var/www/html/

# Expose port 80
EXPOSE 80
