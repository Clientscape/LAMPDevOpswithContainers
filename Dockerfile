FROM clientscape.azurecr.io/clientscape/cs-frontend:74
MAINTAINER Clientscape <info@whalelabs.com>

## Define working directory.
WORKDIR /var/www

## App
COPY src/ /var/www

#security
COPY config/cert.crt /etc/apache2/ssl/
COPY config/bundle.crt /etc/apache2/ssl/
COPY config/clientscape.com.key /etc/apache2/ssl/private/

#enable sites
COPY config/clientscape-ssl.conf /etc/apache2/sites-available/
COPY config/clientscape.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2dissite default-ssl
RUN a2ensite clientscape
RUN a2ensite clientscape-ssl

## App Init
RUN set -x \
    && mkdir -p /var/www/cache \
    && chmod 777 /var/www/cache \
    && mkdir -p /var/www/app/logs \

COPY src/app/config/config.build.ini /var/www/app/config/
RUN set -x \
    && mv /var/www/app/config/config.build.ini /var/www/app/config/config.ini 

RUN set -x \
	&& cd /var/www/public \
	&& yarn install \
	&& yarn run build

# Socket
RUN set -x \
	&& cd /var/www/app/sockets/cs-frontend \
	&& yarn install

COPY config/id_rsa /var/www/id_rsa
COPY config/id_rsa.pub /var/www/id_rsa.pub
COPY config/known_hosts /var/www/known_hosts

RUN set -x \
    && mkdir -p ~/.ssh \
    && mv /var/www/id_rsa ~/.ssh/id_rsa \
    && mv /var/www/id_rsa.pub ~/.ssh/id_rsa.pub \
    && mv /var/www/known_hosts ~/.ssh/known_hosts \
    && chmod 600 ~/.ssh/id_rsa \
	&& composer update --verbose 

# Redis PubSub Events
# RUN set -x \
#     && php app/cli.php Pubsub main 
# > /dev/null 2>&1 &

    
COPY clientscape-frontend.sh /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s -f usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

WORKDIR /var/www

# Expose ports.
EXPOSE 80
EXPOSE 443

# Define default command.
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
