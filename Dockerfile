FROM debian:buster

MAINTAINER Smorel <smorel@student.42lyon.fr>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

RUN apt-get -y install nginx
ADD /srcs/default /etc/nginx/sites-available/default
ADD /srcs/option /etc/nginx/sites-available/option
RUN chmod 755 /etc/nginx/sites-available/*

RUN apt-get -y install mariadb-server

RUN apt-get -y install php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

WORKDIR /usr/share/nginx/html

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz && rm -rf phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.0.1-all-languages phpmyadmin
ADD /srcs/config.inc.php phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
ADD /srcs/wp-config.php wordpress

EXPOSE 80 443

RUN openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=FRANCE/L=Lyon/OU=42LYON/CN=smorel" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data *
RUN chmod -R 755 ./*
ADD /srcs/index.html ./
ADD /srcs/init.sh ./
ADD /srcs/status.sh ./
ADD /srcs/switch.sh ./
RUN chmod 755 ./init.sh
RUN chmod 755 ./switch.sh

CMD bash init.sh 