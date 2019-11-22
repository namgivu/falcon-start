#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/.." ;             a=$(cd "$a" && pwd) ; APP_HOME="$a"

cd "$APP_HOME"
    # amplify if .env exists or not
    if [[ ! -f "$APP_HOME/.env" ]]; then echo "File not found .env at $APP_HOME"; exit; fi
    source "$APP_HOME/.env"

    # stop if any running container exists
    "$SCRIPT_HOME/stop-rm.sh"

    # run it
    docker run  --name nn_falcon_start  -d                         -p $API_PORT:8000  namgivu/falcon_start
                #container name         #run as background daemon  #port mapping      #image name
cd - 1>/dev/null


# aftermath check
echo
docker ps | grep -E 'falcon_start|IMAGE'
echo "
Container log can be viewed by (press ^C to exit watch)
$ docker logs -t -f nn_falcon_start

The api is ready to serve when the log reads 'Listening at: http://0.0.0.0:$API_PORT'
"
