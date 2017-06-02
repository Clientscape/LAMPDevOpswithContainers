FROM php:7.0.17-apache
MAINTAINER Clientscape <info@whalelabs.com>

## update the base image
RUN apt-get update
RUN apt-get install -y
RUN set -x \
	&& apt-get install -y apt-utils \
    && apt-get install -y openssl \
    && apt-get install -y curl

#APACHE & PHP
RUN set -x \
	&& echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
	&& echo "deb-src http://packages.dotdeb.org jessie all" >>  /etc/apt/sources.list \
	&& apt-get install -y wget curl \
    && wget https://www.dotdeb.org/dotdeb.gpg \
    && apt-key add dotdeb.gpg \
# apt-get install mysql-server apache2 libapache2-mod-php7.0 php7.0-cli php7.0-apcu php7.0-mcrypt php7.0-intl php7.0-mysql php7.0-curl php7.0-gd php7.0-soap php7.0-xml php7.0-zip
# a2enmod rewrite
    && apt-get update \
    && apt-get install -y libapache2-mod-php7.0 \
    && a2enmod php7.0 \
    && a2enmod rewrite \
    && a2enmod socache_shmcb \
    && a2enmod authn_socache \
    && a2enmod ssl \
    && a2enmod headers

## ffmpeg
RUN set -x \
	&& apt-get clean -y \
    && echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list \
    && echo "deb-src http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list
RUN set -x \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5C808C2B65558117 \
    && apt-get update && apt-get install -y ffmpeg && ffmpeg -version

## Phalcon
RUN set -x \
    apt-get update && \
    apt-get install -y git libwebp-dev libjpeg62-turbo-dev libpng12-dev libfreetype6-dev libmcrypt-dev libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/list/*

RUN set -x \
    cd ${HOME} && \
    git clone https://github.com/phalcon/cphalcon.git && \
    cd cphalcon/build/php7/64bits && \
    phpize && \
    export CFLAGS="-O2 -g" && \
    ./configure && \
    make && make install && \
    docker-php-ext-enable phalcon && \
    rm -rf ${HOME}/cphalcon

## Phalcon php:ext
RUN set -x \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E9C74FEEA2098A6E \
	&& apt-get update \
	&& curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash

RUN set -x \
	&& wget https://www.dotdeb.org/dotdeb.gpg \
	&& apt-key add dotdeb.gpg \
	&& apt-get update


RUN set -x \
    && apt-get install -y php7.0-phalcon \
    && apt-get install -y php-curl \
    && apt-get install -y php-xml \
    && apt-get install -y php-soap

RUN apt-get update && apt-get install -y libc-client-dev libkrb5-dev && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

## composer
RUN set -x \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

## Imagemagick & PHP Imagick ext [ imagick-3.4.0-PHP7-forge.sh]
RUN set -ex \
    && apt-get update \
    && apt-get install -y libmagickwand-dev \
    && pecl install imagick

RUN set -ex \
	&& apt-get install -y php-gd \
    && apt-get install -y php-zip \
    && apt-get install -y php-mysql

#MongoDB PHP driver
RUN set -ex \
	&& pecl install mongodb

#Redis PHP driver
RUN pecl install -o -f redis \
	&&  rm -rf /tmp/pear \
	&&  echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

# Ruby
RUN set -x \
    && apt-get install -y build-essential \
    && apt-get install -y zlib1g-dev

# Yarn
RUN set -x \
	&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
	&& apt-get -y update \
	&& apt-get install -y yarn


# Node.js
ENV DEBIAN_FRONTEND noninteractive
RUN set -x \
	&& apt-get update \
	&& apt-get -qq update \
	&& curl -sL https://deb.nodesource.com/setup_6.x | bash - \
	&& apt-get install -y nodejs
	#npm

RUN set -x \
    && npm install -g webpack \
    && npm install -g pm2

# ruby
RUN set -x \
    && apt-get install -y ruby

RUN set -x \
    && gem update --system \
    && gem install rubygems-update \
    && update_rubygems

# Fontforge
RUN set -x \
	&& apt-get install -y unzip \
    && apt-get install -y fontforge ttfautohint woff-tools ruby-dev \
    && wget https://people.mozilla.com/~jkew/woff/woff-code-latest.zip \
    && unzip woff-code-latest.zip -d sfnt2woff \
	&& cd sfnt2woff \
	&& make \
	&& mv sfnt2woff /usr/local/bin/ \
    && gem update --system \
    && gem install fontcustom

# Git
RUN set -x \
    && apt-get install -y git

COPY clientscape-frontend.sh /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

WORKDIR /var/www

# Expose ports.
EXPOSE 80
EXPOSE 443

# Define default command.
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]




