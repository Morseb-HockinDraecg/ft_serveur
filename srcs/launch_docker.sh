#! bin/bash
echo "\033[32m===================CLEAN==================\033[39m"
docker stop ft_server
echo ''
echo '\033[32m===================BUILD==================\033[39m'
docker build -t ft_server/img .
echo ''
echo '\033[32m====================RUN===================\033[39m'
docker container run --rm -tid --name ft_server -p 80:80 -p 443:443 ft_server/img
echo ''
echo '\033[32m===================IMAGES=================\033[39m'
docker images
echo ''
echo '\033[32m=================CONTAINER================\033[39m'
docker ps -a
echo ''
echo '\033[32m===================SHELL==================\033[39m'
docker container exec -ti ft_server /bin/bash
