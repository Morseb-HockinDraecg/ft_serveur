#! bin/bash
docker stop bongo
    sleep 4
docker build --rm -t test .
docker run --rm -d --name bongo -ti -p 80:80 test
docker ps -a
docker container exec -ti bongo bash
