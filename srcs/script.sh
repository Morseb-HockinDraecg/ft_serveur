#! bin/bash

#Setup the MariaDB Container
docker pull mariadb

mkdir /usr/share/nginx/html/wordpress
mkdir -p /usr/share/nginx/html/wordpress/database
mkdir -p /usr/share/nginx/html/wordpress/html

docker run -e MYSQL_ROOT_PASSWORD=aqwe123 -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wpuser@ -e MYSQL_DATABASE=wordpress_db -v /root/wordpress/database:/var/lib/mysql --name wordpressdb -d mariadb

mysql -u wpuser -h 172.17.0.2 -p 
TYPE PASSWORD: wpuser@
show databases;

#Setup the Wordpress Container
docker pull wordpress:latest

docker run -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=wpuser@ -e WORDPRESS_DB_NAME=wordpress_db -p 8081:80 -v /root/wordpress/html:/var/www/html --link wordpressdb:mysql --name wpcontainer -d wordpress
curl -I 192.168.43.99:8081

#Install and Configure Nginx as Reverse Proxy

nginx -g 'daemon off;'
