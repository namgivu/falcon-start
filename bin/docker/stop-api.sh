#!/usr/bin/env bash
s=$BASH_SOURCE ; s=$(dirname "$s") ; s=$(cd "$s" && pwd) ; SCRIPT_HOME="$s"  # get SCRIPT_HOME=executed script's path, containing folder, cd & pwd to get container path
a="$SCRIPT_HOME/.." ;                a=$(cd "$a" && pwd) ; APP_HOME="$a"

function stop() {
    cn=$1  # cn aka CONTAINER_NAME
    if [[ -z $cn ]]; then echo "Container name :cn is required"; exit; fi
    printf "Stopping $cn... "
        docker stop $cn 1>/dev/null 2>&1
        docker rm   $cn 1>/dev/null 2>&1
    printf "Done"; echo
}

cd "$APP_HOME"
    stop 'nn_falcon_start';
    stop 'nn_falcon_start_postgres';
cd - 1>/dev/null
