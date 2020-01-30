FROM php:7.3-apache-stretch

# Update + Dependencies
RUN apt-get update
RUN apt-get install -y libzip-dev libjpeg62-turbo-dev libpng-dev libfreetype6-dev vim nano
RUN docker-php-ext-install pdo_mysql mbstring zip

# Apache
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data /var/www/html && a2enmod rewrite

# Install CRON
RUN apt-get install -y cron

# Copy cron file to the cron.d directory
COPY app-cron /etc/cron.d/app-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/app-cron

# Apply cron job
RUN crontab /etc/cron.d/app-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && apache2-foreground && tail -f /var/log/cron.log

# PHP 
RUN echo "upload_max_filesize = 256M" > /usr/local/etc/php/conf.d/maxsizes.ini 
RUN echo "post_max_size = 257M" >> /usr/local/etc/php/conf.d/maxsizes.ini 
RUN echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/maxsizes.ini 
# RUN echo "disable_functions = exec,system,passthru,popen,proc_open,shell_exec" >> /usr/local/etc/php/conf.d/maxsizes.ini 
RUN echo "display_errors = Off" >> /usr/local/etc/php/conf.d/maxsizes.ini 

WORKDIR /var/www/html
