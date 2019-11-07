#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/.." ;                a=$(cd "$a" && pwd) ; APP_HOME="$a"

if [[ -z $PORT ]]; then PORT=6000; fi  # default mapped port as 6000 if not specified other

cd "$APP_HOME"
    # run container from the built image namgivu/falcon_start
    PORT="$PORT" docker-compose up  -d --force-recreate  # start api at port :PORT

    # aftermath check
    docker ps | grep -E 'falcon_start|IMAGE'
cd - 1>/dev/null
