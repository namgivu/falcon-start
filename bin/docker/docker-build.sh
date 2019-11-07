#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/../.." ;                a=$(cd "$a" && pwd) ; APP_HOME="$a"

cd "$APP_HOME"
    # build the docker image for this api app i.e. local image namgivu/falcon_start
    docker build -t namgivu/falcon_start   .
                 #t aka tag of the image   #build image from :current_folder/Dockerfile
cd - 1>/dev/null

# aftermath check
echo
docker image ls | grep -iE 'namgivu/falcon_start|REPOSITORY'
