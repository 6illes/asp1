FROM        debian
MAINTAINER  Gilles

# Update the package repository
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \ 
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl locales nano

# Configure timezone and locale
RUN echo "Europe/Paris" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    locale-gen en_US.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Added prerequisites
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server apache2 mysql-server


# ASPERA

ENV ASPERA aspera
ENV ASPERADIR /opt/$ASPERA

ENV ASPERAURL https://storage.fr1.cloudwatt.com/v1/AUTH_f462168636b34441ac49c9dbf6d9f57d/ASPERA
ENV ASPERAPKG aspera-server.deb
ENV ASPERALIC aspera-license

RUN mkdir -p $ASPERADIR
RUN mkdir -p $ASPERADIR/etc

ADD $ASPERAURL/$ASPERAPKG $ASPERADIR/$ASPERAPKG
ADD $ASPERAURL/$ASPERALIC $ASPERADIR/etc/$ASPERALIC

WORKDIR $ASPERADIR
RUN dpkg -i $ASPERAPKG 

WORKDIR $ASPERADIR/etc
RUN ascp -A

RUN echo ------------ ASPERA CONNECT SERVER ------------

# Let's set the default timezone in both cli and apache configs
#RUN sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Europe\/Stockholm/g' /etc/php5/cli/php.ini
#RUN sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Europe\/Stockholm/g' /etc/php5/apache2/php.ini

#ADD ./001-docker.conf /etc/apache2/sites-available/
#RUN ln -s /etc/apache2/sites-available/001-docker.conf /etc/apache2/sites-enabled/

# Set Apache environment variables (can be changed on docker run with -e)
#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2
#ENV APACHE_PID_FILE /var/run/apache2.pid
#ENV APACHE_RUN_DIR /var/run/apache2
#ENV APACHE_LOCK_DIR /var/lock/apache2
#ENV APACHE_SERVERADMIN admin@localhost
#ENV APACHE_SERVERNAME localhost
#ENV APACHE_SERVERALIAS docker.localhost
#ENV APACHE_DOCUMENTROOT /var/www

#EXPOSE 80
#ADD start.sh /start.sh
#RUN chmod 0755 /start.sh
#CMD ["bash", "start.sh"]
