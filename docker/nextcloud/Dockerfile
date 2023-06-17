FROM debian:latest

#Install apt Packages
RUN apt update && apt install -y \
                lsb-release \
                ca-certificates \
                apt-transport-https \
                software-properties-common \
                gnupg2 \
                curl \
                gpg \
                wget \
                unzip

# Install PHP GPG Key
RUN curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg && sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

#Install PHP with modules
RUN apt update && apt install -y \
                php8.1 \
                php8.1-cli \
                php8.1-xml \
                php8.1-zip \
                php8.1-curl \
                php8.1-gd \
                php8.1-cgi \
                php8.1-mysql \
                php8.1-mbstring
                #php8.1-{cli,xml,zip,curl,gd,cgi,mysql,mbstring}

#Configure PHP
RUN sed -i 's/;date.timezone =/date.timezone = Europe\/Zurich/g' /etc/php/8.1/cgi/php.ini && \
    sed -i 's/memory_limit = .*/memory_limit = 512M/g' /etc/php/8.1/cgi/php.ini && \
    sed -i 's/upload_max_filesize = .*/upload_max_filesize = 500M/g' /etc/php/8.1/cgi/php.ini && \
    sed -i 's/post_max_size = .*/post_max_size = 500M/g' /etc/php/8.1/cgi/php.ini && \
    sed -i 's/max_execution_time = .*/max_execution_time = 300/g' /etc/php/8.1/cgi/php.ini

# Install Apache2
RUN apt install apache2 -y && \
    a2enmod rewrite && \
    a2enmod headers && \
    a2enmod env && \
    a2enmod dir && \
    a2enmod mime && \
    a2enmod setenvif && \
    a2dissite 000-default.conf && \
    rm /var/www/html/index.html

#Copy Apache config File
COPY ./nextcloud.conf /etc/apache2/sites-available/nextcloud.conf

# Enable Nextcloud site and reload Apache configuration
RUN a2ensite nextcloud.conf && \
    service apache2 start && \
    service apache2 reload

RUN mkdir /var/www/html/nextcloud

# Download Nextcloud and move to /var/www/html
WORKDIR /var/www/html/nextcloud
RUN wget https://download.nextcloud.com/server/releases/latest.zip && \
    unzip latest.zip && \
    rm latest.zip && \
    mv nextcloud/* . && \
    rm -r nextcloud

# Set Permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

RUN a2enmod php8.1
# Start Apache service in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]

 