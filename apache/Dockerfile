FROM debian:jessie

RUN apt-get update && \ 
	apt-get upgrade -y && \ 
	apt-get install -y wget && \
	apt-get install -y \
		ca-certificates \
		apache2 \
		gettext-base && \
	echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
	wget -O- https://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
	apt-get update && \
	apt-get install -y --no-install-suggests \
		php7.0 \
		php7.0-apcu \
		php7.0-curl \
		php7.0-gd \
		php7.0-intl \
		php7.0-ldap \
		php7.0-mysql \
		php7.0-dom \
		php7.0-xml \
		php7.0-bcmath

RUN /usr/sbin/a2enmod rewrite
RUN /usr/sbin/a2dissite 000-default

ADD partkeepr.conf /etc/apache2/sites-enabled/partkeepr.conf

COPY partkeepr /var/www/partkeepr
RUN chown -R www-data /var/www/partkeepr

# create daemon
RUN echo "0 0,6,12,18 * * * /usr/bin/php /var/www/partkeepr/app/console partkeepr:cron:run" >> /etc/crontab

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
	ln -sf /dev/stdout /var/log/apache2/partkeepr_access.log && \
	ln -sf /dev/stderr /var/log/apache2/error.log && \
	ln -sf /dev/stderr /var/log/apache2/partkeepr_error.log

EXPOSE 80 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]