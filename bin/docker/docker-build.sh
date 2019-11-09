#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/../.." ;                a=$(cd "$a" && pwd) ; APP_HOME="$a"

DOCKER_IMAGE_NAME='namgivu/falcon_start'
if [[ `docker image ls | grep -c $DOCKER_IMAGE_NAME` == 1 ]]; then
    echo "Deleting docker image $DOCKER_IMAGE_NAME..."
    docker image rm $DOCKER_IMAGE_NAME
fi

cd "$APP_HOME"
    # build the docker image for this api app i.e. local image namgivu/falcon_start
    docker build -t namgivu/falcon_start   .
                 #t aka tag of the image   #build image from :current_folder/Dockerfile
cd - 1>/dev/null

# aftermath check
echo
docker image ls | grep -iE "$DOCKER_IMAGE_NAME|REPOSITORY"
