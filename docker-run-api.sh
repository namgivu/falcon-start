#!/usr/bin/env bash

# build the docker image for this api app i.e. local image namgivu/falcon_start
docker build -t namgivu/falcon_start   .
             #t aka tag of the image   #build image from :current_folder/Dockerfile

# stop if any running container exists
c=nn_falcon_start; docker stop $c; docker rm $c

# load custom mapped exposed-port if nay - default 6000 if not specified
if [[ -z $PORT ]]; then PORT=6000; fi
# run it
docker run  --name nn_falcon_start  -d                             -p $PORT:6000  namgivu/falcon_start
            #container name         #run as daemon aka background  #port mapping  #image name

# aftermath check
echo
t=/tmp/dokerps
    docker ps > $t
    head -n1 $t
    grep nn_falcon_start $t
echo "
Container log can be viewed by (press ^C to exit watch)
watch docker logs nn_falcon_start

The api is ready to serve when we can see 'Listening at: http://0.0.0.0:6000'
"
