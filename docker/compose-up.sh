#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/.." ;             a=$(cd "$a" && pwd) ; APP_HOME="$a"

cd "$APP_HOME"
    # amplify if .env exists or not
    if [[ ! -f "$APP_HOME/.env" ]]; then echo "File not found .env at $APP_HOME"; exit; fi

    # run container from the built image namgivu/falcon_start
    docker-compose  -f "$SCRIPT_HOME/docker-compose.yml"  up  --force-recreate  -d  # start api at port :PORT
    #                #custom docker-compose                                     #run as background
    #                #ref. https://stackoverflow.com/a/45158964/248616

    # aftermath check
    docker ps | grep -E 'falcon_start|IMAGE'
    echo "
Container log can be viewed by (press ^C to exit watch)
$ docker logs -t -f nn_falcon_start

The api is ready to serve when the log reads 'Listening at: http://0.0.0.0:`source $APP_HOME/.env; echo $API_PORT` '
    "

cd - 1>/dev/null
