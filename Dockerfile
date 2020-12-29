FROM debian:buster

MAINTAINER Smorel <smorel@student.42lyon.fr>

RUN apt-get update

RUN apt-get -y install wget
RUN apt-get -y install nginx

ADD srcs/script.sh /usr/bin/script.sh
RUN chmod 755 /usr/bin/script.sh

RUN chmod 755 /etc/nginx/sites-available/default
ADD srcs/wordpress /etc/nginx/sites-available/default
RUN chmod 755 /etc/nginx/sites-available/default

EXPOSE 80

ENTRYPOINT ["script.sh"]

VOLUME /volume/data

ENV MYSQL_ROOT_PASSWORD pw
